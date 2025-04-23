CREATE PROCEDURE [svc].[SetMaintenanceIssue]
	@issueId		  INT = NULL,
    @stakeholderId	  INT,
    @title			  NVARCHAR(255),
    @description	  VARCHAR(MAX) = NULL,
    @statusId         INT,
    @startTime        DATETIME
AS
SET NOCOUNT ON;

    IF @issueId IS NULL
    BEGIN
        INSERT INTO svc.MaintenanceIssue (StakeholderId, Title, Description, StatusId, DateReported)
        VALUES (@stakeholderId, @title, @description, @statusId, GETDATE());
        SELECT @issueId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE svc.MaintenanceIssue
        SET StatusId = @statusId,
            DateResolved = GETDATE()
        WHERE IssueId = @issueId;
    END;

SELECT 
	[M].IssueId,
	[M].StakeholderId,
	[M].Title,
    [M].Description,
	[M].StatusId,
    [M].DateReported,
    [M].DateResolved
FROM svc.MaintenanceIssue [M]
INNER JOIN [sh].Stakeholder [S] ON [M].StakeholderId = [S].StakeholderId
INNER JOIN [svc].[Status] [ST] ON [M].[StatusId] = [ST].StatusId
WHERE [M].IssueId = @issueId
