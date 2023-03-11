/*
 Navicat Premium Data Transfer

 Source Server         : LocalSQLServer
 Source Server Type    : SQL Server
 Source Server Version : 15002000
 Source Host           : localhost:1433
 Source Catalog        : DoctorForum
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002000
 File Encoding         : 65001

 Date: 11/03/2023 14:12:58
*/


-- ----------------------------
-- Table structure for __EFMigrationsHistory
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[__EFMigrationsHistory]') AND type IN ('U'))
	DROP TABLE [dbo].[__EFMigrationsHistory]
GO

CREATE TABLE [dbo].[__EFMigrationsHistory] (
  [MigrationId] nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [ProductVersion] nvarchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[__EFMigrationsHistory] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of __EFMigrationsHistory
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[__EFMigrationsHistory] VALUES (N'20230309112904_ini', N'6.0.0')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for AppointmentReasons
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AppointmentReasons]') AND type IN ('U'))
	DROP TABLE [dbo].[AppointmentReasons]
GO

CREATE TABLE [dbo].[AppointmentReasons] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] int  NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Active] bit  NOT NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[AppointmentReasons] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Appointments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Appointments]') AND type IN ('U'))
	DROP TABLE [dbo].[Appointments]
GO

CREATE TABLE [dbo].[Appointments] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [FullName] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Email] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Phone] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [UserId] int  NOT NULL,
  [AppointmentReasonId] int  NOT NULL,
  [Other] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Status] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [StartDate] datetime2(7)  NOT NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL,
  [TimeStart] datetime2(7)  NULL,
  [CommentAdmin] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Appointments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Certificates
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Certificates]') AND type IN ('U'))
	DROP TABLE [dbo].[Certificates]
GO

CREATE TABLE [dbo].[Certificates] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [SpecialtyDoctorId] int  NOT NULL,
  [Image] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Certificates] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Chats
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Chats]') AND type IN ('U'))
	DROP TABLE [dbo].[Chats]
GO

CREATE TABLE [dbo].[Chats] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] int  NOT NULL,
  [ReceiverUserId] int  NOT NULL,
  [NameChat] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Chats] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for CommentImages
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[CommentImages]') AND type IN ('U'))
	DROP TABLE [dbo].[CommentImages]
GO

CREATE TABLE [dbo].[CommentImages] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [CommentId] int  NOT NULL,
  [Image] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[CommentImages] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Comments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Comments]') AND type IN ('U'))
	DROP TABLE [dbo].[Comments]
GO

CREATE TABLE [dbo].[Comments] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [ParentId] int  NULL,
  [PostId] int  NOT NULL,
  [UserId] int  NOT NULL,
  [Content] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Comments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for ContentChats
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentChats]') AND type IN ('U'))
	DROP TABLE [dbo].[ContentChats]
GO

CREATE TABLE [dbo].[ContentChats] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [ChatId] int  NOT NULL,
  [UserId] int  NOT NULL,
  [ParentId] int  NULL,
  [Content] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [IsRead] bit  NOT NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[ContentChats] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Countries
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type IN ('U'))
	DROP TABLE [dbo].[Countries]
GO

CREATE TABLE [dbo].[Countries] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Countries] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Districts
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Districts]') AND type IN ('U'))
	DROP TABLE [dbo].[Districts]
GO

CREATE TABLE [dbo].[Districts] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [ProvinceId] int  NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Districts] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for EmailReceivedRequests
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailReceivedRequests]') AND type IN ('U'))
	DROP TABLE [dbo].[EmailReceivedRequests]
GO

CREATE TABLE [dbo].[EmailReceivedRequests] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] int  NOT NULL,
  [Email] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Status] bit  NOT NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[EmailReceivedRequests] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Likes
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Likes]') AND type IN ('U'))
	DROP TABLE [dbo].[Likes]
GO

CREATE TABLE [dbo].[Likes] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [PostId] int  NOT NULL,
  [UserId] int  NOT NULL,
  [CommentId] int  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Likes] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Positions
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type IN ('U'))
	DROP TABLE [dbo].[Positions]
GO

CREATE TABLE [dbo].[Positions] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Positions] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Positions
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[Positions] ON
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'1', N'Other')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'2', N'Administrative Staff')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'3', N'Practice Owner')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'4', N'Practice IT/Technology Support Staff')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'5', N'Consultant for Practice')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'6', N'Practice Marketing/PR Director')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'7', N'Doctor')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'8', N'Owner')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'9', N'Director')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'10', N'Admin')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'11', N'Marketing')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'12', N'VP Marketing')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'13', N'Accountant')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'14', N'Staff')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'15', N'IT Administrator')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'16', N'Manager')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'17', N'CEO')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'18', N'Office Manager')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'19', N'Sales')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'20', N'Data Science Intern')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'21', N'Tradeshow')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'22', N'Executive')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'23', N'BisDev')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'24', N'QA')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'25', N'VP')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'26', N'Developer')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'27', N'Point of contact')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'28', N'Product Marketing Manager')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'29', N'Lead Generation')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'30', N'SEO')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'31', N'Re Pro')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'32', N'ENT CS')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'33', N'User')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'34', N'Implementation')
GO

INSERT INTO [dbo].[Positions] ([Id], [Name]) VALUES (N'35', N'Enginee')
GO

SET IDENTITY_INSERT [dbo].[Positions] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for Posts
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Posts]') AND type IN ('U'))
	DROP TABLE [dbo].[Posts]
GO

CREATE TABLE [dbo].[Posts] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] int  NOT NULL,
  [TopicId] int  NOT NULL,
  [Title] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Image] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Content] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Posts] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Provinces
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Provinces]') AND type IN ('U'))
	DROP TABLE [dbo].[Provinces]
GO

CREATE TABLE [dbo].[Provinces] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [CountryId] int  NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Provinces] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Specialties
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Specialties]') AND type IN ('U'))
	DROP TABLE [dbo].[Specialties]
GO

