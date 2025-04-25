CREATE TABLE [edu].[Course] (
    [StakeholderId]        INT NOT NULL,
    [CourseCode]           NVARCHAR (255) NOT NULL,
    [CourseName]           NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED ([StakeholderId] ASC),
    CONSTRAINT [FK_Course_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
);