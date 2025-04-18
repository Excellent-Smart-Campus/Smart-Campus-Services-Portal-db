CREATE TABLE [edu].[DayOfWeekType] (
    [DayOfWeekTypeId]   INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_DayOfWeekType] PRIMARY KEY CLUSTERED ([DayOfWeekTypeId] ASC)
);