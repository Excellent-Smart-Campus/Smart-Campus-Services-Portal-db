CREATE PROCEDURE [usr].[DeleteGroup]
	@groupId		INT,
	@stakeholderId	INT
AS
SET NOCOUNT ON;

BEGIN TRY
 
	BEGIN TRANSACTION

	UPDATE usr.[Group] 
	SET	   IsDeleted = 1
	WHERE GroupId = @groupId

	INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate) VALUES (35, @groupId, @stakeholderId, GETDATE())
 
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
	Description,
	IsDeleted
FROM usr.[Group] 
WHERE GroupId = @groupId