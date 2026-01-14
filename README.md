Game Player Retention & Churn Analysis

SQL • SQLite • Power BI

Project Overview

This project analyzes player churn timing after signup to understand early-game retention behavior in a video game environment. The objective is to identify when players are most likely to drop off and quantify churn across defined time windows — a core problem in game analytics and live-ops decision-making.

The analysis focuses on early churn (Day 0–3) versus longer-term engagement, using SQL for accurate retention logic and Power BI for stakeholder-ready visualization.

Dataset

The dataset is synthetically generated to closely simulate real-world game telemetry while avoiding proprietary or sensitive data.

Why generated data?

Public datasets rarely capture realistic session-level churn behavior

Allows full control over early exits, mid-term churn, and long-tail retention

Mirrors production-style schemas commonly used in game analytics teams

Tables Included

players.csv

player_id

signup_date

sessions.csv

session_id

player_id

session_date

The data generation logic was iteratively refined to correct unrealistically high Day-1 retention and properly model immediate churn, a common pitfall in retention simulations.

Analysis Performed

All analysis was executed in SQLite using SQL, following strict analytical practices to avoid:

Duplicate player counts

Incorrect date arithmetic

Accidental exclusion of churned users

Key Analyses

Last activity calculation per player

Days active since signup

Churn timing bucket classification

Aggregated churn distribution by bucket

Churn Buckets

0 days

1–3 days

4–7 days

8–14 days

15+ days

Key Insights

Over 40% of players churn within the first 3 days, indicating a critical onboarding risk window

A meaningful long-tail of players (15+ days) exists, suggesting strong retention potential when early experience succeeds

Day 0 churn is significant, highlighting the importance of first-session experience, performance, and UX

These patterns closely align with real-world free-to-play and mobile game retention behavior.

Recommendation

Since a large portion of churn occurs within the first 3 days, product and live-ops teams should prioritize:

Improving first-session experience

Clearer tutorials and onboarding flow

Early rewards or progression incentives

Optimizing this early window can significantly improve overall retention.

Dashboard (Power BI)

The final results were visualized in Power BI to clearly communicate insights to non-technical stakeholders.

Dashboard Includes

Player count by churn bucket

Percentage distribution of churn timing

Interactive slicers for exploration

Dashboard Preview






Tools & Technologies

Python (data generation)

SQLite

SQL

Power BI

Git & GitHub

Project Structure
game-player-retention-analysis/
│
├── data/
│   ├── raw/
│   │   ├── players.csv
│   │   └── sessions.csv
│
├── sql/
│   ├── churn_timing_analysis.sql
│   └── churn_bucket_summary.sql
│
├── powerbi/
│
├── screenshots/
│
├── data_generation.py
└── README.md

Limitations

Data is synthetic and does not include monetization or in-game event telemetry

Retention is measured using session activity only, not engagement depth or spend

Why This Project Matters

This project demonstrates:

Correct and defensible retention & churn logic

Strong SQL-first analytical approach

Ability to convert analysis into business insights

End-to-end ownership from data creation to visualization

This workflow mirrors expectations for entry-level data analyst and game analytics roles.
