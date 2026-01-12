-- churn_bucket_summary.sql
-- Aggregated summary of player churn by bucket
-- Uses churn timing logic from churn_timing_analysis.sql

WITH player_activity AS (
    SELECT
        p.player_id,
        p.signup_date,
        COALESCE(MAX(s.session_date), p.signup_date) AS last_active_date,
        CAST(
            julianday(COALESCE(MAX(s.session_date), p.signup_date))
            - julianday(p.signup_date) AS INTEGER
        ) AS days_active
    FROM players p
    LEFT JOIN sessions s
        ON p.player_id = s.player_id
    GROUP BY
        p.player_id,
        p.signup_date
),
churned_players AS (
    SELECT
        player_id,
        CASE
            WHEN days_active = 0 THEN '0 days'
            WHEN days_active BETWEEN 1 AND 3 THEN '1–3 days'
            WHEN days_active BETWEEN 4 AND 7 THEN '4–7 days'
            WHEN days_active BETWEEN 8 AND 14 THEN '8–14 days'
            ELSE '15+ days'
        END AS churn_bucket
    FROM player_activity
),
bucket_counts AS (
    SELECT
        churn_bucket,
        COUNT(DISTINCT player_id) AS player_count
    FROM churned_players
    GROUP BY churn_bucket
)
SELECT
    churn_bucket,
    player_count,
    ROUND(
        player_count * 100.0 / SUM(player_count) OVER (),
        2
    ) AS percentage
FROM bucket_counts
ORDER BY
    -- intuitive order for churn: shortest to longest
    CASE churn_bucket
        WHEN '0 days' THEN 1
        WHEN '1–3 days' THEN 2
        WHEN '4–7 days' THEN 3
        WHEN '8–14 days' THEN 4
        ELSE 5
    END;
