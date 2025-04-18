CREATE PROCEDURE [sh].[SetStakeholderContact]
	@stakeholderId			INT,
	@contactId				INT = NULL,
	@contactTypeId			INT,
	@detail					NVARCHAR(255),
	@areaCode               NVARCHAR(32)

AS
SET NOCOUNT ON;

IF @contactId IS NULL
BEGIN
	INSERT INTO sh.Contact(StakeholderId, ContactTypeId,  Detail, AreaCode)
	VALUES (@stakeholderId, @contactTypeId, @detail, @areaCode)

	SELECT @contactId = SCOPE_IDENTITY()
END
BEGIN
	UPDATE sh.Contact
	SET Detail = @detail,
	    AreaCode = @areaCode,
		ContactTypeId = @contactTypeId
	WHERE ContactId = @contactId
END

SELECT
	[S].StakeholderId,
	[C].ContactId,
    [C].[ContactTypeId],
    [C].[Detail],
    [C].[AreaCode]
FROM sh.Contact [C]
INNER JOIN sh.Stakeholder [S] ON [C].StakeholderId = [S].StakeholderId AND ISNULL([S].IsDeleted, 0) = 0
WHERE [C].ContactId = @contactId