CREATE TABLE [dbo].[Specialties] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [ParentId] int  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Specialties] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Specialties
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[Specialties] ON
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'1', N'Acupuncturist (Alternative Medicine)', NULL, N'2023-03-10 15:58:36.8700000', N'2023-03-10 15:58:36.8700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'2', N'General', N'1', N'2023-03-10 15:58:36.8800000', N'2023-03-10 15:58:36.8800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'3', N'Addiction Medicine Specialist', NULL, N'2023-03-10 15:58:36.8833333', N'2023-03-10 15:58:36.8833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'4', N'General', N'3', N'2023-03-10 15:58:36.8866667', N'2023-03-10 15:58:36.8866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'5', N'Adolescent Medicine Specialist', NULL, N'2023-03-10 15:58:36.8900000', N'2023-03-10 15:58:36.8900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'6', N'General', N'5', N'2023-03-10 15:58:36.8933333', N'2023-03-10 15:58:36.8933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'7', N'Allergist-Immunologist', NULL, N'2023-03-10 15:58:36.8966667', N'2023-03-10 15:58:36.8966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'8', N'General', N'7', N'2023-03-10 15:58:36.9000000', N'2023-03-10 15:58:36.9000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'9', N'Allergy', N'7', N'2023-03-10 15:58:36.9000000', N'2023-03-10 15:58:36.9000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'10', N'Clinical & Laboratory Immunology', N'7', N'2023-03-10 15:58:36.9033333', N'2023-03-10 15:58:36.9033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'11', N'Anaplastologist', NULL, N'2023-03-10 15:58:36.9066667', N'2023-03-10 15:58:36.9066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'12', N'General', N'11', N'2023-03-10 15:58:36.9100000', N'2023-03-10 15:58:36.9100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'13', N'Anesthesiologist', NULL, N'2023-03-10 15:58:36.9133333', N'2023-03-10 15:58:36.9133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'14', N'General', N'13', N'2023-03-10 15:58:36.9166667', N'2023-03-10 15:58:36.9166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'15', N'Addiction Medicine', N'13', N'2023-03-10 15:58:36.9166667', N'2023-03-10 15:58:36.9166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'16', N'Critical Care Medicine', N'13', N'2023-03-10 15:58:36.9200000', N'2023-03-10 15:58:36.9200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'17', N'Hospice & Palliative Medicine', N'13', N'2023-03-10 15:58:36.9233333', N'2023-03-10 15:58:36.9233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'18', N'Pain Medicine', N'13', N'2023-03-10 15:58:36.9266667', N'2023-03-10 15:58:36.9266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'19', N'Pediatric Anesthesiologist', N'13', N'2023-03-10 15:58:36.9266667', N'2023-03-10 15:58:36.9266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'20', N'Art Therapist', NULL, N'2023-03-10 15:58:36.9300000', N'2023-03-10 15:58:36.9300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'21', N'General', N'20', N'2023-03-10 15:58:36.9333333', N'2023-03-10 15:58:36.9333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'22', N'Audiologist', NULL, N'2023-03-10 15:58:36.9333333', N'2023-03-10 15:58:36.9333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'23', N'General', N'22', N'2023-03-10 15:58:36.9366667', N'2023-03-10 15:58:36.9366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'24', N'Assistive Technology Practitioner', N'22', N'2023-03-10 15:58:36.9400000', N'2023-03-10 15:58:36.9400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'25', N'Assistive Technology Supplier', N'22', N'2023-03-10 15:58:36.9400000', N'2023-03-10 15:58:36.9400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'26', N'Hearing Aid Fitter', N'22', N'2023-03-10 15:58:36.9433333', N'2023-03-10 15:58:36.9433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'27', N'Bariatrician (Weight Loss Specialist)', NULL, N'2023-03-10 15:58:36.9466667', N'2023-03-10 15:58:36.9466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'28', N'Bariatric Medicine (Bariatrician)', N'27', N'2023-03-10 15:58:36.9500000', N'2023-03-10 15:58:36.9500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'29', N'Cardiologist (Heart Specialist)', NULL, N'2023-03-10 15:58:36.9500000', N'2023-03-10 15:58:36.9500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'30', N'General', N'29', N'2023-03-10 15:58:36.9533333', N'2023-03-10 15:58:36.9533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'31', N'Clinical Cardiac Electrophysiology', N'29', N'2023-03-10 15:58:36.9600000', N'2023-03-10 15:58:36.9600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'32', N'Pediatric Cardiothoracic Surgery', N'29', N'2023-03-10 15:58:36.9600000', N'2023-03-10 15:58:36.9600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'33', N'Certified Nurse Midwife', NULL, N'2023-03-10 15:58:36.9633333', N'2023-03-10 15:58:36.9633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'34', N'General', N'33', N'2023-03-10 15:58:36.9666667', N'2023-03-10 15:58:36.9666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'35', N'Certified Respiratory Therapist (CRT)', NULL, N'2023-03-10 15:58:36.9700000', N'2023-03-10 15:58:36.9700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'36', N'General', N'35', N'2023-03-10 15:58:36.9700000', N'2023-03-10 15:58:36.9700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'37', N'Critical Care', N'35', N'2023-03-10 15:58:36.9733333', N'2023-03-10 15:58:36.9733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'38', N'Emergency Care', N'35', N'2023-03-10 15:58:36.9766667', N'2023-03-10 15:58:36.9766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'39', N'Educational', N'35', N'2023-03-10 15:58:36.9766667', N'2023-03-10 15:58:36.9766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'40', N'Geriatric Care', N'35', N'2023-03-10 15:58:36.9800000', N'2023-03-10 15:58:36.9800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'41', N'General Care', N'35', N'2023-03-10 15:58:36.9833333', N'2023-03-10 15:58:36.9833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'42', N'Home Health', N'35', N'2023-03-10 15:58:36.9866667', N'2023-03-10 15:58:36.9866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'43', N'Pulmonary Diagnostics', N'35', N'2023-03-10 15:58:36.9900000', N'2023-03-10 15:58:36.9900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'44', N'Pulmonary Rehabilitation', N'35', N'2023-03-10 15:58:36.9900000', N'2023-03-10 15:58:36.9900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'45', N'Pulmonary Function Technology', N'35', N'2023-03-10 15:58:36.9933333', N'2023-03-10 15:58:36.9933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'46', N'Palliative/Hospice', N'35', N'2023-03-10 15:58:36.9966667', N'2023-03-10 15:58:36.9966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'47', N'Neonatal/Pediatrics', N'35', N'2023-03-10 15:58:37.0000000', N'2023-03-10 15:58:37.0000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'48', N'Patient Transport', N'35', N'2023-03-10 15:58:37.0000000', N'2023-03-10 15:58:37.0000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'49', N'SNF/Subacute Care', N'35', N'2023-03-10 15:58:37.0033333', N'2023-03-10 15:58:37.0033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'50', N'Chiropractor', NULL, N'2023-03-10 15:58:37.0066667', N'2023-03-10 15:58:37.0066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'51', N'General', N'50', N'2023-03-10 15:58:37.0100000', N'2023-03-10 15:58:37.0100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'52', N'Independent Medical Examination', N'50', N'2023-03-10 15:58:37.0100000', N'2023-03-10 15:58:37.0100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'53', N'Internist', N'50', N'2023-03-10 15:58:37.0133333', N'2023-03-10 15:58:37.0133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'54', N'Neurology', N'50', N'2023-03-10 15:58:37.0166667', N'2023-03-10 15:58:37.0166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'55', N'Nutrition', N'50', N'2023-03-10 15:58:37.0200000', N'2023-03-10 15:58:37.0200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'56', N'Pediatric', N'50', N'2023-03-10 15:58:37.0233333', N'2023-03-10 15:58:37.0233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'57', N'Radiology', N'50', N'2023-03-10 15:58:37.0266667', N'2023-03-10 15:58:37.0266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'58', N'Rehabilitation', N'50', N'2023-03-10 15:58:37.0266667', N'2023-03-10 15:58:37.0266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'59', N'Sports Medicine', N'50', N'2023-03-10 15:58:37.0300000', N'2023-03-10 15:58:37.0300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'60', N'Thermography', N'50', N'2023-03-10 15:58:37.0333333', N'2023-03-10 15:58:37.0333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'61', N'Occupational Medicine', N'50', N'2023-03-10 15:58:37.0366667', N'2023-03-10 15:58:37.0366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'62', N'Orthopedic', N'50', N'2023-03-10 15:58:37.0366667', N'2023-03-10 15:58:37.0366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'63', N'Functional Medicine', N'50', N'2023-03-10 15:58:37.0400000', N'2023-03-10 15:58:37.0400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'64', N'Clinical / Laboratory Immunologist', NULL, N'2023-03-10 15:58:37.0400000', N'2023-03-10 15:58:37.0400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'65', N'General', N'64', N'2023-03-10 15:58:37.0433333', N'2023-03-10 15:58:37.0433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'66', N'Clinical Neuropsychologist', NULL, N'2023-03-10 15:58:37.0466667', N'2023-03-10 15:58:37.0466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'67', N'General', N'66', N'2023-03-10 15:58:37.0500000', N'2023-03-10 15:58:37.0500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'68', N'Clinical Nurse Specialist (CNS)', NULL, N'2023-03-10 15:58:37.0500000', N'2023-03-10 15:58:37.0500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'69', N'General', N'68', N'2023-03-10 15:58:37.0566667', N'2023-03-10 15:58:37.0566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'70', N'Acute Care', N'68', N'2023-03-10 15:58:37.0566667', N'2023-03-10 15:58:37.0566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'71', N'Adult Health', N'68', N'2023-03-10 15:58:37.0600000', N'2023-03-10 15:58:37.0600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'72', N'Critical Care Medicine', N'68', N'2023-03-10 15:58:37.0633333', N'2023-03-10 15:58:37.0633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'73', N'Community Health/Public Health', N'68', N'2023-03-10 15:58:37.0666667', N'2023-03-10 15:58:37.0666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'74', N'Chronic Care', N'68', N'2023-03-10 15:58:37.0700000', N'2023-03-10 15:58:37.0700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'75', N'Emergency', N'68', N'2023-03-10 15:58:37.0733333', N'2023-03-10 15:58:37.0733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'76', N'Ethics', N'68', N'2023-03-10 15:58:37.0766667', N'2023-03-10 15:58:37.0766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'77', N'Family Health', N'68', N'2023-03-10 15:58:37.0800000', N'2023-03-10 15:58:37.0800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'78', N'Gerontology', N'68', N'2023-03-10 15:58:37.0800000', N'2023-03-10 15:58:37.0800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'79', N'Home Health', N'68', N'2023-03-10 15:58:37.0833333', N'2023-03-10 15:58:37.0833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'80', N'Holistic', N'68', N'2023-03-10 15:58:37.0866667', N'2023-03-10 15:58:37.0866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'81', N'Informatics', N'68', N'2023-03-10 15:58:37.0900000', N'2023-03-10 15:58:37.0900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'82', N'Long-Term Care', N'68', N'2023-03-10 15:58:37.0933333', N'2023-03-10 15:58:37.0933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'83', N'Medical-Surgical', N'68', N'2023-03-10 15:58:37.0966667', N'2023-03-10 15:58:37.0966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'84', N'Neonatal', N'68', N'2023-03-10 15:58:37.0966667', N'2023-03-10 15:58:37.0966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'85', N'Neuroscience', N'68', N'2023-03-10 15:58:37.1000000', N'2023-03-10 15:58:37.1000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'86', N'Pediatrics', N'68', N'2023-03-10 15:58:37.1033333', N'2023-03-10 15:58:37.1033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'87', N'Psych/Mental Health, Child & Adolescent', N'68', N'2023-03-10 15:58:37.1033333', N'2023-03-10 15:58:37.1033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'88', N'Psych/Mental Health', N'68', N'2023-03-10 15:58:37.1066667', N'2023-03-10 15:58:37.1066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'89', N'Psych/Mental Health, Adult', N'68', N'2023-03-10 15:58:37.1100000', N'2023-03-10 15:58:37.1100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'90', N'Psych/Mental Health, Child & Family', N'68', N'2023-03-10 15:58:37.1133333', N'2023-03-10 15:58:37.1133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'91', N'Psych/Mental Health, Chronically Ill', N'68', N'2023-03-10 15:58:37.1133333', N'2023-03-10 15:58:37.1133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'92', N'Psych/Mental Health, Community', N'68', N'2023-03-10 15:58:37.1166667', N'2023-03-10 15:58:37.1166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'93', N'Psych/Mental Health, Geropsychiatric', N'68', N'2023-03-10 15:58:37.1200000', N'2023-03-10 15:58:37.1200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'94', N'Perinatal', N'68', N'2023-03-10 15:58:37.1233333', N'2023-03-10 15:58:37.1233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'95', N'Perioperative', N'68', N'2023-03-10 15:58:37.1233333', N'2023-03-10 15:58:37.1233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'96', N'Rehabilitation', N'68', N'2023-03-10 15:58:37.1266667', N'2023-03-10 15:58:37.1266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'97', N'School', N'68', N'2023-03-10 15:58:37.1300000', N'2023-03-10 15:58:37.1300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'98', N'Transplantation', N'68', N'2023-03-10 15:58:37.1300000', N'2023-03-10 15:58:37.1300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'99', N'Womens Health', N'68', N'2023-03-10 15:58:37.1333333', N'2023-03-10 15:58:37.1333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'100', N'Occupational Health', N'68', N'2023-03-10 15:58:37.1366667', N'2023-03-10 15:58:37.1366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'101', N'Oncology', N'68', N'2023-03-10 15:58:37.1400000', N'2023-03-10 15:58:37.1400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'102', N'Oncology, Pediatrics', N'68', N'2023-03-10 15:58:37.1433333', N'2023-03-10 15:58:37.1433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'103', N'Clinical Pharmacologist', NULL, N'2023-03-10 15:58:37.1466667', N'2023-03-10 15:58:37.1466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'104', N'General', N'103', N'2023-03-10 15:58:37.1466667', N'2023-03-10 15:58:37.1466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'105', N'Colon & Rectal Surgeon (Proctologist)', NULL, N'2023-03-10 15:58:37.1500000', N'2023-03-10 15:58:37.1500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'106', N'General', N'105', N'2023-03-10 15:58:37.1533333', N'2023-03-10 15:58:37.1533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'107', N'Counselor', NULL, N'2023-03-10 15:58:37.1566667', N'2023-03-10 15:58:37.1566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'108', N'General', N'107', N'2023-03-10 15:58:37.1566667', N'2023-03-10 15:58:37.1566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'109', N'Addiction & Substance Use Disorder', N'107', N'2023-03-10 15:58:37.1600000', N'2023-03-10 15:58:37.1600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'110', N'Mental Health', N'107', N'2023-03-10 15:58:37.1633333', N'2023-03-10 15:58:37.1633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'111', N'Pastoral', N'107', N'2023-03-10 15:58:37.1633333', N'2023-03-10 15:58:37.1633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'112', N'Professional', N'107', N'2023-03-10 15:58:37.1666667', N'2023-03-10 15:58:37.1666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'113', N'School', N'107', N'2023-03-10 15:58:37.1700000', N'2023-03-10 15:58:37.1700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'114', N'Critical Care Specialist', NULL, N'2023-03-10 15:58:37.1700000', N'2023-03-10 15:58:37.1700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'115', N'Doctor of Critical Care Medicine', N'114', N'2023-03-10 15:58:37.1733333', N'2023-03-10 15:58:37.1733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'116', N'Dance Therapist', NULL, N'2023-03-10 15:58:37.1766667', N'2023-03-10 15:58:37.1766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'117', N'General', N'116', N'2023-03-10 15:58:37.1800000', N'2023-03-10 15:58:37.1800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'118', N'Dentist', NULL, N'2023-03-10 15:58:37.1833333', N'2023-03-10 15:58:37.1833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'119', N'General', N'118', N'2023-03-10 15:58:37.1866667', N'2023-03-10 15:58:37.1866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'120', N'Dental Public Health', N'118', N'2023-03-10 15:58:37.1900000', N'2023-03-10 15:58:37.1900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'121', N'Endodontics (Endodontist)', N'118', N'2023-03-10 15:58:37.1900000', N'2023-03-10 15:58:37.1900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'122', N'Primary Dental Care', N'118', N'2023-03-10 15:58:37.1933333', N'2023-03-10 15:58:37.1933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'123', N'Oral and Maxillofacial Pathology', N'118', N'2023-03-10 15:58:37.1966667', N'2023-03-10 15:58:37.1966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'124', N'Pediatric Dentist', N'118', N'2023-03-10 15:58:37.2000000', N'2023-03-10 15:58:37.2000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'125', N'Periodontics (Periodontist)', N'118', N'2023-03-10 15:58:37.2000000', N'2023-03-10 15:58:37.2000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'126', N'Prosthodontics (Prosthodontist)', N'118', N'2023-03-10 15:58:37.2033333', N'2023-03-10 15:58:37.2033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'127', N'Oral & Maxillofacial Surgery', N'118', N'2023-03-10 15:58:37.2066667', N'2023-03-10 15:58:37.2066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'128', N'Oral & Maxillofacial Radiology', N'118', N'2023-03-10 15:58:37.2100000', N'2023-03-10 15:58:37.2100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'129', N'Orthodontics & Dentofacial Orthopedics (Orthodontist)', N'118', N'2023-03-10 15:58:37.2100000', N'2023-03-10 15:58:37.2100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'130', N'Cosmetic Dentist', N'118', N'2023-03-10 15:58:37.2133333', N'2023-03-10 15:58:37.2133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'131', N'Family and Cosmetic Dentist', N'118', N'2023-03-10 15:58:37.2166667', N'2023-03-10 15:58:37.2166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'132', N'Periodontal and Implant Surgery Specialist', N'118', N'2023-03-10 15:58:37.2200000', N'2023-03-10 15:58:37.2200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'133', N'Sleep Therapy', N'118', N'2023-03-10 15:58:37.2233333', N'2023-03-10 15:58:37.2233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'134', N'Oral Appliance Therapy', N'118', N'2023-03-10 15:58:37.2233333', N'2023-03-10 15:58:37.2233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'135', N'Dentist - Dentist Anesthesiologist', N'118', N'2023-03-10 15:58:37.2266667', N'2023-03-10 15:58:37.2266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'136', N'Denturist (Dentures Specialist)', NULL, N'2023-03-10 15:58:37.2300000', N'2023-03-10 15:58:37.2300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'137', N'General', N'136', N'2023-03-10 15:58:37.2333333', N'2023-03-10 15:58:37.2333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'138', N'Dermatologist (Skin Specialist)', NULL, N'2023-03-10 15:58:37.2333333', N'2023-03-10 15:58:37.2333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'139', N'General', N'138', N'2023-03-10 15:58:37.2366667', N'2023-03-10 15:58:37.2366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'140', N'MOHS-Micrographic Surgery', N'138', N'2023-03-10 15:58:37.2400000', N'2023-03-10 15:58:37.2400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'141', N'Dermatopathology', N'138', N'2023-03-10 15:58:37.2400000', N'2023-03-10 15:58:37.2400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'142', N'Clinical & Laboratory Dermatological Immunology', N'138', N'2023-03-10 15:58:37.2433333', N'2023-03-10 15:58:37.2433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'143', N'Pediatric Dermatology', N'138', N'2023-03-10 15:58:37.2466667', N'2023-03-10 15:58:37.2466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'144', N'Procedural Dermatologist', N'138', N'2023-03-10 15:58:37.2500000', N'2023-03-10 15:58:37.2500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'145', N'Cosmetic Dermatology', N'138', N'2023-03-10 15:58:37.2533333', N'2023-03-10 15:58:37.2533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'146', N'Hair Loss and Hair Restoration Expert', N'138', N'2023-03-10 15:58:37.2566667', N'2023-03-10 15:58:37.2566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'147', N'Developmental Therapist', NULL, N'2023-03-10 15:58:37.2600000', N'2023-03-10 15:58:37.2600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'148', N'General', N'147', N'2023-03-10 15:58:37.2633333', N'2023-03-10 15:58:37.2633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'149', N'Dietary Manager', NULL, N'2023-03-10 15:58:37.2633333', N'2023-03-10 15:58:37.2633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'150', N'General', N'149', N'2023-03-10 15:58:37.2666667', N'2023-03-10 15:58:37.2666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'151', N'Emergency Doctor', NULL, N'2023-03-10 15:58:37.2700000', N'2023-03-10 15:58:37.2700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'152', N'General', N'151', N'2023-03-10 15:58:37.2700000', N'2023-03-10 15:58:37.2700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'153', N'Emergency Medical Services (EMS)', N'151', N'2023-03-10 15:58:37.2733333', N'2023-03-10 15:58:37.2733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'154', N'Undersea & Hyperbaric Medicine', N'151', N'2023-03-10 15:58:37.2766667', N'2023-03-10 15:58:37.2766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'155', N'Hospice & Palliative Medicine', N'151', N'2023-03-10 15:58:37.2800000', N'2023-03-10 15:58:37.2800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'156', N'Pediatric Emergency Medicine', N'151', N'2023-03-10 15:58:37.2800000', N'2023-03-10 15:58:37.2800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'157', N'Sports Medicine', N'151', N'2023-03-10 15:58:37.2866667', N'2023-03-10 15:58:37.2866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'158', N'Medical Toxicology', N'151', N'2023-03-10 15:58:37.2900000', N'2023-03-10 15:58:37.2900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'159', N'Endocrinologist (Diabetes & Hormones Specialist)', NULL, N'2023-03-10 15:58:37.2900000', N'2023-03-10 15:58:37.2900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'160', N'General', N'159', N'2023-03-10 15:58:37.2933333', N'2023-03-10 15:58:37.2933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'161', N'Family Doctor', NULL, N'2023-03-10 15:58:37.2966667', N'2023-03-10 15:58:37.2966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'162', N'General', N'161', N'2023-03-10 15:58:37.3000000', N'2023-03-10 15:58:37.3000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'163', N'Adolescent Medicine', N'161', N'2023-03-10 15:58:37.3033333', N'2023-03-10 15:58:37.3033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'164', N'Addiction Medicine', N'161', N'2023-03-10 15:58:37.3033333', N'2023-03-10 15:58:37.3033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'165', N'Adult Medicine', N'161', N'2023-03-10 15:58:37.3066667', N'2023-03-10 15:58:37.3066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'166', N'Bariatric Medicine', N'161', N'2023-03-10 15:58:37.3100000', N'2023-03-10 15:58:37.3100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'167', N'Geriatric Medicine', N'161', N'2023-03-10 15:58:37.3100000', N'2023-03-10 15:58:37.3100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'168', N'Hospice & Palliative Medicine', N'161', N'2023-03-10 15:58:37.3133333', N'2023-03-10 15:58:37.3133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'169', N'Sports Medicine', N'161', N'2023-03-10 15:58:37.3166667', N'2023-03-10 15:58:37.3166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'170', N'Medical Aesthetics', N'161', N'2023-03-10 15:58:37.3200000', N'2023-03-10 15:58:37.3200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'171', N'Family Medicine - Sleep Medicine', N'161', N'2023-03-10 15:58:37.3233333', N'2023-03-10 15:58:37.3233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'172', N'Gastroenterologist (Stomach & Bowel Specialist)', NULL, N'2023-03-10 15:58:37.3233333', N'2023-03-10 15:58:37.3233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'173', N'General', N'172', N'2023-03-10 15:58:37.3266667', N'2023-03-10 15:58:37.3266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'174', N'General Practice Doctor (General Practitioner)', NULL, N'2023-03-10 15:58:37.3300000', N'2023-03-10 15:58:37.3300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'175', N'General', N'174', N'2023-03-10 15:58:37.3333333', N'2023-03-10 15:58:37.3333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'176', N'Aesthetic Medicine', N'174', N'2023-03-10 15:58:37.3366667', N'2023-03-10 15:58:37.3366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'177', N'Hair Loss and Hair Restoration Expert', N'174', N'2023-03-10 15:58:37.3366667', N'2023-03-10 15:58:37.3366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'178', N'Integrative Medicine', N'174', N'2023-03-10 15:58:37.3400000', N'2023-03-10 15:58:37.3400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'179', N'Geriatric Medicine Doctor', NULL, N'2023-03-10 15:58:37.3433333', N'2023-03-10 15:58:37.3433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'180', N'General', N'179', N'2023-03-10 15:58:37.3466667', N'2023-03-10 15:58:37.3466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'181', N'Hearing Instrument Specialist', NULL, N'2023-03-10 15:58:37.3466667', N'2023-03-10 15:58:37.3466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'182', N'General', N'181', N'2023-03-10 15:58:37.3500000', N'2023-03-10 15:58:37.3500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'183', N'Hematology / Oncology Specialist', NULL, N'2023-03-10 15:58:37.3533333', N'2023-03-10 15:58:37.3533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'184', N'General', N'183', N'2023-03-10 15:58:37.3566667', N'2023-03-10 15:58:37.3566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'185', N'Oncologist (Cancer)', N'183', N'2023-03-10 15:58:37.3600000', N'2023-03-10 15:58:37.3600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'186', N'Hematologist (Blood)', N'183', N'2023-03-10 15:58:37.3600000', N'2023-03-10 15:58:37.3600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'187', N'Hepatologist (Liver, Gallbladder & Pancreas)', NULL, N'2023-03-10 15:58:37.3633333', N'2023-03-10 15:58:37.3633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'188', N'General', N'187', N'2023-03-10 15:58:37.3666667', N'2023-03-10 15:58:37.3666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'189', N'Homeopath (Alternative Medicine)', NULL, N'2023-03-10 15:58:37.3666667', N'2023-03-10 15:58:37.3666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'190', N'General', N'189', N'2023-03-10 15:58:37.3700000', N'2023-03-10 15:58:37.3700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'191', N'Hospice & Palliative Medicine Specialist', NULL, N'2023-03-10 15:58:37.3733333', N'2023-03-10 15:58:37.3733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'192', N'General', N'191', N'2023-03-10 15:58:37.3733333', N'2023-03-10 15:58:37.3733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'193', N'Hospice & Palliative Surgeon', NULL, N'2023-03-10 15:58:37.3766667', N'2023-03-10 15:58:37.3766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'194', N'General', N'193', N'2023-03-10 15:58:37.3800000', N'2023-03-10 15:58:37.3800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'195', N'Hospitalist', NULL, N'2023-03-10 15:58:37.3800000', N'2023-03-10 15:58:37.3800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'196', N'General', N'195', N'2023-03-10 15:58:37.3866667', N'2023-03-10 15:58:37.3866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'197', N'Independent Medical Examiner', NULL, N'2023-03-10 15:58:37.3900000', N'2023-03-10 15:58:37.3900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'198', N'General', N'197', N'2023-03-10 15:58:37.3900000', N'2023-03-10 15:58:37.3900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'199', N'Infectious Disease Specialist', NULL, N'2023-03-10 15:58:37.3933333', N'2023-03-10 15:58:37.3933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'200', N'General', N'199', N'2023-03-10 15:58:37.3966667', N'2023-03-10 15:58:37.3966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'201', N'Internist', NULL, N'2023-03-10 15:58:37.4000000', N'2023-03-10 15:58:37.4000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'202', N'General', N'201', N'2023-03-10 15:58:37.4033333', N'2023-03-10 15:58:37.4033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'203', N'Aesthetic Medicine', N'201', N'2023-03-10 15:58:37.4033333', N'2023-03-10 15:58:37.4033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'204', N'Sports Medicine', N'201', N'2023-03-10 15:58:37.4066667', N'2023-03-10 15:58:37.4066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'205', N'Internal Medicine - Advanced Heart Failure and Transplant Cardiology', N'201', N'2023-03-10 15:58:37.4100000', N'2023-03-10 15:58:37.4100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'206', N'Internal Medicine - Allergy & Immunology', N'201', N'2023-03-10 15:58:37.4133333', N'2023-03-10 15:58:37.4133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'207', N'Internal Medicine - Hypertension Specialist', N'201', N'2023-03-10 15:58:37.4166667', N'2023-03-10 15:58:37.4166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'208', N'Internal Medicine - Adult Congenital Heart Disease', N'201', N'2023-03-10 15:58:37.4200000', N'2023-03-10 15:58:37.4200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'209', N'Interventional Cardiologist', NULL, N'2023-03-10 15:58:37.4233333', N'2023-03-10 15:58:37.4233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'210', N'General', N'209', N'2023-03-10 15:58:37.4266667', N'2023-03-10 15:58:37.4266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'211', N'Kinesiotherapist', NULL, N'2023-03-10 15:58:37.4300000', N'2023-03-10 15:58:37.4300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'212', N'General', N'211', N'2023-03-10 15:58:37.4300000', N'2023-03-10 15:58:37.4300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'213', N'Legal Medicine Specialist', NULL, N'2023-03-10 15:58:37.4333333', N'2023-03-10 15:58:37.4333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'214', N'General', N'213', N'2023-03-10 15:58:37.4333333', N'2023-03-10 15:58:37.4333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'215', N'Licensed Physchiatric Technician (LPT)', NULL, N'2023-03-10 15:58:37.4366667', N'2023-03-10 15:58:37.4366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'216', N'General', N'215', N'2023-03-10 15:58:37.4400000', N'2023-03-10 15:58:37.4400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'217', N'Licensed Practical Nurse (LPN)', NULL, N'2023-03-10 15:58:37.4433333', N'2023-03-10 15:58:37.4433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'218', N'General', N'217', N'2023-03-10 15:58:37.4466667', N'2023-03-10 15:58:37.4466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'219', N'Aesthetics', N'217', N'2023-03-10 15:58:37.4466667', N'2023-03-10 15:58:37.4466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'220', N'Licensed Vocational Nurse (LVN)', NULL, N'2023-03-10 15:58:37.4500000', N'2023-03-10 15:58:37.4500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'221', N'General', N'220', N'2023-03-10 15:58:37.4533333', N'2023-03-10 15:58:37.4533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'222', N'Magnetic Resonance Imaging (MRI) Specialist', NULL, N'2023-03-10 15:58:37.4600000', N'2023-03-10 15:58:37.4600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'223', N'General', N'222', N'2023-03-10 15:58:37.4666667', N'2023-03-10 15:58:37.4666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'224', N'Marriage & Family Therapist', NULL, N'2023-03-10 15:58:37.4700000', N'2023-03-10 15:58:37.4700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'225', N'General', N'224', N'2023-03-10 15:58:37.4700000', N'2023-03-10 15:58:37.4700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'226', N'Massage Therapist', NULL, N'2023-03-10 15:58:37.4733333', N'2023-03-10 15:58:37.4733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'227', N'Licensed Massage Therapist', N'226', N'2023-03-10 15:58:37.4766667', N'2023-03-10 15:58:37.4766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'228', N'Mechanotherapist', NULL, N'2023-03-10 15:58:37.4766667', N'2023-03-10 15:58:37.4766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'229', N'General', N'228', N'2023-03-10 15:58:37.4800000', N'2023-03-10 15:58:37.4800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'230', N'Medical Geneticist (Genetic & Hereditary Disease Specialist) ', NULL, N'2023-03-10 15:58:37.4833333', N'2023-03-10 15:58:37.4833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'231', N'Clinical Cytogenetics', N'230', N'2023-03-10 15:58:37.4866667', N'2023-03-10 15:58:37.4866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'232', N'Clinical Biochemical Genetics', N'230', N'2023-03-10 15:58:37.4900000', N'2023-03-10 15:58:37.4900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'233', N'Clinical Molecular Genetics', N'230', N'2023-03-10 15:58:37.4933333', N'2023-03-10 15:58:37.4933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'234', N'Medical Geneticist', NULL, N'2023-03-10 15:58:37.4966667', N'2023-03-10 15:58:37.4966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'235', N'Clinical Genetics', N'234', N'2023-03-10 15:58:37.4966667', N'2023-03-10 15:58:37.4966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'236', N'Medical Genetics', N'234', N'2023-03-10 15:58:37.5000000', N'2023-03-10 15:58:37.5000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'237', N'Molecular Genetic Pathology', N'234', N'2023-03-10 15:58:37.5033333', N'2023-03-10 15:58:37.5033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'238', N'Medical Genetics, Ph.D. Medical Genetics', N'234', N'2023-03-10 15:58:37.5066667', N'2023-03-10 15:58:37.5066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'239', N'Genetic Counselor, MS', N'234', N'2023-03-10 15:58:37.5100000', N'2023-03-10 15:58:37.5100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'240', N'Music Therapist', NULL, N'2023-03-10 15:58:37.5100000', N'2023-03-10 15:58:37.5100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'241', N'General', N'240', N'2023-03-10 15:58:37.5133333', N'2023-03-10 15:58:37.5133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'242', N'Naprapath (Alternative Medicine)', NULL, N'2023-03-10 15:58:37.5166667', N'2023-03-10 15:58:37.5166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'243', N'General', N'242', N'2023-03-10 15:58:37.5200000', N'2023-03-10 15:58:37.5200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'244', N'Naturopath', NULL, N'2023-03-10 15:58:37.5233333', N'2023-03-10 15:58:37.5233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'245', N'General', N'244', N'2023-03-10 15:58:37.5266667', N'2023-03-10 15:58:37.5266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'246', N'Nephrologist (Kidney Specialist)', NULL, N'2023-03-10 15:58:37.5300000', N'2023-03-10 15:58:37.5300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'247', N'General', N'246', N'2023-03-10 15:58:37.5300000', N'2023-03-10 15:58:37.5300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'248', N'Neurological Surgeon', NULL, N'2023-03-10 15:58:37.5333333', N'2023-03-10 15:58:37.5333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'249', N'General', N'248', N'2023-03-10 15:58:37.5366667', N'2023-03-10 15:58:37.5366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'250', N'Neuromusculoskeletal Medicine Specialist', NULL, N'2023-03-10 15:58:37.5400000', N'2023-03-10 15:58:37.5400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'251', N'Osteopathic Manual Manipulation', N'250', N'2023-03-10 15:58:37.5400000', N'2023-03-10 15:58:37.5400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'252', N'Sports Medicine', N'250', N'2023-03-10 15:58:37.5433333', N'2023-03-10 15:58:37.5433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'253', N'Nuclear Medicine Specialist', NULL, N'2023-03-10 15:58:37.5466667', N'2023-03-10 15:58:37.5466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'254', N'General', N'253', N'2023-03-10 15:58:37.5500000', N'2023-03-10 15:58:37.5500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'255', N'Nuclear Cardiology', N'253', N'2023-03-10 15:58:37.5500000', N'2023-03-10 15:58:37.5500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'256', N'Nuclear Imaging & Therapy', N'253', N'2023-03-10 15:58:37.5533333', N'2023-03-10 15:58:37.5533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'257', N'In Vivo & In Vitro Nuclear Medicine', N'253', N'2023-03-10 15:58:37.5566667', N'2023-03-10 15:58:37.5566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'258', N'Nurse Anesthetist', NULL, N'2023-03-10 15:58:37.5633333', N'2023-03-10 15:58:37.5633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'259', N'General', N'258', N'2023-03-10 15:58:37.5666667', N'2023-03-10 15:58:37.5666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'260', N'Nurse Practitioner (NP)', NULL, N'2023-03-10 15:58:37.5700000', N'2023-03-10 15:58:37.5700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'261', N'General', N'260', N'2023-03-10 15:58:37.5733333', N'2023-03-10 15:58:37.5733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'262', N'Acute Care', N'260', N'2023-03-10 15:58:37.5766667', N'2023-03-10 15:58:37.5766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'263', N'Adult Health', N'260', N'2023-03-10 15:58:37.5800000', N'2023-03-10 15:58:37.5800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'264', N'Critical Care Medicine', N'260', N'2023-03-10 15:58:37.5800000', N'2023-03-10 15:58:37.5800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'265', N'Community Health', N'260', N'2023-03-10 15:58:37.5833333', N'2023-03-10 15:58:37.5833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'266', N'Family', N'260', N'2023-03-10 15:58:37.5866667', N'2023-03-10 15:58:37.5866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'267', N'Gerontology', N'260', N'2023-03-10 15:58:37.5900000', N'2023-03-10 15:58:37.5900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'268', N'Neonatal', N'260', N'2023-03-10 15:58:37.5933333', N'2023-03-10 15:58:37.5933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'269', N'Neonatal, Critical Care', N'260', N'2023-03-10 15:58:37.5966667', N'2023-03-10 15:58:37.5966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'270', N'Pediatrics', N'260', N'2023-03-10 15:58:37.6000000', N'2023-03-10 15:58:37.6000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'271', N'Pediatrics, Critical Care', N'260', N'2023-03-10 15:58:37.6000000', N'2023-03-10 15:58:37.6000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'272', N'Psych/Mental Health', N'260', N'2023-03-10 15:58:37.6033333', N'2023-03-10 15:58:37.6033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'273', N'Perinatal', N'260', N'2023-03-10 15:58:37.6066667', N'2023-03-10 15:58:37.6066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'274', N'Primary Care', N'260', N'2023-03-10 15:58:37.6100000', N'2023-03-10 15:58:37.6100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'275', N'School', N'260', N'2023-03-10 15:58:37.6133333', N'2023-03-10 15:58:37.6133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'276', N'Womens Health', N'260', N'2023-03-10 15:58:37.6166667', N'2023-03-10 15:58:37.6166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'277', N'Obstetrics & Gynecology', N'260', N'2023-03-10 15:58:37.6200000', N'2023-03-10 15:58:37.6200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'278', N'Occupational Health', N'260', N'2023-03-10 15:58:37.6233333', N'2023-03-10 15:58:37.6233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'279', N'Dermatology', N'260', N'2023-03-10 15:58:37.6266667', N'2023-03-10 15:58:37.6266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'280', N'Nutritionist', NULL, N'2023-03-10 15:58:37.6300000', N'2023-03-10 15:58:37.6300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'281', N'General', N'280', N'2023-03-10 15:58:37.6300000', N'2023-03-10 15:58:37.6300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'282', N'Nutritionist - Nutrition, Education', N'280', N'2023-03-10 15:58:37.6333333', N'2023-03-10 15:58:37.6333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'283', N'Dietetic Technician, Registered', N'280', N'2023-03-10 15:58:37.6366667', N'2023-03-10 15:58:37.6366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'284', N'Obstetrician / Gynecologist (OBGYN)', NULL, N'2023-03-10 15:58:37.6400000', N'2023-03-10 15:58:37.6400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'285', N'General', N'284', N'2023-03-10 15:58:37.6400000', N'2023-03-10 15:58:37.6400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'286', N'Bariatric Medicine', N'284', N'2023-03-10 15:58:37.6433333', N'2023-03-10 15:58:37.6433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'287', N'Critical Care Medicine', N'284', N'2023-03-10 15:58:37.6466667', N'2023-03-10 15:58:37.6466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'288', N'Reproductive Endocrinology', N'284', N'2023-03-10 15:58:37.6500000', N'2023-03-10 15:58:37.6500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'289', N'Gynecology', N'284', N'2023-03-10 15:58:37.6533333', N'2023-03-10 15:58:37.6533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'290', N'Hospice & Palliative Medicine', N'284', N'2023-03-10 15:58:37.6566667', N'2023-03-10 15:58:37.6566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'291', N'Maternal & Fetal Medicine', N'284', N'2023-03-10 15:58:37.6600000', N'2023-03-10 15:58:37.6600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'292', N'Obstetrics', N'284', N'2023-03-10 15:58:37.6633333', N'2023-03-10 15:58:37.6633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'293', N'Gynecologic Oncology', N'284', N'2023-03-10 15:58:37.6633333', N'2023-03-10 15:58:37.6633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'294', N'Fertility and Cosmetic Surgery', N'284', N'2023-03-10 15:58:37.6700000', N'2023-03-10 15:58:37.6700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'295', N'Obstetrics & Gynecology - Female Pelvic Medicine and Reconstructive Surgery', N'284', N'2023-03-10 15:58:37.6700000', N'2023-03-10 15:58:37.6700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'296', N'Reproductive Endocrinology and Fertility', N'284', N'2023-03-10 15:58:37.6733333', N'2023-03-10 15:58:37.6733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'297', N'Urogynecology', N'284', N'2023-03-10 15:58:37.6766667', N'2023-03-10 15:58:37.6766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'298', N'Obstetrics & Gynecology - Complex Family Planning', N'284', N'2023-03-10 15:58:37.6800000', N'2023-03-10 15:58:37.6800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'299', N'Occupational Therapist (OT)', NULL, N'2023-03-10 15:58:37.6800000', N'2023-03-10 15:58:37.6800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'300', N'General', N'299', N'2023-03-10 15:58:37.6833333', N'2023-03-10 15:58:37.6833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'301', N'Ergonomics', N'299', N'2023-03-10 15:58:37.6900000', N'2023-03-10 15:58:37.6900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'302', N'Hand Specialist', N'299', N'2023-03-10 15:58:37.6900000', N'2023-03-10 15:58:37.6900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'303', N'Human Factors', N'299', N'2023-03-10 15:58:37.6933333', N'2023-03-10 15:58:37.6933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'304', N'Neurorehabilitation', N'299', N'2023-03-10 15:58:37.6966667', N'2023-03-10 15:58:37.6966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'305', N'Pediatrics', N'299', N'2023-03-10 15:58:37.6966667', N'2023-03-10 15:58:37.6966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'306', N'Driving and Community Mobility', N'299', N'2023-03-10 15:58:37.7000000', N'2023-03-10 15:58:37.7000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'307', N'Environmental Modification', N'299', N'2023-03-10 15:58:37.7033333', N'2023-03-10 15:58:37.7033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'308', N'Feeding, Eating & Swallowing', N'299', N'2023-03-10 15:58:37.7033333', N'2023-03-10 15:58:37.7033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'309', N'Gerontology', N'299', N'2023-03-10 15:58:37.7066667', N'2023-03-10 15:58:37.7066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'310', N'Low Vision', N'299', N'2023-03-10 15:58:37.7100000', N'2023-03-10 15:58:37.7100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'311', N'Mental Health', N'299', N'2023-03-10 15:58:37.7133333', N'2023-03-10 15:58:37.7133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'312', N'Physical Rehabilitation', N'299', N'2023-03-10 15:58:37.7133333', N'2023-03-10 15:58:37.7133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'313', N'Occupational Therapy Assistant', N'299', N'2023-03-10 15:58:37.7166667', N'2023-03-10 15:58:37.7166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'314', N'Occupational Therapy Assistant - Environmental Modification', N'299', N'2023-03-10 15:58:37.7200000', N'2023-03-10 15:58:37.7200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'315', N'Occupational Therapy Assistant - Feeding, Eating & Swallowing', N'299', N'2023-03-10 15:58:37.7233333', N'2023-03-10 15:58:37.7233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'316', N'Occupational Therapy Assistant - Low Vision', N'299', N'2023-03-10 15:58:37.7266667', N'2023-03-10 15:58:37.7266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'317', N'Occupational Therapy Assistant - Driving and Community Mobility', N'299', N'2023-03-10 15:58:37.7300000', N'2023-03-10 15:58:37.7300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'318', N'Ophthalmologist (Eye Doctor)', NULL, N'2023-03-10 15:58:37.7300000', N'2023-03-10 15:58:37.7300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'319', N'General', N'318', N'2023-03-10 15:58:37.7333333', N'2023-03-10 15:58:37.7333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'320', N'Ophthalmology - Glaucoma Specialist', N'318', N'2023-03-10 15:58:37.7366667', N'2023-03-10 15:58:37.7366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'321', N'Ophthalmology - Retina Specialist', N'318', N'2023-03-10 15:58:37.7400000', N'2023-03-10 15:58:37.7400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'322', N'Ophthalmology - Uveitis and Ocular Inflammatory Disease', N'318', N'2023-03-10 15:58:37.7400000', N'2023-03-10 15:58:37.7400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'323', N'Ophthalmology - Neuro-ophthalmology', N'318', N'2023-03-10 15:58:37.7433333', N'2023-03-10 15:58:37.7433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'324', N'Ophthalmology - Pediatric Ophthalmology and Strabismus Specialist', N'318', N'2023-03-10 15:58:37.7466667', N'2023-03-10 15:58:37.7466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'325', N'Ophthalmology - Cornea and External Diseases Specialist', N'318', N'2023-03-10 15:58:37.7500000', N'2023-03-10 15:58:37.7500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'326', N'Ophthalmology - Ophthalmic Plastic and Reconstructive Surgery', N'318', N'2023-03-10 15:58:37.7533333', N'2023-03-10 15:58:37.7533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'327', N'Optometrist (Eye & Vision Specialist)', NULL, N'2023-03-10 15:58:37.7566667', N'2023-03-10 15:58:37.7566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'328', N'General', N'327', N'2023-03-10 15:58:37.7600000', N'2023-03-10 15:58:37.7600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'329', N'Corneal and Contact Management', N'327', N'2023-03-10 15:58:37.7600000', N'2023-03-10 15:58:37.7600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'330', N'Low Vision Rehabilitation', N'327', N'2023-03-10 15:58:37.7633333', N'2023-03-10 15:58:37.7633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'331', N'Pediatrics', N'327', N'2023-03-10 15:58:37.7666667', N'2023-03-10 15:58:37.7666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'332', N'Sports Vision', N'327', N'2023-03-10 15:58:37.7700000', N'2023-03-10 15:58:37.7700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'333', N'Vision Therapy', N'327', N'2023-03-10 15:58:37.7733333', N'2023-03-10 15:58:37.7733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'334', N'Occupational Vision', N'327', N'2023-03-10 15:58:37.7766667', N'2023-03-10 15:58:37.7766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'335', N'Orthopedic Surgeon', NULL, N'2023-03-10 15:58:37.7800000', N'2023-03-10 15:58:37.7800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'336', N'General', N'335', N'2023-03-10 15:58:37.7800000', N'2023-03-10 15:58:37.7800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'337', N'Hand Surgery', N'335', N'2023-03-10 15:58:37.7833333', N'2023-03-10 15:58:37.7833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'338', N'Surgery of the Spine', N'335', N'2023-03-10 15:58:37.7866667', N'2023-03-10 15:58:37.7866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'339', N'Foot & Ankle Surgery', N'335', N'2023-03-10 15:58:37.7900000', N'2023-03-10 15:58:37.7900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'340', N'Sports Medicine', N'335', N'2023-03-10 15:58:37.7900000', N'2023-03-10 15:58:37.7900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'341', N'Adult Reconstructive Orthopaedic Surgery', N'335', N'2023-03-10 15:58:37.7933333', N'2023-03-10 15:58:37.7933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'342', N'Pediatric Orthopaedic Surgery', N'335', N'2023-03-10 15:58:37.7966667', N'2023-03-10 15:58:37.7966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'343', N'Orthopaedic Trauma', N'335', N'2023-03-10 15:58:37.7966667', N'2023-03-10 15:58:37.7966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'344', N'Joint Replacement', N'335', N'2023-03-10 15:58:37.8000000', N'2023-03-10 15:58:37.8000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'345', N'Orthotics/Prosthetics Fitter', NULL, N'2023-03-10 15:58:37.8033333', N'2023-03-10 15:58:37.8033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'346', N'General', N'345', N'2023-03-10 15:58:37.8066667', N'2023-03-10 15:58:37.8066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'347', N'Orthotist', NULL, N'2023-03-10 15:58:37.8100000', N'2023-03-10 15:58:37.8100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'348', N'General', N'347', N'2023-03-10 15:58:37.8100000', N'2023-03-10 15:58:37.8100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'349', N'Otolaryngologist (Ear, Nose & Throat - ENT)', NULL, N'2023-03-10 15:58:37.8133333', N'2023-03-10 15:58:37.8133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'350', N'General', N'349', N'2023-03-10 15:58:37.8166667', N'2023-03-10 15:58:37.8166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'351', N'Pediatric Otolaryngology', N'349', N'2023-03-10 15:58:37.8200000', N'2023-03-10 15:58:37.8200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'352', N'Sleep Medicine', N'349', N'2023-03-10 15:58:37.8200000', N'2023-03-10 15:58:37.8200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'353', N'Facial Plastic Surgery', N'349', N'2023-03-10 15:58:37.8233333', N'2023-03-10 15:58:37.8233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'354', N'Head & Neck Oncology Surgery', N'349', N'2023-03-10 15:58:37.8266667', N'2023-03-10 15:58:37.8266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'355', N'Otolaryngic Allergy', N'349', N'2023-03-10 15:58:37.8300000', N'2023-03-10 15:58:37.8300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'356', N'Otology & Neurotology', N'349', N'2023-03-10 15:58:37.8333333', N'2023-03-10 15:58:37.8333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'357', N'Facial Plastic & Reconstructive Surgery', N'349', N'2023-03-10 15:58:37.8366667', N'2023-03-10 15:58:37.8366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'358', N'Sinus', N'349', N'2023-03-10 15:58:37.8400000', N'2023-03-10 15:58:37.8400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'359', N'Sleep & Snoring', N'349', N'2023-03-10 15:58:37.8400000', N'2023-03-10 15:58:37.8400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'360', N'Thyroid/Parathyroid', N'349', N'2023-03-10 15:58:37.8433333', N'2023-03-10 15:58:37.8433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'361', N'Sinus & Skull Base Surgery', N'349', N'2023-03-10 15:58:37.8466667', N'2023-03-10 15:58:37.8466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'362', N'Skull Base Surgery', N'349', N'2023-03-10 15:58:37.8466667', N'2023-03-10 15:58:37.8466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'363', N'Sinus Surgery', N'349', N'2023-03-10 15:58:37.8500000', N'2023-03-10 15:58:37.8500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'364', N'Microvascular Reconstruction', N'349', N'2023-03-10 15:58:37.8533333', N'2023-03-10 15:58:37.8533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'365', N'Pain Medicine Specialist', NULL, N'2023-03-10 15:58:37.8566667', N'2023-03-10 15:58:37.8566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'366', N'General', N'365', N'2023-03-10 15:58:37.8566667', N'2023-03-10 15:58:37.8566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'367', N'Pain Medicine - Interventional Pain Medicine', N'365', N'2023-03-10 15:58:37.8633333', N'2023-03-10 15:58:37.8633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'368', N'Pathologist', NULL, N'2023-03-10 15:58:37.8666667', N'2023-03-10 15:58:37.8666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'369', N'Blood Banking & Transfusion Medicine', N'368', N'2023-03-10 15:58:37.8700000', N'2023-03-10 15:58:37.8700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'370', N'Clinical Pathology', N'368', N'2023-03-10 15:58:37.8733333', N'2023-03-10 15:58:37.8733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'371', N'Cytopathology', N'368', N'2023-03-10 15:58:37.8766667', N'2023-03-10 15:58:37.8766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'372', N'Dermatopathology', N'368', N'2023-03-10 15:58:37.8800000', N'2023-03-10 15:58:37.8800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'373', N'Forensic Pathology', N'368', N'2023-03-10 15:58:37.8800000', N'2023-03-10 15:58:37.8800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'374', N'Hematology', N'368', N'2023-03-10 15:58:37.8833333', N'2023-03-10 15:58:37.8833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'375', N'Immunopathology', N'368', N'2023-03-10 15:58:37.8866667', N'2023-03-10 15:58:37.8866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'376', N'Medical Microbiology', N'368', N'2023-03-10 15:58:37.8900000', N'2023-03-10 15:58:37.8900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'377', N'Neuropathology', N'368', N'2023-03-10 15:58:37.8900000', N'2023-03-10 15:58:37.8900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'378', N'Molecular Genetic Pathology', N'368', N'2023-03-10 15:58:37.8933333', N'2023-03-10 15:58:37.8933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'379', N'Anatomic Pathology', N'368', N'2023-03-10 15:58:37.8966667', N'2023-03-10 15:58:37.8966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'380', N'Anatomic Pathology & Clinical Pathology', N'368', N'2023-03-10 15:58:37.9000000', N'2023-03-10 15:58:37.9000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'381', N'Chemical Pathology', N'368', N'2023-03-10 15:58:37.9000000', N'2023-03-10 15:58:37.9000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'382', N'Clinical Pathology/Laboratory Medicine', N'368', N'2023-03-10 15:58:37.9033333', N'2023-03-10 15:58:37.9033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'383', N'Pediatric Pathology', N'368', N'2023-03-10 15:58:37.9066667', N'2023-03-10 15:58:37.9066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'384', N'Pathology - Clinical Informatics', N'368', N'2023-03-10 15:58:37.9100000', N'2023-03-10 15:58:37.9100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'385', N'Pediatrician (Kids / Children Specialist)', NULL, N'2023-03-10 15:58:37.9100000', N'2023-03-10 15:58:37.9100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'386', N'General', N'385', N'2023-03-10 15:58:37.9133333', N'2023-03-10 15:58:37.9133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'387', N'Adolescent Medicine', N'385', N'2023-03-10 15:58:37.9166667', N'2023-03-10 15:58:37.9166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'388', N'Hospice & Palliative Medicine', N'385', N'2023-03-10 15:58:37.9200000', N'2023-03-10 15:58:37.9200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'389', N'Clinical & Laboratory Immunology', N'385', N'2023-03-10 15:58:37.9200000', N'2023-03-10 15:58:37.9200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'390', N'Neonatal-Perinatal Medicine', N'385', N'2023-03-10 15:58:37.9233333', N'2023-03-10 15:58:37.9233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'391', N'Developmental - Behavioral Pediatrics', N'385', N'2023-03-10 15:58:37.9266667', N'2023-03-10 15:58:37.9266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'392', N'Neurodevelopmental Disabilities', N'385', N'2023-03-10 15:58:37.9300000', N'2023-03-10 15:58:37.9300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'393', N'Pediatric Allergy & Immunology', N'385', N'2023-03-10 15:58:37.9300000', N'2023-03-10 15:58:37.9300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'394', N'Pediatric Cardiology', N'385', N'2023-03-10 15:58:37.9333333', N'2023-03-10 15:58:37.9333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'395', N'Pediatric Critical Care Medicine', N'385', N'2023-03-10 15:58:37.9366667', N'2023-03-10 15:58:37.9366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'396', N'Pediatric Emergency Medicine', N'385', N'2023-03-10 15:58:37.9366667', N'2023-03-10 15:58:37.9366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'397', N'Pediatric Endocrinology', N'385', N'2023-03-10 15:58:37.9400000', N'2023-03-10 15:58:37.9400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'398', N'Pediatric Gastroenterology', N'385', N'2023-03-10 15:58:37.9433333', N'2023-03-10 15:58:37.9433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'399', N'Pediatric Hematology-Oncology', N'385', N'2023-03-10 15:58:37.9466667', N'2023-03-10 15:58:37.9466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'400', N'Pediatric Infectious Diseases', N'385', N'2023-03-10 15:58:37.9500000', N'2023-03-10 15:58:37.9500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'401', N'Pediatric Nephrology', N'385', N'2023-03-10 15:58:37.9533333', N'2023-03-10 15:58:37.9533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'402', N'Pediatric Pulmonology', N'385', N'2023-03-10 15:58:37.9533333', N'2023-03-10 15:58:37.9533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'403', N'Pediatric Rheumatology', N'385', N'2023-03-10 15:58:37.9600000', N'2023-03-10 15:58:37.9600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'404', N'Sports Medicine', N'385', N'2023-03-10 15:58:37.9600000', N'2023-03-10 15:58:37.9600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'405', N'Sleep Medicine', N'385', N'2023-03-10 15:58:37.9633333', N'2023-03-10 15:58:37.9633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'406', N'Medical Toxicology', N'385', N'2023-03-10 15:58:37.9666667', N'2023-03-10 15:58:37.9666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'407', N'Pediatric Transplant Hepatology', N'385', N'2023-03-10 15:58:37.9700000', N'2023-03-10 15:58:37.9700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'408', N'Pediatrics - Obesity Medicine', N'385', N'2023-03-10 15:58:37.9700000', N'2023-03-10 15:58:37.9700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'409', N'Pediatrics - Child Abuse Pediatrics', N'385', N'2023-03-10 15:58:37.9766667', N'2023-03-10 15:58:37.9766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'410', N'Phlebologist (Vein Specialist)', NULL, N'2023-03-10 15:58:37.9800000', N'2023-03-10 15:58:37.9800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'411', N'General', N'410', N'2023-03-10 15:58:37.9833333', N'2023-03-10 15:58:37.9833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'412', N'Physical Therapist (PT)', NULL, N'2023-03-10 15:58:37.9866667', N'2023-03-10 15:58:37.9866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'413', N'General', N'412', N'2023-03-10 15:58:37.9900000', N'2023-03-10 15:58:37.9900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'414', N'Cardiopulmonary', N'412', N'2023-03-10 15:58:37.9933333', N'2023-03-10 15:58:37.9933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'415', N'Ergonomics', N'412', N'2023-03-10 15:58:37.9933333', N'2023-03-10 15:58:37.9933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'416', N'Clinical Electrophysiology', N'412', N'2023-03-10 15:58:37.9966667', N'2023-03-10 15:58:37.9966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'417', N'Geriatrics', N'412', N'2023-03-10 15:58:38.0000000', N'2023-03-10 15:58:38.0000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'418', N'Hand', N'412', N'2023-03-10 15:58:38.0033333', N'2023-03-10 15:58:38.0033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'419', N'Human Factors', N'412', N'2023-03-10 15:58:38.0066667', N'2023-03-10 15:58:38.0066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'420', N'Neurology', N'412', N'2023-03-10 15:58:38.0066667', N'2023-03-10 15:58:38.0066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'421', N'Pediatrics', N'412', N'2023-03-10 15:58:38.0100000', N'2023-03-10 15:58:38.0100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'422', N'Sports', N'412', N'2023-03-10 15:58:38.0133333', N'2023-03-10 15:58:38.0133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'423', N'Orthopedic', N'412', N'2023-03-10 15:58:38.0166667', N'2023-03-10 15:58:38.0166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'424', N'Pelvic Pain/Dysfunction', N'412', N'2023-03-10 15:58:38.0166667', N'2023-03-10 15:58:38.0166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'425', N'Physical Therapy Assistant', N'412', N'2023-03-10 15:58:38.0200000', N'2023-03-10 15:58:38.0200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'426', N'Physician Assistant (PA)', NULL, N'2023-03-10 15:58:38.0233333', N'2023-03-10 15:58:38.0233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'427', N'General', N'426', N'2023-03-10 15:58:38.0266667', N'2023-03-10 15:58:38.0266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'428', N'Medical', N'426', N'2023-03-10 15:58:38.0300000', N'2023-03-10 15:58:38.0300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'429', N'Surgical', N'426', N'2023-03-10 15:58:38.0300000', N'2023-03-10 15:58:38.0300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'430', N'Dermatology', N'426', N'2023-03-10 15:58:38.0333333', N'2023-03-10 15:58:38.0333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'431', N'Plastic, Reconstructive, and Cosmetic Surgeon', NULL, N'2023-03-10 15:58:38.0366667', N'2023-03-10 15:58:38.0366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'432', N'General', N'431', N'2023-03-10 15:58:38.0400000', N'2023-03-10 15:58:38.0400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'433', N'Head and Neck Surgery Specialist', N'431', N'2023-03-10 15:58:38.0433333', N'2023-03-10 15:58:38.0433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'434', N'Hand Surgery Specialist', N'431', N'2023-03-10 15:58:38.0433333', N'2023-03-10 15:58:38.0433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'435', N'Plastic Surgery - Plastic Surgery Within the Head and Neck', N'431', N'2023-03-10 15:58:38.0466667', N'2023-03-10 15:58:38.0466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'436', N'Podiatrist (Foot Specialist)', NULL, N'2023-03-10 15:58:38.0500000', N'2023-03-10 15:58:38.0500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'437', N'Podiatrist', N'436', N'2023-03-10 15:58:38.0500000', N'2023-03-10 15:58:38.0500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'438', N'General Practice', N'436', N'2023-03-10 15:58:38.0533333', N'2023-03-10 15:58:38.0533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'439', N'Public Medicine', N'436', N'2023-03-10 15:58:38.0566667', N'2023-03-10 15:58:38.0566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'440', N'Primary Podiatric Medicine', N'436', N'2023-03-10 15:58:38.0600000', N'2023-03-10 15:58:38.0600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'441', N'Radiology', N'436', N'2023-03-10 15:58:38.0633333', N'2023-03-10 15:58:38.0633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'442', N'Sports Medicine', N'436', N'2023-03-10 15:58:38.0666667', N'2023-03-10 15:58:38.0666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'443', N'Foot & Ankle Surgery', N'436', N'2023-03-10 15:58:38.0700000', N'2023-03-10 15:58:38.0700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'444', N'Foot Surgery', N'436', N'2023-03-10 15:58:38.0700000', N'2023-03-10 15:58:38.0700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'445', N'Assistant, Podiatric', N'436', N'2023-03-10 15:58:38.0733333', N'2023-03-10 15:58:38.0733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'446', N'Poetry Therapist', NULL, N'2023-03-10 15:58:38.0766667', N'2023-03-10 15:58:38.0766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'447', N'General', N'446', N'2023-03-10 15:58:38.0800000', N'2023-03-10 15:58:38.0800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'448', N'Preventive Medicine Specialist', NULL, N'2023-03-10 15:58:38.0800000', N'2023-03-10 15:58:38.0800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'449', N'Aerospace Medicine', N'448', N'2023-03-10 15:58:38.0833333', N'2023-03-10 15:58:38.0833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'450', N'Undersea and Hyperbaric Medicine', N'448', N'2023-03-10 15:58:38.0866667', N'2023-03-10 15:58:38.0866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'451', N'Preventive Medicine/Occupational Environmental Medicine', N'448', N'2023-03-10 15:58:38.0900000', N'2023-03-10 15:58:38.0900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'452', N'Public Health & General Preventive Medicine', N'448', N'2023-03-10 15:58:38.0933333', N'2023-03-10 15:58:38.0933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'453', N'Sports Medicine', N'448', N'2023-03-10 15:58:38.0933333', N'2023-03-10 15:58:38.0933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'454', N'Medical Toxicology', N'448', N'2023-03-10 15:58:38.0966667', N'2023-03-10 15:58:38.0966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'455', N'Occupational Medicine', N'448', N'2023-03-10 15:58:38.1000000', N'2023-03-10 15:58:38.1000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'456', N'Preventive Medicine - Obesity Medicine', N'448', N'2023-03-10 15:58:38.1000000', N'2023-03-10 15:58:38.1000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'457', N'Preventive Medicine - Clinical Informatics', N'448', N'2023-03-10 15:58:38.1033333', N'2023-03-10 15:58:38.1033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'458', N'Preventive Medicine - Addiction Medicine', N'448', N'2023-03-10 15:58:38.1066667', N'2023-03-10 15:58:38.1066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'459', N'Prosthetist', NULL, N'2023-03-10 15:58:38.1100000', N'2023-03-10 15:58:38.1100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'460', N'General', N'459', N'2023-03-10 15:58:38.1100000', N'2023-03-10 15:58:38.1100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'461', N'Psychiatrist', NULL, N'2023-03-10 15:58:38.1133333', N'2023-03-10 15:58:38.1133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'462', N'Forensic Psychiatry', N'461', N'2023-03-10 15:58:38.1166667', N'2023-03-10 15:58:38.1166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'463', N'Psychosomatic Medicine', N'461', N'2023-03-10 15:58:38.1200000', N'2023-03-10 15:58:38.1200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'464', N'General', N'461', N'2023-03-10 15:58:38.1200000', N'2023-03-10 15:58:38.1200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'465', N'Addiction Psychiatry', N'461', N'2023-03-10 15:58:38.1233333', N'2023-03-10 15:58:38.1233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'466', N'Child & Adolescent Psychiatry', N'461', N'2023-03-10 15:58:38.1266667', N'2023-03-10 15:58:38.1266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'467', N'Geriatric Psychiatry', N'461', N'2023-03-10 15:58:38.1300000', N'2023-03-10 15:58:38.1300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'468', N'Neurologist', NULL, N'2023-03-10 15:58:38.1300000', N'2023-03-10 15:58:38.1300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'469', N'Diagnostic Neuroimaging', N'468', N'2023-03-10 15:58:38.1333333', N'2023-03-10 15:58:38.1333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'470', N'Neuromuscular Medicine', N'468', N'2023-03-10 15:58:38.1366667', N'2023-03-10 15:58:38.1366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'471', N'General', N'468', N'2023-03-10 15:58:38.1400000', N'2023-03-10 15:58:38.1400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'472', N'Special Qualifications in Child Neurology', N'468', N'2023-03-10 15:58:38.1433333', N'2023-03-10 15:58:38.1433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'473', N'Neurodevelopmental Disabilities', N'468', N'2023-03-10 15:58:38.1466667', N'2023-03-10 15:58:38.1466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'474', N'Pain Medicine', N'468', N'2023-03-10 15:58:38.1500000', N'2023-03-10 15:58:38.1500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'475', N'Vascular Neurology', N'468', N'2023-03-10 15:58:38.1500000', N'2023-03-10 15:58:38.1500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'476', N'Epileptologist', N'468', N'2023-03-10 15:58:38.1533333', N'2023-03-10 15:58:38.1533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'477', N'Psychoanalyst', NULL, N'2023-03-10 15:58:38.1600000', N'2023-03-10 15:58:38.1600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'478', N'General', N'477', N'2023-03-10 15:58:38.1633333', N'2023-03-10 15:58:38.1633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'479', N'Psychologist', NULL, N'2023-03-10 15:58:38.1666667', N'2023-03-10 15:58:38.1666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'480', N'General', N'479', N'2023-03-10 15:58:38.1700000', N'2023-03-10 15:58:38.1700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'481', N'Addiction & Substance Use Disorders', N'479', N'2023-03-10 15:58:38.1700000', N'2023-03-10 15:58:38.1700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'482', N'Adult Development & Aging', N'479', N'2023-03-10 15:58:38.1733333', N'2023-03-10 15:58:38.1733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'483', N'Cognitive & Behavioral', N'479', N'2023-03-10 15:58:38.1766667', N'2023-03-10 15:58:38.1766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'484', N'Clinical', N'479', N'2023-03-10 15:58:38.1800000', N'2023-03-10 15:58:38.1800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'485', N'Counseling', N'479', N'2023-03-10 15:58:38.1800000', N'2023-03-10 15:58:38.1800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'486', N'Clinical Child & Adolescent', N'479', N'2023-03-10 15:58:38.1833333', N'2023-03-10 15:58:38.1833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'487', N'Educational', N'479', N'2023-03-10 15:58:38.1866667', N'2023-03-10 15:58:38.1866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'488', N'Exercise & Sports', N'479', N'2023-03-10 15:58:38.1866667', N'2023-03-10 15:58:38.1866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'489', N'Family', N'479', N'2023-03-10 15:58:38.1933333', N'2023-03-10 15:58:38.1933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'490', N'Forensic', N'479', N'2023-03-10 15:58:38.1933333', N'2023-03-10 15:58:38.1933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'491', N'Health', N'479', N'2023-03-10 15:58:38.1966667', N'2023-03-10 15:58:38.1966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'492', N'Health Service', N'479', N'2023-03-10 15:58:38.2000000', N'2023-03-10 15:58:38.2000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'493', N'Men & Masculinity', N'479', N'2023-03-10 15:58:38.2000000', N'2023-03-10 15:58:38.2000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'494', N'Mental Retardation & Developmental Disabilities', N'479', N'2023-03-10 15:58:38.2066667', N'2023-03-10 15:58:38.2066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'495', N'Medical (Prescribing)', N'479', N'2023-03-10 15:58:38.2100000', N'2023-03-10 15:58:38.2100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'496', N'Psychoanalysis', N'479', N'2023-03-10 15:58:38.2100000', N'2023-03-10 15:58:38.2100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'497', N'Psychotherapy', N'479', N'2023-03-10 15:58:38.2133333', N'2023-03-10 15:58:38.2133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'498', N'Group Psychotherapy', N'479', N'2023-03-10 15:58:38.2166667', N'2023-03-10 15:58:38.2166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'499', N'Rehabilitation', N'479', N'2023-03-10 15:58:38.2200000', N'2023-03-10 15:58:38.2200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'500', N'School', N'479', N'2023-03-10 15:58:38.2233333', N'2023-03-10 15:58:38.2233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'501', N'Women', N'479', N'2023-03-10 15:58:38.2266667', N'2023-03-10 15:58:38.2266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'502', N'Neuropsychologist', N'479', N'2023-03-10 15:58:38.2300000', N'2023-03-10 15:58:38.2300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'503', N'Pulmonologist (Lung Specialist)', NULL, N'2023-03-10 15:58:38.2300000', N'2023-03-10 15:58:38.2300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'504', N'General', N'503', N'2023-03-10 15:58:38.2333333', N'2023-03-10 15:58:38.2333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'505', N'Radiologist', NULL, N'2023-03-10 15:58:38.2366667', N'2023-03-10 15:58:38.2366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'506', N'Body Imaging', N'505', N'2023-03-10 15:58:38.2400000', N'2023-03-10 15:58:38.2400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'507', N'Diagnostic Neuroimaging', N'505', N'2023-03-10 15:58:38.2400000', N'2023-03-10 15:58:38.2400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'508', N'Hospice & Palliative Medicine', N'505', N'2023-03-10 15:58:38.2433333', N'2023-03-10 15:58:38.2433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'509', N'Neuroradiology', N'505', N'2023-03-10 15:58:38.2466667', N'2023-03-10 15:58:38.2466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'510', N'Nuclear Radiology', N'505', N'2023-03-10 15:58:38.2500000', N'2023-03-10 15:58:38.2500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'511', N'Pediatric Radiology', N'505', N'2023-03-10 15:58:38.2500000', N'2023-03-10 15:58:38.2500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'512', N'Radiation Oncology', N'505', N'2023-03-10 15:58:38.2533333', N'2023-03-10 15:58:38.2533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'513', N'Diagnostic Radiology', N'505', N'2023-03-10 15:58:38.2566667', N'2023-03-10 15:58:38.2566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'514', N'Therapeutic Radiology', N'505', N'2023-03-10 15:58:38.2600000', N'2023-03-10 15:58:38.2600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'515', N'Vascular & Interventional Radiology', N'505', N'2023-03-10 15:58:38.2633333', N'2023-03-10 15:58:38.2633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'516', N'Radiological Physics', N'505', N'2023-03-10 15:58:38.2666667', N'2023-03-10 15:58:38.2666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'517', N'Diagnostic Ultrasound', N'505', N'2023-03-10 15:58:38.2700000', N'2023-03-10 15:58:38.2700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'518', N'Breast Imaging', N'505', N'2023-03-10 15:58:38.2733333', N'2023-03-10 15:58:38.2733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'519', N'Recreation Therapist', NULL, N'2023-03-10 15:58:38.2766667', N'2023-03-10 15:58:38.2766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'520', N'General', N'519', N'2023-03-10 15:58:38.2800000', N'2023-03-10 15:58:38.2800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'521', N'Reflexologist', NULL, N'2023-03-10 15:58:38.2800000', N'2023-03-10 15:58:38.2800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'522', N'General', N'521', N'2023-03-10 15:58:38.2833333', N'2023-03-10 15:58:38.2833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'523', N'Dietitian', NULL, N'2023-03-10 15:58:38.2866667', N'2023-03-10 15:58:38.2866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'524', N'General', N'523', N'2023-03-10 15:58:38.2900000', N'2023-03-10 15:58:38.2900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'525', N'Pediatric Nutrition', N'523', N'2023-03-10 15:58:38.2933333', N'2023-03-10 15:58:38.2933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'526', N'Renal Nutrition', N'523', N'2023-03-10 15:58:38.2966667', N'2023-03-10 15:58:38.2966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'527', N'Metabolic Nutrition', N'523', N'2023-03-10 15:58:38.2966667', N'2023-03-10 15:58:38.2966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'528', N'Gerontological Nutrition', N'523', N'2023-03-10 15:58:38.3000000', N'2023-03-10 15:58:38.3000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'529', N'Obesity and Weight Management Nutrition', N'523', N'2023-03-10 15:58:38.3033333', N'2023-03-10 15:58:38.3033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'530', N'Oncology Nutrition', N'523', N'2023-03-10 15:58:38.3033333', N'2023-03-10 15:58:38.3033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'531', N'Pediatric Critical Care Nutrition', N'523', N'2023-03-10 15:58:38.3100000', N'2023-03-10 15:58:38.3100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'532', N'Sports Dietetics Nutrotion', N'523', N'2023-03-10 15:58:38.3100000', N'2023-03-10 15:58:38.3100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'533', N'Registered Nurse (RN)', NULL, N'2023-03-10 15:58:38.3133333', N'2023-03-10 15:58:38.3133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'534', N'General', N'533', N'2023-03-10 15:58:38.3166667', N'2023-03-10 15:58:38.3166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'535', N'Addiction & Substance Use Disorder', N'533', N'2023-03-10 15:58:38.3200000', N'2023-03-10 15:58:38.3200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'536', N'Administrator', N'533', N'2023-03-10 15:58:38.3200000', N'2023-03-10 15:58:38.3200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'537', N'Critical Care Medicine', N'533', N'2023-03-10 15:58:38.3233333', N'2023-03-10 15:58:38.3233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'538', N'Case Management', N'533', N'2023-03-10 15:58:38.3266667', N'2023-03-10 15:58:38.3266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'539', N'College Health', N'533', N'2023-03-10 15:58:38.3300000', N'2023-03-10 15:58:38.3300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'540', N'Community Health', N'533', N'2023-03-10 15:58:38.3333333', N'2023-03-10 15:58:38.3333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'541', N'Continuing Education/Staff Development', N'533', N'2023-03-10 15:58:38.3333333', N'2023-03-10 15:58:38.3333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'542', N'Continence Care', N'533', N'2023-03-10 15:58:38.3366667', N'2023-03-10 15:58:38.3366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'543', N'Cardiac Rehabilitation', N'533', N'2023-03-10 15:58:38.3400000', N'2023-03-10 15:58:38.3400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'544', N'Diabetes Education', N'533', N'2023-03-10 15:58:38.3433333', N'2023-03-10 15:58:38.3433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'545', N'Peritoneal Dialysis', N'533', N'2023-03-10 15:58:38.3466667', N'2023-03-10 15:58:38.3466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'546', N'Emergency', N'533', N'2023-03-10 15:58:38.3500000', N'2023-03-10 15:58:38.3500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'547', N'Enterostomal Therapy', N'533', N'2023-03-10 15:58:38.3500000', N'2023-03-10 15:58:38.3500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'548', N'Flight', N'533', N'2023-03-10 15:58:38.3533333', N'2023-03-10 15:58:38.3533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'549', N'General Practice', N'533', N'2023-03-10 15:58:38.3600000', N'2023-03-10 15:58:38.3600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'550', N'Gastroenterology', N'533', N'2023-03-10 15:58:38.3600000', N'2023-03-10 15:58:38.3600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'551', N'Gerontology', N'533', N'2023-03-10 15:58:38.3633333', N'2023-03-10 15:58:38.3633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'552', N'Home Health', N'533', N'2023-03-10 15:58:38.3666667', N'2023-03-10 15:58:38.3666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'553', N'Hemodialysis', N'533', N'2023-03-10 15:58:38.3700000', N'2023-03-10 15:58:38.3700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'554', N'Hospice', N'533', N'2023-03-10 15:58:38.3700000', N'2023-03-10 15:58:38.3700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'555', N'Infusion Therapy', N'533', N'2023-03-10 15:58:38.3733333', N'2023-03-10 15:58:38.3733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'556', N'Infection Control', N'533', N'2023-03-10 15:58:38.3766667', N'2023-03-10 15:58:38.3766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'557', N'Lactation Consultant', N'533', N'2023-03-10 15:58:38.3800000', N'2023-03-10 15:58:38.3800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'558', N'Maternal Newborn', N'533', N'2023-03-10 15:58:38.3833333', N'2023-03-10 15:58:38.3833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'559', N'Medical-Surgical', N'533', N'2023-03-10 15:58:38.3866667', N'2023-03-10 15:58:38.3866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'560', N'NMT', N'533', N'2023-03-10 15:58:38.3866667', N'2023-03-10 15:58:38.3866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'561', N'Neonatal Intensive Care', N'533', N'2023-03-10 15:58:38.3900000', N'2023-03-10 15:58:38.3900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'562', N'Neonatal, Low-Risk', N'533', N'2023-03-10 15:58:38.3933333', N'2023-03-10 15:58:38.3933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'563', N'Nephrology', N'533', N'2023-03-10 15:58:38.3966667', N'2023-03-10 15:58:38.3966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'564', N'Neuroscience', N'533', N'2023-03-10 15:58:38.4000000', N'2023-03-10 15:58:38.4000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'565', N'Nutrition Support', N'533', N'2023-03-10 15:58:38.4000000', N'2023-03-10 15:58:38.4000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'566', N'Pain Management', N'533', N'2023-03-10 15:58:38.4033333', N'2023-03-10 15:58:38.4033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'567', N'Pediatrics', N'533', N'2023-03-10 15:58:38.4066667', N'2023-03-10 15:58:38.4066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'568', N'Pediatric Oncology', N'533', N'2023-03-10 15:58:38.4100000', N'2023-03-10 15:58:38.4100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'569', N'Psych/Mental Health, Child & Adolescent', N'533', N'2023-03-10 15:58:38.4100000', N'2023-03-10 15:58:38.4100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'570', N'Psych/Mental Health', N'533', N'2023-03-10 15:58:38.4133333', N'2023-03-10 15:58:38.4133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'571', N'Psych/Mental Health, Adult', N'533', N'2023-03-10 15:58:38.4166667', N'2023-03-10 15:58:38.4166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'572', N'Perinatal', N'533', N'2023-03-10 15:58:38.4200000', N'2023-03-10 15:58:38.4200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'573', N'Ambulatory Care', N'533', N'2023-03-10 15:58:38.4200000', N'2023-03-10 15:58:38.4200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'574', N'Registered Nurse First Assistant', N'533', N'2023-03-10 15:58:38.4233333', N'2023-03-10 15:58:38.4233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'575', N'Rehabilitation', N'533', N'2023-03-10 15:58:38.4266667', N'2023-03-10 15:58:38.4266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'576', N'Reproductive Endocrinology/Fertility', N'533', N'2023-03-10 15:58:38.4300000', N'2023-03-10 15:58:38.4300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'577', N'Plastic Surgery', N'533', N'2023-03-10 15:58:38.4333333', N'2023-03-10 15:58:38.4333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'578', N'School', N'533', N'2023-03-10 15:58:38.4333333', N'2023-03-10 15:58:38.4333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'579', N'Urology', N'533', N'2023-03-10 15:58:38.4366667', N'2023-03-10 15:58:38.4366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'580', N'Wound Care', N'533', N'2023-03-10 15:58:38.4400000', N'2023-03-10 15:58:38.4400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'581', N'Womens Health Care, Ambulatory', N'533', N'2023-03-10 15:58:38.4433333', N'2023-03-10 15:58:38.4433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'582', N'Obstetric, High-Risk', N'533', N'2023-03-10 15:58:38.4466667', N'2023-03-10 15:58:38.4466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'583', N'Obstetric, Inpatient', N'533', N'2023-03-10 15:58:38.4500000', N'2023-03-10 15:58:38.4500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'584', N'Occupational Health', N'533', N'2023-03-10 15:58:38.4500000', N'2023-03-10 15:58:38.4500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'585', N'Oncology', N'533', N'2023-03-10 15:58:38.4533333', N'2023-03-10 15:58:38.4533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'586', N'Otorhinolaryngology & Head-Neck', N'533', N'2023-03-10 15:58:38.4566667', N'2023-03-10 15:58:38.4566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'587', N'Orthopedic', N'533', N'2023-03-10 15:58:38.4600000', N'2023-03-10 15:58:38.4600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'588', N'Ophthalmic', N'533', N'2023-03-10 15:58:38.4633333', N'2023-03-10 15:58:38.4633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'589', N'Ostomy Care', N'533', N'2023-03-10 15:58:38.4666667', N'2023-03-10 15:58:38.4666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'590', N'Respiratory Therapist', NULL, N'2023-03-10 15:58:38.4700000', N'2023-03-10 15:58:38.4700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'591', N'General', N'590', N'2023-03-10 15:58:38.4700000', N'2023-03-10 15:58:38.4700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'592', N'Critical Care', N'590', N'2023-03-10 15:58:38.4733333', N'2023-03-10 15:58:38.4733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'593', N'Emergency Care', N'590', N'2023-03-10 15:58:38.4800000', N'2023-03-10 15:58:38.4800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'594', N'Educational', N'590', N'2023-03-10 15:58:38.4833333', N'2023-03-10 15:58:38.4833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'595', N'Geriatric Care', N'590', N'2023-03-10 15:58:38.4866667', N'2023-03-10 15:58:38.4866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'596', N'General Care', N'590', N'2023-03-10 15:58:38.4866667', N'2023-03-10 15:58:38.4866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'597', N'Home Health', N'590', N'2023-03-10 15:58:38.5000000', N'2023-03-10 15:58:38.5000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'598', N'Pulmonary Diagnostics', N'590', N'2023-03-10 15:58:38.5066667', N'2023-03-10 15:58:38.5066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'599', N'Pulmonary Rehabilitation', N'590', N'2023-03-10 15:58:38.5100000', N'2023-03-10 15:58:38.5100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'600', N'Pulmonary Function Technology', N'590', N'2023-03-10 15:58:38.5133333', N'2023-03-10 15:58:38.5133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'601', N'Palliative & Hospice', N'590', N'2023-03-10 15:58:38.5133333', N'2023-03-10 15:58:38.5133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'602', N'Neonatal/Pediatrics', N'590', N'2023-03-10 15:58:38.5166667', N'2023-03-10 15:58:38.5166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'603', N'Patient Transport', N'590', N'2023-03-10 15:58:38.5200000', N'2023-03-10 15:58:38.5200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'604', N'SNF/Subacute Care', N'590', N'2023-03-10 15:58:38.5200000', N'2023-03-10 15:58:38.5200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'605', N'Rehabilitation Counselor', NULL, N'2023-03-10 15:58:38.5233333', N'2023-03-10 15:58:38.5233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'606', N'General', N'605', N'2023-03-10 15:58:38.5266667', N'2023-03-10 15:58:38.5266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'607', N'Assistive Technology Practitioner', N'605', N'2023-03-10 15:58:38.5300000', N'2023-03-10 15:58:38.5300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'608', N'Assistive Technology Supplier', N'605', N'2023-03-10 15:58:38.5300000', N'2023-03-10 15:58:38.5300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'609', N'Orientation and Mobility Training Provider', N'605', N'2023-03-10 15:58:38.5333333', N'2023-03-10 15:58:38.5333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'610', N'Rheumatologist (Joints & Arthritis Specialist)', NULL, N'2023-03-10 15:58:38.5366667', N'2023-03-10 15:58:38.5366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'611', N'General', N'610', N'2023-03-10 15:58:38.5400000', N'2023-03-10 15:58:38.5400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'612', N'Sleep Medicine Specialist', NULL, N'2023-03-10 15:58:38.5433333', N'2023-03-10 15:58:38.5433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'613', N'General', N'612', N'2023-03-10 15:58:38.5433333', N'2023-03-10 15:58:38.5433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'614', N'Speech-Language Pathologist', NULL, N'2023-03-10 15:58:38.5466667', N'2023-03-10 15:58:38.5466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'615', N'General', N'614', N'2023-03-10 15:58:38.5500000', N'2023-03-10 15:58:38.5500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'616', N'Sports Medicine Specialist', NULL, N'2023-03-10 15:58:38.5500000', N'2023-03-10 15:58:38.5500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'617', N'General', N'616', N'2023-03-10 15:58:38.5533333', N'2023-03-10 15:58:38.5533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'618', N'Anti-Aging and Regenerative Medicine', N'616', N'2023-03-10 15:58:38.5566667', N'2023-03-10 15:58:38.5566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'619', N'Surgeon', NULL, N'2023-03-10 15:58:38.5600000', N'2023-03-10 15:58:38.5600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'620', N'General', N'619', N'2023-03-10 15:58:38.5633333', N'2023-03-10 15:58:38.5633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'621', N'Oral & Maxillofacial Surgery', N'619', N'2023-03-10 15:58:38.5633333', N'2023-03-10 15:58:38.5633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'622', N'Pediatric Surgery', N'619', N'2023-03-10 15:58:38.5666667', N'2023-03-10 15:58:38.5666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'623', N'Surgical Oncology', N'619', N'2023-03-10 15:58:38.5700000', N'2023-03-10 15:58:38.5700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'624', N'Surgical Critical Care', N'619', N'2023-03-10 15:58:38.5700000', N'2023-03-10 15:58:38.5700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'625', N'Vascular Surgery', N'619', N'2023-03-10 15:58:38.5766667', N'2023-03-10 15:58:38.5766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'626', N'Trauma Surgery', N'619', N'2023-03-10 15:58:38.5800000', N'2023-03-10 15:58:38.5800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'627', N'Surgery of the Hand', N'619', N'2023-03-10 15:58:38.5800000', N'2023-03-10 15:58:38.5800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'628', N'Cosmetic Surgeon', N'619', N'2023-03-10 15:58:38.5833333', N'2023-03-10 15:58:38.5833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'629', N'Bariatric Surgery', N'619', N'2023-03-10 15:58:38.5866667', N'2023-03-10 15:58:38.5866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'630', N'Thoracic Surgeon (Cardiothoracic Vascular Surgeon)', NULL, N'2023-03-10 15:58:38.5900000', N'2023-03-10 15:58:38.5900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'631', N'General', N'630', N'2023-03-10 15:58:38.5900000', N'2023-03-10 15:58:38.5900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'632', N'Transplant Hepatologist', NULL, N'2023-03-10 15:58:38.5933333', N'2023-03-10 15:58:38.5933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'633', N'General', N'632', N'2023-03-10 15:58:38.5966667', N'2023-03-10 15:58:38.5966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'634', N'Transplant Surgeon', NULL, N'2023-03-10 15:58:38.6000000', N'2023-03-10 15:58:38.6000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'635', N'General', N'634', N'2023-03-10 15:58:38.6033333', N'2023-03-10 15:58:38.6033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'636', N'Urologist', NULL, N'2023-03-10 15:58:38.6066667', N'2023-03-10 15:58:38.6066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'637', N'General', N'636', N'2023-03-10 15:58:38.6100000', N'2023-03-10 15:58:38.6100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'638', N'Pediatric Urology', N'636', N'2023-03-10 15:58:38.6100000', N'2023-03-10 15:58:38.6100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'639', N'Urology - Female Pelvic Medicine and Reconstructive Surgery', N'636', N'2023-03-10 15:58:38.6133333', N'2023-03-10 15:58:38.6133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'640', N'Physiatrist (Physical Medicine & Rehabilitation)', NULL, N'2023-03-10 15:58:38.6166667', N'2023-03-10 15:58:38.6166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'641', N'General', N'640', N'2023-03-10 15:58:38.6200000', N'2023-03-10 15:58:38.6200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'642', N'Hospice and Palliative Medicine', N'640', N'2023-03-10 15:58:38.6200000', N'2023-03-10 15:58:38.6200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'643', N'Neuromuscular Medicine', N'640', N'2023-03-10 15:58:38.6233333', N'2023-03-10 15:58:38.6233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'644', N'Spinal Cord Injury Medicine', N'640', N'2023-03-10 15:58:38.6266667', N'2023-03-10 15:58:38.6266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'645', N'Pediatric Rehabilitation Medicine', N'640', N'2023-03-10 15:58:38.6300000', N'2023-03-10 15:58:38.6300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'646', N'Pain Medicine', N'640', N'2023-03-10 15:58:38.6300000', N'2023-03-10 15:58:38.6300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'647', N'Sports Medicine', N'640', N'2023-03-10 15:58:38.6333333', N'2023-03-10 15:58:38.6333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'648', N'Physical Medicine & Rehabilitation - Brain Injury Medicine', N'640', N'2023-03-10 15:58:38.6366667', N'2023-03-10 15:58:38.6366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'649', N'Social Worker', NULL, N'2023-03-10 15:58:38.6400000', N'2023-03-10 15:58:38.6400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'650', N'General', N'649', N'2023-03-10 15:58:38.6433333', N'2023-03-10 15:58:38.6433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'651', N'Clinical', N'649', N'2023-03-10 15:58:38.6466667', N'2023-03-10 15:58:38.6466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'652', N'School', N'649', N'2023-03-10 15:58:38.6500000', N'2023-03-10 15:58:38.6500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'653', N'Psychiatrist / Neurologist', NULL, N'2023-03-10 15:58:38.6533333', N'2023-03-10 15:58:38.6533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'654', N'Addiction Medicine', N'653', N'2023-03-10 15:58:38.6566667', N'2023-03-10 15:58:38.6566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'655', N'Bariatric Medicine', N'653', N'2023-03-10 15:58:38.6600000', N'2023-03-10 15:58:38.6600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'656', N'Hospice & Palliative Medicine', N'653', N'2023-03-10 15:58:38.6633333', N'2023-03-10 15:58:38.6633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'657', N'Clinical Neurophysiology', N'653', N'2023-03-10 15:58:38.6666667', N'2023-03-10 15:58:38.6666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'658', N'Sports Medicine', N'653', N'2023-03-10 15:58:38.6700000', N'2023-03-10 15:58:38.6700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'659', N'Sleep Medicine', N'653', N'2023-03-10 15:58:38.6700000', N'2023-03-10 15:58:38.6700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'660', N'Psychiatry & Neurology - Neurocritical Care', N'653', N'2023-03-10 15:58:38.6733333', N'2023-03-10 15:58:38.6733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'661', N'Psychiatry & Neurology - Behavioral Neurology & Neuropsychiatry', N'653', N'2023-03-10 15:58:38.6766667', N'2023-03-10 15:58:38.6766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'662', N'Psychiatry & Neurology - Brain Injury Medicine', N'653', N'2023-03-10 15:58:38.6800000', N'2023-03-10 15:58:38.6800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'663', N'Pharmacist Clinician (PhC)/ Clinical Pharmacist', NULL, N'2023-03-10 15:58:38.6833333', N'2023-03-10 15:58:38.6833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'664', N'Pharmacist Clinician (PhC)/ Clinical Pharmacy Specialist', N'663', N'2023-03-10 15:58:38.6866667', N'2023-03-10 15:58:38.6866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'665', N'Pharmacotherapist', NULL, N'2023-03-10 15:58:38.6900000', N'2023-03-10 15:58:38.6900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'666', N'Pharmacotherapy', N'665', N'2023-03-10 15:58:38.6933333', N'2023-03-10 15:58:38.6933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'667', N'Other Healthcare Professional', NULL, N'2023-03-10 15:58:38.6966667', N'2023-03-10 15:58:38.6966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'668', N'General', N'667', N'2023-03-10 15:58:38.7000000', N'2023-03-10 15:58:38.7000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'669', N'Aesthetician', N'667', N'2023-03-10 15:58:38.7000000', N'2023-03-10 15:58:38.7000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'670', N'Pharmacist', NULL, N'2023-03-10 15:58:38.7033333', N'2023-03-10 15:58:38.7033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'671', N'General', N'670', N'2023-03-10 15:58:38.7066667', N'2023-03-10 15:58:38.7066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'672', N'Pharmacist - Critical Care', N'670', N'2023-03-10 15:58:38.7100000', N'2023-03-10 15:58:38.7100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'673', N'Pharmacist - General Practice', N'670', N'2023-03-10 15:58:38.7133333', N'2023-03-10 15:58:38.7133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'674', N'Pharmacist - Geriatric', N'670', N'2023-03-10 15:58:38.7166667', N'2023-03-10 15:58:38.7166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'675', N'Pharmacist - Nuclear', N'670', N'2023-03-10 15:58:38.7200000', N'2023-03-10 15:58:38.7200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'676', N'Pharmacist - Nutrition Support', N'670', N'2023-03-10 15:58:38.7200000', N'2023-03-10 15:58:38.7200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'677', N'Pharmacist - Pediatrics', N'670', N'2023-03-10 15:58:38.7266667', N'2023-03-10 15:58:38.7266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'678', N'Pharmacist - Psychiatric', N'670', N'2023-03-10 15:58:38.7266667', N'2023-03-10 15:58:38.7266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'679', N'Pharmacist - Ambulatory Care', N'670', N'2023-03-10 15:58:38.7300000', N'2023-03-10 15:58:38.7300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'680', N'Pharmacist - Oncology', N'670', N'2023-03-10 15:58:38.7333333', N'2023-03-10 15:58:38.7333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'681', N'Pharmacy Technician', N'670', N'2023-03-10 15:58:38.7366667', N'2023-03-10 15:58:38.7366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'682', N'Other Doctors', NULL, N'2023-03-10 15:58:38.7400000', N'2023-03-10 15:58:38.7400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'683', N'Specialist', N'682', N'2023-03-10 15:58:38.7433333', N'2023-03-10 15:58:38.7433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'684', N'Student', NULL, N'2023-03-10 15:58:38.7433333', N'2023-03-10 15:58:38.7433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'685', N'Student', N'684', N'2023-03-10 15:58:38.7466667', N'2023-03-10 15:58:38.7466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'686', N'Licensed Skin Care Specialist', NULL, N'2023-03-10 15:58:38.7500000', N'2023-03-10 15:58:38.7500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'687', N'General', N'686', N'2023-03-10 15:58:38.7533333', N'2023-03-10 15:58:38.7533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'688', N'Concierge Medicine', NULL, N'2023-03-10 15:58:38.7566667', N'2023-03-10 15:58:38.7566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'689', N'General', N'688', N'2023-03-10 15:58:38.7600000', N'2023-03-10 15:58:38.7600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'690', N'Skilled Nursing Facility Care', NULL, N'2023-03-10 15:58:38.7633333', N'2023-03-10 15:58:38.7633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'691', N'General', N'690', N'2023-03-10 15:58:38.7633333', N'2023-03-10 15:58:38.7633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'692', N'Nutrition Counseling', NULL, N'2023-03-10 15:58:38.7666667', N'2023-03-10 15:58:38.7666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'693', N'General', N'692', N'2023-03-10 15:58:38.7700000', N'2023-03-10 15:58:38.7700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'694', N'Pediatric Ophthalmology ', NULL, N'2023-03-10 15:58:38.7733333', N'2023-03-10 15:58:38.7733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'695', N'Pediatric Ophthalmology', N'694', N'2023-03-10 15:58:38.7766667', N'2023-03-10 15:58:38.7766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'696', N'Behavioral Health & Social Service Providers', NULL, N'2023-03-10 15:58:38.7800000', N'2023-03-10 15:58:38.7800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'697', N'Clinical Neuropsychologist - Clinical', N'696', N'2023-03-10 15:58:38.7833333', N'2023-03-10 15:58:38.7833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'698', N'Behavioral Analyst', N'696', N'2023-03-10 15:58:38.7866667', N'2023-03-10 15:58:38.7866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'699', N'Assistant Behavior Analyst', N'696', N'2023-03-10 15:58:38.7866667', N'2023-03-10 15:58:38.7866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'700', N'Behavior Technician', N'696', N'2023-03-10 15:58:38.7900000', N'2023-03-10 15:58:38.7900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'701', N'Drama Therapist', N'696', N'2023-03-10 15:58:38.7933333', N'2023-03-10 15:58:38.7933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'702', N'Dental Providers', NULL, N'2023-03-10 15:58:38.7966667', N'2023-03-10 15:58:38.7966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'703', N'Dental Hygienist', N'702', N'2023-03-10 15:58:38.8000000', N'2023-03-10 15:58:38.8000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'704', N'Dental Therapist', N'702', N'2023-03-10 15:58:38.8000000', N'2023-03-10 15:58:38.8000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'705', N'Advanced Practice Dental Therapist', N'702', N'2023-03-10 15:58:38.8033333', N'2023-03-10 15:58:38.8033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'706', N'Oral Medicinist', N'702', N'2023-03-10 15:58:38.8066667', N'2023-03-10 15:58:38.8066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'707', N'Dental Assistant', N'702', N'2023-03-10 15:58:38.8100000', N'2023-03-10 15:58:38.8100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'708', N'Dental Laboratory Technician', N'702', N'2023-03-10 15:58:38.8133333', N'2023-03-10 15:58:38.8133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'709', N'Pain Orofacial', N'702', N'2023-03-10 15:58:38.8166667', N'2023-03-10 15:58:38.8166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'710', N'Emergency Medical Service Providers', NULL, N'2023-03-10 15:58:38.8200000', N'2023-03-10 15:58:38.8200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'711', N'Personal Emergency Response Attendant', N'710', N'2023-03-10 15:58:38.8200000', N'2023-03-10 15:58:38.8200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'712', N'Emergency Medical Technician, Paramedic', N'710', N'2023-03-10 15:58:38.8233333', N'2023-03-10 15:58:38.8233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'713', N'Emergency Medical Technician, Intermediate', N'710', N'2023-03-10 15:58:38.8266667', N'2023-03-10 15:58:38.8266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'714', N'Emergency Medical Technician, Basic', N'710', N'2023-03-10 15:58:38.8300000', N'2023-03-10 15:58:38.8300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'715', N'Eye and Vision Services Providers', NULL, N'2023-03-10 15:58:38.8300000', N'2023-03-10 15:58:38.8300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'716', N'Technician/Technologist', N'715', N'2023-03-10 15:58:38.8333333', N'2023-03-10 15:58:38.8333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'717', N'Technician/Technologist - Contact Lens', N'715', N'2023-03-10 15:58:38.8366667', N'2023-03-10 15:58:38.8366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'718', N'Technician/Technologist - Contact Lens Fitter', N'715', N'2023-03-10 15:58:38.8400000', N'2023-03-10 15:58:38.8400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'719', N'Technician/Technologist - Ophthalmic', N'715', N'2023-03-10 15:58:38.8400000', N'2023-03-10 15:58:38.8400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'720', N'Technician/Technologist - Ophthalmic Assistant', N'715', N'2023-03-10 15:58:38.8433333', N'2023-03-10 15:58:38.8433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'721', N'Technician/Technologist - Optometric Assistant', N'715', N'2023-03-10 15:58:38.8466667', N'2023-03-10 15:58:38.8466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'722', N'Technician/Technologist - Optometric Technician', N'715', N'2023-03-10 15:58:38.8500000', N'2023-03-10 15:58:38.8500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'723', N'Technician/Technologist - Ocularist', N'715', N'2023-03-10 15:58:38.8500000', N'2023-03-10 15:58:38.8500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'724', N'Technician/Technologist - Optician', N'715', N'2023-03-10 15:58:38.8533333', N'2023-03-10 15:58:38.8533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'725', N'Technician/Technologist - Orthoptist', N'715', N'2023-03-10 15:58:38.8566667', N'2023-03-10 15:58:38.8566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'726', N'Other Service Providers', NULL, N'2023-03-10 15:58:38.8600000', N'2023-03-10 15:58:38.8600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'727', N'Military Health Care Provider', N'726', N'2023-03-10 15:58:38.8633333', N'2023-03-10 15:58:38.8633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'728', N'Military Health Care Provider - Independent Duty Corpsman', N'726', N'2023-03-10 15:58:38.8633333', N'2023-03-10 15:58:38.8633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'729', N'Military Health Care Provider - Independent Duty Medical Technicians', N'726', N'2023-03-10 15:58:38.8633333', N'2023-03-10 15:58:38.8633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'730', N'Case Manager/Care Coordinator', N'726', N'2023-03-10 15:58:38.8633333', N'2023-03-10 15:58:38.8633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'731', N'Interpreter', N'726', N'2023-03-10 15:58:38.8666667', N'2023-03-10 15:58:38.8666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'732', N'Contractor', N'726', N'2023-03-10 15:58:38.8700000', N'2023-03-10 15:58:38.8700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'733', N'Contractor - Home Modifications', N'726', N'2023-03-10 15:58:38.8700000', N'2023-03-10 15:58:38.8700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'734', N'Contractor - Vehicle Modifications', N'726', N'2023-03-10 15:58:38.8733333', N'2023-03-10 15:58:38.8733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'735', N'Driver', N'726', N'2023-03-10 15:58:38.8766667', N'2023-03-10 15:58:38.8766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'736', N'Community Health Worker', N'726', N'2023-03-10 15:58:38.8800000', N'2023-03-10 15:58:38.8800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'737', N'Legal Medicine', N'726', N'2023-03-10 15:58:38.8833333', N'2023-03-10 15:58:38.8833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'738', N'Sleep Specialist, PhD', N'726', N'2023-03-10 15:58:38.8866667', N'2023-03-10 15:58:38.8866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'739', N'Meals', N'726', N'2023-03-10 15:58:38.8900000', N'2023-03-10 15:58:38.8900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'740', N'Specialist - Graphics Designer', N'726', N'2023-03-10 15:58:38.8900000', N'2023-03-10 15:58:38.8900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'741', N'Specialist - Prosthetics Case Management', N'726', N'2023-03-10 15:58:38.8933333', N'2023-03-10 15:58:38.8933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'742', N'Specialist - Research Study', N'726', N'2023-03-10 15:58:38.8966667', N'2023-03-10 15:58:38.8966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'743', N'Specialist - Research Data Abstracter/Coder', N'726', N'2023-03-10 15:58:38.8966667', N'2023-03-10 15:58:38.8966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'744', N'Health Educator', N'726', N'2023-03-10 15:58:38.9000000', N'2023-03-10 15:58:38.9000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'745', N'Veterinarian', N'726', N'2023-03-10 15:58:38.9033333', N'2023-03-10 15:58:38.9033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'746', N'Veterinarian - Medical Research', N'726', N'2023-03-10 15:58:38.9033333', N'2023-03-10 15:58:38.9033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'747', N'Lactation Consultant, Non-RN', N'726', N'2023-03-10 15:58:38.9066667', N'2023-03-10 15:58:38.9066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'748', N'Clinical Ethicist', N'726', N'2023-03-10 15:58:38.9100000', N'2023-03-10 15:58:38.9100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'749', N'Midwife, Lay', N'726', N'2023-03-10 15:58:38.9100000', N'2023-03-10 15:58:38.9100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'750', N'Peer Specialist', N'726', N'2023-03-10 15:58:38.9133333', N'2023-03-10 15:58:38.9133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'751', N'Midwife', N'726', N'2023-03-10 15:58:38.9166667', N'2023-03-10 15:58:38.9166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'752', N'Funeral Director', N'726', N'2023-03-10 15:58:38.9200000', N'2023-03-10 15:58:38.9200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'753', N'Lodging', N'726', N'2023-03-10 15:58:38.9233333', N'2023-03-10 15:58:38.9233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'754', N'Prevention Professional', N'726', N'2023-03-10 15:58:38.9233333', N'2023-03-10 15:58:38.9233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'755', N'Health & Wellness Coach', N'726', N'2023-03-10 15:58:38.9266667', N'2023-03-10 15:58:38.9266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'756', N'Group', NULL, N'2023-03-10 15:58:38.9300000', N'2023-03-10 15:58:38.9300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'757', N'Multi-Specialty', N'756', N'2023-03-10 15:58:38.9300000', N'2023-03-10 15:58:38.9300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'758', N'Single Specialty', N'756', N'2023-03-10 15:58:38.9366667', N'2023-03-10 15:58:38.9366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'759', N'Allopathic & Osteopathic Physicians', NULL, N'2023-03-10 15:58:38.9400000', N'2023-03-10 15:58:38.9400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'760', N'Electrodiagnostic Medicine', N'759', N'2023-03-10 15:58:38.9400000', N'2023-03-10 15:58:38.9400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'761', N'Respiratory, Developmental, Rehabilitative and Restorative Service Providers', NULL, N'2023-03-10 15:58:38.9433333', N'2023-03-10 15:58:38.9433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'762', N'Mastectomy Fitter', N'761', N'2023-03-10 15:58:38.9466667', N'2023-03-10 15:58:38.9466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'763', N'Pedorthist', N'761', N'2023-03-10 15:58:38.9466667', N'2023-03-10 15:58:38.9466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'764', N'Clinical Exercise Physiologist', N'761', N'2023-03-10 15:58:38.9500000', N'2023-03-10 15:58:38.9500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'765', N'Rehabilitation Practitioner', N'761', N'2023-03-10 15:58:38.9533333', N'2023-03-10 15:58:38.9533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'766', N'Specialist/Technologist', N'761', N'2023-03-10 15:58:38.9533333', N'2023-03-10 15:58:38.9533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'767', N'Specialist/Technologist - Athletic Trainer', N'761', N'2023-03-10 15:58:38.9566667', N'2023-03-10 15:58:38.9566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'768', N'Specialist/Technologist - Rehabilitation, Blind', N'761', N'2023-03-10 15:58:38.9600000', N'2023-03-10 15:58:38.9600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'769', N'Pulmonary Function Technologist', N'761', N'2023-03-10 15:58:38.9633333', N'2023-03-10 15:58:38.9633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'770', N'Recreational Therapist Assistant', N'761', N'2023-03-10 15:58:38.9633333', N'2023-03-10 15:58:38.9633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'771', N'Speech, Language and Hearing Service Providers', NULL, N'2023-03-10 15:58:38.9666667', N'2023-03-10 15:58:38.9666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'772', N'Specialist/Technologist', N'771', N'2023-03-10 15:58:38.9700000', N'2023-03-10 15:58:38.9700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'773', N'Specialist/Technologist - Audiology Assistant', N'771', N'2023-03-10 15:58:38.9733333', N'2023-03-10 15:58:38.9733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'774', N'Specialist/Technologist - Speech-Language Assistant', N'771', N'2023-03-10 15:58:38.9766667', N'2023-03-10 15:58:38.9766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'775', N'Technologists, Technicians & Other Technical Service Providers', NULL, N'2023-03-10 15:58:38.9766667', N'2023-03-10 15:58:38.9766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'776', N'Perfusionist', N'775', N'2023-03-10 15:58:38.9800000', N'2023-03-10 15:58:38.9800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'777', N'Radiology Practitioner Assistant', N'775', N'2023-03-10 15:58:38.9833333', N'2023-03-10 15:58:38.9833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'778', N'Spec/Tech, Pathology', N'775', N'2023-03-10 15:58:38.9866667', N'2023-03-10 15:58:38.9866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'779', N'Spec/Tech, Pathology - Blood Banking', N'775', N'2023-03-10 15:58:38.9900000', N'2023-03-10 15:58:38.9900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'780', N'Spec/Tech, Pathology - Chemistry', N'775', N'2023-03-10 15:58:38.9900000', N'2023-03-10 15:58:38.9900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'781', N'Spec/Tech, Pathology - Cytotechnology', N'775', N'2023-03-10 15:58:38.9933333', N'2023-03-10 15:58:38.9933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'782', N'Spec/Tech, Pathology - Hematology', N'775', N'2023-03-10 15:58:38.9966667', N'2023-03-10 15:58:38.9966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'783', N'Spec/Tech, Pathology - Hemapheresis Practitioner', N'775', N'2023-03-10 15:58:39.0000000', N'2023-03-10 15:58:39.0000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'784', N'Spec/Tech, Pathology - Histology', N'775', N'2023-03-10 15:58:39.0033333', N'2023-03-10 15:58:39.0033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'785', N'Spec/Tech, Pathology - Immunology', N'775', N'2023-03-10 15:58:39.0066667', N'2023-03-10 15:58:39.0066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'786', N'Spec/Tech, Pathology - Laboratory Management', N'775', N'2023-03-10 15:58:39.0100000', N'2023-03-10 15:58:39.0100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'787', N'Spec/Tech, Pathology - Laboratory Management, Diplomate', N'775', N'2023-03-10 15:58:39.0133333', N'2023-03-10 15:58:39.0133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'788', N'Spec/Tech, Pathology - Medical Technologist', N'775', N'2023-03-10 15:58:39.0166667', N'2023-03-10 15:58:39.0166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'789', N'Spec/Tech, Pathology - Microbiology', N'775', N'2023-03-10 15:58:39.0233333', N'2023-03-10 15:58:39.0233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'790', N'Technician, Pathology', N'775', N'2023-03-10 15:58:39.0233333', N'2023-03-10 15:58:39.0233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'791', N'Technician, Pathology - Histology', N'775', N'2023-03-10 15:58:39.0266667', N'2023-03-10 15:58:39.0266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'792', N'Technician, Pathology - Medical Laboratory', N'775', N'2023-03-10 15:58:39.0300000', N'2023-03-10 15:58:39.0300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'793', N'Technician, Pathology - Phlebotomy', N'775', N'2023-03-10 15:58:39.0300000', N'2023-03-10 15:58:39.0300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'794', N'Technician, Cardiology', N'775', N'2023-03-10 15:58:39.0333333', N'2023-03-10 15:58:39.0333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'795', N'Spec/Tech, Cardiovascular', N'775', N'2023-03-10 15:58:39.0366667', N'2023-03-10 15:58:39.0366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'796', N'Spec/Tech, Cardiovascular - Cardiovascular Invasive Specialist', N'775', N'2023-03-10 15:58:39.0400000', N'2023-03-10 15:58:39.0400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'797', N'Spec/Tech, Cardiovascular - Vascular Specialist', N'775', N'2023-03-10 15:58:39.0400000', N'2023-03-10 15:58:39.0400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'798', N'Spec/Tech, Cardiovascular - Sonography', N'775', N'2023-03-10 15:58:39.0433333', N'2023-03-10 15:58:39.0433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'799', N'Spec/Tech, Health Info', N'775', N'2023-03-10 15:58:39.0466667', N'2023-03-10 15:58:39.0466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'800', N'Spec/Tech, Health Info - Coding Specialist, Hospital Based', N'775', N'2023-03-10 15:58:39.0466667', N'2023-03-10 15:58:39.0466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'801', N'Spec/Tech, Health Info - Coding Specialist, Physician Office Based', N'775', N'2023-03-10 15:58:39.0500000', N'2023-03-10 15:58:39.0500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'802', N'Spec/Tech, Health Info - Registered Record Administrator', N'775', N'2023-03-10 15:58:39.0533333', N'2023-03-10 15:58:39.0533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'803', N'Specialist/Technologist, Other', N'775', N'2023-03-10 15:58:39.0566667', N'2023-03-10 15:58:39.0566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'804', N'Specialist/Technologist, Other - Art, Medical', N'775', N'2023-03-10 15:58:39.0600000', N'2023-03-10 15:58:39.0600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'805', N'Specialist/Technologist, Other - Biomedical Engineering', N'775', N'2023-03-10 15:58:39.0600000', N'2023-03-10 15:58:39.0600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'806', N'Specialist/Technologist, Other - Biomedical Photographer', N'775', N'2023-03-10 15:58:39.0633333', N'2023-03-10 15:58:39.0633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'807', N'Specialist/Technologist, Other - Biochemist', N'775', N'2023-03-10 15:58:39.0666667', N'2023-03-10 15:58:39.0666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'808', N'Specialist/Technologist, Other - Biostatistician', N'775', N'2023-03-10 15:58:39.0666667', N'2023-03-10 15:58:39.0666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'809', N'Specialist/Technologist, Other - Surgical Assistant', N'775', N'2023-03-10 15:58:39.0700000', N'2023-03-10 15:58:39.0700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'810', N'Specialist/Technologist, Other - EEG', N'775', N'2023-03-10 15:58:39.0733333', N'2023-03-10 15:58:39.0733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'811', N'Specialist/Technologist, Other - Electroneurodiagnostic', N'775', N'2023-03-10 15:58:39.0766667', N'2023-03-10 15:58:39.0766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'812', N'Specialist/Technologist, Other - Graphics Methods', N'775', N'2023-03-10 15:58:39.0800000', N'2023-03-10 15:58:39.0800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'813', N'Specialist/Technologist, Other - Geneticist, Medical (PhD)', N'775', N'2023-03-10 15:58:39.0833333', N'2023-03-10 15:58:39.0833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'814', N'Specialist/Technologist, Other - Illustration, Medical', N'775', N'2023-03-10 15:58:39.0866667', N'2023-03-10 15:58:39.0866667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'815', N'Specialist/Technologist, Other - Nephrology', N'775', N'2023-03-10 15:58:39.0900000', N'2023-03-10 15:58:39.0900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'816', N'Specialist/Technologist, Other - Surgical Technologist', N'775', N'2023-03-10 15:58:39.0933333', N'2023-03-10 15:58:39.0933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'817', N'Specialist/Technologist, Other - Orthopedic Assistant', N'775', N'2023-03-10 15:58:39.0933333', N'2023-03-10 15:58:39.0933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'818', N'Technician, Health Information', N'775', N'2023-03-10 15:58:39.0966667', N'2023-03-10 15:58:39.0966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'819', N'Technician, Health Information - Assistant Record Technician', N'775', N'2023-03-10 15:58:39.1000000', N'2023-03-10 15:58:39.1000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'820', N'Radiologic Technologist', N'775', N'2023-03-10 15:58:39.1033333', N'2023-03-10 15:58:39.1033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'821', N'Radiologic Technologist - Bone Densitometry', N'775', N'2023-03-10 15:58:39.1066667', N'2023-03-10 15:58:39.1066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'822', N'Radiologic Technologist - Cardiovascular-Interventional Technology', N'775', N'2023-03-10 15:58:39.1100000', N'2023-03-10 15:58:39.1100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'823', N'Radiologic Technologist - Cardiac-Interventional Technology', N'775', N'2023-03-10 15:58:39.1100000', N'2023-03-10 15:58:39.1100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'824', N'Radiologic Technologist - Computed Tomography', N'775', N'2023-03-10 15:58:39.1133333', N'2023-03-10 15:58:39.1133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'825', N'Radiologic Technologist - Radiography', N'775', N'2023-03-10 15:58:39.1166667', N'2023-03-10 15:58:39.1166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'826', N'Radiologic Technologist - Magnetic Resonance Imaging', N'775', N'2023-03-10 15:58:39.1200000', N'2023-03-10 15:58:39.1200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'827', N'Radiologic Technologist - Mammography', N'775', N'2023-03-10 15:58:39.1233333', N'2023-03-10 15:58:39.1233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'828', N'Radiologic Technologist - Nuclear Medicine Technology', N'775', N'2023-03-10 15:58:39.1233333', N'2023-03-10 15:58:39.1233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'829', N'Radiologic Technologist - Quality Management', N'775', N'2023-03-10 15:58:39.1266667', N'2023-03-10 15:58:39.1266667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'830', N'Radiologic Technologist - Radiation Therapy', N'775', N'2023-03-10 15:58:39.1300000', N'2023-03-10 15:58:39.1300000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'831', N'Radiologic Technologist - Sonography', N'775', N'2023-03-10 15:58:39.1333333', N'2023-03-10 15:58:39.1333333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'832', N'Radiologic Technologist - Vascular Sonography', N'775', N'2023-03-10 15:58:39.1366667', N'2023-03-10 15:58:39.1366667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'833', N'Radiologic Technologist - Vascular-Interventional Technology', N'775', N'2023-03-10 15:58:39.1400000', N'2023-03-10 15:58:39.1400000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'834', N'Technician, Other', N'775', N'2023-03-10 15:58:39.1433333', N'2023-03-10 15:58:39.1433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'835', N'Technician, Other - Biomedical Engineering', N'775', N'2023-03-10 15:58:39.1433333', N'2023-03-10 15:58:39.1433333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'836', N'Technician, Other - Darkroom', N'775', N'2023-03-10 15:58:39.1466667', N'2023-03-10 15:58:39.1466667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'837', N'Technician, Other - EEG', N'775', N'2023-03-10 15:58:39.1500000', N'2023-03-10 15:58:39.1500000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'838', N'Technician, Other - Renal Dialysis', N'775', N'2023-03-10 15:58:39.1533333', N'2023-03-10 15:58:39.1533333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'839', N'Technician, Other - Veterinary', N'775', N'2023-03-10 15:58:39.1566667', N'2023-03-10 15:58:39.1566667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'840', N'Pathology - Clinical Laboratory Director, Non-physician', N'775', N'2023-03-10 15:58:39.1600000', N'2023-03-10 15:58:39.1600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'841', N'Physician Assistants & Advanced Practice Nursing Providers', NULL, N'2023-03-10 15:58:39.1600000', N'2023-03-10 15:58:39.1600000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'842', N'Anesthesiologist Assistant', N'841', N'2023-03-10 15:58:39.1633333', N'2023-03-10 15:58:39.1633333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'843', N'Transportation Services', N'841', N'2023-03-10 15:58:39.1666667', N'2023-03-10 15:58:39.1666667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'844', N'Nursing Service Related Providers', NULL, N'2023-03-10 15:58:39.1700000', N'2023-03-10 15:58:39.1700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'845', N'Chore Provider', N'844', N'2023-03-10 15:58:39.1700000', N'2023-03-10 15:58:39.1700000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'846', N'Adult Companion', N'844', N'2023-03-10 15:58:39.1733333', N'2023-03-10 15:58:39.1733333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'847', N'Day Training/Habilitation Specialist', N'844', N'2023-03-10 15:58:39.1766667', N'2023-03-10 15:58:39.1766667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'848', N'Technician', N'844', N'2023-03-10 15:58:39.1800000', N'2023-03-10 15:58:39.1800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'849', N'Technician - Attendant Care Provider', N'844', N'2023-03-10 15:58:39.1800000', N'2023-03-10 15:58:39.1800000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'850', N'Technician - Personal Care Attendant', N'844', N'2023-03-10 15:58:39.1833333', N'2023-03-10 15:58:39.1833333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'851', N'Doula', N'844', N'2023-03-10 15:58:39.1900000', N'2023-03-10 15:58:39.1900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'852', N'Religious Nonmedical Practitioner', N'844', N'2023-03-10 15:58:39.1900000', N'2023-03-10 15:58:39.1900000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'853', N'Religious Nonmedical Nursing Personnel', N'844', N'2023-03-10 15:58:39.1933333', N'2023-03-10 15:58:39.1933333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'854', N'Home Health Aide', N'844', N'2023-03-10 15:58:39.1966667', N'2023-03-10 15:58:39.1966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'855', N'Nursing Home Administrator', N'844', N'2023-03-10 15:58:39.1966667', N'2023-03-10 15:58:39.1966667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'856', N'Homemaker', N'844', N'2023-03-10 15:58:39.2000000', N'2023-03-10 15:58:39.2000000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'857', N'Nurses Aide', N'844', N'2023-03-10 15:58:39.2033333', N'2023-03-10 15:58:39.2033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'858', N'Regenerative Medicine Specialist', NULL, N'2023-03-10 15:58:39.2033333', N'2023-03-10 15:58:39.2033333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'859', N'General', N'858', N'2023-03-10 15:58:39.2066667', N'2023-03-10 15:58:39.2066667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'860', N'Sports Medicine', N'858', N'2023-03-10 15:58:39.2100000', N'2023-03-10 15:58:39.2100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'861', N'Anti-Aging and Aesthetics', N'858', N'2023-03-10 15:58:39.2100000', N'2023-03-10 15:58:39.2100000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'862', N'Orthopedics', N'858', N'2023-03-10 15:58:39.2133333', N'2023-03-10 15:58:39.2133333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'863', N'Laser Technician', NULL, N'2023-03-10 15:58:39.2166667', N'2023-03-10 15:58:39.2166667')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'864', N'General', N'863', N'2023-03-10 15:58:39.2200000', N'2023-03-10 15:58:39.2200000')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'865', N'Marijuana Doctor', NULL, N'2023-03-10 15:58:39.2233333', N'2023-03-10 15:58:39.2233333')
GO

