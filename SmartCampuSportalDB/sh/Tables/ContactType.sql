CREATE TABLE [sh].[ContactType] (
    [ContactTypeId] INT           NOT NULL,
    [Description]   NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED ([ContactTypeId] ASC)
);
