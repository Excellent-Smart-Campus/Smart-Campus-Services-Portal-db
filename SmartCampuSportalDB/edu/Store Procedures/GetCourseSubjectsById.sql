CREATE PROCEDURE [edu].[GetCourseSubjectsById]
    @subjectId	INT = NULL
AS
SET NOCOUNT ON;
SELECT 
    [C].StakeholderId AS 'CourseId',
	[C].CourseCode,
	[C].CourseName,
	[SS].SubjectId,
    [SS].SubjectCode,
    [SS].SubjectName,
    [CS].IsMandatory
FROM [edu].Course [C]
INNER JOIN [sh].Stakeholder [S] ON [S].StakeholderId = [C].StakeholderId
INNER JOIN [edu].CourseSubject [CS] ON [C].StakeholderId = [CS].CourseId
INNER JOIN [edu].Subject [SS] ON [CS].SubjectId = [SS].SubjectId
WHERE (@subjectId IS NULL OR [SS].SubjectId = @subjectId)