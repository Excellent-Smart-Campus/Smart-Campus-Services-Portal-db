-- SCHEMA CREATION
CREATE SCHEMA [edu];
CREATE SCHEMA [ntf];
CREATE SCHEMA [sh];
CREATE SCHEMA [svc];
CREATE SCHEMA [usr];

-- TABLES
CREATE TABLE [sh].[Title] (
    [TitleId]           INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_Title] PRIMARY KEY CLUSTERED ([TitleId] ASC)
);

CREATE TABLE [sh].[Stakeholder] (
    [StakeholderId] INT PRIMARY KEY,
    [Name] NVARCHAR(255) NOT NULL,
    [StakeholderTypeId] INT NOT NULL,
    [IsDeleted]             BIT NULL DEFAULT 0, 
    [DateCreated]           DATETIME NOT NULL,
    [DateUpdated]           DATETIME NULL,
    CONSTRAINT [FK_Stakeholder_Type] FOREIGN KEY ([StakeholderTypeId]) REFERENCES [sh].[StakeholderType] ([StakeholderTypeId])
);

CREATE TABLE [sh].[StakeholderType] (
    [StakeholderTypeId] INT PRIMARY KEY,
    [Description] NVARCHAR(100) NOT NULL
);

CREATE TABLE [sh].[StakeholderPerson] (
    [StakeholderId]			INT NOT NULL PRIMARY KEY,
    [TitleId]               INT NULL,
    [FirstName]             NVARCHAR (255) NOT NULL,
    [LastName]              NVARCHAR (255) NOT NULL,
    CONSTRAINT [FK_StakeholderPerson_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderPerson_Title] FOREIGN KEY ([TitleId]) REFERENCES [sh].[Title] ([TitleId])
);

CREATE TABLE [sh].[StakeholderRelationship]
(
	[StakeholderId]                 INT  NOT NULL,
    [RelatedStakeholderId]          INT  NOT NULL,
    [StakeholderRelationshipTypeId] INT  NOT NULL,
    [EffectiveDate]                 DATE NOT NULL,
    [EndDate]                       DATE NULL,
    CONSTRAINT [PK_StakeholderRelationship] PRIMARY KEY CLUSTERED ([StakeholderId] ASC, [RelatedStakeholderId] ASC, [StakeholderRelationshipTypeId] ASC),
    CONSTRAINT [FK_StakeholderRelationship_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderRelationship_StakeholderRelated] FOREIGN KEY ([RelatedStakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderRelationship_StakeholderRelationshipType] FOREIGN KEY ([StakeholderRelationshipTypeId]) REFERENCES [sh].[StakeholderRelationshipType] ([StakeholderRelationshipTypeId])
)

CREATE TABLE [sh].[StakeholderRelationshipType]
(
	[StakeholderRelationshipTypeId] INT NOT NULL,
    [Description]                   NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_StakeholderRelationshipType] PRIMARY KEY CLUSTERED ([StakeholderRelationshipTypeId] ASC)
)

CREATE TABLE [sh].[ContactType] (
    [ContactTypeId] INT           NOT NULL,
    [Description]   NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED ([ContactTypeId] ASC)
);

CREATE TABLE [sh].[Contact] (
    [ContactId]         INT IDENTITY (1, 1) NOT NULL,
    [StakeholderId]     INT NOT NULL,
    [ContactTypeId]     INT NOT NULL,
    [Detail]            NVARCHAR (255) NOT NULL,
    [AreaCode]          NVARCHAR (32)  NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([ContactId] ASC),
    CONSTRAINT [FK_Contact_ContactType] FOREIGN KEY ([ContactTypeId]) REFERENCES [sh].[ContactType] ([ContactTypeId]),
    CONSTRAINT [FK_Contact_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId])
);

CREATE TABLE [usr].[Action]
(
	[ActionId]			INT NOT NULL PRIMARY KEY,
	[Description]		NVARCHAR(255) NOT NULL
)

CREATE TABLE [usr].[ActionLog]
(
	[ActionLogId]	    INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ActionId]		    INT NOT NULL,
	[StakeholderId]	    INT NOT NULL,
	[ActionDate]	    DATETIME NOT NULL,
	[Description]	    NVARCHAR(255) NULL,
    [KeyId]			INT NULL,
	CONSTRAINT [FK_ActionLog_Action] FOREIGN KEY ([ActionId]) REFERENCES [usr].[Action] ([ActionId]),
	CONSTRAINT [FK_ActionLog_User] FOREIGN KEY ([StakeholderId]) REFERENCES [usr].[User] ([StakeholderId])
)

