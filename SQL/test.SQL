Question 1: SQL 


1)	Create the table Daily Active Users (DAU)
Date	Daily Active Users
2020-07-01	
2020-07-02	

SELECT
   Date,
   COUNT(DISTINCT User_ID) AS Daily_Active_Users
FROM test.dau
GROUP BY Date
ORDER BY Date;


2)	Daily Spenders Conversion: out of total users who were active on a given day, how many spent in the game on that day. 
Date	Conversion (%)
2020-07-01	
2020-07-02	

WITH Daily_Active_Users AS (
    SELECT 
        Date, 
        COUNT(DISTINCT User_ID) AS Total_Active_Users
    FROM test.dau
    GROUP BY Date
),
Daily_Spenders AS (
    SELECT 
        DATE(Date_Time) AS Date, 
        COUNT(DISTINCT User_ID) AS Total_Spenders
    FROM test.rev
    GROUP BY DATE(Date_Time)
)
SELECT 
    d.Date, 
    COALESCE(ROUND((s.Total_Spenders * 100.0) / d.Total_Active_Users, 2), 0) AS Conversion_Percentage
FROM Daily_Active_Users d
LEFT JOIN Daily_Spenders s ON d.Date = s.Date
ORDER BY d.Date;


3)	Revenue per User (DARPU): Total revenue generated on the day/total number of users who were active on that day.
Date	DARPU
2020-07-01	
2020-07-02	

WITH Daily_Active_Users AS (
    SELECT 
        Date, 
        COUNT(DISTINCT User_ID) AS Total_Active_Users
    FROM test.dau
    GROUP BY Date
),
Daily_Revenue AS (
    SELECT 
        DATE(Date_Time) AS Date, 
        SUM(Revenue) AS Total_Revenue
    FROM test.rev
    GROUP BY DATE(Date_Time)
)
SELECT 
    d.Date, 
    COALESCE(ROUND((r.Total_Revenue / d.Total_Active_Users), 2), 0) AS DARPU
FROM Daily_Active_Users d
LEFT JOIN Daily_Revenue r ON d.Date = r.Date
ORDER BY d.Date;


4)	Retention funnel 
a.	D2: (Out of players who were active on day 1, how many users came back the next day) 
b.	D7: (Out of players who were active on day 1, how many users came back on the 7th day)
Date	Total Players	D2	D7
2020-07-01	Total number of players who were active on 2020-07-01	Out of total players who were active on 2020-07-01, how many were active on 2020-07-2	Out of total players who were active on 2020-07-01, how many were active on 2020-07-07
2020-07-02	Total number of players who have come on 2020-07-02	Out of total players who were active on 2020-07-02, how many were active on 2020-07-3	Out of total players who were active on 2020-07-02, how many were active on 2020-07-08

WITH Daily_Active_Users AS (
    -- Count total active users per day
    SELECT 
        Date, 
        COUNT(DISTINCT User_ID) AS Total_Users
    FROM test.dau
    GROUP BY Date
),
D2_Retention AS (
    -- Count users who were active on Day 1 and returned on Day 2
    SELECT 
        d1.Date AS Day1,
        COUNT(DISTINCT d1.User_ID) AS Total_Players,
        COUNT(DISTINCT d2.User_ID) AS D2_Retained
    FROM test.dau d1
    LEFT JOIN test.dau d2 
        ON d1.User_ID = d2.User_ID 
        AND d2.Date = DATE_ADD(d1.Date, INTERVAL 1 DAY)
    GROUP BY d1.Date
),
D7_Retention AS (
    -- Count users who were active on Day 1 and returned on Day 7
    SELECT 
        d1.Date AS Day1,
        COUNT(DISTINCT d1.User_ID) AS Total_Players,
        COUNT(DISTINCT d7.User_ID) AS D7_Retained
    FROM test.dau d1
    LEFT JOIN test.dau d7 
        ON d1.User_ID = d7.User_ID 
        AND d7.Date = DATE_ADD(d1.Date, INTERVAL 7 DAY)
    GROUP BY d1.Date
)
SELECT 
    d.Date,
    d.Total_Users AS Total_Players,
    COALESCE(d2.D2_Retained, 0) AS D2,
    COALESCE(d7.D7_Retained, 0) AS D7
FROM Daily_Active_Users d
LEFT JOIN D2_Retention d2 ON d.Date = d2.Day1
LEFT JOIN D7_Retention d7 ON d.Date = d7.Day1
ORDER BY d.Date;




