CREATE PROCEDURE [sh].[SetStakeholderPerson]
	@stakeholderId			INT = NULL,
    @titleId                INT,
	@firstName				NVARCHAR(255),
    @lastName				NVARCHAR(255)
AS
SET NOCOUNT ON;

    IF @stakeholderId IS NULL
    BEGIN
        INSERT INTO sh.StakeholderPerson (StakeholderId, TitleId, FirstName, LastName)
        VALUES (@stakeholderId, @titleId, @firstName, @lastName);
    END
    ELSE
    BEGIN
        UPDATE sh.StakeholderPerson
        SET FirstName = @firstName,
            LastName = lastName,
            TitleId = @titleId
        WHERE StakeholderId = @stakeholderId;
    END;

SELECT 
	[SHP].StakeholderId,
	[SHP].FirstName,
    [SHP].LastName,
    [SHP].TitleId
FROM [sh].StakeholderPerson [SHP]
INNER JOIN sh.Stakeholder [SH] ON [SHP].StakeholderId = [SH].StakeholderId
WHERE [SHP].StakeholderId = @stakeholderId
