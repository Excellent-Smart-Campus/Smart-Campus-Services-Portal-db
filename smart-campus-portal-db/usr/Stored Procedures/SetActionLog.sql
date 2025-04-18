CREATE PROCEDURE [usr].[SetActionLog]
	@actionId		int,
	@groupId		int,
	@stakeholderId	int,
	@description	NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
		INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate, Description)
		VALUES (@actionId, @groupId, @stakeholderId, GETDATE(), @description)

		SELECT 1 AS Result;
	END TRY
    
	BEGIN CATCH
		DECLARE @errorMessage NVARCHAR(MAX), @errorSeverity INT, @errorState INT;
		SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + CAST(ERROR_LINE() AS NVARCHAR(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();
		RAISERROR(@errorMessage, @errorSeverity, @errorState);
    END CATCH
END;