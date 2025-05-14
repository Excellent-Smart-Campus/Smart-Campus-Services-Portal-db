CREATE PROCEDURE [ntf].[MarkNotificationAsRead]
    @stakeholderId INT,
    @notificationId INT
AS
BEGIN
SET NOCOUNT ON;
    IF EXISTS (SELECT 1 
        FROM [ntf].[NotificationView] 
        WHERE StakeholderId = @stakeholderId 
        AND NotificationId = @notificationId 
        AND IsRead = 0
    )

    BEGIN
        UPDATE [ntf].[NotificationView]
        SET IsRead = 1
        WHERE StakeholderId = @stakeholderId
        AND NotificationId = @notificationId;
    END
    
    SELECT 
        N.NotificationId,
        N.SenderId,
        SH.Name,
        N.NotificationTypeId,
        N.SubjectId 'RelatedSubject',
        N.Message,
        NV.IsRead,
        N.DateCreated,
        N.DateUpdated,
        S.SubjectId,
        S.SubjectCode,
        S.SubjectName
    FROM [ntf].NotificationView NV
    INNER JOIN [ntf].Notification N ON NV.NotificationId = n.NotificationId
    INNER JOIN [sh].Stakeholder SH ON N.SenderId = SH.StakeholderId
    LEFT JOIN [edu].Subject S ON  N.SubjectId = S.SubjectId
    WHERE NV.NotificationId = @notificationId
    AND NV.StakeholderId = @stakeholderId
END