INSERT INTO [dbo].[Specialties] ([Id], [Name], [ParentId], [Created_at], [Updated_at]) VALUES (N'866', N'General', N'865', N'2023-03-10 15:58:39.2233333', N'2023-03-10 15:58:39.2233333')
GO

SET IDENTITY_INSERT [dbo].[Specialties] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for SpecialtyDoctors
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[SpecialtyDoctors]') AND type IN ('U'))
	DROP TABLE [dbo].[SpecialtyDoctors]
GO

CREATE TABLE [dbo].[SpecialtyDoctors] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [SpecialtyId] int  NOT NULL,
  [UserId] int  NOT NULL,
  [Educational] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL,
  [Status] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[SpecialtyDoctors] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Topics
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Topics]') AND type IN ('U'))
	DROP TABLE [dbo].[Topics]
GO

CREATE TABLE [dbo].[Topics] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [ParentId] int  NULL,
  [Title] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Icon] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [IsAdmin] bit  NOT NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Topics] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Topics
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[Topics] ON
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'1', NULL, N'FORUM OPERATION CENTER', N'Rules, questions, FAQs, forum upgrades, areas not allowed to insert advertising textlinks', NULL, N'1', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'2', N'1', N'Rules', N'', N'/images/clipboard.png', N'1', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'3', N'1', N'Report violations', NULL, N'/images/report-violations.png', N'1', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'4', N'1', N'Comment BQT', NULL, N'/images/comment.png', N'1', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'5', NULL, N'Kindness Circle', N'Charity association, charity fund, address for medical examination, medicine distribution, free medical examination', NULL, N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'6', N'5', N'Charity fund', NULL, N'/images/charity.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'7', N'5', N'Address of medical examination', NULL, N'/images/smartphone.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'8', NULL, N'HOSPITAL', N'Summary of diseases and treatments', NULL, N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'9', N'8', N'Medical News', NULL, N'/images/medical-history.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'10', N'8', N'Acupuncturist (Alternative Medicine)', NULL, N'/images/treatment.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'11', N'8', N'Addiction Medicine Specialist', NULL, N'/images/patient.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'12', N'8', N'Adolescent Medicine Specialist', NULL, N'/images/architecture.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'13', N'8', N'Allergist-Immunologist', NULL, N'/images/vaccine.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'14', N'8', N'Anaplastologist', NULL, N'/images/anaplastologist.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'15', N'8', N'Anesthesiologist', NULL, N'/images/surgery.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'16', N'8', N'Art Therapist', NULL, N'/images/painter.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'17', N'8', N'Audiologist', NULL, N'/images/hearing.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'18', N'8', N'Bariatrician (Weight Loss Specialist)', NULL, N'/images/weight.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'19', N'8', N'Cardiologist (Heart Specialist)', NULL, N'/images/cardiogram.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'20', N'19', N'Clinical Cardiac Electrophysiology', NULL, N'/images/clinical.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'21', N'19', N'Pediatric Cardiothoracic Surgery', NULL, N'/images/optometrist.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'22', N'8', N'Certified Respiratory Therapist (CRT)', NULL, N'/images/respiratory.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'23', N'8', N'Orthopedic', NULL, N'/images/bone.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'24', N'8', N'Internist', NULL, N'/images/pharmacist.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'25', N'8', N'Neurology', NULL, N'/images/artificial-intelligence.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'26', N'8', N'Pediatrics', NULL, N'/images/baby.png', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'27', N'26', N'Neonatal/Pediatrics', NULL, N'', N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'28', N'26', N'Pediatric Cardiothoracic Surgery', NULL, NULL, N'0', N'2023-02-24 21:55:45.2100000', N'2023-02-24 21:55:45.2100000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'29', N'26', N'Specialized pediatrics (endocrine, renal, neurological, pulmonary, digestive)', NULL, NULL, N'0', N'2023-02-24 22:03:10.0000000', N'2023-02-24 22:03:12.0000000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'30', N'8', N'Radiology', NULL, N'/images/x-rays.png', N'0', N'2023-02-24 22:03:56.0000000', N'2023-02-24 22:03:58.0000000')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'31', N'8', N'Sports medicine', NULL, N'/images/medicine.png', N'0', N'2023-02-24 22:04:37.5100470', N'2023-02-24 22:04:37.5100472')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'32', N'8', N'Occupational medicine', NULL, N'/images/nurse.png', N'0', N'2023-02-24 22:04:43.5213510', N'2023-02-24 22:04:43.5213512')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'33', N'8', N'Functional Medicine', NULL, N'/images/zoo.png', N'0', N'2023-02-24 22:04:51.4806881', N'2023-02-24 22:04:51.4807305')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'34', N'8', N'Rehabilitation', NULL, N'/images/physiotherapy.png', N'0', N'2023-02-24 22:06:24.3236671', N'2023-02-24 22:06:24.3236674')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'35', N'13', N'Allergy', NULL, NULL, N'0', N'2023-02-24 22:07:01.0859798', N'2023-02-24 22:07:01.0859800')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'36', N'13', N'Clinical & Laboratory Immunology', NULL, NULL, N'0', N'2023-02-24 22:07:06.6325079', N'2023-02-24 22:07:06.6325084')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'37', N'15', N'Addiction Medicine', NULL, NULL, N'0', N'2023-02-24 22:07:42.5180915', N'2023-02-24 22:07:42.5180921')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'38', N'15', N'Critical Care Medicine', NULL, NULL, N'0', N'2023-02-24 22:07:54.6963931', N'2023-02-24 22:07:54.6963933')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'39', N'15', N'Hospice & Palliative Medicine', NULL, NULL, N'0', N'2023-02-24 22:08:02.0896077', N'2023-02-24 22:08:02.0896082')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'40', N'15', N'Pain Medicine', NULL, NULL, N'0', N'2023-02-24 22:08:09.3435212', N'2023-02-24 22:08:09.3435570')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'41', N'15', N'Pediatric Anesthesiologist', NULL, NULL, N'0', N'2023-02-24 22:08:21.0657075', N'2023-02-24 22:08:21.0657078')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'42', N'17', N'Assistive Technology Practitioner', NULL, NULL, N'0', N'2023-02-24 22:08:39.4756263', N'2023-02-24 22:08:39.4756266')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'43', N'17', N'Assistive Technology Supplier', NULL, NULL, N'0', N'2023-02-24 22:08:45.0186709', N'2023-02-24 22:08:45.0186715')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'44', N'17', N'Hearing Aid Fitter', NULL, NULL, N'0', N'2023-02-24 22:08:52.5889803', N'2023-02-24 22:08:52.5889808')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'45', N'18', N'Bariatric Medicine (Bariatrician)', NULL, NULL, N'0', N'2023-02-24 22:09:12.4768764', N'2023-02-24 22:09:12.4768767')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'46', N'22', N'Critical Care', NULL, NULL, N'0', N'2023-02-24 22:09:28.7104455', N'2023-02-24 22:09:28.7104463')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'47', N'22', N'Emergency Care', NULL, NULL, N'0', N'2023-02-24 22:09:34.0468251', N'2023-02-24 22:09:34.0468257')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'48', N'22', N'Educational', NULL, NULL, N'0', N'2023-02-24 22:09:38.7674743', N'2023-02-24 22:09:38.7674748')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'49', N'22', N'Geriatric Care', NULL, NULL, N'0', N'2023-02-24 22:09:42.2853894', N'2023-02-24 22:09:42.2853896')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'50', N'22', N'General Care', NULL, NULL, N'0', N'2023-02-24 22:09:46.9785556', N'2023-02-24 22:09:46.9785561')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'51', N'22', N'Home Health', NULL, NULL, N'0', N'2023-02-24 22:09:51.4731613', N'2023-02-24 22:09:51.4731616')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'52', N'22', N'Pulmonary Diagnostics', NULL, NULL, N'0', N'2023-02-24 22:09:57.0327705', N'2023-02-24 22:09:57.0327711')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'53', N'22', N'Pulmonary Rehabilitation', NULL, NULL, N'0', N'2023-02-24 22:10:04.0281434', N'2023-02-24 22:10:04.0281828')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'54', N'22', N'Pulmonary Function Technology', NULL, NULL, N'0', N'2023-02-24 22:10:10.1669024', N'2023-02-24 22:10:10.1669027')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'55', N'22', N'Palliative/Hospice', NULL, NULL, N'0', N'2023-02-24 22:10:16.6768815', N'2023-02-24 22:10:16.6768818')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'56', N'22', N'Patient Transport', NULL, NULL, N'0', N'2023-02-24 22:10:22.4529534', N'2023-02-24 22:10:22.4529542')
GO

