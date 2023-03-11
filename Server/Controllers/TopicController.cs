using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Topic;
using Doctors_Forum_Server.DTOs.User;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Repositories.Position;
using Doctors_Forum_Server.Utilities;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using AutoMapper;
using Doctors_Forum_Server.DTOs.Topic;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TopicController : ControllerBase
    {
        private ITopicRepository _repository;
        private readonly IMapper _mapper;
        public TopicController(ITopicRepository repository, IMapper mapper)
        {
            _repository = repository;
            _mapper = mapper;
        }
        [HttpPut("update/{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Update([FromBody] TopicUpdateDTO updateTopic, int id)
        {
            User? user = HttpContext.Items["User"] as User;
            var topic = await _repository.FindOne(id);
            if (topic == null)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The topic does not exist in the system",
                }));
            }

            var topicParent = updateTopic.ParentId != null ? await _repository.FindOne(updateTopic.ParentId ?? 0) : null;
            if (topicParent == null)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "Topic parent does not exist in the system",
                }));
            }

            if (ModelState.IsValid && user != null)
            {
                _mapper.Map(updateTopic, topic);
                user.Updated_at = DateTime.Now;
                await _repository.Update(topic);

                var response = _mapper.Map<TopicBaseDTO>(topic);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Update topic successfully",
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
        [HttpGet]
        public IActionResult GetAll()
        {
            var response = _repository.GetAllTopicAndSubs();
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get topic successfully",
                result = response
            }));
        }
        [HttpGet("getTopicOfParent/{id}")]
        public IActionResult GetTopicOfParent(int id)
        {
            var response = _repository.GetTopicOfParent(id);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get topic successfully",
                result = response
            }));
        }
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create([FromBody] TopicCreateDTO topic)
        {
            if (ModelState.IsValid)
            {
                Topic? parentTopic = topic.ParentId != null ? await _repository.FindOne(topic.ParentId ?? 0) : null;
                if (topic.ParentId != null && parentTopic == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "Topic does not exist in the system",
                    }));
                }
                await _repository.Create(_mapper.Map<Topic>(topic));

                var response = topic;
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Create topic successfully",
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