CREATE TABLE [edu].[StudentTimetable] (
    [TimetableId]           INT IDENTITY(1,1) NOT NULL,
    [StakeholderId]         INT NOT NULL,
    [SubjectId]             INT NOT NULL,
    [DayOfWeekTypeId]       INT NOT NULL,
    [StartTime]             TIME NOT NULL,
    [EndTime]               TIME,
    [Location]              NVARCHAR(255) NULL,
    CONSTRAINT [PK_StudentTimetable] PRIMARY KEY CLUSTERED ([TimetableId] ASC),
    CONSTRAINT [FK_StudentTimetable_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StudentTimetable_Subject] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId])
    CONSTRAINT [FK_StudentTimetable_DayOfWeekType] FOREIGN KEY ([DayOfWeekTypeId]) REFERENCES [edu].[DayOfWeekType] ([DayOfWeekTypeId])
);
