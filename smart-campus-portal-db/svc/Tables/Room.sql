CREATE TABLE [svc].[Room] (
    [RoomId]        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name]          NVARCHAR(255) NOT NULL,
    [Capacity]      INT NULL,
    [Location]      NVARCHAR(255) NULL
);