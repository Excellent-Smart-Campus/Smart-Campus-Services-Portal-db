CREATE PROCEDURE [usr].[GetUser]
    @stakeholder INT 
AS
SET NOCOUNT ON;
select 
    S.StakeholderId,
    SP.FirstName,
    SP.LastName,
    SP.TitleId,
    S.IsDeleted,
    SC.ContactId,
    SC.ContactTypeId,
    SC.Detail,
    C.StakeholderId 'CourseId',
    C.CourseCode,
    C.CourseName,
    SB.SubjectId,
    SB.SubjectCode,
    SB.SubjectName
FROM sh.Stakeholder S
INNER JOIN sh.StakeholderPerson SP ON SP.StakeholderId = S.StakeholderId
INNER JOIN sh.Contact SC ON S.StakeholderId = SC.StakeholderId
LEFT JOIN sh.StakeholderRelationship SHR ON SHR.StakeholderId = S.StakeholderId
LEFT JOIN edu.Course C ON C.StakeholderId = SHR.RelatedStakeholderId 
LEFT JOIN edu.CourseSubject CSB ON CSB.CourseId = C.StakeholderId
LEFT JOIN edu.Subject SB ON SB.SubjectId = CSB.SubjectId
WHERE S.StakeholderId = @stakeholder;