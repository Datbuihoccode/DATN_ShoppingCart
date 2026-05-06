using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using RestSharp;
using ShoppingCard.Application.DTOs.Momo;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;

namespace ShoppingCard.Infrastructure.Services
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

        public async Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(Order order, decimal amount)
        {
            try
            {
                var partnerCode = _options.Value.PartnerCode;
                var accessKey = _options.Value.AccessKey;
                var secretKey = _options.Value.SecretKey;
                var redirectUrl = _options.Value.ReturnUrl;
                var ipnUrl = _options.Value.NotifyUrl;
                var momoApiUrl = _options.Value.MomoApiUrl;

                var orderId = order.OrderCode;
                var orderInformation = $"Thanh toán đơn hàng {order.OrderCode} tại Laptop Center";
                var amountLong = (long)amount;
                var amountStr = amountLong.ToString();
                var requestType = _options.Value.RequestType ?? "captureWallet";
                var extraData = "";

                var rawData = $"accessKey={accessKey}&amount={amountStr}&extraData={extraData}&ipnUrl={ipnUrl}&orderId={orderId}&orderInfo={orderInformation}&partnerCode={partnerCode}&redirectUrl={redirectUrl}&requestId={orderId}&requestType={requestType}";

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
                    requestId = orderId,
                    amount = amountLong,
                    orderId,
                    orderInfo = orderInformation,
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
                
                if (string.IsNullOrWhiteSpace(response.Content))
                {
                    return new MomoCreatePaymentResponseModel { ErrorCode = -1, Message = "Không nhận được phản hồi từ MoMo." };
                }

                var json = JObject.Parse(response.Content);
                var resultCode = json.Value<int?>("resultCode") ?? json.Value<int?>("errorCode") ?? -1;

                return new MomoCreatePaymentResponseModel
                {
                    RequestId = json.Value<string>("requestId") ?? orderId,
                    OrderId = json.Value<string>("orderId") ?? orderId,
                    ErrorCode = resultCode,
                    Message = json.Value<string>("message") ?? "Lỗi không xác định từ MoMo",
                    LocalMessage = json.Value<string>("localMessage"),
                    PayUrl = json.Value<string>("payUrl"),
                    Signature = json.Value<string>("signature"),
                    QrCodeUrl = json.Value<string>("qrCodeUrl"),
                    DeepLink = json.Value<string>("deeplink"),
                    DeepLinkWebInApp = json.Value<string>("deeplinkWebInApp"),
                    RequestType = json.Value<string>("requestType") ?? requestType
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi tạo thanh toán MoMo cho đơn hàng {OrderCode}", order.OrderCode);
                return new MomoCreatePaymentResponseModel { ErrorCode = -1, Message = "Lỗi hệ thống: " + ex.Message };
            }
        }

        public MomoExecuteResponseModel PaymentExecute(IQueryCollection collection)
        {
            return new MomoExecuteResponseModel
            {
                Amount = collection["amount"].ToString(),
                OrderId = collection["orderId"].ToString(),
                OrderInfo = collection["orderInfo"].ToString(),
                ResultCode = int.TryParse(collection["resultCode"], out var code) ? code : -1,
                TransId = collection["transId"].ToString(),
                Message = collection["message"].ToString()
            };
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
