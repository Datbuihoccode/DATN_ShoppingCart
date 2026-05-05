using System.Globalization;
using System.Text;
using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using ShoppingCard.Models;
using ShoppingCard.Models.Shipping;
using ShoppingCard.Repository;

namespace ShoppingCard.Services
{
    public class ShippingService : IShippingService
    {
        private readonly DataContext _db;
        private readonly IHttpClientFactory _http;
        private readonly ShippingOptionModel _opt;

        public ShippingService(DataContext db, IHttpClientFactory http, IOptions<ShippingOptionModel> opt)
        {
            _db = db; _http = http; _opt = opt.Value;
        }

        public async Task<ShippingQuoteResult> GetShippingQuoteAsync(string userId, ShippingQuoteRequest req)
        {
            if (!_opt.Enabled) return new ShippingQuoteResult { IsSuccess = true, Fee = 0 };

            var items = await _db.Carts.Include(c => c.Product).Where(c => c.UserId == userId).ToListAsync();
            if (!items.Any()) return new ShippingQuoteResult { Message = "Giỏ hàng trống." };

            var weight = items.Sum(x => 
            {
                var w = x.Product?.WeightGram ?? 0;
                if (w <= 0) w = _opt.DefaultItemWeightGram;
                return w * x.Quantity;
            });
            var value = items.Sum(x => (x.Product?.Price ?? 0) * x.Quantity);

            return await GetGhnFeeAsync(req, weight, value);
        }

        public async Task<ShippingShipmentResult> CreateShipmentAsync(string orderCode)
        {
            if (!_opt.Enabled) return new ShippingShipmentResult { IsSuccess = false, Message = "API vận chuyển đang tắt." };

            var order = await _db.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderCode);
            if (order == null) return new ShippingShipmentResult { Message = "Không tìm thấy đơn hàng." };

            var details = await _db.OrderDetails.Include(d => d.Product).Where(d => d.OrderCode == orderCode).ToListAsync();
            var weight = details.Sum(d => 
            {
                var w = d.Product?.WeightGram ?? 0;
                if (w <= 0) w = _opt.DefaultItemWeightGram;
                return w * d.Quantity;
            });
            var insurance = details.Sum(d => d.Price * d.Quantity);
            var cod = order.PaymentMethod == PaymentMethod.COD.ToString() ? (int)Math.Max(0, insurance - order.DiscountAmount + order.ShippingFee) : 0;

            // GHN V3 support: Ưu tiên dùng to_ward_name + to_province_name + is_new_to_address: true
            bool useNewAddress = !string.IsNullOrWhiteSpace(order.ShippingWardName) && !string.IsNullOrWhiteSpace(order.ShippingProvinceName);

            object payload = useNewAddress ? new
            {
                payment_type_id = order.PaymentMethod == PaymentMethod.COD.ToString() ? 1 : 2,
                note = $"Đơn hàng {order.OrderCode}",
                required_note = "KHONGCHOXEMHANG",
                from_name = _opt.FromName, from_phone = _opt.FromPhone, from_address = _opt.FromAddress,
                from_ward_code = _opt.FromWardCode, 
                from_district_id = _opt.FromDistrictId > 0 ? (int?)_opt.FromDistrictId : null,
                is_new_from_address = _opt.IsNewFromAddress,
                to_name = BuildReceiverName(order.UserName, order.ShippingPhone),
                to_phone = NormalizePhone(order.ShippingPhone),
                to_address = order.ShippingAddress,
                to_ward_name = order.ShippingWardName,
                to_province_name = order.ShippingProvinceName,
                is_new_to_address = true,
                cod_amount = cod,
                content = $"Order {order.OrderCode}",
                weight, length = 20, width = 20, height = 10,
                insurance_value = (int)insurance,
                service_type_id = _opt.ServiceTypeId,
                items = details.Select(d => new { name = d.Product?.Name ?? "SP", quantity = d.Quantity, weight = (d.Product?.WeightGram > 0 ? d.Product.WeightGram : _opt.DefaultItemWeightGram) })
            } : new
            {
                payment_type_id = order.PaymentMethod == PaymentMethod.COD.ToString() ? 1 : 2,
                note = $"Đơn hàng {order.OrderCode}",
                required_note = "KHONGCHOXEMHANG",
                from_name = _opt.FromName, from_phone = _opt.FromPhone, from_address = _opt.FromAddress,
                from_ward_code = _opt.FromWardCode, 
                from_district_id = _opt.FromDistrictId > 0 ? (int?)_opt.FromDistrictId : null,
                is_new_from_address = _opt.IsNewFromAddress,
                to_name = BuildReceiverName(order.UserName, order.ShippingPhone),
                to_phone = NormalizePhone(order.ShippingPhone),
                to_address = order.ShippingAddress,
                to_ward_code = order.ShippingWardCode,
                to_district_id = order.ShippingDistrictId,
                is_new_to_address = false,
                cod_amount = cod,
                content = $"Order {order.OrderCode}",
                weight, length = 20, width = 20, height = 10,
                insurance_value = (int)insurance,
                service_type_id = _opt.ServiceTypeId,
                items = details.Select(d => new { name = d.Product?.Name ?? "SP", quantity = d.Quantity, weight = (d.Product?.WeightGram > 0 ? d.Product.WeightGram : _opt.DefaultItemWeightGram) })
            };