INSERT INTO [dbo].[Topics] ([Id], [ParentId], [Title], [Description], [Icon], [IsAdmin], [Created_at], [Updated_at]) VALUES (N'57', N'22', N'SNF/Subacute Care', NULL, NULL, N'0', N'2023-02-24 22:10:28.1144802', N'2023-02-24 22:10:28.1144808')
GO

SET IDENTITY_INSERT [dbo].[Topics] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for UserAccessLogs
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[UserAccessLogs]') AND type IN ('U'))
	DROP TABLE [dbo].[UserAccessLogs]
GO

CREATE TABLE [dbo].[UserAccessLogs] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [UserId] int  NOT NULL,
  [AccessTime] datetime2(7)  NOT NULL,
  [IpAddress] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [DeviceInfo] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[UserAccessLogs] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Users
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type IN ('U'))
	DROP TABLE [dbo].[Users]
GO

CREATE TABLE [dbo].[Users] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [PositionId] int  NULL,
  [Username] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Password] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [FirstName] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [LastName] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Description] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Gender] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Avatar] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Location_StreetAddress] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Location_StreetAddress2] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Location_ZipCode] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [PhoneNumber] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [EmailAddress] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Latitude] float(53)  NULL,
  [Longitude] float(53)  NULL,
  [OfficeHours] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Website] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [PatientEvaluateNumber] int  NOT NULL,
  [AppointmentEveryDay] int  NOT NULL,
  [RemindPatient] int  NOT NULL,
  [IsAnonymouse] bit  NOT NULL,
  [IsViewOnline] bit  NOT NULL,
  [IsDisabledAppointmentEveryDay] bit  NOT NULL,
  [IsDisabledRemindPatient] bit  NOT NULL,
  [Role] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [IpAddress] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [IsVerifyProfile] bit  NOT NULL,
  [IsDoctor] bit  NULL,
  [Created_at] datetime2(7)  NOT NULL,
  [Updated_at] datetime2(7)  NOT NULL,
  [LastLogin_at] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[Users] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Users
