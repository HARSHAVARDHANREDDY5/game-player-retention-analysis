-- churn_timing_analysis.sql
-- Analysis of player churn timing by days active since signup
-- Follows strict analytical principles to avoid duplicates, missing churned users, or date math errors

WITH player_activity AS (
    -- LEFT JOIN to retain players who churned after first session
    SELECT
        p.player_id,
        p.signup_date,
        COALESCE(MAX(s.session_date), p.signup_date) AS last_active_date,
        CAST(
             julianday(COALESCE(MAX(s.session_date), p.signup_date))
             - julianday(p.signup_date)
               AS INTEGER
               ) AS days_active

    FROM players p
    LEFT JOIN sessions s
        ON p.player_id = s.player_id
    GROUP BY
        p.player_id,
        p.signup_date
)

SELECT
    player_id,
    signup_date,
    last_active_date,
    days_active,
    -- Bucket players by churn timing
    CASE
        WHEN days_active = 0 THEN '0 days'
        WHEN days_active BETWEEN 1 AND 3 THEN '1–3 days'
        WHEN days_active BETWEEN 4 AND 7 THEN '4–7 days'
        WHEN days_active BETWEEN 8 AND 14 THEN '8–14 days'
        ELSE '15+ days'
    END AS churn_bucket
FROM player_activity
ORDER BY signup_date;
