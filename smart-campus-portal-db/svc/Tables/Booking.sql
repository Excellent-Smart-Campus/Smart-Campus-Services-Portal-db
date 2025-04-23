CREATE TABLE [svc].[Booking] (
    [BookingId]         INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [StakeholderId]     INT NOT NULL,
    [RoomId]            INT NOT NULL,
    [Purpose]           VARCHAR(MAX) NULL,
    [BookingDate]       DATETIME NOT NULL,
    [StartTime]         DATETIME NOT NULL,
    [EndTime]           DATETIME NOT NULL,
    [StatusId]          INT NOT NULL,
    [DateCreated]       DATETIME NOT NULL,
    [DateUpdated]       DATETIME       NULL,
    CONSTRAINT [FK_Booking_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Booking_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId]),
    CONSTRAINT [FK_Booking_Status] FOREIGN KEY ([StatusId]) REFERENCES [svc].[Status] ([StatusId])
);