            var res = await SendGhnRequest("/shiip/public-api/v2/shipping-order/create", payload);
            if (!res.IsSuccess) return new ShippingShipmentResult { IsSuccess = false, Message = res.Message };

            var tracking = res.Data.TryGetProperty("order_code", out var oc) ? oc.GetString() : "";
            return new ShippingShipmentResult { IsSuccess = !string.IsNullOrEmpty(tracking), TrackingCode = tracking, Message = "Thành công." };
        }

        // Master data - API địa chỉ Mới (v3 - 2 cấp: Tỉnh/Phường)
        public async Task<List<ShippingLocationModel>> GetProvincesAsync() => 
            await FetchLocations("/shiip/public-api/v3/master-data/province/all", null, "_id", "name", "", isGet: true);

        public async Task<List<ShippingLocationModel>> GetWardsAsync(string provinceId) => 
            await FetchLocations($"/shiip/public-api/v3/master-data/ward/all-by-province-id?province_id={provinceId}", null, "_id", "name", "parent_id", isGet: true);

        private async Task<List<ShippingLocationModel>> FetchLocations(string url, object payload, string cField, string nField, string pField = "", bool isGet = false)
        {
            var res = await SendGhnRequestWithFallbacks(url, payload, isGet);
            if (!res.IsSuccess) return new List<ShippingLocationModel>();

            JsonElement arr;
            if (res.Data.ValueKind == JsonValueKind.Array) arr = res.Data;
            else if (res.Data.ValueKind == JsonValueKind.Object && res.Data.TryGetProperty("data", out var nested) && nested.ValueKind == JsonValueKind.Array) arr = nested;
            else return new List<ShippingLocationModel>();

            return arr.EnumerateArray().Select(x => new ShippingLocationModel
            {
                Code = GetPropString(x, cField),
                Name = GetPropString(x, nField),
                ParentId = !string.IsNullOrEmpty(pField) ? GetPropString(x, pField) : ""
            }).Where(x => !string.IsNullOrEmpty(x.Code)).ToList();
        }

        private async Task<(bool IsSuccess, string Message, JsonElement Data)> SendGhnRequestWithFallbacks(string url, object payload, bool isGet = false)
        {
            var attempts = new[] { (true, isGet), (false, isGet), (true, !isGet), (false, !isGet) };
            (bool IsSuccess, string Message, JsonElement Data) last = (false, "Lỗi kết nối GHN", default);

            foreach (var a in attempts)
            {
                last = await SendGhnRequest(url, payload, includeShopId: a.Item1, isGet: a.Item2);
                if (last.IsSuccess) return last;
            }
            return last;
        }

        private async Task<(bool IsSuccess, string Message, JsonElement Data)> SendGhnRequest(string url, object payload, bool includeShopId = true, bool isGet = false)
        {
            try
            {
                var client = _http.CreateClient("ghn");
                client.BaseAddress = new Uri(_opt.BaseUrl);
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.TryAddWithoutValidation("token", _opt.Token?.Trim());
                client.DefaultRequestHeaders.TryAddWithoutValidation("User-Agent", "ShoppingCard-V3/1.0");
                if (includeShopId && _opt.ShopId > 0) 
                {
                    var sid = _opt.ShopId.ToString();
                    client.DefaultRequestHeaders.TryAddWithoutValidation("ShopId", sid);
                    client.DefaultRequestHeaders.TryAddWithoutValidation("shopid", sid);
                }

                HttpResponseMessage res = isGet ? await client.GetAsync(url) : await client.PostAsync(url, new StringContent(JsonSerializer.Serialize(payload), Encoding.UTF8, "application/json"));
                var raw = await res.Content.ReadAsStringAsync();
                using var doc = JsonDocument.Parse(raw);
                var root = doc.RootElement.Clone();

                int code = 0;
                if (root.TryGetProperty("code", out var c))
                {
                    if (c.ValueKind == JsonValueKind.Number) code = c.GetInt32();
                    else if (c.ValueKind == JsonValueKind.String && int.TryParse(c.GetString(), out var sc)) code = sc;
                }

                if (code == 200 && root.TryGetProperty("data", out var d)) return (true, "", d);
                return (false, root.TryGetProperty("message", out var m) ? m.GetString() : "Lỗi từ GHN", default);
            }
            catch (Exception ex) { return (false, ex.Message, default); }
        }

