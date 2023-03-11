using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.AppointmentReason;
using Doctors_Forum_Server.Models;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.Utilities;
using System.Collections.Generic;
using AutoMapper;
using Doctors_Forum_Server.DTOs.AppointmentReson;
using Doctors_Forum_Server.Repositories.Appointment;
using Doctors_Forum_Server.DTOs.AppointmentReason;
using System.Xml.Linq;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AppointmentReasonController : ControllerBase
    {
        private IAppointmentReasonRepository _repository;
        private IMapper _mapper;
        public AppointmentReasonController(IAppointmentReasonRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        [HttpGet]
        [Authorize(Roles = "Member, Admin")]
        public IActionResult GetAllAppointmentReason()
        {
            var user = (User)HttpContext.Items["User"];
            var AppointmentReason = _repository.GetAllAppointmentReason(user.Id);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = AppointmentReason
            }));
        }
        [HttpGet("{userId}")]
        public IActionResult GetAllAppointmentReasonByUser(int userId)
        {
            var AppointmentReason = _repository.GetAllAppointmentReasonByUser(userId);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = AppointmentReason
            }));
        }

        [Authorize(Roles = "Member, Admin")]
        [HttpPost]
        public async Task<IActionResult> CreateAppointmentAsync(List<AppointmentReasonCreateDTO> data)
        {
            User? user = HttpContext.Items["User"] as User;

            foreach ((var index, var item) in data.Select((value, i) => (i, value)))
            {
                if (string.IsNullOrEmpty(item.Name?.Trim()))
                {
                    ModelState.AddModelError($"AppointmentReason[{index}]", "This field cannot be left blank");
                    continue;
                }
                if (_repository.FindByName(user.Id, item.Name.Trim()))
                {
                    ModelState.AddModelError($"AppointmentReason[{index}]", "Already exist in your account");
                }
            }
            if (ModelState.IsValid)
            {
                var appointmentReasons = data.Select(ar => new AppointmentReason
                {
                    Name = ar.Name.Trim(),
                    UserId = user.Id
                }).ToList();

                await _repository.AddRange(appointmentReasons);

                var response = _mapper.Map<List<AppointmentReasonBaseDTO>>(appointmentReasons);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Appointment created successfully",
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
        public async Task<IActionResult> Update(AppointmentReasonUpdateDTO data, int id)
        {
            if (data.Name?.Trim() == "")
            {
                ModelState.AddModelError("Name", "Name cannot be left blank");
            }
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                AppointmentReason? appointmentReason = await _repository.FindOne(id);
                if (appointmentReason == null || appointmentReason.UserId != user.Id)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The appointment reason does not exist in the system",
                    }));
                }
                var appointmentUpdate = _mapper.Map(data, appointmentReason);
                await _repository.Update(appointmentUpdate);

                var response = _mapper.Map<AppointmentReasonBaseDTO>(appointmentUpdate);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Appointment reason updated successfully",
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
        public async Task<IActionResult> Update(int id)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                AppointmentReason? appointmentReason = await _repository.FindOne(id);
                if (appointmentReason == null || appointmentReason.UserId != user.Id)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The appointment reason does not exist in the system",
                    }));
                }
                await _repository.Delete(id);

                var response = _mapper.Map<AppointmentReasonBaseDTO>(appointmentReason);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Appointment reason deleted successfully",
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

    }
}
