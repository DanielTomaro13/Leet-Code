/* 619. Biggest Single Number
Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.*/

WITH unique_nums AS (
    SELECT
        num,
        COUNT(*) AS count
    FROM
        MyNumbers
    GROUP BY
        num
)
SELECT
    MAX(num) as num
FROM
    unique_nums
WHERE
    count = 1;


-- 402ms beating 97%