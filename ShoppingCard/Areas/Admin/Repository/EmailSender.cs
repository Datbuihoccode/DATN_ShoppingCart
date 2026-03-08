using System.Net;
using System.Net.Mail;

namespace ShoppingCard.Areas.Admin.Repository
{
    public class EmailSender : IEmailSender
    {
        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                EnableSsl = true, //bat bao mat
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("1977datbui@gmail.com", "xinosudnurqnwlpk")
            };

            return client.SendMailAsync(
                new MailMessage(from: "1977datbui@gmail.com",
                                to: email,
                                subject: subject,
                                body: message
                                ));
        }
    }
}
