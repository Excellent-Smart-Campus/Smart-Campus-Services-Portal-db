CREATE PROCEDURE [edu].[SetTimetable]
    @timetableId    INT = NULL,
    @stakeholderId         INT,
    @subjectId             INT,
    @dayOfWeekTypeId       INT,
    @roomId                INT,
    @startTime             TIME,
    @endTime               TIME = NULL,
    @location              NVARCHAR(255) = NULL
AS
SET NOCOUNT ON;
   IF @timetableId IS NULL OR @timetableId = 0
   BEGIN
        INSERT INTO [edu].[StudentTimetable] ([StakeholderId],[SubjectId],[DayOfWeekTypeId],[RoomId],[StartTime],[EndTime],[Location])
        VALUES (@stakeholderId, @subjectId, @dayOfWeekTypeId, @roomId, @startTime, @endTime, @location);
        SELECT @timetableId = SCOPE_IDENTITY();
   END
   ELSE
   BEGIN
        UPDATE edu.StudentTimetable
        SET  [DayOfWeekTypeId]  = @dayOfWeekTypeId,
             [RoomId]           = @roomId,
             [StartTime]        = @startTime,
             [EndTime]          = @endTime,
             [Location]         = @location
        WHERE [TimetableId] = @timetableId;
   END;

SELECT 
    [E].TimetableId,
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
WHERE [E].TimetableId = @timetableId
