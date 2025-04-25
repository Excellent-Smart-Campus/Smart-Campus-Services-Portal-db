CREATE PROCEDURE [sh].[SetStakeholder]
	@stakeholderId			INT = NULL,
    @stakeholderTypeId      INT,
    @name				NVARCHAR(255),
	@isDeleted				BIT = 0
AS
SET NOCOUNT ON;

    IF @stakeholderId IS NULL
    BEGIN
        INSERT INTO sh.Stakeholder (StakeholderTypeId, Name, IsDeleted, DateCreated)
        VALUES (@stakeholderTypeId, @name, @isDeleted, GETDATE());
        SELECT @stakeholderId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE sh.Stakeholder
        SET Name = @name,
            IsDeleted = @isDeleted,
            DateUpdated = GETDATE()
        WHERE StakeholderId = @stakeholderId;
    END;

SELECT 
	[SH].StakeholderId,
	[SH].StakeholderTypeId,
	[SH].FirstName,
    [SH].LastName,
    [SH].TitleId
FROM [sh].Stakeholder [SH]
INNER JOIN sh.Title [T] ON [T].TitleId = [SH].TitleId
WHERE [SH].StakeholderId = @stakeholderId
