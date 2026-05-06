using System.Net;
using System.Net.Mail;
using ShoppingCard.Application.Interfaces;

namespace ShoppingCard.Infrastructure.Services
{
    public class EmailSender : IEmailSender
    {
        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("1977datbui@gmail.com", "xinosudnurqnwlpk")
            };

            return client.SendMailAsync(
                new MailMessage(from: "1977datbui@gmail.com",
                                to: email,
                                subject: subject,
                                body: message
                                ) { IsBodyHtml = true });
        }
    }
}