-- ----------------------------
BEGIN TRANSACTION
GO

SET IDENTITY_INSERT [dbo].[Users] ON
GO

INSERT INTO [dbo].[Users] ([Id], [PositionId], [Username], [Password], [FirstName], [LastName], [Description], [Gender], [Avatar], [Location_StreetAddress], [Location_StreetAddress2], [Location_ZipCode], [PhoneNumber], [EmailAddress], [Latitude], [Longitude], [OfficeHours], [Website], [PatientEvaluateNumber], [AppointmentEveryDay], [RemindPatient], [IsAnonymouse], [IsViewOnline], [IsDisabledAppointmentEveryDay], [IsDisabledRemindPatient], [Role], [IpAddress], [IsVerifyProfile], [IsDoctor], [Created_at], [Updated_at], [LastLogin_at]) VALUES (N'6', NULL, N'accadmin', N'twnzEYF8LSf3kX3iPkicYg==', N'Account', N'Admin', NULL, N'male', N'http://localhost:5000/uploads/avatars/bf02fe58-2f90-4cc6-947c-f70aa8475650.png', NULL, NULL, NULL, N'0912481242', N'admin@gmail.com', NULL, NULL, NULL, NULL, N'0', N'7', N'1', N'0', N'1', N'0', N'0', N'Member', NULL, N'0', N'1', N'2023-03-11 14:11:02.4962700', N'2023-03-11 14:11:02.4963000', N'2023-03-11 14:11:02.4963000')
GO

