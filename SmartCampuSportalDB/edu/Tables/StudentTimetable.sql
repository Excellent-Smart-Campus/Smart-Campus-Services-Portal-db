CREATE TABLE [edu].[StudentTimetable] (
    [StudentTimetableId]    INT IDENTITY(1,1) NOT NULL,
    [StakeholderId]         INT NOT NULL,
    [SubjectId]             INT NOT NULL,
    [DayOfWeekTypeId]       INT NOT NULL,
    [RoomId]                INT NOT NULL,
    [StartTime]             TIME NOT NULL,
    [EndTime]               TIME,
    [Location]              NVARCHAR(255) NULL,
    CONSTRAINT [PK_StudentTimetable] PRIMARY KEY CLUSTERED ([StudentTimetableId] ASC),
    CONSTRAINT [FK_StudentTimetable_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StudentTimetable_Subject] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_StudentTimetable_DayOfWeekType] FOREIGN KEY ([DayOfWeekTypeId]) REFERENCES [edu].[DayOfWeekType] ([DayOfWeekTypeId]),
    CONSTRAINT [FK_StudentTimetable_Room] FOREIGN KEY ([RoomId]) REFERENCES [svc].[Room] ([RoomId])
);
