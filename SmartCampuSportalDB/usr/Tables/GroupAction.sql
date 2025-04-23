CREATE TABLE [usr].[GroupAction]
(
	[GroupId]   INT NOT NULL,
	[ActionId]  INT NOT NULL,
	CONSTRAINT  [PK_GroupAction] PRIMARY KEY CLUSTERED ([GroupId] ASC, [ActionId] ASC),
	CONSTRAINT  [FK_GroupAction_Group] FOREIGN KEY ([GroupId]) REFERENCES [usr].[Group] ([GroupId]),
    CONSTRAINT  [FK_GroupAction_Action] FOREIGN KEY ([ActionId]) REFERENCES [usr].[Action] ([ActionId])
)
