using Microsoft.AspNetCore.Http;
using ShoppingCard.Models.VNP;

namespace ShoppingCard.Services.Vnpay
{
    public interface IVnPayService
    {
        string CreatePaymentUrl(HttpContext context, PaymentInformationModel model);
        PaymentResponseModel PaymentExecute(IQueryCollection collections);
    }
}
