CREATE PROCEDURE [usr].[GetGroupMembership]
	@groupId		INT = NULL
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
WHERE [GM].GroupId = @groupId OR @groupId IS NULL
AND [G].IsDeleted = 0 AND [U].IsDeleted =0