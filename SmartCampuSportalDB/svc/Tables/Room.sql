CREATE TABLE [svc].[Room] (
    [RoomId]        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [RoomNumber]    NVARCHAR(25) NOT NULL,
    [RoomTypeId]    INT NOT NULL,
    [Capacity]      INT NOT NULL,
    [Location]      NVARCHAR(255) NULL
    CONSTRAINT [FK_Room_RoomTypeId] FOREIGN KEY ([RoomTypeId]) REFERENCES [svc].[RoomType] ([RoomTypeId]),
);