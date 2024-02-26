--EX2
--1
SELECT * 
FROM CITY
WHERE COUNTRYCODE = 'JPN'

--2
SELECT Name
FROM STUDENTS 
WHERE Marks > 75 
ORDER BY RIGHT(Name,3), ID ASC

--3
SELECT name 
FROM Employee
ORDER BY name 

--4
SELECT name
FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC

--5