CREATE TABLE [usr].[Group]
(
	[GroupId]		INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[Description]	NVARCHAR(255) NOT NULL,
	[IsDeleted]		BIT NOT NULL
)

CREATE TABLE [usr].[GroupAction]
(
	[GroupId]   INT NOT NULL,
	[ActionId]  INT NOT NULL,
	CONSTRAINT  [PK_GroupAction] PRIMARY KEY CLUSTERED ([GroupId] ASC, [ActionId] ASC),
	CONSTRAINT  [FK_GroupAction_Group] FOREIGN KEY ([GroupId]) REFERENCES [usr].[Group] ([GroupId]),
    CONSTRAINT  [FK_GroupAction_Action] FOREIGN KEY ([ActionId]) REFERENCES [usr].[Action] ([ActionId])
)

CREATE TABLE [usr].[User]
(
	[StakeholderId]			INT NOT NULL,
	[Username]				NVARCHAR(255)  NOT NULL,
	[PasswordHash]          NVARCHAR(1000) NULL,
    [SecurityStamp]         NVARCHAR(1000) NULL,
	[IsLocked]				BIT NULL DEFAULT 0,
	[IsDeleted]				BIT NULL DEFAULT 0,
    [DateCreated]           DATETIME       NOT NULL,
	[DateUpdated]           DATETIME       NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([StakeholderId] ASC),
	CONSTRAINT [FK_User_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].Stakeholder ([StakeholderId]),
	CONSTRAINT [UK_User_Username] UNIQUE(Username)
)

CREATE TABLE [usr].[GroupMember]
(
	[GroupId]		INT NOT NULL,
	[StakeholderId] INT NOT NULL,
	CONSTRAINT [PK_GroupMember] PRIMARY KEY CLUSTERED ([GroupId] ASC, [StakeholderId] ASC),
	CONSTRAINT [FK_GroupMember_Group] FOREIGN KEY ([GroupId]) REFERENCES [usr].[Group] ([GroupId]),
    CONSTRAINT [FK_GroupMember_User] FOREIGN KEY ([StakeholderId]) REFERENCES [usr].[User] ([StakeholderId])
)

CREATE TABLE [svc].[Status] (
    [StatusId]          INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED ([StatusId] ASC)
);

CREATE TABLE [svc].[RoomType] (
    [RoomTypeId]        INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED ([RoomTypeId] ASC)
);

CREATE TABLE [svc].[Room] (
    [RoomId]        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [RoomNumber]    NVARCHAR(25) NOT NULL,
    [RoomTypeId]    INT NOT NULL,
    [Capacity]      INT NOT NULL,
    [Location]      NVARCHAR(255) NULL,
    CONSTRAINT [FK_Room_RoomType] FOREIGN KEY ([RoomTypeId]) REFERENCES [svc].[RoomType] ([RoomTypeId])
);

CREATE TABLE [svc].[MaintenanceIssue] (
    [IssueId]           INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [StakeholderId]     INT NOT NULL, 
    [Title]             NVARCHAR(255) NOT NULL,
    [RoomId]            INT NULL, 
    [Description]       NVARCHAR(MAX) NULL,
    [StatusId]          INT NOT NULL,
    [DateReported]      DATETIME NOT NULL,
    [DateResolved]      DATETIME NULL,
    CONSTRAINT [FK_MaintenanceIssue_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_MaintenanceIssue_Status] FOREIGN KEY ([StatusId]) REFERENCES [svc].[Status] ([StatusId]),
    CONSTRAINT [FK_MaintenanceIssue_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId])
);

CREATE TABLE [svc].[Booking] (
    [BookingId]         INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [StakeholderId]     INT NOT NULL,
    [LecturerId]        INT NULL,
    [RoomId]            INT NULL,
    [Purpose]           VARCHAR(MAX) NULL,
    [BookingDate]       DATETIME NOT NULL,
    [StartTime]         TIME NULL,
    [EndTime]           TIME NULL,
    [StatusId]          INT NOT NULL,
    [DateCreated]       DATETIME NOT NULL,
    [DateUpdated]       DATETIME NULL,
    CONSTRAINT [FK_Booking_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Booking_Lecturer] FOREIGN KEY ([LecturerId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Booking_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId]),
    CONSTRAINT [FK_Booking_Status] FOREIGN KEY ([StatusId]) REFERENCES [svc].[Status] ([StatusId])
);

