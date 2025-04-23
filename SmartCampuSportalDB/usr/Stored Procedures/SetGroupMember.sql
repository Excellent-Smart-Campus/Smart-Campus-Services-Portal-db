CREATE PROCEDURE [usr].[SetGroupMember]
    @groupId        INT,
    @userId         INT,
    @stakeholderId  INT
AS
SET NOCOUNT ON;

BEGIN TRY
 
    BEGIN TRANSACTION
    IF NOT EXISTS(SELECT GroupId FROM usr.[GroupMember] WHERE GroupId = @groupId AND StakeholderId = @userId)
    BEGIN
        INSERT INTO usr.[GroupMember] (GroupId, StakeholderId) VALUES (@groupId, @userId)

        INSERT INTO usr.ActionLog (ActionId, KeyId, StakeholderId, ActionDate) 
        VALUES (5, @groupId, @stakeholderId, GETDATE())
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
	[GM].GroupId,
	[G].Description,
	[GM].StakeholderId,
	[U].Username,
	[S].FirstName,
	[S].LastName,
	[S].TitleId
FROM usr.[GroupMember] [GM]
INNER JOIN usr.[Group] [G] ON [G].GroupId = [GM].GroupId
INNER JOIN [usr].[User] [U] ON [U].StakeholderId = [GM].StakeholderId
INNER JOIN sh.[Stakeholder] [S] ON [S].StakeholderId = [GM].StakeholderId
WHERE [GM].GroupId = @groupId 