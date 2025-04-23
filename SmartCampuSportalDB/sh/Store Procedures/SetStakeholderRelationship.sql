CREATE PROCEDURE [sh].[SetStakeholderRelationship]
	@stakeholderId                  INT,
    @relatedStakeholderId           INT,
    @stakeholderRelationshipTypeId  INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT StakeholderId  FROM sh.StakeholderRelationship  WHERE StakeholderId = @stakeholderId AND RelatedStakeholderId = @relatedStakeholderId AND  StakeholderRelationshipTypeId = @stakeholderRelationshipTypeId)

    BEGIN
        INSERT INTO sh.StakeholderRelationship (StakeholderId, RelatedStakeholderId, StakeholderRelationshipTypeId, EffectiveDate)
        VALUES (@stakeholderId, @relatedStakeholderId, @stakeholderRelationshipTypeId, GETDATE())
    END
    ELSE
    BEGIN
        UPDATE sh.StakeholderRelationship
        SET EndDate = NULL
        WHERE StakeholderId = @stakeholderId
        AND RelatedStakeholderId = @relatedStakeholderId
        AND StakeholderRelationshipTypeId = @stakeholderRelationshipTypeId
    END

    SELECT
        [SHR].StakeholderId,
        [SHR].RelatedStakeholderId,
        [SHR].StakeholderRelationshipTypeId,
        [SHR].EffectiveDate,
        [SHR].EndDate
    FROM sh.StakeholderRelationship [SHR]
    WHERE [SHR].StakeholderId = @stakeholderId
    AND [SHR].RelatedStakeholderId = @relatedStakeholderId
    AND [SHR].StakeholderRelationshipTypeId = @stakeholderRelationshipTypeId
END