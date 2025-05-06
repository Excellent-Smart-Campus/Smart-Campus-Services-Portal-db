CREATE PROCEDURE [usr].[GetSecurityUser]
	@stakeholderId	INT = NULL,
	@userName		NVARCHAR(255) = NULL
AS
SELECT 
	[U].StakeholderId,
	[SH].StakeholderTypeId,
	[U].Username,
    [U].PasswordHash,
    [U].SecurityStamp,
	[U].IsDeleted,
	[U].IsLocked,
    [SH].Name
FROM [usr].[User] [U]
INNER JOIN [sh].Stakeholder SH ON [SH].StakeholderId = [U].StakeholderId
INNER JOIN [sh].StakeholderPerson [SP] ON [SP].StakeholderId = [SH].StakeholderId
WHERE (@stakeholderId IS NOT NULL AND [U].StakeholderId = @stakeholderId)
   OR (@userName IS NOT NULL AND [U].Username = @userName)