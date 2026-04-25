using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using RestSharp;
using ShoppingCard.Models;
using ShoppingCard.Models.Momo;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;

namespace ShoppingCard.Services.Momo
{
    public class MomoService : IMomoService
    {
        private readonly IOptions<MomoOptionModel> _options;
        private readonly ILogger<MomoService> _logger;

        public MomoService(IOptions<MomoOptionModel> options, ILogger<MomoService> logger)
        {
            _options = options;
            _logger = logger;
        }

        public async Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(OrderInfo model)
        {
            try
            {
                var partnerCode = NormalizeRequired(_options.Value.PartnerCode, nameof(MomoOptionModel.PartnerCode));
                var accessKey = NormalizeRequired(_options.Value.AccessKey, nameof(MomoOptionModel.AccessKey));
                var secretKey = NormalizeRequired(_options.Value.SecretKey, nameof(MomoOptionModel.SecretKey));
                var redirectUrl = ResolveCallbackUrl(model.ReturnUrl, _options.Value.ReturnUrl, nameof(MomoOptionModel.ReturnUrl));
                var ipnUrl = ResolveCallbackUrl(model.NotifyUrl, _options.Value.NotifyUrl, nameof(MomoOptionModel.NotifyUrl));
                var momoApiUrl = NormalizeRequired(_options.Value.MomoApiUrl, nameof(MomoOptionModel.MomoApiUrl));

                if (string.IsNullOrWhiteSpace(model.OrderId))
                {
                    model.OrderId = DateTime.UtcNow.Ticks.ToString(CultureInfo.InvariantCulture);
                }
                model.OrderInformation = SanitizeOrderInformation(model.OrderInformation);
                model.OrderInformation = BuildOrderInfo(model.FullName, model.OrderInformation);

                var amountLong = ToMomoAmount(model.Amount);
                var amountStr = amountLong.ToString(CultureInfo.InvariantCulture);
                var requestType = ResolveRequestType(model.RequestType, _options.Value.RequestType);
                var extraData = string.Empty;

                var amountValidationMessage = ValidateAmountForRequestType(amountLong, requestType);
                if (!string.IsNullOrWhiteSpace(amountValidationMessage))
                {
                    return new MomoCreatePaymentResponseModel
                    {
                        ErrorCode = -1,
                        Message = amountValidationMessage
                    };
                }

                var rawData = BuildRawSignatureData(
                    accessKey,
                    amountStr,
                    extraData,
                    ipnUrl,
                    model.OrderId,
                    model.OrderInformation,
                    partnerCode,
                    redirectUrl,
                    model.OrderId,
                    requestType);

                var signature = ComputeHmacSha256(rawData, secretKey);

                var client = new RestClient(new RestClientOptions(momoApiUrl)
                {
                    Timeout = TimeSpan.FromSeconds(15)
                });
                var request = new RestRequest(string.Empty, Method.Post);
                request.AddHeader("Content-Type", "application/json; charset=UTF-8");

                var requestData = new
                {
                    partnerCode,
                    partnerName = "MoMo",
                    storeId = "ShoppingCard",
                    requestId = model.OrderId,
                    amount = amountLong,
                    orderId = model.OrderId,
                    orderInfo = model.OrderInformation,
                    redirectUrl,
                    ipnUrl,
                    lang = "vi",
                    requestType,
                    autoCapture = true,
                    extraData,
                    accessKey,
                    signature
                };

                request.AddJsonBody(requestData);

                var response = await client.ExecuteAsync(request);
                Console.WriteLine("MoMo Response Content: " + response.Content);

                if (string.IsNullOrWhiteSpace(response.Content))
                {
                    return new MomoCreatePaymentResponseModel
                    {
                        ErrorCode = -1,
                        Message = "Không nhận được phản hồi từ MoMo."
                    };
                }

                var json = JObject.Parse(response.Content);
                var resultCode = json.Value<int?>("resultCode") ??
                                 json.Value<int?>("errorCode") ??
                                 (response.IsSuccessful ? 0 : -1);

                if (resultCode == 11007)
                {
                    _logger.LogWarning(
                        "MoMo returned invalid signature (11007). rawData={RawData}; signature={Signature}; partnerCode={PartnerCode}; requestId={RequestId}",
                        rawData,
                        signature,
                        partnerCode,
                        model.OrderId);
                }

                return new MomoCreatePaymentResponseModel
                {
                    RequestId = json.Value<string>("requestId") ?? model.OrderId,
                    OrderId = json.Value<string>("orderId") ?? model.OrderId,
                    ErrorCode = resultCode,
                    Message = json.Value<string>("message") ??
                              json.Value<string>("localMessage") ??
                              "Không thể tạo thanh toán MoMo.",
                    LocalMessage = json.Value<string>("localMessage"),
                    RequestType = json.Value<string>("requestType") ?? requestType,
                    PayUrl = json.Value<string>("payUrl"),
                    Signature = json.Value<string>("signature"),
                    QrCodeUrl = json.Value<string>("qrCodeUrl"),
                    DeepLink = json.Value<string>("deeplink") ?? json.Value<string>("deepLink"),
                    DeepLinkWebInApp = json.Value<string>("deeplinkWebInApp") ?? json.Value<string>("deepLinkWebInApp")
                };
            }
            catch (Exception ex)
            {
                return new MomoCreatePaymentResponseModel
                {
                    ErrorCode = -1,
                    Message = "Lỗi kết nối MoMo: " + ex.Message
                };
            }
        }

