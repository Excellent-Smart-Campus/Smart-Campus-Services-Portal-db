CREATE TABLE [ntf].[NotificationType] (
    [NotificationTypeId]        INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_NotificationType] PRIMARY KEY CLUSTERED ([NotificationTypeId] ASC)
);