CREATE TABLE [edu].[Timetable] (
    [TimetableId]    INT IDENTITY(1,1) NOT NULL,
    [StakeholderId]         INT NOT NULL,
    [SubjectId]             INT NOT NULL,
    [DayOfWeekTypeId]       INT NOT NULL,
    [RoomId]                INT NOT NULL,
    [StartTime]             TIME NOT NULL,
    [EndTime]               TIME,
    [Location]              NVARCHAR(255) NULL,
    CONSTRAINT [PK_Timetable] PRIMARY KEY CLUSTERED ([TimetableId] ASC),
    CONSTRAINT [FK_Timetable_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_Timetable_Subject] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_Timetable_DayOfWeekType] FOREIGN KEY ([DayOfWeekTypeId]) REFERENCES [edu].[DayOfWeekType] ([DayOfWeekTypeId]),
    CONSTRAINT [FK_Timetable_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId])
);