        public MomoExecuteResponseModel PaymentExecuteAsync(IQueryCollection collection)
        {
            var amount = collection.FirstOrDefault(s => s.Key == "amount").Value.ToString();
            var orderInfo = collection.FirstOrDefault(s => s.Key == "orderInfo").Value.ToString();
            var orderId = collection.FirstOrDefault(s => s.Key == "orderId").Value.ToString();

            return new MomoExecuteResponseModel
            {
                Amount = amount,
                OrderId = orderId,
                OrderInfo = orderInfo
            };
        }

        private static string ResolveRequestType(string requestTypeFromRequest, string requestTypeFromConfig)
        {
            var requestedType = NormalizeRequestType(requestTypeFromRequest);
            if (!string.IsNullOrWhiteSpace(requestedType))
            {
                return requestedType;
            }

            var configuredType = NormalizeRequestType(requestTypeFromConfig);
            return string.IsNullOrWhiteSpace(configuredType) ? "captureWallet" : configuredType;
        }

        private static string NormalizeRequestType(string requestType)
        {
            if (string.IsNullOrWhiteSpace(requestType))
            {
                return string.Empty;
            }

            var normalized = requestType.Trim().ToLowerInvariant();
            return normalized switch
            {
                "capturewallet" => "captureWallet",
                "capturemomowallet" => "captureWallet",
                "wallet" => "captureWallet",
                "qr" => "captureWallet",
                "paywithatm" => "payWithATM",
                "atm" => "payWithATM",
                _ => string.Empty
            };
        }

        private static string ValidateAmountForRequestType(long amount, string requestType)
        {
            if (requestType != "payWithATM")
            {
                return string.Empty;
            }

            const long minAtmAmount = 10_000;
            const long maxAtmAmount = 50_000_000;
            return amount < minAtmAmount || amount > maxAtmAmount
                ? "Thanh toan ATM MoMo chi ho tro so tien tu 10,000 den 50,000,000 VND."
                : string.Empty;
        }

        private static long ToMomoAmount(decimal amount)
        {
            if (amount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(amount), "So tien thanh toan phai lon hon 0.");
            }

            return decimal.ToInt64(decimal.Truncate(amount));
        }

        private static string BuildOrderInfo(string fullName, string orderInfo)
        {
            var normalizedName = string.IsNullOrWhiteSpace(fullName) ? "Khach" : fullName.Trim();
            var normalizedOrderInfo = string.IsNullOrWhiteSpace(orderInfo)
                ? "Thanh toán đơn hàng tại ShoppingCard"
                : orderInfo.Replace("\r", " ").Replace("\n", " ").Trim();

            return $"Khach hang {normalizedName} - Noi dung {normalizedOrderInfo}";
        }

        private static string SanitizeOrderInformation(string orderInfo)
        {
            if (string.IsNullOrWhiteSpace(orderInfo))
            {
                return string.Empty;
            }

            return orderInfo
                .Replace(":", "-")
                .Replace(".", "-")
                .Trim();
        }

        private static string NormalizeRequired(string value, string configName)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                throw new InvalidOperationException($"MomoApi:{configName} chua duoc cau hinh.");
            }

            return value.Trim();
        }

        private static string ResolveCallbackUrl(string modelUrl, string fallbackUrl, string configName)
        {
            var selectedUrl = string.IsNullOrWhiteSpace(modelUrl) ? fallbackUrl : modelUrl;
            return NormalizeRequired(selectedUrl, configName);
        }

        private static string BuildRawSignatureData(
            string accessKey,
            string amount,
            string extraData,
            string ipnUrl,
            string orderId,
            string orderInfo,
            string partnerCode,
            string redirectUrl,
            string requestId,
            string requestType)
        {
            return $"accessKey={accessKey}&amount={amount}&extraData={extraData}&ipnUrl={ipnUrl}&orderId={orderId}&orderInfo={orderInfo}&partnerCode={partnerCode}&redirectUrl={redirectUrl}&requestId={requestId}&requestType={requestType}";
        }

        private static string ComputeHmacSha256(string message, string secretKey)
        {
            var keyBytes = Encoding.UTF8.GetBytes(secretKey);
            var messageBytes = Encoding.UTF8.GetBytes(message);

            using var hmac = new HMACSHA256(keyBytes);
            var hashBytes = hmac.ComputeHash(messageBytes);
            return BitConverter.ToString(hashBytes).Replace("-", "").ToLowerInvariant();
        }
    }
}
