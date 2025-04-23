CREATE TABLE [edu].[StudentSubject] (
    [SubjectId]             INT NOT NULL,
	[StakeholderId]         INT NOT NULL,
	CONSTRAINT [PK_StudentSubject] PRIMARY KEY CLUSTERED ([SubjectId] ASC, [StakeholderId] ASC),
    CONSTRAINT [FK_StudentSubject_SubjectId] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_StudentSubject_StakeholderId] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId])
);