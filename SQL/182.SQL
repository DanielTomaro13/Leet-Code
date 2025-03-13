/* 

182. Duplicate Emails

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in any order.

*/

-- We need to use aggregation here to count how many duplicate emails 
-- Because we are using aggregation we cannot use WHERE we have to use HAVING
-- because we are aggregating we will also have to use a group by to specifiy what we are aggregating by

SELECT
email
FROM person
GROUP BY email
HAVING count(email) > 1

/*

Correct, 944 ms beating 20%

Other solutions 

SELECT DISTINCT(p1.email) from Person p1, Person p2
where p1.id <> p2.id AND p1.email = p2.email;

-- This is using a inner join to select distinct emails where the IDs do not equal each other AND the emails do equal each other

*/
