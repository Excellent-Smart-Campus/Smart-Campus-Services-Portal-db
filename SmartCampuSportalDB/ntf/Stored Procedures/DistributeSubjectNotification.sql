CREATE PROCEDURE [ntf].[DistributeSubjectNotification]
    @senderId	        INT,
    @message            VARCHAR(MAX),
    @subjectId	        INT

AS
SET NOCOUNT ON;

BEGIN TRY
    BEGIN TRANSACTION;
        INSERT INTO [ntf].[Notification] (SenderId, NotificationTypeId, SubjectId, Message, DateCreated)
        VALUES (@senderId, 5, @subjectId, @message, GETDATE());
                
        DECLARE @notificationId INT = SCOPE_IDENTITY();
                
        INSERT INTO [ntf].[NotificationView] (NotificationId, StakeholderId, IsRead, DateCreated)
        SELECT 
            @notificationId,
            S.StakeholderId,
            0,
             GETDATE()
        FROM edu.[StakeholderSubject] S
        WHERE SubjectId = @subjectId;
        
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