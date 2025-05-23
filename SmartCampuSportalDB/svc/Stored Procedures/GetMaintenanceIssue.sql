CREATE PROCEDURE [svc].[GetMaintenanceIssue]
	@issueId		  INT,
	@statudId NVARCHAR(32) = NULL
AS
SET NOCOUNT ON;

SELECT 
	[M].IssueId,
	[M].StakeholderId,
	[M].RoomId,
	[M].Title,
    [M].Description,
	[M].StatusId,
    [M].DateReported,
    [M].DateResolved
FROM svc.MaintenanceIssue [M]
INNER JOIN [sh].Stakeholder [S] ON [M].StakeholderId = [S].StakeholderId
INNER JOIN [svc].[Status] [ST] ON [M].[StatusId] = [ST].StatusId
WHERE (@issueId IS NULL OR [M].IssueId = @issueId)
AND (@statudId IS NULL OR ST.StatusId IN (SELECT value FROM STRING_SPLIT(@statudId, ',')))

