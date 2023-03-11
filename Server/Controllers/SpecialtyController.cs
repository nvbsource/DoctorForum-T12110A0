using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Specialty;
using Doctors_Forum_Server.Middlewares;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using Microsoft.EntityFrameworkCore;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SpecialtyController : ControllerBase
    {
        private ISpecialtyRepository _repository;
        public SpecialtyController(ISpecialtyRepository repository)
        {
            _repository = repository; 			
        }

		[HttpGet]
		public IActionResult GetAllSpecialty()
		{
			//var user = HttpContext.Items.ContainsKey("User") ? (Specialty)HttpContext.Items["User"] : null;
			var specialty = _repository.GetAllSpecialty();
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = specialty
            }));
		}
	}
}
