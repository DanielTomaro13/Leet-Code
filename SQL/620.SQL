/* 620. Not boring movies

Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 

Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.

The result format is in the following example. */

SELECT
    id,
    movie,
    description,
    rating
FROM Cinema
WHERE description NOT LIKE '%boring%' AND id % 2 != 0
ORDER BY rating DESC

/* So the reason we do % 2 is because that means when divided by 2 it does not equal 0
all odd numbers divided by 2 will not equal 0 and all even numbers divided by 2 will  equal 0
546 ms and beats 30% of users *'/