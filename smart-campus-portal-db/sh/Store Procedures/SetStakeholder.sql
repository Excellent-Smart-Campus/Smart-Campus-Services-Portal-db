CREATE PROCEDURE [sh].[SetStakeholder]
	@stakeholderId			INT = NULL,
    @stakeholderTypeId      INT,
    @titleId                INT,
	@firstName				NVARCHAR(255),
    @lastName				NVARCHAR(255),
	@isDeleted				BIT = 0
AS
SET NOCOUNT ON;

    IF @stakeholderId IS NULL
    BEGIN
        INSERT INTO sh.Stakeholder (StakeholderTypeId, TitleId, FirstName, LastName, IsDeleted, DateCreated)
        VALUES (@stakeholderTypeId, @titleId, @firstName, @lastName, @isDeleted, GETDATE());
        SELECT @stakeholderId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE sh.Stakeholder
        SET FirstName = @firstName,
            LastName = lastName,
            TitleId = @titleId,
            IsDeleted = @isDeleted
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
