CREATE TABLE [sh].[Title] (
    [TitleId]           INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_Title] PRIMARY KEY CLUSTERED ([TitleId] ASC)
);