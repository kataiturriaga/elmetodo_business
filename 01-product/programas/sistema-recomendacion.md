# Program Recommendation System
(Last update: 28 febrero - by claude + carles)

## Overview

The `/programs/recommended` endpoint returns personalized program recommendations using a **hybrid scoring system**. It replaces the old logic that only returned FREE programs sorted by popularity.

**Key changes from the old system:**
- Returns ALL programs (free + subscription), not just free
- Excludes programs the user has **ever** enrolled in (active + archived)
- Personalized scoring based on exercise history, continuations, and popularity
- Gender hard-filter from questionnaire
- Falls back to popularity for new users (cold start)

## Algorithm

### Scoring Formula

Each candidate program is scored with:

```
score = 0.45 * exercise_similarity
      + 0.25 * continuation_bonus
      + 0.15 * normalized_popularity
      + 0.10 * gender_match
      + 0.05 * location_affinity
```

Programs are returned sorted by score descending.

### Layer 1: Exercise Similarity (weight: 0.45)

**What it does:** Measures how much overlap exists between exercises the user has done and exercises in the candidate program.

**How it works:**
1. Collect all distinct `exercise_id` values the user has completed (`user_exercise_logs` where `completed = true`)
2. For each candidate program, collect all `exercise_id` values via the chain: `program → program_phases → program_phase_routines → training_days_v2 → training_day_exercises_v2`
3. Compute Jaccard similarity: `|intersection| / |union|`

**Why it works:** Programs with similar exercises target the same muscle groups and training style. A user who did "Definición extrema - Gym - 3 días" will get high similarity for "Definición extrema - Gym - 4 días" (77% exercise overlap) but low similarity for "Running 5km" (minimal overlap).

**Data from production (exercise overlap examples):**

| Program A | Program B | Shared Exercises | Jaccard |
|-----------|-----------|-----------------|---------|
| Programs 34/35 | Running variants | 26 | 1.00 |
| Programs 33/34 | Running variants | 25 | 0.96 |
| Programs 9/10 | Defn. Casa 4d/5d | 25 | 0.86 |
| Programs 2/3 | Defn. Gym 3d/4d | 27 | 0.77 |

### Layer 2: Continuation Bonus (weight: 0.25)

**What it does:** Boosts programs that are explicitly linked as "next program" from programs the user has enrolled in.

**How it works:**
1. Look up `program_continuations` for all programs the user has enrolled in
2. Score by position:
   - Position 0 or 1 → score = 1.0
   - Position 2 → score = 0.7
   - Position 3+ → score = 0.4
3. If a program appears as continuation of multiple enrolled programs, keep the highest score

**Why it works:** Continuations are manually curated progressions (e.g., beginner → intermediate). This is the strongest signal for "what should come next" when available.

### Layer 3: Popularity (weight: 0.15)

**What it does:** Normalized popularity score as social proof and cold-start tiebreaker.

**How it works:**
- `normalized_popularity = program.popularity_score / max(all_candidate_scores)`
- Score ranges from 0.0 to 1.0

**Why it's low-weight:** Popularity is a weak signal — it doesn't account for the user's specific needs. But it's useful when other signals are equal.

### Layer 4: Gender Match (weight: 0.10)

**What it does:** Hard filter + scoring. Programs that don't match the user's gender are excluded before scoring. Matching programs get score 1.0.

**Gender matching rules:**
- Program gender `all` or `NULL` → matches everyone
- User has no questionnaire → no filtering, score 1.0 for all
- Exact gender match → score 1.0

### Layer 5: Location Affinity (weight: 0.05)

**What it does:** Soft bonus for programs in locations the user has trained at before.

**How it works:**
1. Count `training_location` of all programs the user has enrolled in (ignoring `all`)
2. For each candidate: `score = count(location) / total_enrollments`
3. Programs with `training_location = 'all'` get score 1.0

**Why it's low-weight:** Location preference is derived from behavior, not stated. It's just a tiebreaker, not a filter.

## User States

| State | Behavior |
|-------|----------|
| **New user, no questionnaire** | All programs eligible, ranked by popularity only |
| **Has questionnaire, no enrollments** | Gender-filtered programs, ranked by popularity |
| **Has enrollment history** | Full hybrid scoring with all 5 layers |
| **All programs already enrolled** | Returns empty list |

## Exclusion Rules

A program is excluded if:
1. User has **any** enrollment for it (active, archived, or deleted-but-not-hard-deleted)
2. Program is soft-deleted (`deleted_at IS NOT NULL`)
3. Program gender doesn't match user's questionnaire gender

## API

### `GET /training/programs/recommended`

**Query parameters:**
- `limit` (int, default=4, max=50): Number of recommendations to return

**Response:** `List[ProgramCatalogItem]` — same schema as before, no breaking changes.

**Performance:**
- 3 SQL queries for user data (enrollments, exercise logs, questionnaire)
- 1 SQL query for candidate programs
- 1 SQL query for program exercise sets (bulk)
- 1 SQL query for continuations
- 1 SQL query for location preferences
- Scoring is done in Python (trivial for ~50 programs)

## Implementation

**Files:**
- `app/services/recommendation_service.py` — Scoring engine
- `app/api/routes/mobile/programs.py` — `/recommended` endpoint (calls the service)

**Key methods in `RecommendationService`:**

| Method | Purpose |
|--------|---------|
| `get_recommendations()` | Main entry point. Orchestrates data gathering and scoring |
| `_score_program()` | Computes hybrid score for a single program |
| `_get_user_exercise_ids()` | Distinct exercises user has completed |
| `_get_program_exercise_sets()` | Bulk-loads exercise sets for all candidate programs |
| `_get_continuation_targets()` | Continuation links from enrolled programs |
| `_get_location_preference()` | Location frequency counter from enrollment history |

## Why Not ML

1. **49 programs** — too few items for collaborative filtering
2. **Sparse interaction data** — most users have 1-3 enrollments
3. **Deterministic scoring is debuggable** — can explain exactly why a program was recommended
4. **No training pipeline needed** — no model to retrain, deploy, or monitor
5. **Exercise similarity is already strong** — Jaccard index captures the real relationships between programs
6. **Same API contract** — can swap in ML later without changing the endpoint

## Future Improvements

- **Track program detail views** → add "viewed but not enrolled" as a negative signal
- **Weight by recency** → more recent enrollments could have higher influence
- **Completion rate** → boost programs similar to ones user actually finished (vs abandoned)
- **A/B testing** → compare recommendation quality with different weight configurations
Collapse




Carles Mallafré
  10:20 AM