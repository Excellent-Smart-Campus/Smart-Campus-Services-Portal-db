CREATE PROCEDURE [ntf].[MarkNotificationAsRead]
    @stakeholderId INT,
    @notificationId INT
AS
SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM [ntf].[NotificationView] WHERE StakeholderId = @stakeholderId AND NotificationId = @notificationId AND IsRead = 0
    BEGIN
        UPDATE [ntf].[NotificationView]
        SET IsRead = 1
        WHERE StakeholderId = @stakeholderId
        AND NotificationId = @notificationId;
    END
    
SELECT 
    NotificationId,
    StakeholderId,
    IsRead,
    DateCreated,
    DateUpdated
FROM [ntf].[Notification] 
WHERE NotificationId = @notificationId;