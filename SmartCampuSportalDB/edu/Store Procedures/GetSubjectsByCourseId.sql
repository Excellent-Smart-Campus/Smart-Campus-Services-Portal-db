CREATE PROCEDURE [edu].[GetCourseSubjectsById]
    @stakeholderId	INT = NULL
AS
SET NOCOUNT ON;
SELECT 
	[SS].SubjectId,
    [SS].SubjectCode,
    [SS].SubjectName,
    [CS].IsMandatory
FROM [edu].Course [C]
INNER JOIN [sh].Stakeholder [S] ON [S].StakeholderId = [C].StakeholderId
INNER JOIN [edu].CourseSubject [CS] ON [C].StakeholderId = [CS].CourseId
INNER JOIN [edu].Subject [SS] ON [CS].SubjectId = [SS].SubjectId
WHERE (@stakeholderId IS NULL OR [S].StakeholderId = @stakeholderId)
AND  [S].IsDeleted = 0