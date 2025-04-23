CREATE TABLE [sh].[StakeholderType] (
    [StakeholderTypeId] INT           NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_StakeholderType] PRIMARY KEY CLUSTERED ([StakeholderTypeId] ASC)
);