CREATE TABLE [svc].[BookingParticipant] (
    [BookingId]            INT NOT NULL,
    [StakeholderId]        INT NOT NULL,
    [JoinedAt]             DATETIME NOT NULL,
    CONSTRAINT [PK_BookingParticipant] PRIMARY KEY CLUSTERED ([BookingId] ASC, [StakeholderId] ASC),
    CONSTRAINT [FK_BookingParticipant_Booking] FOREIGN KEY ([BookingId]) REFERENCES [svc].[Booking] ([BookingId]),
    CONSTRAINT [FK_BookingParticipant_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].Stakeholder ([StakeholderId])
);

CREATE TABLE [edu].[Course] (
    [CourseId]        INT NOT NULL,
    [CourseCode]           NVARCHAR (255) NOT NULL,
    [CourseName]           NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED ([StakeholderId] ASC),
    CONSTRAINT [FK_Course_Stakeholder] FOREIGN KEY ([CourseId]) REFERENCES [sh].[Stakeholder] ([StakeholderId])
);

CREATE TABLE [edu].[Subject] (
    [SubjectId]             INT IDENTITY (1, 1) NOT NULL,
    [SubjectCode]           NVARCHAR (255) NOT NULL,
    [SubjectName]           NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED ([SubjectId] ASC)
);

CREATE TABLE [edu].[StakeholderSubject] (
    [SubjectId]             INT NOT NULL,
	[StakeholderId]         INT NOT NULL,
	[StakeholderTypeId]     INT NULL,
	[IsDeleted]             BIT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_StakeholderSubject] PRIMARY KEY CLUSTERED ([SubjectId] ASC, [StakeholderId] ASC),
    CONSTRAINT [FK_StakeholderSubject_SubjectId] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_StakeholderSubject_StakeholderId] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderSubject_StakeholderTypeId] FOREIGN KEY ([StakeholderTypeId]) REFERENCES [sh].[StakeholderType] ([StakeholderTypeId])
);

CREATE TABLE [edu].[CourseSubject] (
    [CourseId]      INT NOT NULL,
    [SubjectId]     INT NOT NULL,
    [IsMandatory]   BIT NOT NULL DEFAULT 1,
    CONSTRAINT [PK_CourseSubject] PRIMARY KEY CLUSTERED ([CourseId], [SubjectId]),
    CONSTRAINT [FK_CourseSubject_Course] FOREIGN KEY ([CourseId]) REFERENCES [edu].[Course] ([StakeholderId]),
    CONSTRAINT [FK_CourseSubject_Subject] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId])
);

CREATE TABLE [edu].[DayOfWeekType] (
    [DayOfWeekTypeId]   INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_DayOfWeekType] PRIMARY KEY CLUSTERED ([DayOfWeekTypeId] ASC)
);

CREATE TABLE [edu].[Timetable] (
    [TimetableId]    INT IDENTITY(1,1) NOT NULL,
    [StakeholderId]         INT NOT NULL,
    [SubjectId]             INT NOT NULL,
    [DayOfWeekTypeId]       INT NOT NULL,
    [RoomId]                INT NOT NULL,
    [StartTime]             TIME NOT NULL,
    [EndTime]               TIME,
    [Location]              NVARCHAR(255) NULL,
    CONSTRAINT [PK_Timetable] PRIMARY KEY CLUSTERED ([TimetableId] ASC),
    CONSTRAINT [FK_Timetable_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Timetable_Subject] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_Timetable_DayOfWeekType] FOREIGN KEY ([DayOfWeekTypeId]) REFERENCES [edu].[DayOfWeekType] ([DayOfWeekTypeId]),
    CONSTRAINT [FK_Timetable_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId])
);

CREATE TABLE [ntf].[NotificationType] (
    [NotificationTypeId]        INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_NotificationType] PRIMARY KEY CLUSTERED ([NotificationTypeId] ASC)
);

