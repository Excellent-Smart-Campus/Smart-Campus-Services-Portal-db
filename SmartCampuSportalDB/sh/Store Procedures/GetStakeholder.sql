CREATE PROCEDURE [sh].[GetStakeholder]
	@stakeholderId	INT = NULL,
	@stakeholderTypeId INT = NULL
AS
SET NOCOUNT ON;

SELECT 
	[SH].StakeholderId,
	[SH].StakeholderTypeId
FROM [sh].Stakeholder [SH]
WHERE (@stakeholderId IS NULL OR [SH].StakeholderId = @stakeholderId) AND (@stakeholderTypeId IS NULL OR [SH].StakeholderTypeId = @stakeholderTypeId)
AND SH.IsDeleted = 0