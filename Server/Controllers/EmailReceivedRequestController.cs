using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.EmailReceivedRequest;
using Doctors_Forum_Server.DTOs.AppointmentReason;
using Doctors_Forum_Server.DTOs.AppointmentReson;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using Doctors_Forum_Server.DTOs.EmailReceivedRequest;
using AutoMapper;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmailReceivedRequestController : ControllerBase
    {
        private IEmailReceivedRequestRepository _repository;
        private readonly IMapper _mapper;
        public EmailReceivedRequestController(IEmailReceivedRequestRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        [HttpGet]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> GetAll()
        {
            var user = (User)HttpContext.Items["User"];
            var emails = await _repository.GetAllOfUser(user.Id);
            var response = _mapper.Map<List<EmailReceivedRequestBaseDTO>>(emails);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = response
            }));
        }

        [Authorize(Roles = "Member, Admin")]
        [HttpPost]
        public async Task<IActionResult> Create(EmailReceivedRequestCreateDTO data)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                EmailReceivedRequest emailNew = _mapper.Map<EmailReceivedRequest>(data);
                emailNew.UserId = user.Id;
                await _repository.Create(emailNew);
                var response = _mapper.Map<EmailReceivedRequestBaseDTO>(emailNew);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Create email successfully",
                    result = response
                }));
            }
           
            var errors = ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, x => x.Value.Errors.Select(e => e.ErrorMessage).ToList());
            return BadRequest(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.ERROR_DATA_CODE,
                message = "Input data is incorrect",
                errors = errors
            }));
        }
        [Authorize(Roles = "Member, Admin")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(EmailReceivedRequestCreateDTO data, int id)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                EmailReceivedRequest? email = await _repository.FindOne(id);
                if (email == null || email.UserId != user.Id)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The email does not exist in the system",
                    }));
                }
                var emailUpdate = _mapper.Map(data, email);
                await _repository.Update(emailUpdate);

                var response = _mapper.Map<EmailReceivedRequestBaseDTO>(emailUpdate);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Email updated successfully",
                    result = response
                }));
            }
            var errors = ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, x => x.Value.Errors.Select(e => e.ErrorMessage).ToList());
            return BadRequest(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.ERROR_DATA_CODE,
                message = "Input data is incorrect",
                errors = errors
            }));
        }

        [Authorize(Roles = "Member, Admin")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
                User? user = HttpContext.Items["User"] as User;
                EmailReceivedRequest? email = await _repository.FindOne(id);
                if (email == null || email.UserId != user.Id)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The email does not exist in the system",
                    }));
                }
                await _repository.Delete(id);

                var response = _mapper.Map<EmailReceivedRequestBaseDTO>(email);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Email deleted successfully",
                    result = response
                }));
        }
    }
}
