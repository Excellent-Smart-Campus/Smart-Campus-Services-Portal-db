CREATE PROCEDURE [edu].[GetRegisteredSubjectLecturers]
	@@subjectId	INT = NULL
AS
SET NOCOUNT ON;

SELECT
    SS.StakeholderId 'Lecturer',
    SH.Name 
FROM [edu].StakeholderSubject SS
INNER JOIN edu.Subject S ON S.SubjectId = SS.SubjectId
CROSS APPLY (
    SELECT C.StakeholderId 'CourseId'
    FROM sh.StakeholderRelationship R 
    INNER JOIN edu.Course C ON C.StakeholderId = R.RelatedStakeholderId
    WHERE R.StakeholderId = SS.StakeholderId
    AND R.EndDate IS NULL
) AS RC
INNER JOIN edu.CourseSubject CS ON CS.SubjectId = S.SubjectId AND CS.CourseId = RC.CourseId
INNER JOIN sh.Stakeholder SH ON SH.StakeholderId = SS.StakeholderId AND SH.StakeholderTypeId = 2
WHERE S.SubjectId = @subjectId;
