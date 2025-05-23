CREATE TABLE [sh].[Stakeholder] (
    [StakeholderId]         INT IDENTITY (1, 1) NOT NULL,
    [StakeholderTypeId]     INT  NOT NULL,
    [Name]                  NVARCHAR (255) NOT NULL,
    [IsDeleted]             BIT NULL DEFAULT 0, 
    [DateCreated]           DATETIME NOT NULL,
    [DateUpdated]           DATETIME NULL,
    CONSTRAINT [PK_Stakeholder] PRIMARY KEY CLUSTERED ([StakeholderId] ASC),
    CONSTRAINT [FK_Stakeholder_StakeholderType] FOREIGN KEY ([StakeholderTypeId]) REFERENCES [sh].[StakeholderType] ([StakeholderTypeId])
);