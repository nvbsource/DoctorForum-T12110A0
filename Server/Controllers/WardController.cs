using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Ward;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WardController : ControllerBase
    {
        private ICertificateRepository _repository;
        public WardController(ICertificateRepository repository)
        {
            _repository = repository;
        }
    }
}
