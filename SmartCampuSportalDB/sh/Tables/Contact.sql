CREATE TABLE [sh].[Contact] (
    [ContactId]     INT            IDENTITY (1, 1) NOT NULL,
    [StakeholderId] INT            NOT NULL,
    [ContactTypeId] INT            NOT NULL,
    [Detail]        NVARCHAR (255) NOT NULL,
    [AreaCode]      NVARCHAR (32)  NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([ContactId] ASC),
    CONSTRAINT [FK_Contact_ContactType] FOREIGN KEY ([ContactTypeId]) REFERENCES [sh].[ContactType] ([ContactTypeId]),
    CONSTRAINT [FK_Contact_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
);
