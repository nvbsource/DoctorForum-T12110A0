using System;
using System.Net;
using System.Numerics;
using System.Xml.Linq;
using Doctors_Forum_Server.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace Doctors_Forum_Server.Data
{
    public class ApplicationContext : DbContext
    {
        public ApplicationContext(DbContextOptions<ApplicationContext> options) : base(options)
        {
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().OwnsOne(x => x.Location);
            // one User has many EmailReceivedRequests
            modelBuilder.Entity<User>()
                .HasMany(s => s.EmailReceivedRequests)
                .WithOne(c => c.User)
                .HasForeignKey(d => d.UserId);

            // many to many - Specialty has many User and User has many Specialty

            modelBuilder.Entity<SpecialtyDoctor>()
              .HasAlternateKey(d => new { d.UserId, d.SpecialtyId });

            modelBuilder.Entity<SpecialtyDoctor>()
                .HasOne(sd => sd.Specialty)
                .WithMany(s => s.SpecialtyDoctors)
                .HasForeignKey(sd => sd.SpecialtyId);

            modelBuilder.Entity<SpecialtyDoctor>()
                .HasMany(sd => sd.Certificates)
                .WithOne(s => s.SpecialtyDoctor)
                .HasPrincipalKey(c => c.Id);

            modelBuilder.Entity<SpecialtyDoctor>()
                .HasOne(sd => sd.User)
                .WithMany(s => s.SpecialtyDoctors)
                .HasForeignKey(sd => sd.UserId);

            // one Chat has many ContentChat
            modelBuilder.Entity<Chat>()
                .HasMany(s => s.ContentChats)
                .WithOne(c => c.Chat)
                .HasForeignKey(d => d.ChatId)
                .OnDelete(DeleteBehavior.Restrict);
            // one User has many ContentChat
            modelBuilder.Entity<User>()
                .HasMany(s => s.ContentChats)
                .WithOne(c => c.User)
                .HasForeignKey(d => d.UserId);
            // one User has many Chat
            modelBuilder.Entity<Chat>()
                .HasOne(c => c.User)
                .WithMany(d => d.Chats)
                .HasForeignKey(c => c.UserId)
                .OnDelete(DeleteBehavior.Restrict);
            // one Specialty has many Specialty
            modelBuilder.Entity<Specialty>()
                .HasMany(a => a.SubSpecialties)
                .WithOne(b => b.ParentSpecialty)
                .HasForeignKey(b => b.ParentId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Chat>()
                .HasOne(c => c.ReceiverUser)
                .WithMany()
                .HasForeignKey(c => c.ReceiverUserId)
                .OnDelete(DeleteBehavior.Restrict);

            // one Position has many User
            modelBuilder.Entity<Position>()
                .HasMany(a => a.Users)
                .WithOne(b => b.Position)
                .HasForeignKey(b => b.PositionId);

            // one User has many Like
            modelBuilder.Entity<User>()
                .HasMany(a => a.Likes)
                .WithOne(b => b.User)
                .HasForeignKey(b => b.UserId);

            // one ContentChat has many ContentChat
            modelBuilder.Entity<ContentChat>()
                .HasMany(a => a.ReplyChats)
                .WithOne(b => b.ParentChat)
                .HasForeignKey(b => b.ParentId)
                .OnDelete(DeleteBehavior.Restrict);

            // one Post has many Like
            modelBuilder.Entity<Post>()
                .HasMany(a => a.Likes)
                .WithOne(b => b.Post)
                .HasForeignKey(b => b.PostId)
                .OnDelete(DeleteBehavior.Restrict);

            // one Comment has many Like
            modelBuilder.Entity<Comment>()
                .HasMany(a => a.Likes)
                .WithOne(b => b.Comment)
                .HasForeignKey(b => b.CommentId)
                .OnDelete(DeleteBehavior.Restrict);

            // one User has many Post
            modelBuilder.Entity<User>()
                .HasMany(a => a.Posts)
                .WithOne(b => b.User)
                .HasForeignKey(b => b.UserId);

            // one User has many Comment
            modelBuilder.Entity<User>()
               .HasMany(a => a.Comments)
               .WithOne(b => b.User)
               .HasForeignKey(b => b.UserId);

            // one User has many UserAccesslogs
            modelBuilder.Entity<User>()
               .HasMany(a => a.UserAccessLogs)
               .WithOne(b => b.User)
               .HasForeignKey(b => b.UserId);

            // one Post has many Comment
            modelBuilder.Entity<Post>()
               .HasMany(a => a.Comments)
               .WithOne(b => b.Post)
               .HasForeignKey(b => b.PostId)
               .OnDelete(DeleteBehavior.Restrict);

            // one Comment has many CommentImage
            modelBuilder.Entity<Comment>()
               .HasMany(a => a.CommentImages)
               .WithOne(b => b.Comment)
               .HasForeignKey(b => b.CommentId);

            // one Comment has many Comment
            modelBuilder.Entity<Comment>()
               .HasMany(a => a.ReplyComments)
               .WithOne(b => b.ParentComment)
               .HasForeignKey(b => b.ParentId)
               .OnDelete(DeleteBehavior.Restrict);

            // one Topic has many Post
            modelBuilder.Entity<Topic>()
               .HasMany(a => a.Posts)
               .WithOne(b => b.Topic)
               .HasForeignKey(b => b.TopicId);

            // one Topic has many Topic
            modelBuilder.Entity<Topic>()
               .HasMany(a => a.SubTopics)
               .WithOne(b => b.ParentTopic)
               .HasForeignKey(b => b.ParentId)
               .OnDelete(DeleteBehavior.Restrict);

            // one Country has many Province
            modelBuilder.Entity<Country>()
               .HasMany(a => a.Provinces)
               .WithOne(b => b.Country)
               .HasForeignKey(b => b.CountryId);

            // one Province has many District
            modelBuilder.Entity<Province>()
               .HasMany(a => a.Districts)
               .WithOne(b => b.Province)
               .HasForeignKey(b => b.ProvinceId);

            // one District has many Ward
            modelBuilder.Entity<District>()
               .HasMany(a => a.Wards)
               .WithOne(b => b.District)
               .HasForeignKey(b => b.DistrictId);

            // one User has many Appointment
            modelBuilder.Entity<User>()
               .HasMany(a => a.Appointments)
               .WithOne(b => b.User)
               .HasForeignKey(b => b.UserId)
               .OnDelete(DeleteBehavior.Restrict);

            // one User has many AppointmentReason
            modelBuilder.Entity<User>()
               .HasMany(a => a.AppointmentReasons)
               .WithOne(b => b.User)
               .HasForeignKey(b => b.UserId);

            // one AppointmentReason has many Appointment
            modelBuilder.Entity<AppointmentReason>()
               .HasMany(a => a.Appointments)
               .WithOne(b => b.AppointmentReason)
               .HasForeignKey(b => b.AppointmentReasonId);
        }
        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<AppointmentReason> AppointmentReasons { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<ContentChat> ContentChats { get; set; }
        public DbSet<Chat> Chats { get; set; }
        public DbSet<Specialty> Specialties { get; set; }
        public DbSet<SpecialtyDoctor> SpecialtyDoctors { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<Topic> Topics { get; set; }
        public DbSet<CommentImage> CommentImages { get; set; }
        public DbSet<Like> Likes { get; set; }
        public DbSet<Position> Positions { get; set; }
        public DbSet<Ward> Wards { get; set; }
        public DbSet<District> Districts { get; set; }
        public DbSet<Province> Provinces { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<Certificate> Certificates { get; set; }
        public DbSet<EmailReceivedRequest> EmailReceivedRequests { get; set; }
        public DbSet<UserAccessLogs> UserAccessLogs { get; set; }
    }
}
