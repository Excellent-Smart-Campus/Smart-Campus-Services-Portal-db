CREATE PROCEDURE [edu].[GetSubjectById]
    @subjectId	INT = NULL
AS
SET NOCOUNT ON;

SELECT 
    [S].SubjectId,
	[S].SubjectCode,
	[S].SubjectName
FROM [edu].Subject [S]
WHERE (@subjectId IS NULL OR [S].SubjectId = @subjectId)