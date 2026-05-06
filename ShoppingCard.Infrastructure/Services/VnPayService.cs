using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using ShoppingCard.Application.DTOs.VnPay;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using System.Globalization;
using System.Net;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Text;

namespace ShoppingCard.Infrastructure.Services
{
    public class VnPayService : IVnPayService
    {
        private readonly IConfiguration _config;

        public VnPayService(IConfiguration config)
        {
            _config = config;
        }

        public string CreatePaymentUrl(HttpContext context, Order order, decimal amount)
        {
            var vnpay = new VnPayLibrary();
            var tick = order.OrderCode;

            vnpay.AddRequestData("vnp_Version", _config["Vnpay:Version"] ?? "2.1.0");
            vnpay.AddRequestData("vnp_Command", _config["Vnpay:Command"] ?? "pay");
            vnpay.AddRequestData("vnp_TmnCode", _config["Vnpay:TmnCode"]);
            vnpay.AddRequestData("vnp_Amount", ((long)(amount * 100)).ToString());
            vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", _config["Vnpay:CurrCode"] ?? "VND");
            vnpay.AddRequestData("vnp_IpAddr", vnpay.GetIpAddress(context));
            vnpay.AddRequestData("vnp_Locale", _config["Vnpay:Locale"] ?? "vn");
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toán đơn hàng " + order.OrderCode);
            vnpay.AddRequestData("vnp_OrderType", "other");
            vnpay.AddRequestData("vnp_ReturnUrl", ResolveReturnUrl(context));
            vnpay.AddRequestData("vnp_TxnRef", tick);

            return vnpay.CreateRequestUrl(_config["Vnpay:BaseUrl"], _config["Vnpay:HashSecret"]);
        }

        public PaymentResponseModel PaymentExecute(IQueryCollection collections)
        {
            var vnpay = new VnPayLibrary();
            foreach (var (key, value) in collections)
            {
                if (!string.IsNullOrEmpty(key) && key.StartsWith("vnp_"))
                {
                    vnpay.AddResponseData(key, value.ToString());
                }
            }

            var secureHash = collections["vnp_SecureHash"].ToString();
            var checkSignature = vnpay.ValidateSignature(secureHash, _config["Vnpay:HashSecret"]);

            if (!checkSignature)
            {
                return new PaymentResponseModel { Success = false };
            }

            return new PaymentResponseModel
            {
                Success = true,
                PaymentMethod = "VnPay",
                OrderDescription = vnpay.GetResponseData("vnp_OrderInfo"),
                OrderId = vnpay.GetResponseData("vnp_TxnRef"),
                TransactionId = vnpay.GetResponseData("vnp_TransactionNo"),
                PaymentId = vnpay.GetResponseData("vnp_BankTranNo"),
                VnPayResponseCode = vnpay.GetResponseData("vnp_ResponseCode")
            };
        }

        private string ResolveReturnUrl(HttpContext context)
        {
            var configuredUrl = _config["Vnpay:PaymentBackReturnUrl"];
            if (string.IsNullOrEmpty(configuredUrl)) return "";

            if (configuredUrl.StartsWith("http")) return configuredUrl;

            return $"{context.Request.Scheme}://{context.Request.Host}{configuredUrl}";
        }

        // Internal helper class
        private class VnPayLibrary
        {
            private readonly SortedList<string, string> _requestData = new(new VnPayCompare());
            private readonly SortedList<string, string> _responseData = new(new VnPayCompare());

            public void AddRequestData(string key, string value)
            {
                if (!string.IsNullOrEmpty(value)) _requestData[key] = value;
            }

            public void AddResponseData(string key, string value)
            {
                if (!string.IsNullOrEmpty(value)) _responseData[key] = value;
            }

            public string GetResponseData(string key)
            {
                return _responseData.TryGetValue(key, out var retValue) ? retValue : string.Empty;
            }

            public string CreateRequestUrl(string baseUrl, string vnpHashSecret)
            {
                var data = new StringBuilder();
                foreach (var kv in _requestData)
                {
                    if (!string.IsNullOrEmpty(kv.Value))
                    {
                        data.Append(WebUtility.UrlEncode(kv.Key)).Append('=').Append(WebUtility.UrlEncode(kv.Value)).Append('&');
                    }
                }
                var signData = data.ToString().TrimEnd('&');
                var secureHash = HmacSHA512(vnpHashSecret, signData);
                return $"{baseUrl}?{data}vnp_SecureHash={secureHash}";
            }

            public bool ValidateSignature(string inputHash, string secretKey)
            {
                var data = new StringBuilder();
                foreach (var kv in _responseData)
                {
                    if (kv.Key != "vnp_SecureHash" && kv.Key != "vnp_SecureHashType" && !string.IsNullOrEmpty(kv.Value))
                    {
                        data.Append(WebUtility.UrlEncode(kv.Key)).Append('=').Append(WebUtility.UrlEncode(kv.Value)).Append('&');
                    }
                }
                var signData = data.ToString().TrimEnd('&');
                var myChecksum = HmacSHA512(secretKey, signData);
                return myChecksum.Equals(inputHash, StringComparison.InvariantCultureIgnoreCase);
            }

            public string GetIpAddress(HttpContext context)
            {
                try
                {
                    var remoteIpAddress = context.Connection.RemoteIpAddress;
                    if (remoteIpAddress != null)
                    {
                        if (remoteIpAddress.AddressFamily == AddressFamily.InterNetworkV6)
                        {
                            remoteIpAddress = Dns.GetHostEntry(remoteIpAddress).AddressList
                                .FirstOrDefault(x => x.AddressFamily == AddressFamily.InterNetwork);
                        }
                        return remoteIpAddress?.ToString() ?? "127.0.0.1";
                    }
                }
                catch { }
                return "127.0.0.1";
            }

            private string HmacSHA512(string key, string inputData)
            {
                var hash = new StringBuilder();
                var keyBytes = Encoding.UTF8.GetBytes(key);
                var inputBytes = Encoding.UTF8.GetBytes(inputData);
                using var hmac = new HMACSHA512(keyBytes);
                var hashValue = hmac.ComputeHash(inputBytes);
                foreach (var theByte in hashValue) hash.Append(theByte.ToString("x2"));
                return hash.ToString();
            }
        }

        private class VnPayCompare : IComparer<string>
        {
            public int Compare(string? x, string? y) => string.Compare(x, y, StringComparison.Ordinal);
        }
    }
}
