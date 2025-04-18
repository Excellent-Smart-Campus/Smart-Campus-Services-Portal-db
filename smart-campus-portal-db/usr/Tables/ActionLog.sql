CREATE TABLE [usr].[ActionLog]
(
	[ActionLogId]	    INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ActionId]		    INT NOT NULL,
	[StakeholderId]	    INT NOT NULL,
	[ActionDate]	    DATETIME NOT NULL,
	[Description]	    NVARCHAR(255) NULL,
    [KeyId]			INT NULL,
	CONSTRAINT [FK_ActionLog_Action] FOREIGN KEY ([ActionId]) REFERENCES [usr].[Action] ([ActionId]),
	CONSTRAINT [FK_ActionLog_User] FOREIGN KEY ([StakeholderId]) REFERENCES [usr].[User] ([StakeholderId])
)
