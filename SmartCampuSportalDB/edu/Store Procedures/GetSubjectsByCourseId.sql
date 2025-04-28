CREATE PROCEDURE [edu].[GetSubjectsByCourseId]
    @courseId	INT
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
WHERE [S].StakeholderId = @courseId
AND  [S].IsDeleted = 0