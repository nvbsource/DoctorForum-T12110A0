using System.Net.Mail;
using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
namespace Doctors_Forum_Server.Utilities
{
    public class Helpers
    {
        public static int SUCCESS_CODE { get; } = 200;
        public static int CREATED_CODE { get; } = 201;
        public static int ERROR_DATA_CODE { get; } = 400;
        public static int UNAUTHORIZED_CODE { get; } = 401;
        public static int NOTFOUND_CODE { get; } = 404;
        public static int ERROR_CODE { get; } = 500;
        public static int MISS_PARAM_CODE { get; } = 501;
        public static int ERROR_ALREADY_EXISTS { get; } = 600;
        public static int ERROR_INSERT { get; } = 601;
        public static ResponseModel ResponseApi(ResponseModel data)
        {
            return data;
        }

        public async Task SendEmailAsync(string toEmail, string subject, string body)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Doctor Web Forum", "doctor@vn.com"));
            message.To.Add(new MailboxAddress("", toEmail));
            message.Subject = subject;

            var htmlBody = new TextPart("html")
            {
                Text = body
            };

            message.Body = htmlBody;

            using var client = new MailKit.Net.Smtp.SmtpClient();
            await client.ConnectAsync("smtp.gmail.com", 465, SecureSocketOptions.SslOnConnect);
            await client.AuthenticateAsync("vexegroup@gmail.com", "hssadsgbzkpdygdb");
            await client.SendAsync(message);
            await client.DisconnectAsync(true);
        }
        public void SendEmailList(string[] toAddresses, string subject, string body)
        {
            foreach (var email in toAddresses)
            {
                SendEmailAsync(email, subject, body);
            }
        }


    }
}
