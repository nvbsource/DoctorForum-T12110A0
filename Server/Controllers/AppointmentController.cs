using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Appointment;
using Doctors_Forum_Server.Utilities;
using Doctors_Forum_Server.Models;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.Repositories.AppointmentReason;
using AutoMapper;
using System.Threading.Tasks;
using Doctors_Forum_Server.DTOs.AppointmentReason;
using Doctors_Forum_Server.DTOs.AppointmentReson;
using Doctors_Forum_Server.Repositories;
using Doctors_Forum_Server.DTOs.Appointment;
using Doctors_Forum_Server.Repositories.User;
using Hangfire;
using Doctors_Forum_Server.Repositories.EmailReceivedRequest;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AppointmentController : ControllerBase
    {
        private readonly IAppointmentRepository _repository;
        private readonly IUserRepository _userRepository;
        private readonly IAppointmentReasonRepository _appointmentReasonRepository;
        private readonly IEmailReceivedRequestRepository _emailReceivedRequestRepository;
        private readonly IMapper _mapper;

        public AppointmentController(IAppointmentRepository repository, IEmailReceivedRequestRepository emailReceivedRequestRepository, IAppointmentReasonRepository appointmentReasonRepository, IUserRepository userRepository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
            _userRepository = userRepository;
            _appointmentReasonRepository = appointmentReasonRepository;
            _emailReceivedRequestRepository = emailReceivedRequestRepository;
        }
        [HttpGet]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> GetAll()
        {
            User? user = HttpContext.Items["User"] as User;
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = _repository.GetAllAppointment(user.Id)
            }));
        }
        [HttpPut("{id}/updateState")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> UpdateState(int id, [FromBody] AppointmentUpdateStateDTO data)
        {
            User? user = HttpContext.Items["User"] as User;
            var appointment = await _repository.FindOne(id);
            if (appointment == null || appointment.UserId != user.Id)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The appointment does not exist in the system",
                }));
            }
            var appointReason = await _appointmentReasonRepository.FindOne(appointment.AppointmentReasonId);

            if (appointment.Status != "pending")
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.ERROR_CODE,
                    message = "This appointment has been processed before",
                }));
            }

            _mapper.Map(data, appointment);
            DateTime timeStart = appointment.StartDate.Date.Add(appointment.TimeStart?.TimeOfDay ?? TimeSpan.Zero);
            appointment.TimeStart = timeStart;
            var title = "";
            var body = "";
            if (data.Status == "accept")
            {
                title = "Your appointment has been accepted";
                body = $"<b>Information patient</b>" +
                           $"<br/>Full Name: {appointment.FullName}" +
                           $"<br/>Phone Number: {appointment.Phone}" +
                           $"<br/>Email Address: {appointment.Email}" +
                           $"<br/>Reason: {appointReason?.Name} " +
                           $"<br/>Appointment time: Patients please arrive 30 minutes in advance - {appointment.StartDate.ToString("yyyy-MM-dd")} {data.TimeStart?.ToString("HH:mm")}" +
                           $"<br/>Other: {appointment.CommentAdmin}";
                if (!user.IsDisabledRemindPatient)
                {
                    var titleRemind = "The appointment is coming, please pay attention and come early";
                    var bodyRemind = $"{user.RemindPatient} hour left until your appointment, please arrive 30 minutes early";
                    var jobId = BackgroundJob.Schedule(() => new Helpers().SendEmailAsync(appointment.Email, titleRemind, bodyRemind), timeStart.AddHours(-user.RemindPatient));
                }
            }
            if (data.Status == "cancel")
            {
                appointment.TimeStart = null;
                title = "Your appointment has been cancelled";
                body = $"<b>Information patient</b>" +
                        $"<br/>Full Name: {appointment.FullName}" +
                        $"<br/>Phone Number: {appointment.Phone}" +
                        $"<br/>Email Address: {appointment.Email}" +
                        $"<br/>Reason: {appointment.AppointmentReason?.Name} " +
                        $"<br/>Appointment Date: {appointment.StartDate.ToString("yyyy-MM-dd")}" +
                        $"<br/>The reason the appointment was canceled: {data.CommentAdmin}";
            }
            await _repository.Update(appointment);
            BackgroundJob.Enqueue(() => new Helpers().SendEmailAsync(appointment.Email, title, body));
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Update successfully"
            }));
        }

        [HttpPost]
        public async Task<IActionResult> Create(AppointmentCreateDTO data)
        {
            var user = await _userRepository.FindOne(data.UserId);
            var appointReason = await _appointmentReasonRepository.FindOne(data.AppointmentReasonId);
            if (user == null)
            {
                ModelState.AddModelError("UserId", "User not exist in system");
            }
            if (user != null && user.IsDisabledAppointmentEveryDay)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.ERROR_CODE,
                    message = "The doctor is temporarily suspending appointment requests"
                }));
            }
            if (appointReason == null)
            {
                ModelState.AddModelError("AppointmentReasonId", "Appointment reason not exist in system");
            }
            if (user != null)
            {
                var checkAcceptRequest = _repository.CheckAcceptRequestAppointment(user, data.StartDate);
                var checkUserRequestByDate = _repository.CheckExistsUserRequestInDate(data.Email, data.Phone, data.StartDate);
                if (!checkAcceptRequest)
                {
                    ModelState.AddModelError("StartDate", "The number of appointments for the day is full");
                }
                else if (checkUserRequestByDate)
                {
                    ModelState.AddModelError("StartDate", "You can only create 1 appointment with 1 doctor on the start date");
                }
            }

            if (ModelState.IsValid)
            {
                await _repository.Create(_mapper.Map<Appointment>(data));
                var emails = await _emailReceivedRequestRepository.GetAllOfUser(user.Id);
                var title = $"Announcement has 1 new appointment request  - {data.StartDate.ToString("yyyy-MM-dd")}";
                var body = $"Full Name: {data.FullName}" +
                           $"<br/>Phone Number: {data.Phone} " +
                           $"<br/>Email Address: {data.Email} " +
                           $"<br/>Reason: {appointReason.Name} " +
                           $"<br/>Message: Just created a new appointment on {data.StartDate.ToString("yyyy-MM-dd")}";
                BackgroundJob.Enqueue(() => new Helpers().SendEmailList(emails.Select(e => e.Email).ToArray(), title, body));
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Create request appointment successfully"
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
