CREATE TABLE [svc].[MaintenanceIssue] (
    [IssueId]           INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [StakeholderId]     INT NOT NULL, 
    [Title]             NVARCHAR(255) NOT NULL,
    [Description]       NVARCHAR(MAX) NULL,
    [StatusId]          INT NOT NULL,
    [DateReported]      DATETIME NOT NULL,
    [DateResolved]      DATETIME NULL,
    CONSTRAINT [FK_MaintenanceIssue_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_MaintenanceIssue_Status] FOREIGN KEY ([StatusId]) REFERENCES [svc].[Status] ([StatusId])
);
