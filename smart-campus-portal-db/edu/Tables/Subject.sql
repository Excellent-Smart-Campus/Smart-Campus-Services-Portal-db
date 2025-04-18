CREATE TABLE [edu].[Subject] (
    [SubjectId]             INT IDENTITY (1, 1) NOT NULL,
    [Name]                  NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED ([SubjectId] ASC)
);