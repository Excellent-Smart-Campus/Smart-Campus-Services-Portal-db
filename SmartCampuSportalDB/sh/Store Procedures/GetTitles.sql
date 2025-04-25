CREATE PROCEDURE [sh].[GetTitles]
AS
SET NOCOUNT ON;

SELECT 
	[T].TitleId,
	[T].Description
FROM [sh].Title [T]