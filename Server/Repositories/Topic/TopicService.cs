using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Topic
{
    using System.Collections.Generic;
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.Post;
    using Doctors_Forum_Server.DTOs.Topic;
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;

    public class TopicService : BaseRepository<Topic>, ITopicRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        public TopicService(ApplicationContext context, IConfiguration config, IMapper mapper) : base(context)
        {
            _config = config;
            _mapper = mapper;
        }

        public List<TopicResponseClientDTO> GetAllTopicAndSubs()
        {
            var topicParents = this._context.Topics
                .Where(t => t.ParentId == null)
                .Include(t => t.SubTopics)
                    .ThenInclude(st => st.Posts)
                    .ThenInclude(st => st.User)
                    .Include(st => st.SubTopics)
                .Select(t => new TopicResponseClientDTO()
                {
                    Description = t.Description,
                    Icon = t.Icon,
                    SubTopics = _mapper.Map<List<TopicResponseClientDTO>>(t.SubTopics.Select(st => new TopicResponseClientDTO()
                    {
                        Description = st.Description,
                        Icon = st.Icon,
                        SubTopics = _mapper.Map<List<TopicResponseClientDTO>>(st.SubTopics),
                        Id = st.Id,
                        Title = st.Title,
                        LastPost = _mapper.Map<ResponsePostDTO>(st.Posts.OrderByDescending(p => p.Created_at).FirstOrDefault()),
                        NumberPost = st.Posts.Count(),
                        IsAdmin = st.IsAdmin
                    })),
                    Id = t.Id,
                    Title = t.Title,
                    LastPost = null,
                    NumberPost = null
                }).ToList();
            return topicParents;

        }
        public TopicResponseClientDTO GetTopicOfParent(int id)
        {
            var topicParent = this._context.Topics
                .Where(t => t.Id == id)
                .Include(t => t.SubTopics) // Lấy topic con của cấp 1
                    .ThenInclude(st => st.SubTopics) // Lấy topic con của cấp 2
                .Select(t => new TopicResponseClientDTO()
                {
                    Description = t.Description,
                    Icon = t.Icon,
                    SubTopics = _mapper.Map<List<TopicResponseClientDTO>>(t.SubTopics),
                    Id = t.Id,
                    Title = t.Title
                }).FirstOrDefault();
            return topicParent;
        }

    }
}
