using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Position;
using Doctors_Forum_Server.Models;
using AutoMapper;
using Doctors_Forum_Server.DTOs.Position;
using Doctors_Forum_Server.Utilities;
using Microsoft.AspNetCore.Authorization;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PositionController : ControllerBase
    {
        private readonly IPositionRepository _repository;
        private readonly IMapper _mapper;
        public PositionController(IPositionRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        [HttpGet]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> GetAll()
        {
            List<Position>? listPosition = await _repository.FindAll() as List<Position>;
            var response = _mapper.Map<List<PositionBaseDTO>>(listPosition);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = response
            }));
        }
    }
}
