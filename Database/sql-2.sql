IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[AggregatedCounter]') AND type IN ('U'))
	DROP TABLE [dbo].[AggregatedCounter]
GO

CREATE TABLE [dbo].[AggregatedCounter] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [Key] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Value] bigint  NOT NULL,
  [ExpireAt] datetime2(7)  NOT NULL
)
GO

ALTER TABLE [dbo].[AggregatedCounter] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Counter
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Counter]') AND type IN ('U'))
	DROP TABLE [dbo].[Counter]
GO

CREATE TABLE [dbo].[Counter] (
  [Key] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Value] bigint  NOT NULL
)
GO

ALTER TABLE [dbo].[Counter] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Job]') AND type IN ('U'))
	DROP TABLE [dbo].[Job]
GO

CREATE TABLE [dbo].[Job] (
  [Id] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [InvocationData] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Arguments] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [CreatedAt] datetime2(7)  NOT NULL,
  [ExpireAt] datetime2(7)  NULL,
  [StateName] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [StateReason] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [StateData] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [StateDataHash] nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Job] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for State
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[State]') AND type IN ('U'))
	DROP TABLE [dbo].[State]
GO

CREATE TABLE [dbo].[State] (
  [Id] int  IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Reason] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [CreatedAt] datetime2(7)  NOT NULL,
  [JobId] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Data] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[State] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Auto increment value for AggregatedCounter
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[AggregatedCounter]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table AggregatedCounter
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_Key]
ON [dbo].[AggregatedCounter] (
  [Key] ASC
)
INCLUDE ([Value], [ExpireAt])
GO


-- ----------------------------
-- Primary Key structure for table AggregatedCounter
-- ----------------------------
ALTER TABLE [dbo].[AggregatedCounter] ADD CONSTRAINT [PK__Aggregat__3214EC07EDDD154B] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table Counter
-- ----------------------------
ALTER TABLE [dbo].[Counter] ADD CONSTRAINT [PK__Counter__C41E02886F7C64F7] PRIMARY KEY CLUSTERED ([Key])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table Job
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName]
ON [dbo].[Job] (
  [StateName] ASC
)
INCLUDE ([Id], [CreatedAt], [ExpireAt], [StateReason])
GO


-- ----------------------------
-- Primary Key structure for table Job
-- ----------------------------
ALTER TABLE [dbo].[Job] ADD CONSTRAINT [PK__Job__3214EC0799307CED] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for State
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[State]', RESEED, 1)
GO


-- ----------------------------
-- Indexes structure for table State
-- ----------------------------
CREATE NONCLUSTERED INDEX [IX_HangFire_State_JobId]
ON [dbo].[State] (
  [JobId] ASC
)
INCLUDE ([CreatedAt], [Name], [Reason], [Data])
GO


-- ----------------------------
-- Primary Key structure for table State
-- ----------------------------
ALTER TABLE [dbo].[State] ADD CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

