using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Ward;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificateController : ControllerBase
    {
        private ICertificateRepository _repository;
        public CertificateController(ICertificateRepository repository)
        {
            _repository = repository;
        }
    }
}
