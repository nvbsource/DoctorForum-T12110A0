using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.CommentImage;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentImageController : ControllerBase
    {
        private ICommentImageRepository _repository;
        public CommentImageController(ICommentImageRepository repository)
        {
            _repository = repository;
        }
    }
}
