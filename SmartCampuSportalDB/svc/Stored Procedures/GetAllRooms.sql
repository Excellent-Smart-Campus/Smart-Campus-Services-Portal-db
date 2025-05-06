CREATE PROCEDURE [svc].[GetAllRooms]
AS
SET NOCOUNT ON;

SELECT 
	[R].[RoomId]
   ,[R].[RoomNumber]
   ,[R].[RoomTypeId]
   ,[R].[Capacity]
   ,[R].[Location]
   ,[RT].[Description] 'RoomName'
FROM [svc].Room [R]
INNER JOIN [svc].[RoomType] [RT] on RT.RoomTypeId = R.RoomTypeId