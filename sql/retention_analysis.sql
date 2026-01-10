-- Retention analysis: D1, D7, D30
-- Definition:
-- D1: active 1 day after signup
-- D7: active 7 days after signup
-- D30: active 30 days after signup

WITH player_activity AS (
    SELECT
        p.player_id,
        p.signup_date,
        s.session_date,
        CAST(julianday(s.session_date) - julianday(p.signup_date) AS INT) AS days_since_signup
    FROM players p
    LEFT JOIN sessions s
        ON p.player_id = s.player_id
)

SELECT
    signup_date,
    COUNT(DISTINCT player_id) AS total_players,
    COUNT(DISTINCT CASE WHEN days_since_signup = 1 THEN player_id END) AS d1_retained,
    COUNT(DISTINCT CASE WHEN days_since_signup = 7 THEN player_id END) AS d7_retained,
    COUNT(DISTINCT CASE WHEN days_since_signup = 30 THEN player_id END) AS d30_retained
FROM player_activity
GROUP BY signup_date
ORDER BY signup_date;
