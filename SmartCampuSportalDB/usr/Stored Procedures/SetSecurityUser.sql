CREATE PROCEDURE [usr].[SetSecurityUser]
    @stakeholderId INT,
    @username NVARCHAR(255),
    @passwordHash NVARCHAR(1000) = null,
    @securityStamp NVARCHAR(1000) = null,
    @isDeleted BIT = 0,
    @isLocked BIT = 0
AS
SET NOCOUNT ON;

IF EXISTS(SELECT StakeholderId FROM [usr].[User] WHERE StakeholderId = @stakeholderId)
    UPDATE [usr].[User]
    SET PasswordHash = @passwordHash,
        SecurityStamp = @securityStamp,
        IsDeleted = @isDeleted,
        IsLocked = @isLocked,
        DateUpdated = GETDATE()
    WHERE StakeholderId = @stakeholderId
ELSE
    INSERT INTO [usr].[User] (StakeholderId, Username, SecurityStamp, IsDeleted, IsLocked, DateCreated)
    VALUES (@stakeholderId, @username, @securityStamp, @isDeleted, @isLocked, GETDATE())

SELECT
    [U].StakeholderId,
	[U].Username,
    [SP].FirstName,
    [SP].LastName,
    [SP].TitleId,
    [U].PasswordHash,
    [U].SecurityStamp,
    [U].IsDeleted,
    [U].IsLocked
FROM [usr].[User] [U]
INNER JOIN [sh].Stakeholder SH ON [SH].StakeholderId = [U].StakeholderId
INNER JOIN [sh].StakeholderPerson [SP] ON [SP].StakeholderId = [SH].StakeholderId
WHERE [U].StakeholderId = @stakeholderId