CREATE TABLE [ntf].[Notification] (
    [NotificationId]             INT IDENTITY (1, 1) NOT NULL,
    [SenderId]                   INT NOT NULL,
    [NotificationTypeId]         INT NOT NULL,
    [SubjectId]                  INT NULL,
    [Message]                    NVARCHAR(MAX) NULL,
    [ReferenceId]                INT NULL,
    [DateCreated]                DATETIME NOT NULL,
    [DateUpdated]                DATETIME NULL,
    CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED ([NotificationId] ASC),
    CONSTRAINT [FK_Notification_SubjectId] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_Notification_Sender] FOREIGN KEY ([SenderId]) REFERENCES [sh].[Stakeholder]([StakeholderId]),
    CONSTRAINT [FK_Notification_NotificationType] FOREIGN KEY ([NotificationTypeId]) REFERENCES [ntf].[NotificationType] ([NotificationTypeId])
);

CREATE TABLE [ntf].[NotificationView] (
    [NotificationId]            INT NOT NULL,
    [StakeholderId]             INT NOT NULL,
    [isRead]                    BIT NULL DEFAULT 0,
    [DateCreated]               DATETIME,
    [DateUpdated]               DATETIME NULL,
    CONSTRAINT [PK_NotificationView] PRIMARY KEY CLUSTERED ([StakeholderId] ASC, [NotificationId] ASC),
    CONSTRAINT [FK_NotificationView_Notification] FOREIGN KEY ([NotificationId]) REFERENCES [ntf].[Notification] ([NotificationId]),
    CONSTRAINT [FK_NotificationView_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].Stakeholder ([StakeholderId])
);

