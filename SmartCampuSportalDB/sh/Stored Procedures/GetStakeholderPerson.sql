CREATE PROCEDURE [sh].[GetStakeholderPerson]
	@stakeholderId	INT = NULL
AS
SET NOCOUNT ON;

SELECT 
	[SHP].StakeholderId,
	[SHP].FirstName,
    [SHP].LastName,
    [SHP].TitleId
FROM [sh].StakeholderPerson [SHP]
LEFT JOIN [sh].Title [T] ON [SHP].TitleId = [T].TitleId 
INNER JOIN [sh].Stakeholder [SH] ON [SHP].StakeholderId = [SH].StakeholderId
WHERE [SHP].StakeholderId = @stakeholderId
AND SH.IsDeleted = 0