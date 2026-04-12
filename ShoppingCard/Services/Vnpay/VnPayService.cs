using System.Globalization;
using Microsoft.AspNetCore.Http;
using ShoppingCard.Library;
using ShoppingCard.Models.VNP;

namespace ShoppingCard.Services.Vnpay
{
    public class VnPayService : IVnPayService
    {
        private readonly IConfiguration _config;

        public VnPayService(IConfiguration config)
        {
            _config = config;
        }

        public string CreatePaymentUrl(HttpContext context, PaymentInformationModel model)
        {
            if (model == null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            if (model.Amount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(model.Amount), "So tien thanh toan phai lon hon 0.");
            }

            var createdDate = ResolveVnpayCreateDate();
            var tick = string.IsNullOrWhiteSpace(model.OrderId)
                ? DateTime.Now.Ticks.ToString(CultureInfo.InvariantCulture)
                : model.OrderId.Trim();

            var orderDescription = string.IsNullOrWhiteSpace(model.OrderDescription)
                ? $"Thanh toán đơn hàng:{tick}"
                : model.OrderDescription.Trim();
            const string orderType = "other";
            var returnUrl = ResolveReturnUrl(context);

            var vnpay = new VnPayLibrary();
            vnpay.AddRequestData("vnp_Version", GetRequiredConfig("Vnpay:Version"));
            vnpay.AddRequestData("vnp_Command", GetRequiredConfig("Vnpay:Command"));
            vnpay.AddRequestData("vnp_TmnCode", GetRequiredConfig("Vnpay:TmnCode"));
            vnpay.AddRequestData("vnp_Amount", decimal.Round(model.Amount * 100m, 0, MidpointRounding.AwayFromZero).ToString(CultureInfo.InvariantCulture));
            vnpay.AddRequestData("vnp_CreateDate", createdDate.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", GetRequiredConfig("Vnpay:CurrCode"));
            vnpay.AddRequestData("vnp_IpAddr", vnpay.GetIpAddress(context));
            vnpay.AddRequestData("vnp_Locale", GetRequiredConfig("Vnpay:Locale"));
            vnpay.AddRequestData("vnp_OrderInfo", orderDescription);
            vnpay.AddRequestData("vnp_OrderType", orderType);
            vnpay.AddRequestData("vnp_ReturnUrl", returnUrl);
            vnpay.AddRequestData("vnp_TxnRef", tick);

            return vnpay.CreateRequestUrl(
                GetRequiredConfig("Vnpay:BaseUrl"),
                GetRequiredConfig("Vnpay:HashSecret"));
        }

        public PaymentResponseModel PaymentExecute(IQueryCollection collections)
        {
            var vnpay = new VnPayLibrary();
            return vnpay.GetFullResponseData(collections, GetRequiredConfig("Vnpay:HashSecret"));
        }

        private DateTime ResolveVnpayCreateDate()
        {
            var configuredTimeZoneId = _config["Vnpay:TimeZoneId"];
            var timeZoneId = string.IsNullOrWhiteSpace(configuredTimeZoneId)
                ? "SE Asia Standard Time"
                : configuredTimeZoneId.Trim();

            try
            {
                var targetZone = TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
                return TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, targetZone);
            }
            catch (TimeZoneNotFoundException ex)
            {
                throw new InvalidOperationException($"Vnpay:TimeZoneId '{timeZoneId}' không tồn tại trên hệ thống.", ex);
            }
            catch (InvalidTimeZoneException ex)
            {
                throw new InvalidOperationException($"Vnpay:TimeZoneId '{timeZoneId}' không hợp lệ.", ex);
            }
        }

        private string GetRequiredConfig(string key)
        {
            var value = _config[key];
            if (string.IsNullOrWhiteSpace(value))
            {
                throw new InvalidOperationException($"{key} chua duoc cau hinh.");
            }

            return value.Trim();
        }

        private string ResolveReturnUrl(HttpContext context)
        {
            var configuredUrl = _config["Vnpay:PaymentBackReturnUrl"];
            if (!string.IsNullOrWhiteSpace(configuredUrl))
            {
                var normalized = configuredUrl.Trim();
                if (Uri.TryCreate(normalized, UriKind.Absolute, out _))
                {
                    return normalized;
                }

                var relativePath = normalized.StartsWith("/", StringComparison.Ordinal)
                    ? normalized
                    : "/" + normalized;

                return $"{context.Request.Scheme}://{context.Request.Host}{relativePath}";
            }

            return $"{context.Request.Scheme}://{context.Request.Host}/Checkout/PaymentCallBackVnPay";
        }
    }
}
