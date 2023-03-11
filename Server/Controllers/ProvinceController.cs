using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Province;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProvinceController : ControllerBase
    {
        private IProvinceRepository _repository;
        public ProvinceController(IProvinceRepository repository)
        {
            _repository = repository;
        }
    }
}
