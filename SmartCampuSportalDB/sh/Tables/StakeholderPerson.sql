CREATE TABLE [sh].[StakeholderPerson] (
    [StakeholderId]	        BIGINT NOT NULL PRIMARY KEY,
    [TitleId]               INT NULL,
    [FirstName]             NVARCHAR (255) NOT NULL,
    [LastName]              NVARCHAR (255) NOT NULL
    CONSTRAINT [FK_StakeholderPerson_Stakeholder] FOREIGN KEY ([StakeholderTypeId]) REFERENCES [sh].[StakeholderType] ([StakeholderTypeId]),
    CONSTRAINT [FK_StakeholderPerson_Title] FOREIGN KEY ([TitleId]) REFERENCES [sh].[Title] ([TitleId])
);