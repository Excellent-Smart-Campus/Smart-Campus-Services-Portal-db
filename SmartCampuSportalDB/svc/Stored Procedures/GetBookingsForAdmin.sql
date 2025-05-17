CREATE PROCEDURE [svc].[GetBookingsForAdmin]
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
    [B].DateCreated,
    [R].RoomId,
    [R].RoomTypeId,
    [R].RoomNumber,
    [RT].[Description] 'RoomName'
FROM svc.Booking [B]
INNER JOIN [sh].Stakeholder [S] ON [B].StakeholderId = [S].StakeholderId
INNER JOIN [svc].[Status] [ST] ON [B].[StatusId] = [ST].StatusId
INNER JOIN [svc].Room [R] ON [B].RoomId = [R].RoomId
INNER JOIN [svc].RoomType [RT] ON  [R].[RoomTypeId] = [RT].RoomTypeId 
WHERE ST.StatusId IN (1,2)
ORDER BY[B].DateCreated DESC;
