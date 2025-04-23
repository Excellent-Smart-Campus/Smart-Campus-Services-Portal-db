CREATE PROCEDURE [usr].[GetAllActions]
    
AS
SET NOCOUNT ON;

SELECT 
   [A].ActionId,
   [A].Description
FROM usr.[Action] [A]