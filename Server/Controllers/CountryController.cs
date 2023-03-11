using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Country;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CountryController : ControllerBase
    {
        private ICountryRepository _repository;
        public CountryController(ICountryRepository repository)
        {
            _repository = repository;
        }
    }
}
