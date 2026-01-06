# Dataset Schema

## players
Stores static player-level information.

- player_id (int): Unique identifier for each player
- signup_date (date): Date when the player first registered
- country (string): Player's country
- platform (string): Platform used (PC / Console)

## sessions
Stores session-level behavioral data.

- session_id (int): Unique identifier for each session
- player_id (int): References players.player_id
- session_date (date): Date of gameplay session
- session_duration_minutes (int): Length of session
- level_reached (int): Highest level reached during session
- events_completed (int): Number of in-game events completed
- purchase_amount (float): Amount spent during session (0 if none)

## Assumptions
- One player can have multiple sessions
- purchase_amount is 0 for non-paying sessions
- Data covers at least 30 days post signup
- Churn is defined as no activity for 7 consecutive days
