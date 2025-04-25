CREATE PROCEDURE [edu].[GetCourseById]
    @stakeholderId	INT = NULL
AS
SET NOCOUNT ON;

SELECT 
    [C].StakeholderId,
	[C].CourseCode,
	[C].CourseName
FROM [edu].Course [C]
INNER JOIN [sh].Stakeholder [S] ON [S].StakeholderId = [C].StakeholderId
WHERE (@stakeholderId IS NULL OR [S].StakeholderId = @stakeholderId)