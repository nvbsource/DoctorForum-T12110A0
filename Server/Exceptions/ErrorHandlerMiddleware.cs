using System.Net;
using Doctors_Forum_Server.Utilities;
using Newtonsoft.Json;

namespace Doctors_Forum_Server.Exceptions
{
    public class ErrorHandlerMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ErrorHandlerMiddleware> _logger;

        public ErrorHandlerMiddleware(RequestDelegate next, ILogger<ErrorHandlerMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }
        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "System error");
                await HandleExceptionAsync(context, ex);
            }
        }
        public static Task HandleExceptionAsync(HttpContext context, Exception ex)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            var response = new ResponseModel()
            {
                code = context.Response.StatusCode,
                message = ex.Message,
            };
            var json = JsonConvert.SerializeObject(Helpers.ResponseApi(response));
            return context.Response.WriteAsync(json);
        }
    }
}
