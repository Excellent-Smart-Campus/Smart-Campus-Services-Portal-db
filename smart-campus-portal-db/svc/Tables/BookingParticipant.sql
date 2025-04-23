CREATE TABLE [svc].[BookingParticipant] (
    [BookingId]            INT NOT NULL,
    [StakeholderId]        INT NOT NULL,
    [JoinedAt]             DATETIME NOT NULL,
    CONSTRAINT [PK_BookingParticipant] PRIMARY KEY CLUSTERED ([BookingId] ASC, [StakeholderId] ASC),
    CONSTRAINT [FK_BookingParticipant_Booking] FOREIGN KEY ([BookingId]) REFERENCES [svc].[Booking] ([BookingId]),
    CONSTRAINT [FK_BookingParticipant_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].Stakeholder ([StakeholderId])
);