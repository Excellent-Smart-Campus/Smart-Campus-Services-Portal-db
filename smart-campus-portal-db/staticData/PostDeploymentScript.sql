--- StakeholderContact
MERGE INTO dbo.[ContactType] AS Target
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
  (3, N'Admin')
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

--- StakeholderRelationshipType
MERGE INTO sh.StakeholderRelationshipType AS Target
USING (VALUES
  (1, N'Teaches'),
  (2, N'Mentors'),
  (3, N'Branch'),
  (4, N'Supervises')
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

--Status
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

-----Action
MERGE INTO usr.[Action] AS Target 
USING (VALUES 
    (1,N'Login'),
    (2,N'Update Profile'),
    (3,N'View Timetable'),
    (4,N'Assign Class Schedule'),
    (5,N'Update Class Schedule'),
    (6,N'Delete Class Schedule'),
    (7,N'View Available Rooms'),
    (8,N'Book Room'),
    (9,N'Cancel Room Booking'),
    (10,N'View My Bookings'),
    (11,N'Approve Booking'),
    (12,N'Reject Booking'),
    (13,N'Report Maintenance Issue'),
    (14,N'Update Maintenance Issue'),
    (15,N'Close Maintenance Issue'),
    (16,N'View Maintenance Requests'),
    (17,N'Assign Maintenance Technician'),
    (18,N'View Announcements'),
    (19,N'Post Announcement'),
    (20,N'Edit Announcement'),
    (21,N'Delete Announcement'),
    (22,N'Send Notification'),
    (23,N'Receive Notification'),
    (24,N'Access Dashboard'),
    (25,N'View Logs'),
    (26,N'Search Recordss'),
    (27,N'Export Data'),
    (28,N'Revoke Action From Group'),
    (29,N'Assign Action To Group'),
    (30,N'Remove User From Group'),
    (31,N'AddUser To Group'),
    (32,N'Delete Group'),
    (33,N'Update Group'),
    (34,N'Create Group'),
    (35,N'Unlock User'),
    (36,N'Add Group Action'),
    (37,N'Delete Group Action'),
    (38,N'Delete Group Member'),
    (39,N'Lock User'),
    (40,N'Reset Password'),
    (41,N'Change Password'),
    (42,N'Set group Member')
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