/* 610. Triangle Judgement

able: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Report for every three line segments whether they can form a triangle.

Return the result table in any order.*/

SELECT
    *,
    CASE
        WHEN (ABS(x) + ABS(y)) <= ABS(z) THEN 'No'
        WHEN (ABS(x) + ABS(z)) <= ABS(y) THEN 'No'
        WHEN (ABS(y) + ABS(z)) <= ABS(x) THEN 'No'
        ELSE 'Yes'
    END AS triangle
FROM 
    Triangle

-- 281 ms beating 95% of users