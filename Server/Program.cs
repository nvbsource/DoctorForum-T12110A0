using System.Text;
using Doctors_Forum_Server.Data;
using Doctors_Forum_Server.Repositories.User;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.EntityFrameworkCore;
using Doctors_Forum_Server.Repositories.ContentChat;
using Doctors_Forum_Server.Repositories.Chat;
using Doctors_Forum_Server.Repositories.Specialty;
using Doctors_Forum_Server.Repositories.SpecialtyDoctor;
using Doctors_Forum_Server.Repositories.Comment;
using Doctors_Forum_Server.Repositories.CommentImage;
using Doctors_Forum_Server.Repositories.Country;
using Doctors_Forum_Server.Repositories.District;
using Doctors_Forum_Server.Repositories.Like;
using Doctors_Forum_Server.Repositories.Position;
using Doctors_Forum_Server.Repositories.Post;
using Doctors_Forum_Server.Repositories.Province;
using Doctors_Forum_Server.Repositories.Topic;
using Doctors_Forum_Server.Repositories.Ward;
using Microsoft.OpenApi.Models;
using System.Text.Json.Serialization;
using Doctors_Forum_Server.Repositories.AppointmentReason;
using Doctors_Forum_Server.Middlewares;
using Doctors_Forum_Server.Hubs;
using Doctors_Forum_Server.Repositories;
using Doctors_Forum_Server.Repositories.UserAccessLogs;
using Doctors_Forum_Server.Repositories.EmailReceivedRequest;
using DeviceDetectorNET.Parser.Device;
using Microsoft.Extensions.FileProviders;
using Doctors_Forum_Server.Repositories.GeoLocation;
using Doctors_Forum_Server.Repositories.Appointment;
using Hangfire;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers().AddJsonOptions(x =>
                x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
//Auto Mapper
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
//DbContext
builder.Services.AddDbContext<ApplicationContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("DoctorsConnectDB")), ServiceLifetime.Transient);

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Doctor-Forum-API",
        Version = "v1"
    });
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
    {
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "JWT Authorization header using the Bearer scheme. \r\n\r\n Enter 'Bearer' [space] and then your token in the text input below.\r\n\r\nExample: \"Bearer 1safsfsdfdfd\"",
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement {
        {
            new OpenApiSecurityScheme {
                Reference = new OpenApiReference {
                    Type = ReferenceType.SecurityScheme,
                        Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});
// Dependence Injection
builder.Services.AddScoped<IUserRepository, UserService>();
builder.Services.AddScoped<IContentChatRepository, ContentChatService>();
builder.Services.AddScoped<IChatRepository, ChatService>();
builder.Services.AddScoped<ISpecialtyRepository, SpecialtyService>();
builder.Services.AddScoped<ISpecialtyDoctorRepository, SpecialtyDoctorService>();
builder.Services.AddScoped<ILikeRepository, LikeService>();
builder.Services.AddScoped<ICommentRepository, CommentService>();
builder.Services.AddScoped<IPostRepository, PostService>();
builder.Services.AddScoped<ITopicRepository, TopicService>();
builder.Services.AddScoped<IPositionRepository, PositionService>();
builder.Services.AddScoped<ICommentImageRepository, CommentImageService>();
builder.Services.AddScoped<ICertificateRepository, CertificateService>();
builder.Services.AddScoped<IDistrictRepository, DistrictService>();
builder.Services.AddScoped<IProvinceRepository, ProvinceService>();
builder.Services.AddScoped<ICountryRepository, CountryService>();
builder.Services.AddScoped<IAppointmentReasonRepository, AppointmentReasonService>();
builder.Services.AddScoped<ChatHub>();
builder.Services.AddScoped<IChatRepository, ChatService>();
builder.Services.AddScoped<IUserAccessLogsRepository, UserAccessLogsService>();
builder.Services.AddScoped<IEmailReceivedRequestRepository, EmailReceivedRequestService>();
builder.Services.AddScoped<IGeoLocationService, GeoLocationService>();
builder.Services.AddScoped<IAppointmentRepository, AppointmentService>();
builder.Services.AddSingleton<IFileProvider>(
    new PhysicalFileProvider(
        Path.Combine(Directory.GetCurrentDirectory(), "Views/EmailTemplates")));
builder.Services.AddHangfire(configuration => configuration
        .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
        .UseSimpleAssemblyNameTypeSerializer()
        .UseRecommendedSerializerSettings()
        .UseSqlServerStorage(builder.Configuration.GetConnectionString("HangFireConnectDB")));
//Authentication
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.Events = new JwtBearerEvents
    {
        OnMessageReceived = context =>
        {
            var accessToken = context.Request.Query["access_token"];

            // If the request is for our hub...
            var path = context.HttpContext.Request.Path;
            if (!string.IsNullOrEmpty(accessToken) &&
                (path.StartsWithSegments("/Chat")))
            {
                // Read the token out of the query string
                context.Token = accessToken;
            }
            return Task.CompletedTask;
        }
    };
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))
    };
});
builder.Services.AddCors(options => options.AddPolicy("CorsPolicy",
        builder =>
        {
            builder.AllowAnyHeader()
                   .AllowAnyMethod()
                   .SetIsOriginAllowed((host) => true)
                   .AllowCredentials();
        }));

builder.Services.AddSignalR();
builder.Services.AddSingleton<ConnectionManagement>();
builder.Services.AddTransient<ChatHub>();

var app = builder.Build();
app.UseHangfireDashboard();
app.UseHangfireServer();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
           Path.Combine(app.Environment.ContentRootPath, "uploads")),
    RequestPath = "/uploads"
});

app.UseCors("CorsPolicy");

app.UseMiddleware<JwtMiddleware>();

//a pp.UseMiddleware<ErrorHandlerMiddleware>();
app.MapHub<ChatHub>("/Chat");

app.UseAuthentication();

app.UseAuthorization();

ControllerActionEndpointConventionBuilder controllerActionEndpointConventionBuilder = app.MapControllers();
app.MapControllerRoute(
    name: "default",
    pattern: "api/[controller]/[action]",
    defaults: new { controller = "Admin" });
app.Run();
