CREATE PROCEDURE [sh].[GetStakeholderContact]
	@stakeholderId INT = NULL,
	@email		NVARCHAR(255) = NULL,
	@contactTypeId INT = NULL
AS
SELECT
	[S].StakeholderId,
	[C].ContactId,
    [C].[ContactTypeId],
    [C].[Detail],
    [C].[AreaCode]
FROM sh.Contact [C]
INNER JOIN sh.Stakeholder [S] ON [C].StakeholderId = [S].StakeholderId AND ISNULL([S].IsDeleted, 0) = 0
WHERE ( @email IS NOT NULL AND C.Detail = @email AND (@contactTypeId IS NULL OR C.ContactTypeId = @contactTypeId))
OR ( @email IS NULL AND @stakeholderId IS NOT NULL AND S.StakeholderId = @stakeholderId)
ORDER BY  [C].ContactId DESC;