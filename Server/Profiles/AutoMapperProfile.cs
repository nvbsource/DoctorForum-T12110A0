using System;
using AutoMapper;
using Doctors_Forum_Server.DTOs.Comment;
using Doctors_Forum_Server.DTOs.AppointmentReson;
using Doctors_Forum_Server.DTOs.User;
using Doctors_Forum_Server.DTOs.Like;
using Doctors_Forum_Server.DTOs.Post;
using Doctors_Forum_Server.DTOs.Topic;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.DTOs.AppointmentReason;
using Doctors_Forum_Server.DTOs.Chat;
using Doctors_Forum_Server.DTOs.ContentChat;
using Doctors_Forum_Server.DTOs.SubSpecialty;
using Doctors_Forum_Server.DTOs.Specialty;
using Newtonsoft.Json;
using Doctors_Forum_Server.DTOs.Position;
using Doctors_Forum_Server.DTOs.SpecialtyDoctor;
using Doctors_Forum_Server.DTOs.EmailReceivedRequest;
using Doctors_Forum_Server.DTOs.Appointment;

namespace Doctors_Forum_Server.Profiles
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            /* User*/
            CreateMap<UserCreateDTO, User>();
            CreateMap<CreatePostDTO, Post>();
            CreateMap<User, UserResponseCreateDTO>();
            CreateMap<SpecialtyDoctor, SpecialtyDoctorBaseDTO>();
            CreateMap<User, UserFindLocationResponseDTO>()
                .ForMember(des => des.FullName, opt => opt.MapFrom(src => string.Concat(src.FirstName, " ", src.LastName)))
                .ForMember(des => des.Created_at, opt => opt.MapFrom(src => src.Created_at.ToString("yyyy-MM-dd HH:mm:ss")))
                .ForMember(dest => dest.EmailAddress, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.FullName, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.FirstName, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.Avatar, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.LastName, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.PhoneNumber, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.Gender, opt => opt.Condition(src => !src.IsAnonymouse));
            CreateMap<User, UserBaseProfileDTO>()
             .ForMember(des => des.FullName, opt => opt.MapFrom(src => string.Concat(src.FirstName, " ", src.LastName)))
             .ForMember(dest => dest.EmailAddress, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.PhoneNumber, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.FullName, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.FirstName, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.LastName, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.LastLogin_at, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.Avatar, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.Description, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.Gender, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.Location, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.Role, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.PositionId, opt => opt.Condition(src => !src.IsAnonymouse))
             .ForMember(dest => dest.Website, opt => opt.Condition(src => !src.IsAnonymouse));
            CreateMap<int?, int>().ConvertUsing((src, dest) => src ?? dest);
            CreateMap<bool?, bool>().ConvertUsing((src, dest) => src ?? dest);
            CreateMap<UserUpdateStateDTO, User>()
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));
            CreateMap<User, UserBaseDTO>()
                .ForMember(des => des.FullName, opt => opt.MapFrom(src => string.Concat(src.FirstName, " ", src.LastName)))
                .ForMember(des => des.Created_at, opt => opt.MapFrom(src => src.Created_at.ToString("yyyy-MM-dd HH:mm:ss")))
                .ForMember(dest => dest.EmailAddress, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.FullName, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.FirstName, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.Avatar, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.LastName, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.PhoneNumber, opt => opt.Condition(src => !src.IsAnonymouse))
                .ForMember(dest => dest.Gender, opt => opt.Condition(src => !src.IsAnonymouse));

            CreateMap<User, UserBasePrivateDTO>()
                .ForMember(des => des.FullName, opt => opt.MapFrom(src => string.Concat(src.FirstName, " ", src.LastName)))
                .ForMember(des => des.Created_at, opt => opt.MapFrom(src => src.Created_at.ToString("yyyy-MM-dd HH:mm:ss")))
                .ForMember(des => des.Updated_at, opt => opt.MapFrom(src => src.Created_at.ToString("yyyy-MM-dd HH:mm:ss")))
                .ForMember(des => des.LastLogin_at, opt => opt.MapFrom(src => src.Created_at.ToString("yyyy-MM-dd HH:mm:ss")));
            CreateMap<UserUpdateDTO, User>()
                    .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;
            CreateMap<CreatePostDTO, Post>().ReverseMap();
            CreateMap<Post, PostBaseDTO>();
            CreateMap<Post, ResponsePostDTO>();
            CreateMap<Post, ResponsePostDTOAdmin>();
            CreateMap<UpdatePostDTO, Post>();
            /* Like */
            CreateMap<Like, LikeBaseDTO>();
            CreateMap<LikeCreateDTO, Like>();
            /* Comment */
            CreateMap<Comment, CommentBaseDTO>();
            CreateMap<Comment, CommentResponseDTO>();
            CreateMap<CreateCommentDTO, Comment>().ReverseMap();
            /* Topic */
            CreateMap<Topic, TopicBaseDTO>();
            CreateMap<Topic, TopicResponseClientDTO>();
            CreateMap<TopicCreateDTO, Topic>();
            CreateMap<TopicUpdateDTO, Topic>()
                .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));
            /* AppoimentReason*/
            CreateMap<AppointmentReason, AppointmentReasonBaseClientDTO>();
            CreateMap<AppointmentCreateDTO, Appointment>();
            CreateMap<Appointment, AppointmentBaseDTO>();
            CreateMap<AppointmentUpdateStateDTO, Appointment>();
            CreateMap<AppointmentReasonCreateDTO, AppointmentReason>();
            CreateMap<AppointmentReasonUpdateDTO, AppointmentReason>()
            .ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;
            CreateMap<AppointmentReason, AppointmentReasonBaseDTO>();
            /*ContentChat*/
            CreateMap<ContentChat, ContentChatBaseDTO>();
            CreateMap<ContentChat, ContentChatRoomDTO>();
            /*Chat*/
            CreateMap<Chat, ChatBaseDTO>();
            CreateMap<Chat, ChatReceiverDTO>();
            CreateMap<ChatReceiverDTO, ChatBaseDTO>();
            /*Specialty*/
            CreateMap<Specialty, SpecialtyBaseDTO>();
            CreateMap<Specialty, SpecialtyClientDTO>();
            CreateMap<Specialty, SubSpecialtyBaseDTO>();
            /*Position*/
            CreateMap<Position, PositionBaseDTO>();
            /*SpecialtyDoctor*/
            CreateMap<CreateSpecialtyDoctorDTO, SpecialtyDoctor>().ReverseMap();
            /*EmailReceivedRequest*/
            CreateMap<EmailReceivedRequestCreateDTO, EmailReceivedRequest>();
            CreateMap<EmailReceivedRequest, EmailReceivedRequestBaseDTO>();
            CreateMap<SpecialtyDoctorClientResponse, SpecialtyDoctorAdminResponse>();
            CreateMap<SpecialtyDoctorUpdateStateDTO, SpecialtyDoctor>();
        }
    }
}