--- NotificationType
MERGE INTO ntf.[NotificationType] AS Target
USING (VALUES
  (1, N'Booking'),
  (2, N'Appointment'),
  (3, N'Maintenance'),
  (4, N'Announcement'),
  (5, N'Subject')
)
AS Source (NotificationTypeId, Description)
ON Target.NotificationTypeId = Source.NotificationTypeId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (NotificationTypeId, Description)
VALUES (NotificationTypeId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

--- StakeholderContact
MERGE INTO sh.[ContactType] AS Target
USING (VALUES
  (1, N'Email Address'),
  (2, N'Mobile Number')
)
AS Source (ContactTypeId, Description)
ON Target.ContactTypeId = Source.ContactTypeId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (ContactTypeId, Description)
VALUES (ContactTypeId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- StakeholderType
MERGE INTO sh.StakeholderType AS Target
USING (VALUES
  (1, N'Student'),
  (2, N'Lecture'),
  (3, N'Admin'),
  (4, N'Course')
)
AS Source (StakeholderTypeId, Description)
ON Target.StakeholderTypeId = Source.StakeholderTypeId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (StakeholderTypeId, Description)
VALUES (StakeholderTypeId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

--- Stakeholder
SET IDENTITY_INSERT sh.Stakeholder ON;
MERGE INTO sh.[Stakeholder] AS Target
USING (VALUES
  (1, 4, N'Diploma In Computer Science', 0, GETDATE()),
  (2, 4, N'Diploma In Computer Systems Engineering', 0, GETDATE()),
  (3, 4, N'Advance Diploma In Computer Science', 0, GETDATE()),
  (4, 4, N'Advance Diploma In Computer Systems Engineering', 0, GETDATE())
)
AS Source (StakeholderId, StakeholderTypeId, Name, IsDeleted, DateCreated)
ON Target.StakeholderId = Source.StakeholderId

WHEN MATCHED THEN
UPDATE SET StakeholderTypeId = Source.StakeholderTypeId,
            Name = Source.Name,
            IsDeleted = Source.IsDeleted,
            DateCreated = Source.DateCreated

WHEN NOT MATCHED BY TARGET THEN
INSERT (StakeholderId, StakeholderTypeId, Name, IsDeleted, DateCreated)
VALUES (StakeholderId, StakeholderTypeId, Name, IsDeleted, DateCreated);

SET IDENTITY_INSERT sh.Stakeholder OFF;

----- Title
MERGE INTO sh.Title AS Target 
USING (VALUES 
  (1, N'Mr.'),
  (2, N'Mrs.'),
  (3, N'Miss'),
  (4, N'Ms.'),
  (5, N'Mx. '),
  (6, N'Dr.'),
  (7, N'Prof.'),
  (8, N'Rev.'),
  (9, N'Sir'),
  (10,N'Lady'),
  (11,N'Hon.'),
  (12,N'Capt.'),
  (13,N'Major'),
  (14,N'Col.'),
  (15,N'Lt.'),
  (16,N'Sgt.')
) 
AS Source (TitleId, Description) 
ON Target.TitleId = Source.TitleId
WHEN MATCHED THEN 
UPDATE SET Description = Source.Description 

WHEN NOT MATCHED BY TARGET THEN 
INSERT (TitleId, Description) 
VALUES (TitleId, Description) 

WHEN NOT MATCHED BY SOURCE THEN 
DELETE;

--- StakeholderRelationshipType
MERGE INTO sh.StakeholderRelationshipType AS Target
USING (VALUES
  (1, N'Enrolled'),
  (2, N'Teaches'),
  (3, N'Supervise')
)
AS Source (StakeholderRelationshipTypeId, Description)
ON Target.StakeholderRelationshipTypeId = Source.StakeholderRelationshipTypeId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (StakeholderRelationshipTypeId, Description)
VALUES (StakeholderRelationshipTypeId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

--DayOfWeekType
MERGE INTO edu.DayOfWeekType AS Target
USING (VALUES
  (1, N'Monday'),
  (2, N'Tuesday'),
  (3, N'Wednesday'),
  (4, N'Thursday'),
  (5, N'Friday')
)
AS Source (DayOfWeekTypeId, Description)
ON Target.DayOfWeekTypeId = Source.DayOfWeekTypeId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (DayOfWeekTypeId, Description)
VALUES (DayOfWeekTypeId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- Status
MERGE INTO svc.Status AS Target
USING (VALUES
  (1, N'Pending'),
  (2, N'Approved'),
  (3, N'Rejected'),
  (4, N'Open'),
  (5, N'In Progress'),
  (6, N'Resolved')
)
AS Source (StatusId, Description)
ON Target.StatusId = Source.StatusId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (StatusId, Description)
VALUES (StatusId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- subject
SET IDENTITY_INSERT edu.Subject ON;
MERGE INTO edu.Subject AS Target
USING (VALUES
  (1, N'DTD117V', N'Data Structures And Algorithms'),
  (2, N'GMD117V', N'Games Engineering'),
  (3, N'SEC117V', N'Service-Oriented Computing'),
  (4, N'HMD117V', N'Human Computer Interaction'),
  (5, N'SFG117V', N'Software Engineering'),
  
  (6, N'CFA115D', N'Computing Fundamentals'),
  (7, N'PPA115D', N'Principles of Programming A'),
  (8, N'WEB115D', N'Web Computing'),
  
  (9, N'CMS115D', N'Communication Science'),
  (10, N'DE1115D', N'Digital Electronics'),
  (11, N'PG1115D', N'Programming'),
  
  (12, N'EGD107V', N'Engineering Project Design'),
  (13, N'AIS117V', N'Artificial Inteligent Systems'),
  (14, N'EBD117V', N'Embedded Systems Design')
)
AS Source (SubjectId, SubjectCode, SubjectName)
ON Target.SubjectId = Source.SubjectId

WHEN MATCHED THEN
UPDATE SET SubjectCode = Source.SubjectCode,
          SubjectName = Source.SubjectName

WHEN NOT MATCHED BY TARGET THEN
INSERT (SubjectId, SubjectCode, SubjectName)
VALUES (SubjectId, SubjectCode, SubjectName)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;
SET IDENTITY_INSERT edu.Subject OFF;

-- COURSE
MERGE INTO edu.Course AS Target
USING (VALUES
  (1, N'DCS01', N'Diploma In Computer Science'),
  (2, N'DCSE1', N'Diploma In Computer Systems Engineering'),
  (3, N'ADCS1', N'Advance Diploma In Computer Science'),
  (4, N'ADCSE', N'Advance Diploma In Computer Systems Engineering')
)
AS Source (StakeholderId, CourseCode, CourseName)
ON Target.StakeholderId = Source.StakeholderId

WHEN MATCHED THEN
UPDATE SET CourseCode = Source.CourseCode,
          CourseName = Source.CourseName

WHEN NOT MATCHED BY TARGET THEN
INSERT (StakeholderId, CourseCode, CourseName)
VALUES (StakeholderId, CourseCode, CourseName)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;


-- CourseSubject
MERGE INTO edu.CourseSubject AS Target
USING (VALUES
  (1, 6, 1),
  (1, 7, 1),
  (1, 8, 1), 
  (2, 9, 1),
  (2, 10, 1),
  (2, 11, 1), 
  (3, 1, 1),
  (3, 2, 1),
  (3, 3, 1),
  (3, 4, 1),
  (3, 5, 1),
  (4, 12, 1),
  (4, 13, 1),
  (4, 14, 1)
)
AS Source (CourseId, SubjectId, IsMandatory)
ON Target.CourseId = Source.CourseId
AND Target.SubjectId = Source.SubjectId

WHEN MATCHED THEN
UPDATE SET IsMandatory = Source.IsMandatory

WHEN NOT MATCHED BY TARGET THEN
INSERT (CourseId, SubjectId, IsMandatory)
VALUES (CourseId, SubjectId, IsMandatory)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- RoomType
MERGE INTO svc.RoomType AS Target
USING (VALUES
  (1, N'Study Room'),
  (2, N'Lecture Hall'),
  (3, N'Lab'),
  (4, N'Lab'),
  (5, N'Technical Lab')
)
AS Source (RoomTypeId, Description)
ON Target.RoomTypeId = Source.RoomTypeId

WHEN MATCHED THEN
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN
INSERT (RoomTypeId, Description)
VALUES (RoomTypeId, Description)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- room
SET IDENTITY_INSERT svc.Room ON;
MERGE INTO svc.Room AS Target
USING (VALUES
  (1, N'A101', 1, 200, NULL),
  (2, N'B202', 2, 50, NULL),
  (3, N'B201', 2, 50, NULL),
  (4, N'10-G06', 3, 50, NULL),
  (5, N'10-140', 4, 50, NULL),
  (6, N'BB01', 5, 25, NULL)
)
AS Source (RoomId, RoomNumber, RoomTypeId, Capacity, Location)
ON Target.RoomId = Source.RoomId

WHEN MATCHED THEN
UPDATE SET RoomNumber = Source.RoomNumber,
          RoomTypeId = Source.RoomTypeId,
          Capacity = Source.Capacity,
          Location = Source.Location

WHEN NOT MATCHED BY TARGET THEN
INSERT (RoomId, RoomNumber, RoomTypeId, Capacity, Location)
VALUES (RoomId, RoomNumber, RoomTypeId, Capacity, Location)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;
SET IDENTITY_INSERT svc.Room OFF;

-----Action
MERGE INTO usr.[Action] AS Target 
USING (VALUES 
    (1, N'Login'),
    (2, N'View Profile'),
    (3, N'Update Profile'),
    (4, N'Student Dashboard'),
    (5, N'Lecture Dashboard'),
    (6, N'Admin Dashboard'),
    (7, N'View Notifications'),
    (8, N'Mark Notification as Read'),
    (9, N'Enroll Course And Subject'),
    (10, N'View Timetable'),
    (11, N'Export Timetable as PDF'),
    (12, N'Teach a subject'),
    (13, N'Book A Room'),
    (14, N'Cancel Room Booking'),
    (15, N'View My Bookings'),
    (16, N'Approve Booking'),
    (17, N'Reject Booking'),
    (18, N'Report Maintenance Issue'),
    (19, N'Update Maintenance Issue'),
    (20, N'Close Maintenance Issue'),
    (21, N'View Maintenance Request'),
    (22, N'Assign Maintenance Issue'),
    (23, N'Send Subject Notification'),
    (24, N'Send General Notification'),
    (25, N'Schedule Appointment Notification'),
    (26, N'View Available Rooms'),
    (27, N'Delete Announcement'),
    (28, N'Assign Class Schedule'),
    (29, N'Update Class Schedule'),
    (30, N'View Logs'),
    (31, N'Revoke Action From Group'),
    (32, N'Assign Action To Group'),
    (33, N'Remove User From Group'),
    (34, N'AddUser To Group'),
    (35, N'Delete Group'),
    (36, N'Update Group'),
    (37, N'Create Group'),
    (38, N'Unlock User'),
    (39, N'Add Group Action'),
    (40, N'Delete Group Action'),
    (41, N'Delete Group Member'),
    (42, N'Set group Member'),
    (43, N'Reset Password'),
    (44, N'Change Password'),
    (45, N'Lock User')
)
AS Source ([ActionId], Description) 
ON Target.[ActionId] = Source.[ActionId]

WHEN MATCHED THEN 
UPDATE SET Description = Source.Description

WHEN NOT MATCHED BY TARGET THEN 
INSERT ([ActionId], Description) 
VALUES ([ActionId], Description) 

WHEN NOT MATCHED BY SOURCE THEN 
DELETE;

----- Group
SET IDENTITY_INSERT [usr].[Group] ON;
MERGE INTO [usr].[Group] AS Target 
USING (VALUES 
  (1, N'Super User', 0),
  (2, N'Students', 0),
  (3, N'Lecturers', 0)
) 
AS Source ([GroupId], [Description], [IsDeleted])
ON Target.[GroupId] = Source.[GroupId]

WHEN MATCHED THEN 
UPDATE SET [Description] = Source.[Description]

WHEN NOT MATCHED BY Target THEN 
INSERT ([GroupId], [Description], [IsDeleted])
VALUES (Source.[GroupId], Source.[Description], Source.[IsDeleted]);

SET IDENTITY_INSERT [usr].[Group] OFF; 


--Super User
INSERT INTO usr.GroupAction 
SELECT
	1,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,6,7,8,14,16,17,19,20,21,22,24,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45)

--Students
INSERT INTO usr.GroupAction 
SELECT
	2,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,3,4,7,8,9,10,11,13,14,15,18,21,25,26,45)

--Lecturers
INSERT INTO usr.GroupAction 
SELECT
	3,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,3,5,7,8,9,10,11,12,13,14,15,16,17,18,21,23,26,27,29,45)



--Lecturers users 
BEGIN TRANSACTION;
BEGIN TRY

    DECLARE @users TABLE (
        FirstName NVARCHAR(255),
        LastName NVARCHAR(255),
        StakeholderTypeId INT,
        RelatedStakeholderId INT,
        StakeholderRelationshipTypeId INT,
        EffectiveDate DATE,
        Mobile NVARCHAR(20),
        Email NVARCHAR(100),
        SecurityStamp NVARCHAR(1000),
        PasswordHash NVARCHAR(1000)
    );

    INSERT INTO @Users
     (FirstName, LastName, StakeholderTypeId, RelatedStakeholderId, StakeholderRelationshipTypeId , EffectiveDate, Mobile, Email, SecurityStamp, PasswordHash)
    VALUES 
        ('Alice', 'Smith', 2, 1, 2, CONVERT(DATE, GETDATE()), '0712345678', 'alice@smt.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g=='),
        ('Bob', 'Jones', 2,  1, 2, CONVERT(DATE, GETDATE()), '0723456789', 'bob@example.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g=='),
        ('Charlie', 'Magagula', 2, 2, 2, CONVERT(DATE, GETDATE()), '0734567890', 'charlie@example.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g==')

 
    DECLARE @FirstName NVARCHAR(255),
        @LastName NVARCHAR(255),
        @StakeholderTypeId INT,
        @RelatedStakeholderId INT,
        @StakeholderRelationshipTypeId INT,
        @EffectiveDate DATE,
        @Mobile NVARCHAR(20),
        @Email NVARCHAR(100),
        @SecurityStamp NVARCHAR(1000),
        @PasswordHash NVARCHAR(1000),
        @PersonStakeholderId INT;

    DECLARE user_cursor CURSOR FOR
        SELECT FirstName, 
        LastName, 
        StakeholderTypeId, 
        RelatedStakeholderId, 
        StakeholderRelationshipTypeId, 
        EffectiveDate, 
        Mobile,
        Email,
        SecurityStamp,
        PasswordHash FROM @Users;

    OPEN user_cursor;
        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @RelatedStakeholderId, 
            @StakeholderRelationshipTypeId,
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insert Stakeholder
        INSERT INTO sh.Stakeholder (StakeholderTypeId, Name, DateCreated)
        VALUES (
            @StakeholderTypeId,
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))) + ' ' +
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName))),
            GETDATE()
        );
        SET @PersonStakeholderId = SCOPE_IDENTITY();
    
        -- Insert StakeholderPerson
        INSERT INTO sh.StakeholderPerson (StakeholderId, FirstName, LastName)
        VALUES (
            @PersonStakeholderId, 
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))),
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName)))
        );

        -- Insert Contact: 2 Mobile
        INSERT INTO sh.Contact (StakeholderId,ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 2, @Mobile);

        -- Insert Contact: 1 Email
        INSERT INTO sh.Contact (StakeholderId, ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 1, @Email);

        -- StakeholderRelationship
        INSERT INTO sh.StakeholderRelationship (StakeholderId, RelatedStakeholderId, StakeholderRelationshipTypeId, EffectiveDate)
        VALUES (@PersonStakeholderId, @RelatedStakeholderId, @StakeholderRelationshipTypeId, @EffectiveDate);

        -- Insert User
        INSERT INTO usr.[User] (StakeholderId, Username, PasswordHash, SecurityStamp, DateCreated)
        VALUES (@PersonStakeholderId, @Email, @PasswordHash, @SecurityStamp, GETDATE());

        -- GroupMember
        INSERT INTO usr.GroupMember (GroupId, StakeholderId)
        VALUES (3, @PersonStakeholderId);

        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @RelatedStakeholderId, 
            @StakeholderRelationshipTypeId,
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
        END
    CLOSE user_cursor;
    DEALLOCATE user_cursor;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE @errorMessage nvarchar(max), @errorSeverity int, @errorState int;
    SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();

    IF (@@TRANCOUNT > 0)
    BEGIN
        ROLLBACK TRANSACTION
    END 

    RAISERROR(@errorMessage, @errorSeverity, @errorState);
