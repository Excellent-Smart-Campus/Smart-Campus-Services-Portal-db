CREATE TABLE [usr].[GroupMember]
(
	[GroupId]		INT NOT NULL,
	[StakeholderId] INT NOT NULL,
	CONSTRAINT [PK_GroupMember] PRIMARY KEY CLUSTERED ([GroupId] ASC, [StakeholderId] ASC),
	CONSTRAINT [FK_GroupMember_Group] FOREIGN KEY ([GroupId]) REFERENCES [usr].[Group] ([GroupId]),
    CONSTRAINT [FK_GroupMember_User] FOREIGN KEY ([StakeholderId]) REFERENCES [usr].[User] ([StakeholderId])
)