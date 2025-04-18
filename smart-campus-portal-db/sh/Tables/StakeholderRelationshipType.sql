CREATE TABLE [sh].[StakeholderRelationshipType]
(
	[StakeholderRelationshipTypeId] INT NOT NULL,
    [Description]                   NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_StakeholderRelationshipType] PRIMARY KEY CLUSTERED ([StakeholderRelationshipTypeId] ASC)
)