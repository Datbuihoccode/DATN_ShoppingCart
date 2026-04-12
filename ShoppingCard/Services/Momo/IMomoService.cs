using Microsoft.AspNetCore.Http;
using ShoppingCard.Models;
using ShoppingCard.Models.Momo;

namespace ShoppingCard.Services.Momo
{
    public interface IMomoService
    {
        Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(OrderInfo model);
        MomoExecuteResponseModel PaymentExecuteAsync(IQueryCollection collection);
    }
}
