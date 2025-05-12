DELETE usr.GroupAction

--Super User
INSERT INTO usr.GroupAction 
SELECT
	1,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,6,7,8,14,16,17,19,20,21,22,24,26,27,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45)

--Students
INSERT INTO usr.GroupAction 
SELECT
	2,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,3,4,7,8,9,10,11,13,14,15,18,21,25,26,45)

--Lecturers
INSERT INTO usr.GroupAction 
SELECT
	3,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,3,5,7,8,9,10,11,12,13,14,15,16,17,18,21,23,26,27,29,45)



--Lecturers users 
BEGIN TRANSACTION;
BEGIN TRY

    DECLARE @users TABLE (
        FirstName NVARCHAR(255),
        LastName NVARCHAR(255),
        StakeholderTypeId INT,
        RelatedStakeholderId INT,
        StakeholderRelationshipTypeId INT,
        EffectiveDate DATE,
        Mobile NVARCHAR(20),
        Email NVARCHAR(100),
        SecurityStamp NVARCHAR(1000),
        PasswordHash NVARCHAR(1000)
    );

    INSERT INTO @Users
     (FirstName, LastName, StakeholderTypeId, RelatedStakeholderId, StakeholderRelationshipTypeId , EffectiveDate, Mobile, Email, SecurityStamp, PasswordHash)
    VALUES 
        ('Alice', 'Smith', 2, 1, 2, CONVERT(DATE, GETDATE()), '0712345678', 'alice@smt.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g=='),
        ('Bob', 'Jones', 2,  1, 2, CONVERT(DATE, GETDATE()), '0723456789', 'bob@example.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g=='),
        ('Charlie', 'Magagula', 2, 2, 2, CONVERT(DATE, GETDATE()), '0734567890', 'charlie@example.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g==')

 
    DECLARE @FirstName NVARCHAR(255),
        @LastName NVARCHAR(255),
        @StakeholderTypeId INT,
        @RelatedStakeholderId INT,
        @StakeholderRelationshipTypeId INT,
        @EffectiveDate DATE,
        @Mobile NVARCHAR(20),
        @Email NVARCHAR(100),
        @SecurityStamp NVARCHAR(1000),
        @PasswordHash NVARCHAR(1000),
        @PersonStakeholderId INT;

    DECLARE user_cursor CURSOR FOR
        SELECT FirstName, 
        LastName, 
        StakeholderTypeId, 
        RelatedStakeholderId, 
        StakeholderRelationshipTypeId, 
        EffectiveDate, 
        Mobile,
        Email,
        SecurityStamp,
        PasswordHash FROM @Users;

    OPEN user_cursor;
        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @RelatedStakeholderId, 
            @StakeholderRelationshipTypeId,
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insert Stakeholder
        INSERT INTO sh.Stakeholder (StakeholderTypeId, Name, DateCreated)
        VALUES (
            @StakeholderTypeId,
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))) + ' ' +
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName))),
            GETDATE()
        );
        SET @PersonStakeholderId = SCOPE_IDENTITY();
    
        -- Insert StakeholderPerson
        INSERT INTO sh.StakeholderPerson (StakeholderId, FirstName, LastName)
        VALUES (
            @PersonStakeholderId, 
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))),
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName)))
        );

        -- Insert Contact: 2 Mobile
        INSERT INTO sh.Contact (StakeholderId,ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 2, @Mobile);

        -- Insert Contact: 1 Email
        INSERT INTO sh.Contact (StakeholderId, ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 1, @Email);

        -- StakeholderRelationship
        INSERT INTO sh.StakeholderRelationship (StakeholderId, RelatedStakeholderId, StakeholderRelationshipTypeId, EffectiveDate)
        VALUES (@PersonStakeholderId, @RelatedStakeholderId, @StakeholderRelationshipTypeId, @EffectiveDate);

        -- Insert User
        INSERT INTO usr.[User] (StakeholderId, Username, PasswordHash, SecurityStamp, DateCreated)
        VALUES (@PersonStakeholderId, @Email, @PasswordHash, @SecurityStamp, GETDATE());

        -- GroupMember
        INSERT INTO usr.GroupMember (GroupId, StakeholderId)
        VALUES (3, @PersonStakeholderId);

        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @RelatedStakeholderId, 
            @StakeholderRelationshipTypeId,
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
        END
    CLOSE user_cursor;
    DEALLOCATE user_cursor;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE @errorMessage nvarchar(max), @errorSeverity int, @errorState int;
    SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();

    IF (@@TRANCOUNT > 0)
    BEGIN
        ROLLBACK TRANSACTION
    END 

    RAISERROR(@errorMessage, @errorSeverity, @errorState);
