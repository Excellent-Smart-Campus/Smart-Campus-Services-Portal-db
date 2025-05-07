CREATE PROCEDURE [svc].[SetBooking]
	@bookingId	INT = NULL,
    @stakeholderId	INT,
    @lecturerId       	INT = NULL,
    @roomId		INT = NULL,
    @purpose		VARCHAR(MAX),
    @bookingDate      	DATETIME,
    @startTime        	DATETIME = NULL,
    @endTime          	DATETIME = NULL,
    @statusId         	INT
AS
SET NOCOUNT ON;

    IF @bookingId IS NULL
    BEGIN
        INSERT INTO svc.Booking (StakeholderId, LecturerId, RoomId, Purpose, BookingDate, StartTime, EndTime, StatusId, DateCreated)
        VALUES (@stakeholderId,  @lecturerId, @roomId, @purpose, @bookingDate, @startTime, @endTime, @statusId, GETDATE());
        SELECT @bookingId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE svc.Booking
        SET StatusId = @statusId,
            DateUpdated = GETDATE()
        WHERE BookingId = @bookingId;
    END;

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
INNER JOIN [svc].Room [R] ON [B].RoomId = [R].RoomId
INNER JOIN [svc].[Status] [ST] ON [B].[StatusId] = [ST].StatusId
WHERE [B].BookingId = @bookingId
