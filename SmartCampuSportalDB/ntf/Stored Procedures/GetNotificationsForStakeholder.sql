CREATE PROCEDURE [ntf].[GetNotificationsForStakeholder]
    @stakeholderId INT
AS
SET NOCOUNT ON;
BEGIN
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
    WHERE NV.StakeholderId = @stakeholderId
    ORDER BY N.DateCreated DESC;
END;