INSERT INTO [dbo].[Users] ([Id], [PositionId], [Username], [Password], [FirstName], [LastName], [Description], [Gender], [Avatar], [Location_StreetAddress], [Location_StreetAddress2], [Location_ZipCode], [PhoneNumber], [EmailAddress], [Latitude], [Longitude], [OfficeHours], [Website], [PatientEvaluateNumber], [AppointmentEveryDay], [RemindPatient], [IsAnonymouse], [IsViewOnline], [IsDisabledAppointmentEveryDay], [IsDisabledRemindPatient], [Role], [IpAddress], [IsVerifyProfile], [IsDoctor], [Created_at], [Updated_at], [LastLogin_at]) VALUES (N'7', NULL, N'accdoctor', N'twnzEYF8LSf3kX3iPkicYg==', N'Account', N'Doctor', NULL, N'male', N'http://localhost:5000/uploads/avatars/80bf7b1b-c025-4627-94f4-d77c31f12491.png', NULL, NULL, NULL, N'0382428427', N'doctor@gmail.com', NULL, NULL, NULL, NULL, N'0', N'7', N'1', N'0', N'1', N'0', N'0', N'Member', NULL, N'0', N'1', N'2023-03-11 14:11:45.7755740', N'2023-03-11 14:11:45.7755790', N'2023-03-11 14:11:45.7755790')
GO

