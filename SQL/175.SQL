/*
175. Combine Two Tables

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key (column with unique values) for this table.
This table contains information about the ID of some persons and their first and last names.

Table: Address

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key (column with unique values) for this table.
Each row of this table contains information about the city and state of one person with ID = PersonId.
 

Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

Return the result table in any order.

*/

-- Need a join
-- Since it would like nulls to be reported it will not be an inner join as all entries much match in an inner join
-- We are joining the address table onto the person table therefore we will use a left join as any person who doesn't have a match in address will therefore have a null as
-- we are returning all of the left (person) and matching of the right (address)

SELECT
    p.FirstName,
    p.LastName,
    a.City,
    a.State
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId
-- No need for ordering or grouping as it is not specified


/* Leet Code Answer

select FirstName, LastName, City, State
from Person left join Address
on Person.PersonId = Address.PersonId
;

My answer had 448 ms run time beating 91% of people

*/