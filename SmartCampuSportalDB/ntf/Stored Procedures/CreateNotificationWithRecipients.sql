CREATE PROCEDURE [ntf].[CreateNotificationWithRecipients]
    @senderId	        INT,
    @notificationTypeId	INT,
    @message            VARCHAR(MAX),
    @subjectId	        INT = NULL,
    @referenceId	    INT = NULL,
    @recipientIds       INT
AS
SET NOCOUNT ON;
BEGIN TRY
    BEGIN TRANSACTION;
            INSERT INTO [ntf].[Notification] (SenderId, NotificationTypeId, SubjectId, Message, ReferenceId, DateCreated)
            VALUES (@senderId, @notificationTypeId, @subjectId, @message, @referenceId, GETDATE());
                
            DECLARE @notificationId INT = SCOPE_IDENTITY();
                
            INSERT INTO [ntf].[NotificationView] (NotificationId, StakeholderId, IsRead, DateCreated)
            VALUES(@notificationId, @recipientIds, 0, GETDATE())
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
   ,[N].Description
   ,[N].[SubjectId]
   ,[N].[Message]
   ,[N].[ReferenceId]
   ,[N].[DateCreated]
FROM [ntf].Notification [N]
INNER JOIN [ntf].NotificationType [NT] ON [N].NotificationTypeId = [NT].NotificationTypeId
WHERE [N].NotificationId = @notificationId