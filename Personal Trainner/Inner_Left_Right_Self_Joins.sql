USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
--------------------
select * from exercisecategory inner join exercise on ExerciseCategory.ExerciseCategoryId = exercise.ExerciseCategoryId;
    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
--------------------
select ExerciseCategory.Name, Exercise.Name from exercisecategory inner join exercise on ExerciseCategory.ExerciseCategoryId = exercise.ExerciseCategoryId
where ParentCategoryId is null;
-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
--------------------
select ExerciseCategory.Name as CategoryName, Exercise.Name as ExerciseName from exercisecategory inner join exercise on ExerciseCategory.ExerciseCategoryId = exercise.ExerciseCategoryId
where ParentCategoryId is null;

-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows
--------------------
describe client;
describe login;
select c.firstname, c.lastname, c.birthdate, l.emailaddress from client c inner join login l on c.clientid = l.clientid
where c.birthdate between "1990-1-1" and "1999-12-31";
-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows
--------------------
select workout.name, client.firstname, client.lastname from client
inner join clientworkout on client.clientid = clientworkout.clientid
inner join workout on workout.workoutid = clientworkout.workoutid
where client.lastname like "C%";
-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
--------------------
select workout.name as workoutname, goal.name as goalname from workout
inner join workoutgoal on workout.workoutid = workoutgoal.workoutid
inner join goal on goal.goalid = workoutgoal.goalid;
-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows
--------------------
SELECT c.FirstName, c.LastName, l.ClientId, l.EmailAddress
FROM Client c
LEFT JOIN Login l ON c.ClientId = l.ClientId;

-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows
--------------------
SELECT c.FirstName, c.LastName
FROM Client c
LEFT JOIN Login l ON c.ClientId = l.ClientId
where l.clientid is null;

-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(
--------------------
select * from client c left join login l on c.clientid = l.clientid where c.firstname = "romeo" and l.clientid is not null;
-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows
--------------------
SELECT c.Name AS CategoryName, p.Name AS ParentCategoryName
FROM ExerciseCategory c
LEFT JOIN ExerciseCategory p ON c.ParentCategoryId = p.ExerciseCategoryId
WHERE c.ParentCategoryId IS NOT NULL;

select * from exercisecategory;

-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows
--------------------
SELECT c.Name AS CategoryName, p.Name AS ParentCategoryName
FROM ExerciseCategory c
LEFT JOIN ExerciseCategory p ON c.ParentCategoryId = p.ExerciseCategoryId;

-- Are there Clients who are not signed up for a Workout?
-- 50 rows
--------------------
select client.firstname, client.lastname from client left join clientworkout on client.clientid = clientworkout.clientid where clientworkout.clientid is null;
-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows
--------------------
select workout.name from client
inner join clientgoal on client.clientid = clientgoal.clientid
inner join goal on goal.goalid = clientgoal.goalid
inner join workoutgoal on workoutgoal.goalid = goal.goalid
inner join workout on workout.workoutid = workoutgoal.workoutid
INNER JOIN level ON workout.levelid = level.levelid
where client.firstname = "Shell"
AND level.Name = 'Beginner';
