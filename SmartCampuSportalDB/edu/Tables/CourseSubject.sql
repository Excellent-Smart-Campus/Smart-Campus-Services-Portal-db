CREATE TABLE [edu].[CourseSubject] (
    [CourseId]      INT NOT NULL,
    [SubjectId]     INT NOT NULL,
    [IsMandatory]   BIT NOT NULL DEFAULT 1,
    CONSTRAINT [PK_CourseSubject] PRIMARY KEY CLUSTERED ([CourseId], [SubjectId]),
    CONSTRAINT [FK_CourseSubject_Course] FOREIGN KEY ([CourseId]) REFERENCES [edu].[Course] ([StakeholderId]),
    CONSTRAINT [FK_CourseSubject_Subject] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId])
);