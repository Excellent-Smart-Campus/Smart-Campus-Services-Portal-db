CREATE PROCEDURE [sh].[GetStakeholderRelationship]
    @stakeholderId INT
AS
SET NOCOUNT ON;

SELECT 
        [SHR].StakeholderId,
        [SHR].RelatedStakeholderId,
        [SHR].StakeholderRelationshipTypeId,
        [SHR].EffectiveDate,
        [SHR].EndDate
FROM sh.StakeholderRelationship [SHR]
WHERE [SHR].StakeholderId = @stakeholderId AND [SHR].EndDate IS NULL 
