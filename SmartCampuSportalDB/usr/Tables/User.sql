CREATE TABLE [usr].[User]
(
	[StakeholderId]			INT NOT NULL,
	[Username]				NVARCHAR(255)  NOT NULL,
	[PasswordHash]          NVARCHAR(1000) NULL,
    [SecurityStamp]         NVARCHAR(1000) NULL,
	[IsLocked]				BIT NULL DEFAULT 0,
	[IsDeleted]				BIT NULL DEFAULT 0,
    [DateCreated]           DATETIME       NOT NULL,
	[DateUpdated]           DATETIME       NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([StakeholderId] ASC),
	CONSTRAINT [FK_User_Stakeholder] FOREIGN KEY ([StakeholderId]) REFERENCES [sh].Stakeholder ([StakeholderId]),
	CONSTRAINT [UK_User_Username] UNIQUE(Username)
)
