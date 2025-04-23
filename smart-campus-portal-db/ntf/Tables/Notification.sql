CREATE TABLE [ntf].[Notification] (
    [NotificationId]             INT IDENTITY (1, 1) NOT NULL,
    [SubjectId]                  INT,
    [Message]                    NVARCHAR(MAX) NULL,
    [DateCreated]                DATETIME NOT NULL,
    [DateUpdated]                DATETIME       NULL,
    CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED ([NotificationId] ASC),
    CONSTRAINT [FK_Notification_SubjectId] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId])
);