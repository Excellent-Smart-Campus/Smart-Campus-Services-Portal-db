CREATE PROCEDURE [usr].[SetGroupAction]
	@groupId		INT,
	@actionId		INT,
	@stakeholderId	INT
AS
SET NOCOUNT ON;

BEGIN TRY
 
	BEGIN TRANSACTION

	IF NOT EXISTS(SELECT GroupId FROM usr.GroupAction WHERE GroupId =@groupId AND ActionId = @actionId)
	BEGIN
		DECLARE @description NVARCHAR(255)
		SELECT @description = Description FROM usr.[Action] WHERE ActionId = @actionId

		INSERT INTO usr.[GroupAction] (GroupId, ActionId) VALUES (@groupId, @actionId)
		INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate, Description) VALUES (36, @groupId, @stakeholderId, GETDATE(), @description)
	END
	
	COMMIT TRANSACTION
END TRY

BEGIN CATCH
    DECLARE @errorMessage nvarchar(max), @errorSeverity int, @errorState int;
    SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();

	IF (@@TRANCOUNT > 0)
	BEGIN
		ROLLBACK TRANSACTION
	END 

    RAISERROR(@errorMessage, @errorSeverity, @errorState);
END CATCH

SELECT
	GroupId,
	[G].ActionId,
	[A].Description 'Action'
FROM usr.[GroupAction]  [G]
INNER JOIN usr.[Action] [A] ON [A].ActionId = [G].ActionId
WHERE GroupId = @groupId AND [g].ActionId = @actionId