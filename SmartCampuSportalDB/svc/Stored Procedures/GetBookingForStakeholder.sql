CREATE PROCEDURE [svc].[GetBookingForStakeholder]
    @stakeholderId	INT
AS
SET NOCOUNT ON;

SELECT 
	[B].BookingId,
	[B].StakeholderId,
    [B].LecturerId,
	[B].RoomId,
    [B].Purpose,
	[B].BookingDate,
	[B].StartTime,
    [B].EndTime,
	[B].StatusId,
    [B].DateCreated
FROM svc.Booking [B]
INNER JOIN [sh].Stakeholder [S] ON [B].StakeholderId = [S].StakeholderId
INNER JOIN [svc].[Status] [ST] ON [B].[StatusId] = [ST].StatusId
WHERE ([B].StakeholderId = @stakeholderId OR [B].LecturerId = @stakeholderId)
AND ST.StatusId IN (1,2);