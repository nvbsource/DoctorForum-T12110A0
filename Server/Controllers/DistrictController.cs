using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.District;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DistrictController : ControllerBase
    {
        private IDistrictRepository _repository;
        public DistrictController(IDistrictRepository repository)
        {
            _repository = repository;
        }
    }
}
