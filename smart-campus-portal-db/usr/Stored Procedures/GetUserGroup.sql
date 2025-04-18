CREATE PROCEDURE [usr].[GetUserGroup]
	@stakeholderId		INT
AS
SET NOCOUNT ON;

SELECT
	[GM].GroupId,
	[G].Description,
	[GM].StakeholderId,
	[U].Username,
	[S].Name
FROM usr.[GroupMember] [GM]
INNER JOIN usr.[Group] [G] ON [G].GroupId = [GM].GroupId
INNER JOIN [usr].[User] [U] ON [U].StakeholderId = [GM].StakeholderId
INNER JOIN sh.[Stakeholder] [S] ON [S].StakeholderId = [GM].StakeholderId
WHERE [GM].StakeholderId = @stakeholderId