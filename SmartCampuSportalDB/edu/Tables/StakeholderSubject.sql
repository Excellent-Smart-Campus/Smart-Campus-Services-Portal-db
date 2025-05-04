CREATE TABLE [edu].[StakeholderSubject] (
    [SubjectId]             INT NOT NULL,
	[StakeholderId]         INT NOT NULL,
	[StakeholderTypeId]     INT NULL,
	[IsDeleted]             BIT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_StakeholderSubject] PRIMARY KEY CLUSTERED ([SubjectId] ASC, [StakeholderId] ASC),
    CONSTRAINT [FK_StakeholderSubject_SubjectId] FOREIGN KEY ([SubjectId]) REFERENCES [edu].[Subject] ([SubjectId]),
    CONSTRAINT [FK_StakeholderSubject_StakeholderId] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderSubject_StakeholderTypeId] FOREIGN KEY ([StakeholderTypeId]) REFERENCES [sh].[StakeholderType] ([StakeholderTypeId])
);