INSERT INTO [dbo].[Users] ([Id], [PositionId], [Username], [Password], [FirstName], [LastName], [Description], [Gender], [Avatar], [Location_StreetAddress], [Location_StreetAddress2], [Location_ZipCode], [PhoneNumber], [EmailAddress], [Latitude], [Longitude], [OfficeHours], [Website], [PatientEvaluateNumber], [AppointmentEveryDay], [RemindPatient], [IsAnonymouse], [IsViewOnline], [IsDisabledAppointmentEveryDay], [IsDisabledRemindPatient], [Role], [IpAddress], [IsVerifyProfile], [IsDoctor], [Created_at], [Updated_at], [LastLogin_at]) VALUES (N'8', NULL, N'accmember', N'twnzEYF8LSf3kX3iPkicYg==', N'Account', N'Member', NULL, N'male', N'http://localhost:5000/uploads/avatars/c276b56d-3869-43d5-9ed7-9092122fa2b1.png', NULL, NULL, NULL, N'0912471222', N'member@gmail.com', NULL, NULL, NULL, NULL, N'0', N'7', N'1', N'0', N'1', N'0', N'0', N'Member', NULL, N'0', N'0', N'2023-03-11 14:12:15.9056130', N'2023-03-11 14:12:15.9056180', N'2023-03-11 14:12:15.9056180')
GO

