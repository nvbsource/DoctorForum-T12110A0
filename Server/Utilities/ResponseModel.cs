namespace Doctors_Forum_Server.Utilities
{
    public class ResponseModel
    {
        public int code { get; set; }
        public string message { get; set; }
        public object result { get; set; } = new List<string>();
        public object errors { get; set; } = new List<string>();
    }
}
