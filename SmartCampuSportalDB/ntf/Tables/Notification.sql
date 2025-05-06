CREATE TABLE [ntf].[Notification] (
    [NotificationId]             INT IDENTITY (1, 1) NOT NULL,
    [SenderId]                   INT NOT NULL,
    [NotificationTypeId]         INT NOT NULL
    [SubjectId]                  INT NULL,
    [Message]                    NVARCHAR(MAX) NULL,
    [ReferenceId]                INT NULL
    [DateCreated]                DATETIME NOT NULL,
    [DateUpdated]                DATETIME NULL,
    CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED ([NotificationId] ASC),
    CONSTRAINT [FK_Notification_SubjectId] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_Notification_Sender] FOREIGN KEY ([SenderId]) REFERENCES [sh].[Stakeholder]([StakeholderId]),
    CONSTRAINT [FK_Notification_NotificationType] FOREIGN KEY ([NotificationTypeId]) REFERENCES [ntf].[NotificationType] ([NotificationTypeId])
);