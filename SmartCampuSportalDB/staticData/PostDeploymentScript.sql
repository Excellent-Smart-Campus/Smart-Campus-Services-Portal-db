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
    (4, N'StudentDashboard'),
    (5, N'LectureDashboard'),
    (6, N'AdminDashboard'),
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


----- Creating DB Owner and Api USer
---- DB Owner used by admin
---- Api USer for api executions only 
IF NOT EXISTS(SELECT principal_id FROM sys.database_principals WHERE name = 'SCSApiUser')
BEGIN
    CREATE USER SCSApiUser FROM LOGIN SCSApiUser;
END

GO

IF ISNULL(IS_ROLEMEMBER ('ApiRole', 'SCSApiUser'), 0) = 0
    EXEC sp_addrolemember 'ApiRole', 'SCSApiUser';

IF NOT EXISTS(SELECT principal_id FROM sys.database_principals WHERE name = 'scs_dba')
BEGIN
    CREATE USER scs_dba FROM LOGIN scs_dba;
END

GO

IF ISNULL(IS_ROLEMEMBER ('db_owner', 'scs_dba'), 0) = 0
    EXEC sp_addrolemember 'db_owner', 'scs_dba';