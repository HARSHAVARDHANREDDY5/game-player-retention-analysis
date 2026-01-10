import pandas as pd
import numpy as np
import random
from datetime import timedelta

np.random.seed(42)

# -----------------------------
# CONFIG
# -----------------------------
NUM_PLAYERS = 600
MAX_DAYS = 30
COUNTRIES = ["US", "CA", "UK", "FR", "DE"]
PLATFORMS = ["PC", "Console"]

# -----------------------------
# PLAYERS TABLE
# -----------------------------
players = []

start_date = pd.to_datetime("2024-01-01")

for player_id in range(1, NUM_PLAYERS + 1):
    signup_offset = np.random.randint(0, 7)
    signup_date = start_date + timedelta(days=signup_offset)

    players.append({
        "player_id": player_id,
        "signup_date": signup_date,
        "country": random.choice(COUNTRIES),
        "platform": random.choice(PLATFORMS)
    })

players_df = pd.DataFrame(players)

# -----------------------------
# SESSIONS TABLE
# -----------------------------
sessions = []
session_id = 1

for _, player in players_df.iterrows():
    churn_day = np.random.choice(
        [3, 7, 14, 30],
        p=[0.30, 0.25, 0.20, 0.25]
    )

    max_level = np.random.choice(
        [5, 10, 15, 20],
        p=[0.25, 0.30, 0.25, 0.20]
    )

    is_payer = np.random.rand() < 0.12

    current_level = 1

    for day in range(churn_day):
        session_date = player["signup_date"] + timedelta(days=day)

        sessions_per_day = np.random.randint(1, 3)

        for _ in range(sessions_per_day):
            session_duration = np.random.randint(
                10, 90 if is_payer else 60
            )

            # Simulate level progression slowdown
            if current_level < max_level:
                level_increase_chance = 0.7 if current_level < 6 else 0.4
                if np.random.rand() < level_increase_chance:
                    current_level += 1

            purchase_amount = 0
            if is_payer and np.random.rand() < 0.2:
                purchase_amount = round(np.random.uniform(1, 50), 2)

            sessions.append({
                "session_id": session_id,
                "player_id": player["player_id"],
                "session_date": session_date,
                "session_duration_minutes": session_duration,
                "level_reached": current_level,
                "events_completed": np.random.randint(0, 8),
                "purchase_amount": purchase_amount
            })

            session_id += 1

sessions_df = pd.DataFrame(sessions)

# -----------------------------
# SAVE FILES
# -----------------------------
players_df.to_csv("data/raw/players.csv", index=False)
sessions_df.to_csv("data/raw/sessions.csv", index=False)

print("Data generation complete.")
print(f"Players: {players_df.shape}")
print(f"Sessions: {sessions_df.shape}")
