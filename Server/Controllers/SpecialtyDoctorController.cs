using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.SpecialtyDoctor;
using AutoMapper;
using Doctors_Forum_Server.DTOs.Topic;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using Doctors_Forum_Server.DTOs.SpecialtyDoctor;
using Doctors_Forum_Server.Repositories.Specialty;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SpecialtyDoctorController : ControllerBase
    {
        private readonly ISpecialtyDoctorRepository _repository;
        private readonly ISpecialtyRepository _specialtyRepository;
        private readonly IMapper _mapper;
        public SpecialtyDoctorController(ISpecialtyDoctorRepository repository, ISpecialtyRepository specialtyRepository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
            _specialtyRepository = specialtyRepository;
        }
        [HttpDelete("{id}")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            User? user = HttpContext.Items["User"] as User;
            var specDoctor = await _repository.FindOne(id);
            if (specDoctor == null || specDoctor.UserId != user.Id)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The specialty does not exist in the system",
                }));
            }
            await _repository.Delete(id);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Delete successfully"
            }));
        }
        [HttpPut("{id}")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> Update(int id, [FromBody] SpecialtyDoctorUpdateDTO data)
        {
            User? user = HttpContext.Items["User"] as User;
            var specDoctor = await _repository.FindOne(id);
            if (specDoctor == null || specDoctor.UserId != user.Id)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The specialty does not exist in the system",
                }));
            }
            specDoctor.Educational = data.Educational;
            await _repository.Update(specDoctor);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Update successfully"
            }));
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
                result = await _repository.GetAllSpecialtiesOfDoctor(user.Id)
            }));
        }
        [HttpPut("{id}/updateState")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> UpdateState(int id, [FromBody] SpecialtyDoctorUpdateStateDTO data)
        {
            var spec = await _repository.FindOne(id);
            if (spec == null)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The Specialty does not exist in the system",
                }));
            }
            _mapper.Map(data, spec);
            await _repository.Update(spec);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Update successfully"
            }));
        }
        [HttpGet("getSpecsOfUser/{userId}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> GetAllSpecialtiesOfDoctor(int userId)
        {
            User? user = HttpContext.Items["User"] as User;
            var specOfUser = await _repository.GetAllSpecialtiesOfDoctor(userId);
            var specResponse = new List<SpecialtyDoctorAdminResponse>();
            foreach (var spec in specOfUser)
            {
                var specMapper = _mapper.Map<SpecialtyDoctorAdminResponse>(spec);
                var directory = Path.Combine("uploads", "files", $"{spec.Id}");
                var files = new List<FileSpecialtyDoctorDTO>();
                if (System.IO.Directory.Exists(directory))
                {
                    foreach (var fileInfo in new DirectoryInfo(directory).GetFiles())
                    {
                        files.Add(new FileSpecialtyDoctorDTO()
                        {
                            Url = $"{HttpContext.Request.Scheme}://{HttpContext.Request.Host}/uploads/files/{spec.Id}/{fileInfo.Name}"
                        });
                    }
                }
                specMapper.files = files.Select(f =>
                {
                    string timestampString = f.Url.Split('_').Last().Split('.').First(); // Lấy chuỗi số từ URL
                    long unixTimeSeconds = long.Parse(timestampString); // Chuyển chuỗi số thành một số nguyên
                    DateTimeOffset dateTimeOffset = DateTimeOffset.FromUnixTimeSeconds(unixTimeSeconds); // Tạo đối tượng DateTimeOffset từ số giây
                    DateTime dateTime = dateTimeOffset.DateTime;
                    return new FileSpecialtyDoctorDTO()
                    {
                        Url = f.Url,
                        Created_At = dateTime

                    };
                }).OrderByDescending(f => f.Created_At).ToList();
                specResponse.Add(specMapper);
            }

            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = specResponse
            }));
        }

        [Authorize(Roles = "Member,Admin")]
        [HttpPost]
        public async Task<IActionResult> CreateSpecialtyDoctorsAsync(CreateSpecialtyDoctorDTO newSpecialty)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;

                SpecialtyDoctor specialtyDoctor = _mapper.Map<SpecialtyDoctor>(newSpecialty);
                Specialty? existingSpecialty = await _specialtyRepository.FindOne(specialtyDoctor.SpecialtyId);
                if (existingSpecialty == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The Specialty does not exist in the system",
                    }));
                }
                specialtyDoctor.UserId = user.Id;
                try
                {
                    await _repository.Create(specialtyDoctor);
                }
                catch (Exception ex)
                {
                    return BadRequest(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.ERROR_DATA_CODE,
                        message = "Existing data cannot be added",
                    }));
                }
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Create specialty successfully",
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
        [HttpPost("{id}/uploadFileCV")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> UploadFileCV(int id, IFormFile file)
        {
            var specDoctor = await _repository.FindOne(id);
            if (specDoctor == null)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The Specialty does not exist in the system",
                }));
            }
            if (specDoctor.Status == "accept")
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.ERROR_CODE,
                    message = "Your expertise has been approved by the admin before",
                }));
            }
            if (file == null || file.Length == 0)
            {
                return BadRequest(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.ERROR_DATA_CODE,
                    message = "Please select a file",
                }));
            }

            var uploads = Path.Combine(Directory.GetCurrentDirectory(), $"uploads/files/{id}");
            if (!Directory.Exists(uploads))
            {
                Directory.CreateDirectory(uploads);
            }
            DateTimeOffset currentTimeStamp = DateTimeOffset.UtcNow;
            TimeSpan offset = TimeSpan.FromHours(7); // replace with your desired time zone offset
            DateTimeOffset currentLocalTimeStamp = currentTimeStamp.ToOffset(offset);
            long unixTimeSeconds = currentLocalTimeStamp.ToUnixTimeMilliseconds() / 1000;
            string formattedTimestamp = unixTimeSeconds.ToString("0");

            var fileName = Path.GetFileNameWithoutExtension(file.FileName) + "_" +
                formattedTimestamp + Path.GetExtension(file.FileName);
            var filePath = Path.Combine(uploads, fileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            specDoctor.Status = "checking";
            await _repository.Update(specDoctor);

            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Upload file successfully",
                result = $"{HttpContext.Request.Scheme}://{HttpContext.Request.Host}/uploads/files/{fileName}"
            }));
        }

    }
}
