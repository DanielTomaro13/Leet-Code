/*
181. Employees Earning More Than Their Managers

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

Write a solution to find the employees who earn more than their managers.

Return the result table in any order.

Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+

-- We are comparing values within a table therefore we can use a CTE or we can use a self join which would be more efficient
-- If managerId is null therefore they are a manager
-- We want to compare managerId and id
-- e1 will be managers and e2 will be employees

*/

SELECT
e2.name AS Employee -- We want employees who earn more not managers therefore we use e2
FROM employee e1
JOIN employee e2 ON e1.id = e2.managerid -- here we are specifing e1 values as a manager value
WHERE e1.salary < e2.salary -- Where employee salary is greater than manager salary

/*

Accepted Solution! 1090 ms beats 17%

*/