CREATE PROCEDURE [usr].[SetGroup]
	@groupId		INT = NULL,
	@description	NVARCHAR(255),
	@stakeholderId	INT
AS
SET NOCOUNT ON;

BEGIN TRY
 
	BEGIN TRANSACTION

	IF @groupId IS NULL
	BEGIN
		INSERT INTO usr.[Group] (Description, IsDeleted) VALUES (@description, 0)
		SELECT @groupId = SCOPE_IDENTITY()

		INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate, Description) VALUES (37, @groupId, @stakeholderId, GETDATE(), @description)
	END
	ELSE
	BEGIN
	 
		UPDATE usr.[Group] 
		SET	   Description = @description
		WHERE GroupId = @groupId

		INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate, Description) VALUES (33, @groupId, @stakeholderId, GETDATE(), @description)
 
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
	Description,
	IsDeleted
FROM usr.[Group] 
WHERE GroupId = @groupId