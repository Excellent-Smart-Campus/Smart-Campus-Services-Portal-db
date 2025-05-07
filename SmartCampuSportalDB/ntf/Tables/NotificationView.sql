CREATE TABLE [ntf].[NotificationView] (
    [NotificationId]            INT NOT NULL,
    [StakeholderId]             INT NOT NULL,
    [isRead]                    BIT NULL DEFAULT 0,
    [DateCreated]               DATETIME,
    [DateUpdated]               DATETIME NULL,
    CONSTRAINT [PK_NotificationView] PRIMARY KEY CLUSTERED ([StakeholderId] ASC, [NotificationId] ASC),
    CONSTRAINT [FK_NotificationView_Notification] FOREIGN KEY ([NotificationId]) REFERENCES [ntf].[Notification] ([NotificationId]),
    CONSTRAINT [FK_NotificationView_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].Stakeholder ([StakeholderId])
);