END CATCH




--Admin users 
BEGIN TRANSACTION;
BEGIN TRY

    DECLARE @users TABLE (
        FirstName NVARCHAR(255),
        LastName NVARCHAR(255),
        StakeholderTypeId INT,
        EffectiveDate DATE,
        Mobile NVARCHAR(20),
        Email NVARCHAR(100),
        SecurityStamp NVARCHAR(1000),
        PasswordHash NVARCHAR(1000)
    );

    INSERT INTO @Users
     (FirstName, LastName, StakeholderTypeId, EffectiveDate, Mobile, Email, SecurityStamp, PasswordHash)
    VALUES 
        ('georgia', 'mosamo', 3, CONVERT(DATE, GETDATE()), '0712345678', 'georgia.mosamo@un.org.za', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g=='),
        ('betty', 'tinyane', 3, CONVERT(DATE, GETDATE()), '0723456789', 'bettytinyane@gmail.com', 'U66FPCREDWKGI3AHYUN2XANY7RCOX6IH', 'AQAAAAIAAYagAAAAEHJUxYseW4edU89G3awZ+8sWEDW9HIcg+Fa1r9wqbVwUu+L2ByuxRbJ4/DZ5cAns+g==')

 
    DECLARE @FirstName NVARCHAR(255),
        @LastName NVARCHAR(255),
        @StakeholderTypeId INT,
        @EffectiveDate DATE,
        @Mobile NVARCHAR(20),
        @Email NVARCHAR(100),
        @SecurityStamp NVARCHAR(1000),
        @PasswordHash NVARCHAR(1000),
        @PersonStakeholderId INT;

    DECLARE user_cursor CURSOR FOR
        SELECT FirstName, 
        LastName, 
        StakeholderTypeId, 
        EffectiveDate, 
        Mobile,
        Email,
        SecurityStamp,
        PasswordHash FROM @Users;

    OPEN user_cursor;
        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insert Stakeholder
        INSERT INTO sh.Stakeholder (StakeholderTypeId, Name, DateCreated)
        VALUES (
            @StakeholderTypeId,
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))) + ' ' +
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName))),
            GETDATE()
        );
        SET @PersonStakeholderId = SCOPE_IDENTITY();
    
        -- Insert StakeholderPerson
        INSERT INTO sh.StakeholderPerson (StakeholderId, FirstName, LastName)
        VALUES (
            @PersonStakeholderId, 
            UPPER(LEFT(@FirstName, 1)) + LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))),
            UPPER(LEFT(@LastName, 1)) + LOWER(SUBSTRING(@LastName, 2, LEN(@LastName)))
        );

        -- Insert Contact: 2 Mobile
        INSERT INTO sh.Contact (StakeholderId,ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 2, @Mobile);

        -- Insert Contact: 1 Email
        INSERT INTO sh.Contact (StakeholderId, ContactTypeId, Detail)
        VALUES (@PersonStakeholderId, 1, @Email);

        -- Insert User
        INSERT INTO usr.[User] (StakeholderId, Username, PasswordHash, SecurityStamp, DateCreated)
        VALUES (@PersonStakeholderId, @Email, @PasswordHash, @SecurityStamp, GETDATE());

        -- GroupMember
        INSERT INTO usr.GroupMember (GroupId, StakeholderId)
        VALUES (1, @PersonStakeholderId);

        FETCH NEXT FROM user_cursor 
        INTO @FirstName, 
            @LastName, 
            @StakeholderTypeId, 
            @EffectiveDate,
            @Mobile,
            @Email,
            @SecurityStamp,
            @PasswordHash;
        END
    CLOSE user_cursor;
    DEALLOCATE user_cursor;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE @errorMessage nvarchar(max), @errorSeverity int, @errorState int;
    SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();

    IF (@@TRANCOUNT > 0)
    BEGIN
        ROLLBACK TRANSACTION
    END 

    RAISERROR(@errorMessage, @errorSeverity, @errorState);
END CATCH





   