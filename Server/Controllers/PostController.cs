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

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
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
        [HttpPost]      
        [Authorize(Roles = "Member, Admin")]

        public async Task<IActionResult> Create([FromBody] CreatePostDTO post)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                Topic? topic = await _topicRepository.FindOne(post.TopicId);
                if (topic == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The topic does not exist in the system",
                    }));
                }
                if (topic.IsAdmin && user.Role != "Admin")
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.UNAUTHORIZED_CODE,
                        message = "You do not have permission to post in this thread",
                    }));
                }

                Post postNew = _mapper.Map<Post>(post);
                postNew.UserId = user.Id;

                await _repository.Create(postNew);

                var response = _mapper.Map<PostBaseDTO>(postNew);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Create Post Successfully",
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
        [HttpDelete("{id}")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            User? user = HttpContext.Items["User"] as User;
            Post? ownPost = await _repository.FindOne(id);
            if (ownPost == null || ownPost.UserId != user?.Id)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The post does not exist in the system",
                }));
            }
            await _repository.Delete(id);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Delete Post Successfully",
            }));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Detail(int id)
        {
            Post? ownPost = await _repository.Detail(id);
            if (ownPost == null)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The post does not exist in the system",
                }));
            }
            var response = _mapper.Map<ResponsePostDTO>(ownPost);
            response.NumberComments = _commentRepository.GetNumberCommentInPost(id);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get Post Successfully",
                result = response
            }));
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> Edit(int id, [FromBody] UpdatePostDTO postUpdate)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                Post? ownPost = await _repository.FindOne(id);
                if (ownPost == null || ownPost.UserId != user?.Id)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The post does not exist in the system",
                    }));
                }


                ownPost = _mapper.Map(postUpdate, ownPost);

                ownPost.Updated_at= DateTime.Now;

                await _repository.Update(ownPost);

                var response = _mapper.Map<PostBaseDTO>(ownPost);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Update Post Successfully",
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

        [HttpGet]
        public IActionResult GetAllPostOfDoctor(int userId)
        {
            var posts = _repository.GetPostOfDoctor(userId);
            var response = _mapper.Map<List<ResponsePostDTO>>(posts);
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
            var response = _mapper.Map<List<ResponsePostDTO>>(posts);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get Post Successfully",
                result = response
            }));
        }
        [HttpGet("getNewsPost")]
        public IActionResult GetNewsPost(int perPage)
        {
            var posts = _repository.GetNewsPost(perPage);
            var response = _mapper.Map<List<ResponsePostDTO>>(posts);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get Post Successfully",
                result = response
            }));
        }
    }
}
