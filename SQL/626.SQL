/* 
626 Exchange Seats
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.*/

SELECT 
s1.id, 
s2.student
FROM Seat s1
JOIN Seat s2 ON 
    (s1.id % 2 = 1 AND s1.id + 1 = s2.id) 
    OR 
    (s1.id % 2 = 0 AND s1.id - 1 = s2.id)
UNION ALL
SELECT 
s1.id, 
s1.student
FROM Seat s1
WHERE s1.id % 2 = 1 AND NOT EXISTS (
    SELECT 1 FROM Seat s2 WHERE s2.id = s1.id + 1
)
ORDER BY id;

-- 300 ms beating 95% of users 