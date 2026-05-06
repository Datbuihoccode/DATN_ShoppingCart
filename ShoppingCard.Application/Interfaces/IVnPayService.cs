using Microsoft.AspNetCore.Http;
using ShoppingCard.Application.DTOs.VnPay;

namespace ShoppingCard.Application.Interfaces
{
    public interface IVnPayService
    {
        string CreatePaymentUrl(HttpContext context, ShoppingCard.Domain.Entities.Order order, decimal amount);
        PaymentResponseModel PaymentExecute(IQueryCollection collections);
    }
}
