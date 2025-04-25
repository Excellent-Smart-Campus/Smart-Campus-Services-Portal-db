CREATE PROCEDURE [edu].[setStudentTimetable]
    @StudentTimetableId    INT = NULL,
    @StakeholderId         INT,
    @SubjectId             INT,
    @DayOfWeekTypeId       INT,
    @RoomId                INT,
    @StartTime             TIME,
    @EndTime               TIME = NULL,
    @Location              NVARCHAR(255) = NULL
AS
SET NOCOUNT ON;
   IF @StudentTimetableId IS NULL OR @StudentTimetableId = 0
   BEGIN
        INSERT INTO [edu].[StudentTimetable] ([StakeholderId],[SubjectId],[DayOfWeekTypeId],[RoomId],[StartTime],[EndTime],[Location])
        VALUES (@StakeholderId, @SubjectId, @DayOfWeekTypeId, @RoomId, @StartTime, @EndTime, @Location);
        SELECT @StudentTimetableId = SCOPE_IDENTITY();
   END
   ELSE
   BEGIN
        UPDATE edu.StudentTimetable
        SET  [DayOfWeekTypeId]  = @DayOfWeekTypeId,
             [RoomId]           = @RoomId,
             [StartTime]        = @StartTime,
             [EndTime]          = @EndTime,
             [Location]         = @Location
        WHERE [StudentTimetableId] = @StudentTimetableId;
   END;

SELECT 
    [E].StudentTimetableId,
	[E].StakeholderId,
	[S].SubjectCode,
	[E].SubjectId,
	[E].DayOfWeekTypeId,
	[D].Description,
	[E].RoomId,
	[R].RoomNumber,
    [E].StartTime,
    [E].EndTime,
    [E].Location
FROM [edu].StudentTimetable [E]
INNER JOIN [edu].Subject [S] ON [E].SubjectId = [S].SubjectId
INNER JOIN [edu].DayOfWeekType [D] ON [E].DayOfWeekTypeId = [D].DayOfWeekTypeId
INNER JOIN [svc].Room [R] ON [E].RoomId = [R].RoomId
WHERE [E].StudentTimetableId = @StudentTimetableId
