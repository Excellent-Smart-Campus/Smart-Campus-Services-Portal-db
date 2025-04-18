CREATE PROCEDURE [usr].[GetGroup]
	@groupId	INT = NULL
AS
SET NOCOUNT ON;

SELECT
	GroupId,
	Description,
	IsDeleted
FROM usr.[Group] 
WHERE GroupId = @groupId OR @groupId IS NULL AND IsDeleted = 0