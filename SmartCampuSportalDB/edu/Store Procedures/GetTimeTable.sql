CREATE PROCEDURE [edu].[GetTimeTable]
    @stakeholderId INT,
    @stakeholderRelationshipTypeId INT
AS
BEGIN
    SET NOCOUNT ON;

    WITH RegisteredSubjects AS (
        SELECT
            C.StakeholderId AS 'CourseId',
            C.CourseCode,
            S.SubjectCode,
            S.SubjectId,
            S.SubjectName
        FROM [edu].Course C
        CROSS APPLY (
            SELECT 1 AS RegisteredCheck
            FROM sh.StakeholderRelationship 
            WHERE StakeholderId = @stakeholderId 
            AND StakeholderRelationshipTypeId = @stakeholderRelationshipTypeId
            AND RelatedStakeholderId = C.StakeholderId
            AND EndDate IS NULL
        ) AS RegisteredCheck
        INNER JOIN [edu].CourseSubject CS ON C.StakeholderId = CS.CourseId
        INNER JOIN [edu].[Subject] S ON CS.SubjectId = S.SubjectId
        INNER JOIN [edu].[StakeholderSubject] SS ON S.SubjectId = SS.SubjectId AND SS.StakeholderId = @stakeholderId
    )
    SELECT 
        [RS].CourseId,
        [RS].CourseCode,
        T.TimetableId,
        [RS].SubjectId,
        [RS].SubjectCode,
        [RS].SubjectName,
        T.StartTime,
        T.EndTime,
        T.Location,
        T.DayOfWeekTypeId,
        D.Description AS 'DayOfWeekType',
        T.RoomId,
        R.RoomNumber,
        RT.Description AS 'RoomType'
    FROM [edu].[Timetable] T
    INNER JOIN RegisteredSubjects RS ON T.SubjectId = RS.SubjectId
    INNER JOIN [edu].[DayOfWeekType] D ON T.DayOfWeekTypeId = D.DayOfWeekTypeId
    INNER JOIN [svc].[Room] R ON T.RoomId = R.RoomId
    INNER JOIN [svc].[RoomType] RT ON R.RoomTypeId = RT.RoomTypeId
END