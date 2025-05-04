CREATE TABLE [edu].[Subject] (
    [SubjectId]             INT IDENTITY (1, 1) NOT NULL,
    [SubjectCode]           NVARCHAR (255) NOT NULL,
    [SubjectName]           NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED ([SubjectId] ASC)
);