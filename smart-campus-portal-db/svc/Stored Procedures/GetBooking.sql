CREATE PROCEDURE [svc].[GetBooking]
    @bookingId		 INT

AS
SET NOCOUNT ON;

SELECT 
	[B].BookingId,
	[B].StakeholderId,
	[B].RoomId,
    [B].Purpose,
	[B].BookingDate,
	[B].StartTime,
    [B].EndTime,
	[B].StatusId,
    [B].DateCreated
FROM svc.Booking [B]
INNER JOIN [sh].Stakeholder [S] ON [B].StakeholderId = [S].StakeholderId
INNER JOIN [svc].Room [R] ON [B].RoomId = [R].RoomId
INNER JOIN [svc].[Status] [ST] ON [B].[StatusId] = [ST].StatusId
WHERE [B].BookingId = @bookingId