END CATCH




--Admin users 
BEGIN TRANSACTION;
BEGIN TRY

    DECLARE @users TABLE (
        FirstName NVARCHAR(255),
        LastName NVARCHAR(255),
        StakeholderTypeId INT,
        EffectiveDate DATE,
        Mobile NVARCHAR(20),
        Email NVARCHAR(100),
        SecurityStamp NVARCHAR(1000),
        PasswordHash NVARCHAR(1000)
    );

    INSERT INTO @Users
     (FirstName, LastName, StakeholderTypeId, EffectiveDate, Mobile, Email, SecurityStamp, PasswordHash)
    VALUES 
        ('georgia', 'mosamo', 3, CONVERT(DATE, GETDATE()), '0712345678', 'georgia.mosamo@un.org.za', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g=='),
        ('betty', 'tinyane', 3, CONVERT(DATE, GETDATE()), '0723456789', 'bettytinyane@gmail.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g==')

 
    DECLARE @FirstName NVARCHAR(255),
        @LastName NVARCHAR(255),
        @StakeholderTypeId INT,
        @EffectiveDate DATE,
        @Mobile NVARCHAR(20),
        @Email NVARCHAR(100),
        @SecurityStamp NVARCHAR(1000),
        @PasswordHash NVARCHAR(1000),
        @PersonStakeholderId INT;

    DECLARE user_cursor CURSOR FOR
        SELECT FirstName, 
        LastName, 
        StakeholderTypeId, 
        EffectiveDate, 
        Mobile,
        Email,
        SecurityStamp,
        PasswordHash FROM @Users;

    OPEN user_cursor;
        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insert Stakeholder
        INSERT INTO sh.Stakeholder (StakeholderTypeId, Name, DateCreated)
        VALUES (
            @StakeholderTypeId,
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))) + ' ' +
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName))),
            GETDATE()
        );
        SET @PersonStakeholderId = SCOPE_IDENTITY();
    
        -- Insert StakeholderPerson
        INSERT INTO sh.StakeholderPerson (StakeholderId, FirstName, LastName)
        VALUES (
            @PersonStakeholderId, 
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))),
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName)))
        );

        -- Insert Contact: 2 Mobile
        INSERT INTO sh.Contact (StakeholderId,ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 2, @Mobile);

        -- Insert Contact: 1 Email
        INSERT INTO sh.Contact (StakeholderId, ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 1, @Email);

        -- Insert User
        INSERT INTO usr.[User] (StakeholderId, Username, PasswordHash, SecurityStamp, DateCreated)
        VALUES (@PersonStakeholderId, @Email, @PasswordHash, @SecurityStamp, GETDATE());

        -- GroupMember
        INSERT INTO usr.GroupMember (GroupId, StakeholderId)
        VALUES (1, @PersonStakeholderId);

        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
        END
    CLOSE user_cursor;
    DEALLOCATE user_cursor;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE @errorMessage nvarchar(max), @errorSeverity int, @errorState int;
    SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();

    IF (@@TRANCOUNT > 0)
    BEGIN
        ROLLBACK TRANSACTION
    END 

    RAISERROR(@errorMessage, @errorSeverity, @errorState);
END CATCH
