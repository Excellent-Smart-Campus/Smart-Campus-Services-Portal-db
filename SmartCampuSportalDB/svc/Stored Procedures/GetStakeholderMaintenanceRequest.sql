CREATE PROCEDURE [svc].[GetStakeholderMaintenanceRequest]
	@stakeholderId	INT = NULL,
	@statudId NVARCHAR(32) = NULL
AS
SET NOCOUNT ON;

SELECT M.[IssueId]
      ,M.[StakeholderId]
      ,M.[Title]
      ,M.[RoomId]
      ,M.[Description]
      ,M.[StatusId]
      ,M.[DateReported]
      ,M.[DateResolved]
FROM [svc].[MaintenanceIssue] M
INNER JOIN svc.[Status] S ON M.StatusId = S.StatusId
WHERE (@stakeholderId IS NULL OR StakeholderId = @stakeholderId)
AND (@statudId IS NULL OR S.StatusId IN (SELECT value FROM STRING_SPLIT(@statudId, ',')))
AND M.StatusId NOT IN (1,2,3)
ORDER BY DateReported DESC