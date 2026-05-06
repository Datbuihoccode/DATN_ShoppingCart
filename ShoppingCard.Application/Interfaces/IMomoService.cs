using Microsoft.AspNetCore.Http;
using ShoppingCard.Application.DTOs.Momo;

namespace ShoppingCard.Application.Interfaces
{
    public interface IMomoService
    {
        Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(ShoppingCard.Domain.Entities.Order order, decimal amount);
        MomoExecuteResponseModel PaymentExecute(IQueryCollection collection);
    }
}
