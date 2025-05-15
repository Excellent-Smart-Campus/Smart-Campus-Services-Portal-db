CREATE PROCEDURE [ntf].[CreateNotificationWithRecipients]
     @senderId	        INT,
    @notificationTypeId	INT,
    @message            VARCHAR(MAX),
    @subjectId	        INT = NULL,
    @referenceId	    INT = NULL,
    @recipientIds       NVARCHAR(MAX)
AS
SET NOCOUNT ON;
BEGIN TRY
    BEGIN TRANSACTION;
            INSERT INTO [ntf].[Notification] (SenderId, NotificationTypeId, SubjectId, Message, ReferenceId, DateCreated)
            VALUES (@senderId, @notificationTypeId, @subjectId, @message, @referenceId, GETDATE());
                
            DECLARE @notificationId INT = SCOPE_IDENTITY();
            
            DECLARE @xml XML = CAST('<i>' + REPLACE(@RecipientIds, ',', '</i><i>') + '</i>' AS XML);

            INSERT INTO [ntf].[NotificationView] (NotificationId, StakeholderId, IsRead, DateCreated)
            SELECT
                @notificationId,
                T.value('.', 'INT'),
                0,
                GETDATE()
            FROM @xml.nodes('/i') AS X(T);
    COMMIT TRANSACTION;
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
    [N].[NotificationId]
   ,[N].[SenderId]
   ,[N].[NotificationTypeId]
   ,[NT].Description
   ,[N].[SubjectId]
   ,[N].[Message]
   ,[N].[ReferenceId]
   ,[N].[DateCreated]
FROM [ntf].Notification [N]
INNER JOIN [ntf].NotificationType [NT] ON [N].NotificationTypeId = [NT].NotificationTypeId
WHERE [N].NotificationId = @notificationId