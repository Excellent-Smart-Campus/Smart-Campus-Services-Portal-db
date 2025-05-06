CREATE PROCEDURE [svc].[GetAvailableRoom]
    @year INT,
    @month INT,
    @roomTypeId NVARCHAR(32) = null
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @startDate DATE = DATEFROMPARTS(@year, @month, 1);
    DECLARE @endDate DATE = EOMONTH(@startDate);

    WITH Dates AS (
        SELECT @startDate AS BookingDate
        UNION ALL
        SELECT DATEADD(DAY, 1, BookingDate)
        FROM Dates
        WHERE BookingDate < @endDate
    ),
    TimeSlots AS (
        SELECT CAST('08:00:00' AS TIME) AS SlotStart
        UNION ALL
        SELECT DATEADD(HOUR, 1, SlotStart)
        FROM TimeSlots
        WHERE SlotStart < '18:00:00'
    )

     SELECT 
        R.RoomId,
        R.RoomNumber,
        R.RoomTypeId,
        RT.Description 'RoomName',
        R.Capacity,
        R.Location,
        D.BookingDate,
        T.SlotStart,
        DATEADD(HOUR, 1, T.SlotStart) AS SlotEnd,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM svc.Booking B
                WHERE 
                    B.RoomId = R.RoomId
                    AND CAST(B.BookingDate AS DATE) = D.BookingDate
                    AND b.StatusId = 1
                    AND (T.SlotStart < CAST(B.EndTime AS TIME)
                        AND DATEADD(HOUR, 1, T.SlotStart) > CAST(B.StartTime AS TIME)
                    )
            )
            THEN CAST(0 AS BIT)
            ELSE CAST(1 AS BIT)
        END AS IsAvailable
    FROM [svc].Room [R]
    INNER JOIN [svc].RoomType RT on R.RoomTypeId = RT.RoomTypeId
    CROSS JOIN Dates D
    CROSS JOIN TimeSlots T
    WHERE (@roomTypeId IS NULL OR R.RoomTypeId IN (SELECT value FROM STRING_SPLIT(@roomTypeId, ',')))
    ORDER BY D.BookingDate, R.RoomNumber, T.SlotStart
    OPTION (MAXRECURSION 1000)
END
