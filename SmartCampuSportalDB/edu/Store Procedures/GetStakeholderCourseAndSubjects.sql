CREATE PROCEDURE [edu].[GetStakeholderCourseAndSubjects]
    @stakeholderId INT,
    @stakeholderRelationshipTypeId INT
AS
SET NOCOUNT ON;
SELECT
    C.StakeholderId AS 'CourseId',
    C.CourseCode,
    C.CourseName,
    Sh.StakeholderTypeId,
    ST.[Description] AS 'StakholderType',
    S.SubjectId,
    S.SubjectCode,
    S.SubjectName,
    CS.IsMandatory
FROM [edu].Course C
CROSS APPLY (
    SELECT 1  AS RegisteredCheck
    FROM sh.StakeholderRelationship 
    WHERE StakeholderId = @stakeholderId 
    AND StakeholderRelationshipTypeId = @stakeholderRelationshipTypeId
    AND RelatedStakeholderId = C.StakeholderId
    AND EndDate IS NULL
) AS RegisteredCheck
INNER JOIN [edu].CourseSubject CS ON C.StakeholderId = CS.CourseId
INNER JOIN [edu].[Subject] S ON CS.SubjectId = S.SubjectId
INNER JOIN [edu].[StakeholderSubject] SS ON S.SubjectId = SS.SubjectId AND SS.StakeholderId = @stakeholderId
INNER JOIN [sh].Stakeholder SH ON SH.StakeholderId = @stakeholderId
INNER JOIN [sh].StakeholderType ST ON SH.StakeholderTypeId = ST.StakeholderTypeId
