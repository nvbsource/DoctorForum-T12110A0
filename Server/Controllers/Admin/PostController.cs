using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Post;
using Doctors_Forum_Server.DTOs.Post;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.Models;
using AutoMapper;
using Doctors_Forum_Server.Utilities;
using Doctors_Forum_Server.Repositories.Topic;
using System;
using Doctors_Forum_Server.DTOs.User;
using System.Xml.XPath;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Mvc.Filters;
using Doctors_Forum_Server.Repositories.Comment;

namespace Doctors_Forum_Server.Controllers.Admin
{
    [Route("api/admin/[controller]")]
    [ApiController]
    public class PostController : ControllerBase
    {
        private IPostRepository _repository;
        private ITopicRepository _topicRepository;
        private ICommentRepository _commentRepository;
        private IMapper _mapper;
        public PostController(IPostRepository repository, ITopicRepository topicRepository, IMapper mapper, ICommentRepository commentRepository)
        {
            _repository = repository;
            _mapper = mapper;
            _topicRepository = topicRepository;
            _commentRepository = commentRepository;
        }
        [HttpGet]
        public IActionResult GetAll(int userId)
        {
            var posts = _repository.GetAllPost();
            var response = _mapper.Map<List<ResponsePostDTOAdmin>>(posts);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get Post Successfully",
                result = response
            }));
        }
        [HttpGet("postOfTopic/{topicId}")]
        public IActionResult GetAllPostOfTopic(int topicId)
        {
            var posts = _repository.GetAllPostOfTopic(topicId);
            var response = _mapper.Map<List<ResponsePostDTOAdmin>>(posts);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get Post Successfully",
                result = response
            }));
        }
    }
}
