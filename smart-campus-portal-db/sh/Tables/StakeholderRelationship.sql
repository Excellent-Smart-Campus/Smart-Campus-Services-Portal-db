CREATE TABLE [sh].[StakeholderRelationship]
(
	[StakeholderId]                 INT  NOT NULL,
    [RelatedStakeholderId]          INT  NOT NULL,
    [StakeholderRelationshipTypeId] INT  NOT NULL,
    [EffectiveDate]                 DATE NOT NULL,
    [EndDate]                       DATE NULL,
    CONSTRAINT [PK_StakeholderRelationship] PRIMARY KEY CLUSTERED ([StakeholderId] ASC, [RelatedStakeholderId] ASC, [StakeholderRelationshipTypeId] ASC),
    CONSTRAINT [FK_StakeholderRelationship_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderRelationship_StakeholderRelated] FOREIGN KEY ([RelatedStakeholderId]) REFERENCES [sh].[Stakeholder] ([StakeholderId]),
    CONSTRAINT [FK_StakeholderRelationship_StakeholderRelationshipType] FOREIGN KEY ([StakeholderRelationshipTypeId]) REFERENCES [sh].[StakeholderRelationshipType] ([StakeholderRelationshipTypeId])
)
