CREATE TABLE [svc].[RoomType] (
    [RoomTypeId]        INT NOT NULL,
    [Description]       NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED ([RoomTypeId] ASC)
);