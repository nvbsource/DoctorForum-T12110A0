using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Comment;
using Microsoft.AspNetCore.Authorization;
using AutoMapper;
using Doctors_Forum_Server.Repositories.Post;
using Doctors_Forum_Server.Repositories.Topic;
using Doctors_Forum_Server.DTOs.Like;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using Doctors_Forum_Server.DTOs.Comment;
using Doctors_Forum_Server.DTOs.Post;
using Microsoft.Extensions.Hosting;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : ControllerBase
    {
        private ICommentRepository _repository;
        private IPostRepository _postRepository;
        private IMapper _mapper;
        public CommentController(ICommentRepository repository, IMapper mapper, IPostRepository postRepository)
        {
            _repository = repository;
            _mapper = mapper;
            _postRepository = postRepository;
        }
        [HttpDelete("{commentId}")]
        [Authorize(Roles = "Member")]
        public async Task<IActionResult> Delete(int commentId)
        {
            User? user = HttpContext.Items["User"] as User;
            var commentFind = await _repository.FindOne(commentId);
            if (commentFind == null || commentFind.UserId != user.Id)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The Comment does not exist in the system",
                }));
            }
            await _repository.Delete(commentId);

            var response = _mapper.Map<CommentBaseDTO>(commentFind);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Delete Comment Successfully",
                result = response
            }));
        }
        [HttpPut]
        [Authorize(Roles = "Member")]
        public async Task<IActionResult> Update([FromBody] UpdateCommentDTO comment)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                var commentFind = await _repository.FindOne(comment.CommentId);
                if (commentFind == null || commentFind.UserId != user.Id)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The Comment does not exist in the system",
                    }));
                }
                commentFind.Content = comment.Content;

                await _repository.Update(commentFind);

                var response = _mapper.Map<CommentBaseDTO>(commentFind);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Update Comment Successfully",
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
        [HttpPost]
        [Authorize(Roles = "Member,Admin")]
        public async Task<IActionResult> Create([FromBody] CreateCommentDTO comment)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                var postFind = await _postRepository.FindOne(comment.PostId);
                if (postFind == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The PostId does not exist in the system",
                    }));
                }
                if (comment.ParentId != null && await _repository.FindOne(comment.ParentId ?? 0) == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The Comment does not exist in the system",
                    }));
                }

                Comment commentNew = _mapper.Map<Comment>(comment);

                commentNew.UserId = user.Id;

                await _repository.Create(commentNew);

                var response = _mapper.Map<CreateCommentDTO>(commentNew);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Create Comment Successfully",
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
