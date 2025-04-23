CREATE PROCEDURE [usr].[GetGroupAction]
	@groupId	INT
AS
SET NOCOUNT ON;

SELECT
	[G].GroupId,
	[G].ActionId,
	[A].Description 'Action'
FROM usr.[GroupAction] [G] 
INNER JOIN usr.[Action] [A] ON [G].ActionId = [A].ActionId
WHERE GroupId = @groupId