        private static string GetPropString(JsonElement x, string name)
        {
            if (x.TryGetProperty(name, out var p1)) return p1.ToString();
            var pascal = char.ToUpper(name[0]) + name.Substring(1);
            if (x.TryGetProperty(pascal, out var p2)) return p2.ToString();
            if (pascal.Contains("_"))
            {
                var key = string.Join("", name.Split('_').Select(s => char.ToUpper(s[0]) + s.Substring(1))).Replace("Id", "ID");
                if (x.TryGetProperty(key, out var p3)) return p3.ToString();
            }
            return "";
        }

        private async Task<ShippingQuoteResult> GetGhnFeeAsync(ShippingQuoteRequest req, int weight, decimal insurance)
        {
            var useNewAddress = req.ToProvinceId > 0 && req.ToWardIdV2 > 0 && !string.IsNullOrWhiteSpace(req.ToAddressV2);
            object payload = useNewAddress ? new
            {
                from_district_id = _opt.FromDistrictId > 0 ? (int?)_opt.FromDistrictId : null,
                from_ward_code = _opt.FromWardCode,
                from_ward_id_v2 = int.TryParse(_opt.FromWardCode, out var fw) ? (int?)fw : null,
                from_address_v2 = _opt.FromAddress,
                is_new_from_address = _opt.IsNewFromAddress,
                to_ward_id_v2 = req.ToWardIdV2,
                to_address_v2 = req.ToAddressV2,
                is_new_to_address = true,
                weight, length = 20, width = 20, height = 10,
                service_type_id = _opt.ServiceTypeId,
                insurance_value = (int)insurance
            } : new
            {
                from_district_id = _opt.FromDistrictId > 0 ? (int?)_opt.FromDistrictId : null,
                from_ward_code = _opt.FromWardCode,
                from_ward_id_v2 = int.TryParse(_opt.FromWardCode, out var fw2) ? (int?)fw2 : null,
                from_address_v2 = _opt.FromAddress,
                is_new_from_address = _opt.IsNewFromAddress,
                to_district_id = req.ToDistrictId,
                to_ward_code = req.ToWardCode,
                is_new_to_address = false,
                weight = Math.Max(weight, 100),
                length = 20, width = 20, height = 10,
                service_type_id = _opt.ServiceTypeId,
                insurance_value = (int)insurance
            };

            var res = await SendGhnRequest("/shiip/public-api/v2/shipping-order/fee", payload);
            if (!res.IsSuccess) return new ShippingQuoteResult { Message = res.Message };
            return new ShippingQuoteResult { IsSuccess = true, Fee = res.Data.TryGetProperty("total", out var t) ? t.GetDecimal() : 0 };
        }

        private string BuildReceiverName(string u, string p)
        {
            var name = (u ?? "").Split('@')[0].Trim();
            return !string.IsNullOrEmpty(name) ? name : (p?.Length >= 4 ? $"Khách {p[^4..]}" : "Khách hàng");
        }

        private string NormalizePhone(string p)
        {
            var d = new string((p ?? "").Where(char.IsDigit).ToArray());
            if (d.StartsWith("84") && d.Length == 11) d = "0" + d[2..];
            return d.Length == 10 && d.StartsWith("0") ? d : "";
        }

        public bool TryMapWebhookStatus(string ext, out OrderStatus st)
        {
            var s = (ext ?? "").ToLower();
            
            // ready_to_pick, picking, picked -> Processing
            if (s is "ready_to_pick" or "picking" or "picked")
            {
                st = OrderStatus.Processing;
                return true;
            }
            
            // storing, transporting, sorting, delivering -> Shipping
            if (s is "storing" or "transporting" or "sorting" or "delivering")
            {
                st = OrderStatus.Shipping;
                return true;
            }
            
            // delivered -> Delivered
            if (s is "delivered")
            {
                st = OrderStatus.Delivered;
                return true;
            }
            
            // delivery_fail -> DeliveryFailed
            if (s is "delivery_fail")
            {
                st = OrderStatus.DeliveryFailed;
                return true;
            }

            // waiting_to_return, return -> Returning
            if (s is "waiting_to_return" or "return")
            {
                st = OrderStatus.Returning;
                return true;
            }

            // returned -> Returned
            if (s is "returned")
            {
                st = OrderStatus.Returned;
                return true;
            }
            
            // cancel -> Cancelled
            if (s is "cancel")
            {
                st = OrderStatus.Cancelled;
                return true;
            }

            st = OrderStatus.Shipping; // Default fallback
            return false;
        }

    }
}
