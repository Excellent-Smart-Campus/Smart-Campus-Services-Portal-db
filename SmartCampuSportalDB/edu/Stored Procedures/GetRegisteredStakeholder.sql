CREATE PROCEDURE [edu].[GetRegisteredStakeholder]
    @stakeholderType    INT
AS
SET NOCOUNT ON;
SELECT
    SH.StakeholderId,
    SHP.FirstName,
    SHP.LastName,
    SHP.TitleId,
    RM.ModuleCount,
    C.StakeholderId 'CourseId', 
    C.CourseCode,
    C.CourseName
FROM sh.Stakeholder SH 
INNER JOIN sh.StakeholderPerson SHP ON SHP.StakeholderId = SH.StakeholderId AND SH.StakeholderTypeId = @stakeholderType
INNER JOIN sh.StakeholderRelationship SHR ON SHR.StakeholderId = SH.StakeholderId
INNER JOIN edu.Course C ON C.StakeholderId = SHR.RelatedStakeholderId
OUTER APPLY(
    SELECT COUNT(SS.SubjectId) 'ModuleCount'
    FROM edu.StakeholderSubject SS
    WHERE SS.StakeholderId = SH.StakeholderId
    AND SS.IsDeleted = 0
) RM
WHERE SH.IsDeleted = 0
AND RM.ModuleCount > 0
GROUP BY 
    SH.StakeholderId,
    SHP.FirstName,
    SHP.LastName,
    SHP.TitleId,
    C.StakeholderId,
    C.CourseCode,
    C.CourseName,
    RM.ModuleCount;








