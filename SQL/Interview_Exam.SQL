player_table: Records info for all players of game A, one row per player

+--------------------+----------+
| Column Name        | Type     |
+--------------------+----------+
| player_id          | VARCHAR  |
| first_played_date  | date     |
| dlc_owned_count    | int      |
| country            | VARCHAR  |
+--------------------+----------+

entitlement_table: Records all player DLC entitlement for game A, one row per player per dlc

+--------------------+----------+
| Column Name        | Type     |
+--------------------+----------+
| player_id          | VARCHAR  |
| dlc_name           | VARCHAR  |
| entitlement_date   | date     |
+--------------------+----------+


engagement_table: Records summary of players daily engagement (login) for game A, one row per player per engagement date.

+---------------------+----------+
| Column Name         | Type     |
+---------------------+----------+
| player_id           | VARCHAR  |
| engagement_date     | date     |
| total_play_time_min | VARCHAR  |
+---------------------+----------+


Today is CURRENT_DATE()

1. Get total entitlement for each dlc, in the past 5 years (columns: dlc_name, total_entitlements).

SELECT
    dlc_name,
    COUNT(*) as total_entitlements
FROM entitlement
WHERE
    entitlement_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY 
    dlc_name
ORDER BY
    total_entitlements DESC

2. Get DAU (daily active user) count for the past 7 days, and the average daily play time for DAUs who have at least one dlc_entitlement (columns: date, DAU, avg_play_time_per_player)


WITH players_with_dlc AS (
    SELECT DISTINCT player_id
    FROM entitlement_table
),
filtered_engagement AS (
    SELECT 
        e.engagement_date AS date,
        e.player_id,
        CAST(e.total_play_time_min AS INT) AS play_time_min
    FROM engagement_table e
    JOIN players_with_dlc d ON e.player_id = d.player_id
    WHERE e.engagement_date >= CURRENT_DATE - INTERVAL '7 days'
),
DAU_7_days AS (
    SELECT
        date,
        COUNT(DISTINCT player_id) AS DAU,
        AVG(play_time_min) AS avg_play_time_per_player
    FROM filtered_engagement
    GROUP BY date
    ORDER BY date
)

SELECT * FROM DAU_7_days



3. What's the daily new player count and new players' D1, D7 retention, in the past 30 days? The result should have these columns: date, new_user_count, d1_retention, d7_retention (leavel column blank/NULL for players)



4. Get daily DAU in the past 30 day for each country, then use window function to calculate total DAU for that day. The result should have these columns: date, country, DAU_country, DAU_total.




5. Get a list of player_ids that had played the game for at least 7 consecutive days, in the past 180 days
