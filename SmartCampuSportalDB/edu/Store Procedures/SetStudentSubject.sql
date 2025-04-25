CREATE PROCEDURE [edu].[setStudentSubject]
    @subjectId              INT,
    @stakeholderId          INT,
    @isDeleted              BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT SubjectId FROM edu.StudentSubject 
        WHERE SubjectId = @subjectId 
        AND StakeholderId = @stakeholderId
        AND IsDeleted = 0)
    BEGIN
        UPDATE edu.StudentSubject 
        SET IsDeleted = @isDeleted
        WHERE SubjectId = @subjectId 
        AND StakeholderId = @stakeholderId
    END
    ELSE
    BEGIN
        INSERT INTO edu.StudentSubject (SubjectId, StakeholderId, IsDeleted)
        VALUES (@subjectId, @stakeholderId, @isDeleted);
    END;
    SELECT
       [E].SubjectId,
       [E].StakeholderId,
       [E].IsDeleted
    FROM edu.StudentSubject [E]
    WHERE [E].StakeholderId = @stakeholderId
    AND [E].SubjectId = @subjectId
    AND [E].IsDeleted = @isDeleted
END