5)	Last 30-day Active Spenders: 
a.	ex: if you are calculating Last 30-day active spenders for June 2020-07-01, count (Players who spent at least once in the game in last 30days i.e. 2020-06-01 to 2020-07-01). 
Date	Last 30 Day Active Spenders
2020-07-01	
2020-07-02	

SELECT 
    d.Date,
    COUNT(DISTINCT r.User_ID) AS Last_30_Day_Active_Spenders
FROM (
    SELECT DISTINCT Date FROM test.dau
) d
LEFT JOIN test.rev r 
    ON DATE(r.Date_Time) BETWEEN DATE_SUB(d.Date, INTERVAL 29 DAY) AND d.Date
GROUP BY d.Date
ORDER BY d.Date;


6)	Cumulative Spend: 
a.	Ex: if a user spent 10$ on 2020-07-01 ,5$ on 2020-07-02 and 0$ on 2020-07-03, his cumulative spend was 10$ for 2020-07-01, 15$ on 2020-07-02 and 15$ on 2020-07-03
Date	User ID	Cumm Spend
2020-07-05	1279	
2020-07-06	1279	
2020-07-07	1279	
2020-07-08	1279	
2020-07-09	1279	


WITH Daily_User_Spend AS (
    SELECT 
        DATE(Date_Time) AS Transaction_Date, 
        User_ID, 
        SUM(Revenue) AS Daily_Spend
    FROM test.rev
    GROUP BY DATE(Date_Time), User_ID
),
Cumulative_Spend AS (
    SELECT 
        d1.Transaction_Date, 
        d1.User_ID, 
        SUM(d2.Daily_Spend) AS Cumm_Spend
    FROM Daily_User_Spend d1
    LEFT JOIN Daily_User_Spend d2
        ON d1.User_ID = d2.User_ID
        AND d2.Transaction_Date <= d1.Transaction_Date
    GROUP BY d1.Transaction_Date, d1.User_ID
)
SELECT 
    c.Transaction_Date AS Date, 
    c.User_ID, 
    c.Cumm_Spend
FROM Cumulative_Spend c
WHERE c.User_ID = 1279  -- Filter for User 1279 (Can be removed for all users)
ORDER BY c.User_ID, c.Transaction_Date;



Question 2: Stats

Assume that a typical computer manufactured by HP lasts 10 Months and that the standard deviation is 50 days. Computer life follows a normal distribution. What is the probability that a computer made by this company will last at most 1 Year? (Assume 1 month has approx. 30 days)

•	Mean (μ) = 10 months
•	Standard deviation (σ) = 50 days
•	We want to find the probability that a computer lasts at most 1 year
 
•	Mean lifespan (μ) = 10 months × 30 days/month = 300 days
•	Standard deviation (σ) = 50 days
•	Maximum lifespan (X) = 12 months × 30 days/month = 360 days
 
Z =360−300/50 = 60/50 =1.2
 
P(X≤360) = P(Z≤1.2)
From the Z-table 
P(Z≤1.2) = 0.8849

Final Answer: 88.49% 


Question 3: Stats

Assume we have divided our player base into two groups A and B. A has 20,000 players and B has 40,000 players. 
Games played per Player for Group A = 20
Games Played Per Player for Group B = 22
Standard Deviation for Group A = 5
Standard Deviation for Group B = 19

What is the confidence that Group B is better than Group A? Explain the methodology used.


Define the Hypothesis
•	Null Hypothesis = Group B is not significantly better than Group A 
•	Alternative Hypothesis = Group B is significantly better than Group A 
 
Given Data
•	Sample size for Group A: =20,000
•	Sample size for Group B: 40,000
•	Mean games played for Group A: 20
•	Mean games played for Group B: 22
•	Standard deviation for Group A: 5
•	Standard deviation for Group B: 19
 
Compute Standard Errors
The standard error for each group is the standard deviation divided by the square root of sample size
A. 0.0354
B. 0.095
The standard error of the difference in means:
= 0.1014
 
Compute Z-score
Which is the mean of B – mean of A divided by the standard error of difference
= 19.72
 
Compute Confidence Level
Using the normal distribution:
P(Z>19.72) = 0.0P
This means the p-value is essentially 0, and the probability that Group B is truly better than Group A is ~100%.
 
Conclusion
The Z-score of 19.72 is extremely high, meaning that the difference in means between Group B and Group A is statistically significant with near 100% confidence. We can confidently conclude that Group B plays more games per player than Group A.

