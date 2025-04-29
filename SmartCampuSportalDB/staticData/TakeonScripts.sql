DELETE usr.GroupAction

--Super User
INSERT INTO usr.GroupAction 
SELECT
	1,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(
1,2,9,10,11,12,14,15,16,17,18,20,21,22, 23, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,37,38)

--Students
INSERT INTO usr.GroupAction 
SELECT
	2,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,3,7,8,9,10,13,20,22, 24,39,40, 41)

--Lecturers
INSERT INTO usr.GroupAction 
SELECT
	3,
	ActionId
FROM usr.[Action]
WHERE ActionId IN(1,2,3,4,5,6,8,9,10,13,19,20,21,22, 23, 24,39,40)
   