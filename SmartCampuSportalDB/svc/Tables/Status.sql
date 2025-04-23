CREATE TABLE [svc].[Status] (
    [StatusId]          INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED ([StatusId] ASC)
);