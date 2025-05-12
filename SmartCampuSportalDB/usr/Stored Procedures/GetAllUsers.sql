CREATE PROCEDURE [usr].[GetAllUsers]
    
AS
SET NOCOUNT ON;

SELECT 
    [U].StakeholderId,
    [SH].[Name] 'DisplayName',
    [U].Username,
    [U].IsDeleted,
    [U].IsLocked,
    STRING_AGG([G].[Description], ', ') AS Groups
FROM usr.[User] [U]
INNER JOIN sh.Stakeholder [SH] ON [SH].[StakeholderId] = [U].[StakeholderId] AND ISNULL([SH].IsDeleted, 0) = 0
LEFT JOIN usr.[GroupMember] [GM] ON [GM].[StakeholderId] = [U].[StakeholderId]
LEFT JOIN usr.[Group] [G] ON [G].[GroupId] = [GM].[GroupId] AND [G].[IsDeleted] = 0
GROUP BY 
        [U].StakeholderId, 
        [SH].[Name], 
        [U].Username, 
        [U].IsDeleted,
        [U].IsLocked;
GO