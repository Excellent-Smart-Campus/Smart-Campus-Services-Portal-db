CREATE PROCEDURE [svc].[GetStakeholderMaintenanceRequest]
	@stakeholderId	INT = NULL,
	@statudId NVARCHAR(32) = NULL
AS
SET NOCOUNT ON;

SELECT [IssueId]
      ,[StakeholderId]
      ,[Title]
      ,[RoomId]
      ,[Description]
      ,[StatusId]
      ,[DateReported]
      ,[DateResolved]
FROM [svc].[MaintenanceIssue]
INNER JOIN svc.[Status] S ON M.StatusId = S.StatusId
WHERE (@stakeholderId IS NULL OR StakeholderId = @stakeholderId)
AND (@statudId IS NULL OR S.StatusId IN (SELECT value FROM STRING_SPLIT(@statudId, ',')))
AND M.StatusId NOT IN (1,2,3,6)