SET IDENTITY_INSERT [dbo].[Users] OFF
GO

COMMIT
GO


-- ----------------------------
-- Table structure for Wards
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Wards]') AND type IN ('U'))
	DROP TABLE [dbo].[Wards]
GO

CREATE TABLE [dbo].[Wards] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [DistrictId] int  NOT NULL,
  [Name] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Wards] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Primary Key structure for table __EFMigrationsHistory
-- ----------------------------
ALTER TABLE [dbo].[__EFMigrationsHistory] ADD CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED ([MigrationId])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for AppointmentReasons
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[AppointmentReasons]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table AppointmentReasons
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_AppointmentReasons_UserId]
ON [dbo].[AppointmentReasons] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table AppointmentReasons
-- ----------------------------
ALTER TABLE [dbo].[AppointmentReasons] ADD CONSTRAINT [PK_AppointmentReasons] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Appointments
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Appointments]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Appointments
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Appointments_AppointmentReasonId]
ON [dbo].[Appointments] (
  [AppointmentReasonId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Appointments_UserId]
ON [dbo].[Appointments] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Appointments
-- ----------------------------
ALTER TABLE [dbo].[Appointments] ADD CONSTRAINT [PK_Appointments] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Certificates
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Certificates]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Certificates
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Certificates_SpecialtyDoctorId]
ON [dbo].[Certificates] (
  [SpecialtyDoctorId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Certificates
-- ----------------------------
ALTER TABLE [dbo].[Certificates] ADD CONSTRAINT [PK_Certificates] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Chats
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Chats]', RESEED, 2)
GO


-- ----------------------------
-- Indexes structure for table Chats
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Chats_ReceiverUserId]
ON [dbo].[Chats] (
  [ReceiverUserId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Chats_UserId]
ON [dbo].[Chats] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Chats
-- ----------------------------
ALTER TABLE [dbo].[Chats] ADD CONSTRAINT [PK_Chats] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for CommentImages
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[CommentImages]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table CommentImages
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_CommentImages_CommentId]
ON [dbo].[CommentImages] (
  [CommentId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table CommentImages
-- ----------------------------
ALTER TABLE [dbo].[CommentImages] ADD CONSTRAINT [PK_CommentImages] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Comments
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Comments]', RESEED, 7)
GO


-- ----------------------------
-- Indexes structure for table Comments
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Comments_ParentId]
ON [dbo].[Comments] (
  [ParentId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Comments_PostId]
ON [dbo].[Comments] (
  [PostId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Comments_UserId]
ON [dbo].[Comments] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Comments
-- ----------------------------
ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for ContentChats
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[ContentChats]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table ContentChats
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_ContentChats_ChatId]
ON [dbo].[ContentChats] (
  [ChatId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_ContentChats_ParentId]
ON [dbo].[ContentChats] (
  [ParentId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_ContentChats_UserId]
ON [dbo].[ContentChats] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table ContentChats
-- ----------------------------
ALTER TABLE [dbo].[ContentChats] ADD CONSTRAINT [PK_ContentChats] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Countries
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Countries]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table Countries
-- ----------------------------
ALTER TABLE [dbo].[Countries] ADD CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Districts
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Districts]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Districts
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Districts_ProvinceId]
ON [dbo].[Districts] (
  [ProvinceId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Districts
-- ----------------------------
ALTER TABLE [dbo].[Districts] ADD CONSTRAINT [PK_Districts] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for EmailReceivedRequests
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[EmailReceivedRequests]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table EmailReceivedRequests
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_EmailReceivedRequests_UserId]
ON [dbo].[EmailReceivedRequests] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table EmailReceivedRequests
-- ----------------------------
ALTER TABLE [dbo].[EmailReceivedRequests] ADD CONSTRAINT [PK_EmailReceivedRequests] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Likes
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Likes]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Likes
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Likes_CommentId]
ON [dbo].[Likes] (
  [CommentId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Likes_PostId]
ON [dbo].[Likes] (
  [PostId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Likes_UserId]
ON [dbo].[Likes] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Likes
-- ----------------------------
ALTER TABLE [dbo].[Likes] ADD CONSTRAINT [PK_Likes] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Positions
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Positions]', RESEED, 35)
GO


-- ----------------------------
-- Primary Key structure for table Positions
-- ----------------------------
ALTER TABLE [dbo].[Positions] ADD CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Posts
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Posts]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Posts
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Posts_TopicId]
ON [dbo].[Posts] (
  [TopicId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Posts_UserId]
ON [dbo].[Posts] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Posts
-- ----------------------------
ALTER TABLE [dbo].[Posts] ADD CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Provinces
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Provinces]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Provinces
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Provinces_CountryId]
ON [dbo].[Provinces] (
  [CountryId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Provinces
-- ----------------------------
ALTER TABLE [dbo].[Provinces] ADD CONSTRAINT [PK_Provinces] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Specialties
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Specialties]', RESEED, 866)
GO


-- ----------------------------
-- Indexes structure for table Specialties
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Specialties_ParentId]
ON [dbo].[Specialties] (
  [ParentId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Specialties
-- ----------------------------
ALTER TABLE [dbo].[Specialties] ADD CONSTRAINT [PK_Specialties] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for SpecialtyDoctors
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[SpecialtyDoctors]', RESEED, 5)
GO


-- ----------------------------
-- Indexes structure for table SpecialtyDoctors
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_SpecialtyDoctors_SpecialtyId]
ON [dbo].[SpecialtyDoctors] (
  [SpecialtyId] ASC
)
GO


-- ----------------------------
-- Uniques structure for table SpecialtyDoctors
-- ----------------------------
ALTER TABLE [dbo].[SpecialtyDoctors] ADD CONSTRAINT [AK_SpecialtyDoctors_UserId_SpecialtyId] UNIQUE NONCLUSTERED ([UserId] ASC, [SpecialtyId] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table SpecialtyDoctors
-- ----------------------------
ALTER TABLE [dbo].[SpecialtyDoctors] ADD CONSTRAINT [PK_SpecialtyDoctors] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Topics
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Topics]', RESEED, 57)
GO


-- ----------------------------
-- Indexes structure for table Topics
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Topics_ParentId]
ON [dbo].[Topics] (
  [ParentId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Topics
-- ----------------------------
ALTER TABLE [dbo].[Topics] ADD CONSTRAINT [PK_Topics] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for UserAccessLogs
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[UserAccessLogs]', RESEED, 13)
GO


-- ----------------------------
-- Indexes structure for table UserAccessLogs
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_UserAccessLogs_UserId]
ON [dbo].[UserAccessLogs] (
  [UserId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table UserAccessLogs
-- ----------------------------
ALTER TABLE [dbo].[UserAccessLogs] ADD CONSTRAINT [PK_UserAccessLogs] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Users
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Users]', RESEED, 8)
GO


-- ----------------------------
-- Indexes structure for table Users
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Users_PositionId]
ON [dbo].[Users] (
  [PositionId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Wards
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Wards]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table Wards
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_Wards_DistrictId]
ON [dbo].[Wards] (
  [DistrictId] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table Wards
-- ----------------------------
ALTER TABLE [dbo].[Wards] ADD CONSTRAINT [PK_Wards] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table AppointmentReasons
-- ----------------------------
ALTER TABLE [dbo].[AppointmentReasons] ADD CONSTRAINT [FK_AppointmentReasons_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Appointments
-- ----------------------------
ALTER TABLE [dbo].[Appointments] ADD CONSTRAINT [FK_Appointments_AppointmentReasons_AppointmentReasonId] FOREIGN KEY ([AppointmentReasonId]) REFERENCES [dbo].[AppointmentReasons] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Appointments] ADD CONSTRAINT [FK_Appointments_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Certificates
-- ----------------------------
ALTER TABLE [dbo].[Certificates] ADD CONSTRAINT [FK_Certificates_SpecialtyDoctors_SpecialtyDoctorId] FOREIGN KEY ([SpecialtyDoctorId]) REFERENCES [dbo].[SpecialtyDoctors] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Chats
-- ----------------------------
ALTER TABLE [dbo].[Chats] ADD CONSTRAINT [FK_Chats_Users_ReceiverUserId] FOREIGN KEY ([ReceiverUserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Chats] ADD CONSTRAINT [FK_Chats_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table CommentImages
-- ----------------------------
ALTER TABLE [dbo].[CommentImages] ADD CONSTRAINT [FK_CommentImages_Comments_CommentId] FOREIGN KEY ([CommentId]) REFERENCES [dbo].[Comments] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Comments
-- ----------------------------
ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [FK_Comments_Comments_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Comments] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [FK_Comments_Posts_PostId] FOREIGN KEY ([PostId]) REFERENCES [dbo].[Posts] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Comments] ADD CONSTRAINT [FK_Comments_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table ContentChats
-- ----------------------------
ALTER TABLE [dbo].[ContentChats] ADD CONSTRAINT [FK_ContentChats_Chats_ChatId] FOREIGN KEY ([ChatId]) REFERENCES [dbo].[Chats] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[ContentChats] ADD CONSTRAINT [FK_ContentChats_ContentChats_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[ContentChats] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[ContentChats] ADD CONSTRAINT [FK_ContentChats_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Districts
-- ----------------------------
ALTER TABLE [dbo].[Districts] ADD CONSTRAINT [FK_Districts_Provinces_ProvinceId] FOREIGN KEY ([ProvinceId]) REFERENCES [dbo].[Provinces] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table EmailReceivedRequests
-- ----------------------------
ALTER TABLE [dbo].[EmailReceivedRequests] ADD CONSTRAINT [FK_EmailReceivedRequests_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Likes
-- ----------------------------
ALTER TABLE [dbo].[Likes] ADD CONSTRAINT [FK_Likes_Comments_CommentId] FOREIGN KEY ([CommentId]) REFERENCES [dbo].[Comments] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Likes] ADD CONSTRAINT [FK_Likes_Posts_PostId] FOREIGN KEY ([PostId]) REFERENCES [dbo].[Posts] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Likes] ADD CONSTRAINT [FK_Likes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Posts
-- ----------------------------
ALTER TABLE [dbo].[Posts] ADD CONSTRAINT [FK_Posts_Topics_TopicId] FOREIGN KEY ([TopicId]) REFERENCES [dbo].[Topics] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[Posts] ADD CONSTRAINT [FK_Posts_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Provinces
-- ----------------------------
ALTER TABLE [dbo].[Provinces] ADD CONSTRAINT [FK_Provinces_Countries_CountryId] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Countries] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Specialties
-- ----------------------------
ALTER TABLE [dbo].[Specialties] ADD CONSTRAINT [FK_Specialties_Specialties_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Specialties] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION NOT FOR REPLICATION
GO

ALTER TABLE [dbo].[Specialties] NOCHECK CONSTRAINT [FK_Specialties_Specialties_ParentId]
GO


-- ----------------------------
-- Foreign Keys structure for table SpecialtyDoctors
-- ----------------------------
ALTER TABLE [dbo].[SpecialtyDoctors] ADD CONSTRAINT [FK_SpecialtyDoctors_Specialties_SpecialtyId] FOREIGN KEY ([SpecialtyId]) REFERENCES [dbo].[Specialties] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [dbo].[SpecialtyDoctors] ADD CONSTRAINT [FK_SpecialtyDoctors_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Topics
-- ----------------------------
ALTER TABLE [dbo].[Topics] ADD CONSTRAINT [FK_Topics_Topics_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Topics] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table UserAccessLogs
-- ----------------------------
ALTER TABLE [dbo].[UserAccessLogs] ADD CONSTRAINT [FK_UserAccessLogs_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_Users_Positions_PositionId] FOREIGN KEY ([PositionId]) REFERENCES [dbo].[Positions] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table Wards
-- ----------------------------
ALTER TABLE [dbo].[Wards] ADD CONSTRAINT [FK_Wards_Districts_DistrictId] FOREIGN KEY ([DistrictId]) REFERENCES [dbo].[Districts] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

