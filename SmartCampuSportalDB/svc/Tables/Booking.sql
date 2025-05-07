CREATE TABLE [svc].[Booking] (
    [BookingId]         INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [StakeholderId]     INT NOT NULL,
    [LecturerId]        INT NULL,
    [RoomId]            INT NULL,
    [Purpose]           VARCHAR(MAX) NULL,
    [BookingDate]       DATETIME NOT NULL,
    [StartTime]         TIME NULL,
    [EndTime]           TIME NULL,
    [StatusId]          INT NOT NULL,
    [DateCreated]       DATETIME NOT NULL,
    [DateUpdated]       DATETIME NULL,
    CONSTRAINT [FK_Booking_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Booking_Lecturer] FOREIGN KEY ([LecturerId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Booking_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId]),
    CONSTRAINT [FK_Booking_Status] FOREIGN KEY ([StatusId]) REFERENCES [svc].[Status] ([StatusId])
);