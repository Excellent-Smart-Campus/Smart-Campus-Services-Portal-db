CREATE PROCEDURE [sh].[GetStakeholder]
	@stakeholderId	INT = NULL,
	@stakeholderTypeId INT = NULL
AS
SET NOCOUNT ON;

SELECT 
	[SH].StakeholderId,
	[SH].StakeholderTypeId,
	[SH].FirstName,
    [SH].LastName,
    [SH].TitleId
FROM [sh].Stakeholder [SH]
INNER JOIN [sh].Title [T] ON [SH].TitleId = [T].TitleId 
WHERE (@stakeholderId IS NULL OR [SH].StakeholderId = @stakeholderId) AND (@stakeholderTypeId IS NULL OR [SH].StakeholderTypeId = @stakeholderTypeId)
AND SH.IsDeleted = 0