CREATE PROCEDURE [ntf].[MarkNotificationAsRead]
    @stakeholderId INT
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @UpdatedRows INT;

    UPDATE [ntf].[NotificationView]
    SET IsRead = 1
    WHERE StakeholderId = @stakeholderId
      AND IsRead = 0;

    SET @UpdatedRows = @@ROWCOUNT;

    SELECT CAST(IIF(@UpdatedRows > 0, 1, 0) AS BIT) AS Success;
END