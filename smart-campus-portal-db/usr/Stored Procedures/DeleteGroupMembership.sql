CREATE PROCEDURE [usr].[DeleteGroupMembership]
	@groupId		INT,
	@groupMemberId	INT,
	@stakeholderId	INT
AS

SET NOCOUNT ON;

BEGIN TRY
	BEGIN TRANSACTION
		DELETE [usr].GroupMember
		WHERE  GroupId = @groupId AND StakeholderId = @groupMemberId
 
		INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate, [Description]) 
		VALUES (38, @groupId, @stakeholderId, GETDATE(), 'delete Group Member: ' + CAST(@groupId AS NVARCHAR(5)))
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
	StakeholderId
FROM usr.[GroupMember] 
WHERE GroupId = @groupId 