
using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Like;
using AutoMapper;
using Doctors_Forum_Server.Repositories.Topic;
using Doctors_Forum_Server.DTOs.Post;
using Doctors_Forum_Server.Middlewares;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using Doctors_Forum_Server.DTOs.Like;
using Microsoft.Extensions.Hosting;
using Doctors_Forum_Server.Repositories.Post;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LikeController : ControllerBase
    {
        private ILikeRepository _repository;
        private ITopicRepository _topicRepository;
        private IMapper _mapper;
        private IPostRepository _postRepository;
        public LikeController(ILikeRepository repository, ITopicRepository topicRepository, IMapper mapper, IPostRepository postRepository)
        {
            _repository = repository;
            _postRepository = postRepository;
            _mapper = mapper;
            _topicRepository = topicRepository;
        }
        [HttpPost]
        [Authorize(Roles = "Member")]
        public async Task<IActionResult> Create([FromBody] LikeCreateDTO like)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                var postFind = await _postRepository.FindOne(like.PostId);
                if ( postFind== null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The post does not exist in the system",
                    }));
                }
                if (like.CommentId != null)
                {
                    if (postFind?.Comments?.SingleOrDefault(c => c.Id.Equals(like.CommentId)) == null)
                    {
                        return Ok(Helpers.ResponseApi(new ResponseModel()
                        {
                            code = Helpers.NOTFOUND_CODE,
                            message = "The comment does not exist in the system",
                        }));
                    }
                }
                
                // đầu tiên lấy UserId(user.Id) và Post(postFind.Id)
                List<Like>? likeFind = _repository.GetAllLikePost(like.PostId);
                bool isLike = true;
                bool isLikePost = true;

                if (like.CommentId == null)
                {
                    Like? findLikePost = _repository.FindLikeByPostId(like.PostId);
                    if (findLikePost != null)
                    {
                        await _repository.Delete(findLikePost.Id);
                        isLike = false;
                    }
                    // delete like post
                }
                else
                {
                    Like? findLikePost = _repository.FindLikeComment(like.PostId, like.CommentId ?? 0);
                    if (findLikePost != null)
                    {
                        await _repository.Delete(findLikePost.Id);
                        isLike = false;
                    }
                    isLikePost = false;
                    // delete like comment
                }

                if (isLike)
                {
                    Like likeNew = _mapper.Map<Like>(like);
                    likeNew.UserId = user.Id;
                    await _repository.Create(likeNew);

                    var response = _mapper.Map<LikeBaseDTO>(likeNew);
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.SUCCESS_CODE,
                        message = "Create " + (isLikePost ? "post" : "comment") + " Successfully",
                        result= response
                    }));
                }
                else
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.SUCCESS_CODE,
                        message = "Unlike " + (isLikePost ? "post" : "comment") + " Successfully",
                    }));
                }
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
