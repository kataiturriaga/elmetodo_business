# Analytics Tracking System

Complete reference for the El Método analytics implementation. This document covers every event, parameter, user property, and Firebase Audience used for marketing, engagement tracking, and push notification targeting.

**Analytics Provider**: Firebase Analytics (GA4)
**Infrastructure Status**: Built (`lib/core/analytics/`) — event enum, parameter constants, user properties, Riverpod provider, debug/production switching.
**Current Coverage**: 2 of 34 predefined events wired (`logout_success`, `account_deleted`).

---

## Executive Summary

### Numbers at a Glance

| Metric | Count |
|--------|-------|
| Total custom events | 75 |
| Automatic screen views | 37 screens |
| User properties | 22 (of 25 max) |
| Firebase Audiences | 22 |
| GA4 custom dimensions to register | 43 event-scoped + 12 user-scoped |
| Files to modify | 28 |
| New files to create | 1 (`analytics_route_observer.dart`) |

---

## All Proposed Events (Master Table)

Every custom event we will track, organized by domain. Status column indicates whether the event already exists in the codebase enum or is new.

### Screen Views (37 — automatic via route observer)

These fire automatically on every navigation. No manual code needed per screen.

| # | Route | `screen_name` | Widget Class |
|---|-------|---------------|--------------|
| 1 | `/` | `home` | `HomeScreen` |
| 2 | `/training` | `training` | `TrainingScreen` |
| 3 | `/ranking` | `ranking` | `CommunityScreen` |
| 4 | `/explore` | `explore` | `ExploreScreen` |
| 5 | `/profile` | `profile` | `ProfileScreen` |
| 6 | `/login` | `login` | `LoginScreen` |
| 7 | `/login/email` | `login_email` | `EmailLoginScreen` |
| 8 | `/onboarding` | `onboarding` | `WelcomeScreen` |
| 9 | `/onboarding/home-preview` | `onboarding_home_preview` | `OnboardingHomePreviewScreen` |
| 10 | `/training/onboarding-tip` | `training_onboarding_tip` | `OnboardingTipScreen` |
| 11 | `/training/choose-program` | `training_choose_program` | `ChooseProgramScreen` |
| 12 | `/training/program-video` | `training_program_video` | `ProgramVideoScreen` |
| 13 | `/training/location` | `training_location` | `LocationSelectionScreen` |
| 14 | `/training/session` | `training_session` | `TrainingSessionScreen` |
| 15 | `/training/day` | `training_day` | `TrainingDayScreen` |
| 16 | `/training/exercise` | `exercise_detail` | `ExerciseDetailScreen` |
| 17 | `/training/exercise-video` | `exercise_video` | `ExerciseVideoScreen` |
| 18 | `/training/exercise-history` | `exercise_history` | `ExerciseHistoryScreen` |
| 19 | `/training/session-records` | `session_records` | `SessionRecordsScreen` |
| 20 | `/training/catalog` | `programs_catalog` | `ProgramsCatalogScreen` |
| 21 | `/training/program-detail` | `program_detail` | `ProgramDetailScreen` |
| 22 | `/training/complete` | `training_complete` | `TrainingCompleteScreen` |
| 23 | `/training/rate` | `training_rate` | `TrainingRateScreen` |
| 24 | `/explore/recipes` | `recipe_list` | `RecipeListScreen` |
| 25 | `/explore/recipes/detail` | `recipe_detail` | `RecipeDetailScreen` |
| 26 | `/explore/guides` | `guide_list` | `GuideListScreen` |
| 27 | `/explore/guides/category` | `guide_category` | `GuideCategoryScreen` |
| 28 | `/explore/guides/video` | `guide_video` | `GuideVideoScreen` |
| 29 | `/explore/calculator` | `calorie_calculator` | `CalorieCalculatorScreen` |
| 30 | `/explore/calculator/result` | `calorie_calculator_result` | `CalorieCalculatorResultScreen` |
| 31 | `/explore/history` | `program_history` | `ProgramHistoryScreen` |
| 32 | `/profile/gender` | `profile_edit_gender` | `GenderEditScreen` |
| 33 | `/profile/age` | `profile_edit_age` | `AgeEditScreen` |
| 34 | `/profile/weight` | `profile_edit_weight` | `WeightEditScreen` |
| 35 | `/profile/height` | `profile_edit_height` | `HeightEditScreen` |
| 36 | `/delete-account` | `delete_account` | `DeleteAccountScreen` |
| 37 | `/legal` | `legal_info` | `LegalInfoScreen` |

### Custom Events (75 total)

| # | Event Name | Domain | Status | Parameters | When Fired |
|---|-----------|--------|--------|------------|------------|
| | **AUTHENTICATION** | | | | |
| 1 | `login_attempt` | Auth | Exists | `method` | User taps any login button |
| 2 | `login_success` | Auth | Exists | `method`, `is_new_user`, `is_guest` | Login succeeds |
| 3 | `login_failure` | Auth | Exists | `method`, `error_code` | Login fails |
| 4 | `sign_up_success` | Auth | Exists | `method` | New account created |
| 5 | `sign_up_failure` | Auth | Exists | `method`, `error_code` | Signup fails |
| 6 | `guest_login` | Auth | Exists | `device_id` | Guest auth with device ID |
| 7 | `guest_upgrade` | Auth | Exists | `method` | Guest registers / links account |
| 8 | `logout_success` | Auth | **Wired** | — | User logs out |
| 9 | `account_deleted` | Auth | **Wired** | — | Account deletion completes |
| 10 | `session_expired` | Auth | Exists | — | Token refresh fails |
| 11 | `google_sign_in_start` | Auth | Exists | — | Taps Google button |
| 12 | `google_sign_in_success` | Auth | Exists | `is_new_user` | Google auth completes |
| 13 | `google_sign_in_cancel` | Auth | Exists | — | User cancels Google flow |
| 14 | `apple_sign_in_start` | Auth | Exists | — | Taps Apple button |
| 15 | `apple_sign_in_success` | Auth | Exists | `is_new_user` | Apple auth completes |
| 16 | `apple_sign_in_cancel` | Auth | Exists | — | User cancels Apple flow |


| | **ONBOARDING** | | | | |
| 17 | `onboarding_start` | Onboarding | Exists | — | WelcomeScreen shown |
| 18 | `onboarding_complete` | Onboarding | Exists | — | User finishes onboarding |
| 19 | `onboarding_skip` | Onboarding | Exists | — | User skips onboarding |


| | **TRAINING ONBOARDING** | | | | |
| 20 | `training_onboarding_continue_clicked` | Training Onboarding | **New** | — | User taps "Continuar" on training tip screen |
| 21 | `program_start_intent_clicked` | Training Onboarding | **New** | `template_id` | User taps "Empezar programa" on choose program screen |
| 22 | `program_video_viewed` | Training Onboarding | **New** | `program_id` | Program video screen is displayed |
| 23 | `program_video_continue_clicked` | Training Onboarding | **New** | `program_id` | User taps "Continuar" after watching video |
| 24 | `program_enroll_intent_clicked` | Training Onboarding | **New** | `program_id` | User taps "Suscribirse" on location selection |
| 25 | `signup_method_selected` | Training Onboarding | **New** | `method`, `entry_point`, `program_id` | User selects signup method (google/apple/email) |
| 26 | `signup_completed` | Training Onboarding | **New** | `method`, `is_new_user`, `program_id` | System confirms user authenticated after signup |


| | **TRAINING** | | | | |
| 27 | `program_view` | Training | **New** | `program_id`, `program_name`, `content_type` | User views program detail |
| 28 | `program_video_play` | Training | **New** | `program_id`, `program_name` | Watches program intro video |
| 29 | `program_enroll` | Training | **New** | `program_id`, `program_name`, `location`, `level`, `entry_point`, `program_type`, `program_goal`, `program_secondary_goal` | User subscribes to program |
| 30 | `program_complete` | Training | **New** | `program_id`, `program_name`, `total_days`, `duration_weeks` | All training days completed |
| 31 | `program_unenroll` | Training | **New** | `program_id`, `program_name`, `completed_days`, `total_days` | User leaves program early |
| 32 | `training_session_start` | Training | **New** | `program_id`, `day_name`, `week_number` | Starts a training day |
| 33 | `training_session_complete` | Training | **New** | `program_id`, `day_name`, `week_number`, `duration_seconds`, `exercises_completed` | Finishes a session |
| 34 | `training_session_rate` | Training | **New** | `program_id`, `rating`, `perceived_effort` | Rates session difficulty |
| 35 | `exercise_start` | Training | **New** | `exercise_id`, `exercise_name`, `program_id` | Opens exercise detail |
| 36 | `exercise_set_log` | Training | **New** | `exercise_id`, `exercise_name`, `set_number`, `weight`, `reps` | Logs a set |
| 37 | `exercise_video_play` | Training | **New** | `exercise_id`, `exercise_name` | Watches exercise demo video |
| 38 | `exercise_history_view` | Training | **New** | `exercise_id`, `exercise_name` | Views exercise PR/history |
| 39 | `training_tab_select` | Training | **New** | `tab_name` | Switches training tab |
| 40 | `catalog_filter_apply` | Training | **New** | `gender`, `location`, `level`, `objective` | Applies catalog filters |
| 41 | `training_location_select` | Training | **New** | `location` | Selects training location |
| 42 | `continuation_program_view` | Training | **New** | `program_id`, `program_name` | Views continuation suggestion |
| 43 | `continuation_reminder_set` | Training | **New** | `program_id` | Sets continuation reminder |


| | **PEDOMETER / STEPS** | | | | |
| 44 | `pedometer_enabled` | Pedometer | Exists | `source` | User enables steps |
| 45 | `pedometer_disabled` | Pedometer | Exists | — | User disables steps |
| 46 | `pedometer_permission_granted` | Pedometer | Exists | — | Grants health permission |
| 47 | `pedometer_permission_denied` | Pedometer | Exists | — | Denies health permission |
| 48 | `pedometer_sync_success` | Pedometer | Exists | `steps`, `calories`, `source` | Data synced to backend |


| | **EXPLORE / CONTENT** | | | | |
| 49 | `recipe_view` | Explore | **New** | `recipe_id`, `recipe_name`, `content_type` | Opens recipe detail |
| 50 | `recipe_favorite` | Explore | **New** | `recipe_id`, `recipe_name` | Favorites a recipe |
| 51 | `recipe_unfavorite` | Explore | **New** | `recipe_id`, `recipe_name` | Unfavorites a recipe |
| 52 | `recipe_mode_select` | Explore | **New** | `recipe_id`, `mode` | Selects recipe mode (ligero/normal/bestia) |
| 53 | `recipe_filter_apply` | Explore | **New** | `meal_types`, `is_spicy`, `favorites_only` | Applies recipe filters |
| 54 | `guide_category_view` | Explore | **New** | `category_id`, `category_name`, `content_type` | Opens guide category |
| 55 | `guide_video_play` | Explore | **New** | `video_id`, `video_name`, `category_name` | Plays guide video |
| 56 | `calculator_start` | Explore | **New** | — | Opens calorie calculator |
| 57 | `calculator_complete` | Explore | **New** | `goal`, `gender`, `age`, `activity_level`, `bmr`, `tdee`, `goal_calories` | Sees calculator results |
| 58 | `program_history_view` | Explore | **New** | — | Opens training history |
| 59 | `explore_section_tap` | Explore | **New** | `section_name` | Taps explore card |


| | **RANKING / COMMUNITY** | | | | |
| 60 | `ranking_view` | Ranking | Exists | `filter_type` | Views ranking screen |
| 61 | `ranking_enrolled` | Ranking | Exists | — | Joins ranking competition |
| 62 | `ranking_filter_change` | Ranking | **New** | `filter_type` | Switches ranking filter |


| | **PROFILE** | | | | |
| 63 | `profile_view` | Profile | Exists | — | Opens profile screen |
| 64 | `profile_field_update` | Profile | Exists | `field_name`, `value` | Updates any profile field |
| 65 | `profile_photo_change` | Profile | Exists | — | Changes profile picture |


| | **ACTIVITY LOGGING** | | | | |
| 66 | `activity_create` | Activity | Exists | `activity_type`, `duration_minutes` | Logs manual activity |
| 67 | `activity_delete` | Activity | Exists | `activity_type` | Deletes an activity |


| | **APP ENGAGEMENT** | | | | |
| 68 | `tab_select` | Engagement | **New** | `tab_name` | Bottom nav tap |
| 69 | `share_content` | Engagement | Exists | `content_type`, `content_id`, `item_name` | Any share action |
| 70 | `notification_received` | Engagement | **New** | `notification_type` | Push notification arrives |
| 71 | `notification_tap` | Engagement | **New** | `notification_type`, `action` | User taps notification |


| | **ERRORS** | | | | |
| 72 | `error_occurred` | Error | Exists | `error_type`, `error_code`, `error_message` | Generic error |
| 73 | `network_error` | Error | Exists | `endpoint`, `status_code`, `error_message` | Network failure |
| 74 | `api_error` | Error | Exists | `endpoint`, `status_code`, `error_code` | API error response |


| | **APP LIFECYCLE** | | | | |
| 75 | `app_open` | Lifecycle | Exists | — | App launched |

**Summary by status**:
- **Wired** (already sending data): 2 events
- **Exists** (in enum, not wired): 36 events
- **New** (must add to enum + wire): 37 events

---

## All User Properties (22 of 25 max)

| # | Property | Values | Status | Set When | Marketing Use |
|---|----------|--------|--------|----------|---------------|
| 1 | `is_guest` | `true` / `false` | Exists | Login | Segment guests vs registered |
| 2 | `auth_method` | `google` / `apple` / `email` / `guest` | Exists | Login | Auth method breakdown |
| 3 | `pedometer_enabled` | `true` / `false` | Exists | Toggle | Steps feature adoption |
| 4 | `notifications_enabled` | `true` / `false` | Exists | Permission | Push notification eligibility |
| 5 | `app_version` | `1.2.3` | Exists | App start | Version-specific campaigns |
| 6 | `platform` | `ios` / `android` | Exists | App start | Platform targeting |
| 7 | `language` | `es` / `en` | Exists | App start | Language targeting |
| 8 | `theme` | `dark` / `light` | Exists | App start | — |
| 9 | `account_created_at` | ISO date | Exists | Registration | New user campaigns |
| 10 | `last_login_at` | ISO date | Exists | Login | Recency targeting |
| 11 | `gender` | `male` / `female` | **New** | Profile update | Gender-targeted campaigns |
| 12 | `age_group` | `18_24` / `25_34` / `35_44` / `45_54` / `55_plus` | **New** | Profile update | Age-targeted content |
| 13 | `fitness_goal` | `lose_weight` / `maintain` / `gain_muscle` | **New** | Calculator / questionnaire | Goal-specific programs |
| 14 | `training_level` | `beginner` / `intermediate` / `advanced` | **New** | Program enrollment | Level-appropriate suggestions |
| 15 | `training_location` | `gym` / `home_bands` / `home_dumbbells` | **New** | Location selection | Location-specific programs |
| 16 | `has_active_program` | `true` / `false` | **New** | Enroll / unenroll / complete | Re-engagement campaigns |
| 17 | `active_program_name` | Program name string | **New** | Program enrollment | Program-specific messaging |
| 18 | `completed_programs` | Count as string (`0`, `1`, `2`...) | **New** | Program completion | Loyalty / progression campaigns |
| 19 | `days_since_last_training` | `0` / `1_7` / `8_14` / `15_30` / `30_plus` | **New** | Session complete / app open | Churn prevention |
| 20 | `total_training_sessions` | Count as string | **New** | Session completion | Engagement tiers |
| 21 | `favorite_recipes_count` | Count as string | **New** | Favorite toggle | Content engagement |
| 22 | `has_used_calculator` | `true` / `false` | **New** | Calculator completion | Feature adoption |

**Remaining slots**: 3 (reserved for future use, e.g. `subscription_status` for monetization)

---

## All Firebase Audiences (22)

These are user segments created in Firebase Console. They auto-populate based on events + user properties and can be used as targets for push notifications via Firebase Cloud Messaging.

### Acquisition & Activation (4)

| # | Audience Name | Condition | Push Notification Campaign |
|---|--------------|-----------|---------------------------|
| 1 | New Users (7d) | `account_created_at` within last 7 days | Welcome series, onboarding tips |
| 2 | Guests Not Registered | `is_guest = true` for 3+ days | "Create an account to save your progress!" |
| 3 | Registered No Program | `is_guest = false` AND `has_active_program = false` | "Start your first program today!" |
| 4 | Onboarding Dropoff | `onboarding_start` fired but NOT `onboarding_complete` | "Complete your setup to get started" |

### Engagement & Retention (7)

| # | Audience Name | Condition | Push Notification Campaign |
|---|--------------|-----------|---------------------------|
| 5 | Active Trainers | `training_session_complete` in last 7 days | Motivational content, new features |
| 6 | Lapsed Trainers (7-14d) | `has_active_program = true` AND `days_since_last_training = 8_14` | "We miss you! Get back on track" |
| 7 | Churning Users (30d+) | `days_since_last_training = 30_plus` | Win-back with special program offer |
| 8 | Completed a Program | `program_complete` event fired | "Ready for your next challenge?" |
| 9 | High Step Counters | `pedometer_enabled = true` AND high step patterns | Community challenges |
| 10 | Recipe Enthusiasts | `favorite_recipes_count >= 3` | "New recipes just added!" |
| 11 | Calculator Users | `has_used_calculator = true` | Nutrition-focused content |

### Segmentation by Profile (8)

| # | Audience Name | Condition | Push Notification Campaign |
|---|--------------|-----------|---------------------------|
| 12 | Gym Users | `training_location = gym` | Gym-specific programs and tips |
| 13 | Home Workout Users | `training_location` starts with `home_` | Home workout content |
| 14 | Weight Loss Goal | `fitness_goal = lose_weight` | Diet tips, cardio programs |
| 15 | Muscle Gain Goal | `fitness_goal = gain_muscle` | Strength programs, protein recipes |
| 16 | Beginners | `training_level = beginner` | Intro content, technique guides |
| 17 | Advanced Athletes | `training_level = advanced` AND `total_training_sessions >= 50` | Advanced programs, PRs |
| 18 | Men 25-34 | `gender = male` AND `age_group = 25_34` | Targeted program ads |
| 19 | Women 25-34 | `gender = female` AND `age_group = 25_34` | Targeted program ads |

### Lifecycle (3)

| # | Audience Name | Condition | Push Notification Campaign |
|---|--------------|-----------|---------------------------|
| 20 | Power Users | 5+ `training_session_complete` in 7 days | Beta features, referral program |
| 21 | Feature Discoverers | Used 3+ features (training + recipes + calculator + ranking) | Cross-feature promotion |
| 22 | Notification Opted-In | `notifications_enabled = true` | All push campaigns (base audience) |

---

## All Event Parameters (43 unique keys)

Every parameter key used across events. Each must be registered as a **custom dimension** in GA4 Console.

| # | Parameter Key | Type | Used By Events | Example Value |
|---|--------------|------|----------------|---------------|
| 1 | `method` | string | Auth events | `google`, `apple`, `email` |
| 2 | `is_new_user` | boolean | `login_success`, social auth | `true` |
| 3 | `is_guest` | boolean | `login_success` | `true` |
| 4 | `error_code` | string | Failure events | `auth/invalid-email` |
| 5 | `error_message` | string | Error events | `Network timeout` |
| 6 | `device_id` | string | `guest_login` | `elmetodo_uuid-v4` |
| 7 | `content_type` | string | View events | `program`, `recipe`, `guide` |
| 8 | `content_id` | string | Share events | `123` |
| 9 | `item_name` | string | Share events | `Programa Fuerza` |
| 10 | `program_id` | int | Training events | `42` |
| 11 | `program_name` | string | Training events | `Fuerza Básica` |
| 12 | `exercise_id` | int | Exercise events | `156` |
| 13 | `exercise_name` | string | Exercise events | `Press banca` |
| 14 | `day_name` | string | Session events | `Día 1 - Pecho` |
| 15 | `week_number` | int | Session events | `3` |
| 16 | `duration_seconds` | int | `training_session_complete` | `2400` |
| 17 | `exercises_completed` | int | `training_session_complete` | `6` |
| 18 | `set_number` | int | `exercise_set_log` | `3` |
| 19 | `weight` | double | `exercise_set_log` | `80.0` |
| 20 | `reps` | int | `exercise_set_log` | `10` |
| 21 | `rating` | int | `training_session_rate` | `4` |
| 22 | `perceived_effort` | int | `training_session_rate` | `7` |
| 23 | `location` | string | Training events | `gym`, `home_bands` |
| 24 | `level` | string | Training events | `beginner` |
| 25 | `total_days` | int | Program events | `24` |
| 26 | `completed_days` | int | `program_unenroll` | `18` |
| 27 | `duration_weeks` | int | `program_complete` | `4` |
| 28 | `tab_name` | string | Tab events | `training`, `catalog` |
| 29 | `objective` | string | `catalog_filter_apply` | `fuerza` |
| 30 | `recipe_id` | int | Recipe events | `89` |
| 31 | `recipe_name` | string | Recipe events | `Pollo con arroz` |
| 32 | `mode` | string | `recipe_mode_select` | `ligero`, `normal`, `bestia` |
| 33 | `meal_types` | string | `recipe_filter_apply` | `desayuno,comida` |
| 34 | `section_name` | string | `explore_section_tap` | `recipes`, `guides` |
| 35 | `category_id` | int | Guide events | `5` |
| 36 | `category_name` | string | Guide events | `Técnica` |
| 37 | `video_id` | int | Video events | `22` |
| 38 | `video_name` | string | Video events | `Sentadilla correcta` |
| 39 | `template_id` | string | Training onboarding events | `Fuerza Básica` |
| 40 | `entry_point` | string | `program_enroll` | `onboarding`, `catalog` |
| 41 | `program_type` | string | `program_enroll` | `Completo`, `Base`, `Subscripcion`, `Gratis` |
| 42 | `program_goal` | string | `program_enroll` | `Fuerza`, `Hipertrofia` |
| 43 | `program_secondary_goal` | string | `program_enroll` | `Ganar masa muscular` |

> Less frequently used parameters (`goal`, `gender`, `age`, `activity_level`, `bmr`, `tdee`, `goal_calories`, `filter_type`, `field_name`, `value`, `notification_type`, `action`, `activity_type`, `duration_minutes`, `source`, `steps`, `calories`, `endpoint`, `status_code`, `error_type`, `is_spicy`, `favorites_only`) are documented in the detailed event sections below.

---

## Table of Contents

1. [Event Naming Convention](#event-naming-convention)
2. [Existing Infrastructure](#existing-infrastructure)
3. [Screen Views](#1-screen-views)
4. [Authentication Events](#2-authentication-events)
5. [Onboarding Events](#3-onboarding-events)
6. [Training Onboarding Events](#3a-training-onboarding-events)
7. [Training Events](#4-training-events)
8. [Pedometer / Steps Events](#5-pedometer--steps-events)
9. [Explore / Content Events](#6-explore--content-events)
10. [Ranking / Community Events](#7-ranking--community-events)
11. [Profile Events](#8-profile-events)
12. [Activity Logging Events](#9-activity-logging-events)
13. [App Engagement Events](#10-app-engagement-events)
14. [User Properties](#user-properties)
15. [Firebase Audiences](#firebase-audiences)
16. [Implementation Guide](#implementation-guide)
17. [GA4 Custom Dimensions Checklist](#ga4-custom-dimensions-registration-checklist)
18. [Verification](#verification)
19. [Key Files Reference](#key-files-reference)

---

## Event Naming Convention

Following [GA4 best practices](https://support.google.com/analytics/answer/13316687):

| Rule | Detail |
|------|--------|
| **Format** | `snake_case`, all lowercase |
| **Structure** | `{domain}_{action}` or `{action}_{object}` (verb_noun) |
| **Max length** | 40 characters |
| **Reserved prefixes** | Never use `ga_`, `firebase_`, `google_` |
| **Max custom events** | 500 per project |
| **Max parameters per event** | 25 |
| **Max user properties** | 25 |

### Reusable Verbs

Use these verbs consistently across all domains:

| Verb | Meaning | Example |
|------|---------|---------|
| `view` | User sees content | `recipe_view`, `program_view` |
| `select` | User chooses an option | `tab_select`, `recipe_mode_select` |
| `start` | User begins a flow | `training_session_start`, `calculator_start` |
| `complete` | User finishes a flow | `training_session_complete`, `onboarding_complete` |
| `create` | User creates something | `activity_create` |
| `delete` | User removes something | `activity_delete` |
| `tap` | User taps a UI element | `explore_section_tap` |
| `play` | User plays media | `guide_video_play`, `exercise_video_play` |
| `apply` | User applies a filter | `catalog_filter_apply`, `recipe_filter_apply` |
| `enroll` | User joins something | `program_enroll`, `ranking_enrolled` |

### Reusable Parameter Keys

These parameters appear across multiple events for cross-domain correlation:

| Key | Type | Used In |
|-----|------|---------|
| `content_type` | `string` | `program`, `recipe`, `guide`, `exercise` |
| `content_id` | `string` | Any content item's ID |
| `item_name` | `string` | Human-readable name of any item |
| `method` | `string` | Auth method (`google`, `apple`, `email`, `guest`) |
| `error_code` | `string` | Error identifiers |

---

## Existing Infrastructure

### Files

| File | Purpose |
|------|---------|
| `lib/core/analytics/analytics_service.dart` | Abstract interface, `AnalyticsEvent` enum, `AnalyticsParams`, `UserProperties` |
| `lib/core/analytics/firebase_analytics_service.dart` | Firebase Analytics implementation |
| `lib/core/analytics/noop_analytics_service.dart` | No-op implementation for debug mode |
| `lib/core/analytics/analytics_providers.dart` | Riverpod provider + helper extensions |

### Provider Setup

```dart
// In debug mode → NoopAnalyticsService (no data pollution)
// In production → FirebaseAnalyticsService
final analytics = ref.read(analyticsServiceProvider);
```

### Existing Helper Extensions

| Extension | Methods | Location |
|-----------|---------|----------|
| `AnalyticsAuthExtension` | `logLogin()`, `logSignUp()`, `logSocialSignInStart()`, `logSocialSignInResult()`, `setAuthUserProperties()`, `clearUserProperties()` | `analytics_providers.dart` |
| `AnalyticsPedometerExtension` | `logPedometerStateChange()`, `logPedometerSync()` | `analytics_providers.dart` |
| `AnalyticsErrorExtension` | `logError()`, `logNetworkError()`, `logApiError()` | `analytics_providers.dart` |

### Currently Wired Events (2/34)

| Event | Where | Status |
|-------|-------|--------|
| `logout_success` | Auth providers | Wired |
| `account_deleted` | Delete account flow | Wired |

---

## Complete Event Catalog

### 1. Screen Views

Screen views are logged automatically via `AnalyticsRouteObserver` (to be created). Every navigation fires `screen_view` with:

| Parameter | Type | Example |
|-----------|------|---------|
| `screen_name` | `string` | `home`, `training`, `recipe_detail` |
| `screen_class` | `string` | `HomeScreen`, `RecipeDetailScreen` |

#### Screen Name Mapping (Route to Analytics Name)

| Route | Screen Name | Widget Class |
|-------|-------------|--------------|
| `/` | `home` | `HomeScreen` |
| `/training` | `training` | `TrainingScreen` |
| `/ranking` | `ranking` | `CommunityScreen` |
| `/explore` | `explore` | `ExploreScreen` |
| `/profile` | `profile` | `ProfileScreen` |
| `/login` | `login` | `LoginScreen` |
| `/login/email` | `login_email` | `EmailLoginScreen` |
| `/onboarding` | `onboarding` | `WelcomeScreen` |
| `/onboarding/home-preview` | `onboarding_home_preview` | `OnboardingHomePreviewScreen` |
| `/training/onboarding-tip` | `training_onboarding_tip` | `OnboardingTipScreen` |
| `/training/choose-program` | `training_choose_program` | `ChooseProgramScreen` |
| `/training/program-video` | `training_program_video` | `ProgramVideoScreen` |
| `/training/location` | `training_location` | `LocationSelectionScreen` |
| `/training/session` | `training_session` | `TrainingSessionScreen` |
| `/training/day` | `training_day` | `TrainingDayScreen` |
| `/training/exercise` | `exercise_detail` | `ExerciseDetailScreen` |
| `/training/exercise-video` | `exercise_video` | `ExerciseVideoScreen` |
| `/training/exercise-history` | `exercise_history` | `ExerciseHistoryScreen` |
| `/training/session-records` | `session_records` | `SessionRecordsScreen` |
| `/training/catalog` | `programs_catalog` | `ProgramsCatalogScreen` |
| `/training/program-detail` | `program_detail` | `ProgramDetailScreen` |
| `/training/complete` | `training_complete` | `TrainingCompleteScreen` |
| `/training/rate` | `training_rate` | `TrainingRateScreen` |
| `/explore/recipes` | `recipe_list` | `RecipeListScreen` |
| `/explore/recipes/detail` | `recipe_detail` | `RecipeDetailScreen` |
| `/explore/guides` | `guide_list` | `GuideListScreen` |
| `/explore/guides/category` | `guide_category` | `GuideCategoryScreen` |
| `/explore/guides/video` | `guide_video` | `GuideVideoScreen` |
| `/explore/calculator` | `calorie_calculator` | `CalorieCalculatorScreen` |
| `/explore/calculator/result` | `calorie_calculator_result` | `CalorieCalculatorResultScreen` |
| `/explore/history` | `program_history` | `ProgramHistoryScreen` |
| `/profile/gender` | `profile_edit_gender` | `GenderEditScreen` |
| `/profile/age` | `profile_edit_age` | `AgeEditScreen` |
| `/profile/weight` | `profile_edit_weight` | `WeightEditScreen` |
| `/profile/height` | `profile_edit_height` | `HeightEditScreen` |
| `/delete-account` | `delete_account` | `DeleteAccountScreen` |
| `/legal` | `legal_info` | `LegalInfoScreen` |
| `/legal/document` | `legal_document` | `LegalDocumentScreen` |

---

### 2. Authentication Events

**Status**: Defined in enum, helper extensions built. Need wiring.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `login_attempt` | `loginAttempt` | `method` | User taps any login button |
| `login_success` | `loginSuccess` | `method`, `is_new_user`, `is_guest` | Login succeeds |
| `login_failure` | `loginFailure` | `method`, `error_code` | Login fails |
| `sign_up_success` | `signUpSuccess` | `method` | New account created |
| `sign_up_failure` | `signUpFailure` | `method`, `error_code` | Signup fails |
| `guest_login` | `guestLogin` | `device_id` | Guest auth with device ID |
| `guest_upgrade` | `guestUpgrade` | `method` | Guest registers/links account |
| `logout_success` | `logoutSuccess` | — | User logs out |
| `account_deleted` | `accountDeleted` | — | Account deletion completes |
| `session_expired` | `sessionExpired` | — | Token refresh fails |
| `google_sign_in_start` | `googleSignInStart` | — | Taps Google button |
| `google_sign_in_success` | `googleSignInSuccess` | `is_new_user` | Google auth completes |
| `google_sign_in_cancel` | `googleSignInCancel` | — | User cancels Google flow |
| `apple_sign_in_start` | `appleSignInStart` | — | Taps Apple button |
| `apple_sign_in_success` | `appleSignInSuccess` | `is_new_user` | Apple auth completes |
| `apple_sign_in_cancel` | `appleSignInCancel` | — | User cancels Apple flow |

**Implementation file**: `lib/features/auth/presentation/providers/auth_providers.dart`

**Example**:
```dart
// In social auth provider
analytics.logSocialSignInStart('google');
// ... auth flow ...
analytics.logSocialSignInResult(
  provider: 'google',
  success: true,
  isNewUser: response.isNewUser,
);
```

---

### 3. Onboarding Events

**Status**: Defined in enum. Need wiring.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `onboarding_start` | `onboardingStart` | — | WelcomeScreen shown |
| `onboarding_complete` | `onboardingComplete` | — | User finishes onboarding |
| `onboarding_skip` | `onboardingSkip` | — | User skips onboarding |

**Implementation file**: `lib/features/onboarding/presentation/screens/welcome_screen.dart`

---

### 3a. Training Onboarding Events

**Status**: NEW — must add to `AnalyticsEvent` enum and wire.

These events track the **complete conversion funnel** for new training users — from the first onboarding tip through program selection, video preview, location choice, and signup. This funnel is critical for understanding where users drop off before their first program enrollment.

**Funnel Flow:**
```
TrainingOnboardingTipScreen ("Esta es tu pantalla de entreno")
        ↓ training_onboarding_continue_clicked
ProgramFirstChoiceScreen (Gender selector + Program carousel)
        ↓ program_start_intent_clicked
   ┌────┴────┐
   │ Optional │
   ↓         ↓
ProgramVideoScreen ──→ program_video_viewed (on screen load)
        ↓ program_video_continue_clicked
TrainingLocationScreen ("¿Dónde vas a entrenar?")
        ↓ program_enroll_intent_clicked
LoginMethodScreen ("¡Todo listo para empezar!" — guests only)
        ↓ signup_method_selected
Auth Flow (Google / Apple / Email)
        ↓ signup_completed
   ──→ program_enroll (tracked in Training Events)
```

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `training_onboarding_continue_clicked` | `trainingOnboardingContinueClicked` | — | User taps "Continuar" on the training onboarding tip screen |
| `program_start_intent_clicked` | `programStartIntentClicked` | `template_id` | User taps "Empezar programa" on the choose program screen |
| `program_video_viewed` | `programVideoViewed` | `program_id` | Program video screen is displayed (fires on screen load, not on play) |
| `program_video_continue_clicked` | `programVideoContinueClicked` | `program_id` | User taps "Continuar" after the program video |
| `program_enroll_intent_clicked` | `programEnrollIntentClicked` | `program_id` | User taps "Suscribirse" on the location selection screen |
| `signup_method_selected` | `signupMethodSelected` | `method`, `entry_point`, `program_id` | User selects a signup method (google/apple/email) on the ready screen |
| `signup_completed` | `signupCompleted` | `method`, `is_new_user`, `program_id` | System confirms user authenticated (social auth return or email account created) |

**Parameter details:**

| Parameter | Type | Values | Notes |
|-----------|------|--------|-------|
| `template_id` | string | Grouped program name | Used on choose program screen because grouped programs don't have a single `program_id` yet — the real ID is resolved after location selection |
| `entry_point` | string | `first_program_enroll`, `profile` | Distinguishes training onboarding signup from profile-initiated signup |
| `program_id` | int | Program ID | Available after location resolves the grouped program to a specific variant |

**Implementation files**:
- `lib/features/training/presentation/screens/training_onboarding_tip_screen.dart` — `training_onboarding_continue_clicked`
- `lib/features/training/presentation/screens/program_first_choice_screen.dart` — `program_start_intent_clicked`
- `lib/features/training/presentation/screens/program_video_screen.dart` — `program_video_viewed`, `program_video_continue_clicked`
- `lib/features/training/presentation/screens/training_location_screen.dart` — `program_enroll_intent_clicked`
- `lib/features/auth/presentation/screens/login_method_screen.dart` — `signup_method_selected`
- `lib/features/auth/presentation/screens/email_auth_screen.dart` — `signup_completed`

**Notes:**
- The video screen is **optional** — users can tap "Empezar programa" to go directly to location selection, or "Ver como funciona" to watch the video first.
- `signup_method_selected` and `signup_completed` only fire for **guest users** who need to create an account. Already-authenticated users skip the login screen entirely.
- `signup_completed` fires when the system confirms the user is authenticated (return from social auth provider or after creating an email account). This is distinct from `sign_up_success` (Auth #4) which doesn't carry `program_id` context.

---

### 4. Training Events

**Status**: NEW — must add to `AnalyticsEvent` enum and wire.

This is the **most critical domain** for marketing. Training is the core product.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `program_view` | `programView` | `program_id`, `program_name`, `content_type:program` | User views program detail |
| `program_video_play` | `programVideoPlay` | `program_id`, `program_name` | Watches program intro video |
| `program_enroll` | `programEnroll` | `program_id`, `program_name`, `location`, `level`, `entry_point`, `program_type`, `program_goal`, `program_secondary_goal` | User subscribes to a program |
| `program_complete` | `programComplete` | `program_id`, `program_name`, `total_days`, `duration_weeks` | All training days completed |
| `program_unenroll` | `programUnenroll` | `program_id`, `program_name`, `completed_days`, `total_days` | User leaves a program early |
| `training_session_start` | `trainingSessionStart` | `program_id`, `day_name`, `week_number` | Starts a training day |
| `training_session_complete` | `trainingSessionComplete` | `program_id`, `day_name`, `week_number`, `duration_seconds`, `exercises_completed` | Finishes a session |
| `training_session_rate` | `trainingSessionRate` | `program_id`, `rating`, `perceived_effort` | Rates session difficulty |
| `exercise_start` | `exerciseStart` | `exercise_id`, `exercise_name`, `program_id` | Opens exercise detail |
| `exercise_set_log` | `exerciseSetLog` | `exercise_id`, `exercise_name`, `set_number`, `weight`, `reps` | Logs a set |
| `exercise_video_play` | `exerciseVideoPlay` | `exercise_id`, `exercise_name` | Watches exercise demo video |
| `exercise_history_view` | `exerciseHistoryView` | `exercise_id`, `exercise_name` | Views exercise PR/history |
| `training_tab_select` | `trainingTabSelect` | `tab_name` (`your_programs` / `catalog`) | Switches training tab |
| `catalog_filter_apply` | `catalogFilterApply` | `gender`, `location`, `level`, `objective` | Applies catalog filters |
| `training_location_select` | `trainingLocationSelect` | `location` (`gym` / `home_bands` / `home_dumbbells`) | Selects training location |
| `continuation_program_view` | `continuationProgramView` | `program_id`, `program_name` | Views continuation suggestion |
| `continuation_reminder_set` | `continuationReminderSet` | `program_id` | Sets continuation reminder |

**Implementation files**:
- `lib/features/training/presentation/providers/training_providers.dart` — enrollment, session flow
- `lib/features/training/presentation/screens/training_session_screen.dart` — session start
- `lib/features/training/presentation/screens/training_complete_screen.dart` — session complete
- `lib/features/training/presentation/screens/training_rate_screen.dart` — rate event
- `lib/features/training/presentation/screens/exercise_detail_screen.dart` — exercise/set events
- `lib/features/training/presentation/screens/program_detail_screen.dart` — program view
- `lib/features/training/presentation/widgets/active_programs_section.dart` — tab select

**Helper extension to add** (`AnalyticsTrainingExtension`):
```dart
extension AnalyticsTrainingExtension on AnalyticsService {
  Future<void> logProgramEnroll({
    required int programId,
    required String programName,
    required String location,
    required String entryPoint,
    required String programType,
    String? level,
    String? programGoal,
    String? programSecondaryGoal,
  }) async {
    await logEvent(AnalyticsEvent.programEnroll, {
      AnalyticsParams.programId: programId,
      AnalyticsParams.programName: programName,
      AnalyticsParams.contentType: 'program',
      AnalyticsParams.location: location,
      AnalyticsParams.entryPoint: entryPoint,
      AnalyticsParams.programType: programType,
      if (level != null) AnalyticsParams.level: level,
      if (programGoal != null) AnalyticsParams.programGoal: programGoal,
      if (programSecondaryGoal != null) AnalyticsParams.programSecondaryGoal: programSecondaryGoal,
    });
    await setUserProperty(
      name: UserProperties.hasActiveProgram,
      value: 'true',
    );
    await setUserProperty(
      name: UserProperties.activeProgramName,
      value: programName,
    );
    await setUserProperty(
      name: UserProperties.trainingLocation,
      value: location,
    );
  }

  Future<void> logSessionComplete({
    required int programId,
    required String dayName,
    required int weekNumber,
    required int durationSeconds,
    required int exercisesCompleted,
  }) async {
    await logEvent(AnalyticsEvent.trainingSessionComplete, {
      AnalyticsParams.programId: programId,
      'day_name': dayName,
      'week_number': weekNumber,
      'duration_seconds': durationSeconds,
      'exercises_completed': exercisesCompleted,
    });
  }

  Future<void> logExerciseSetLog({
    required int exerciseId,
    required String exerciseName,
    required int setNumber,
    double? weight,
    int? reps,
  }) async {
    await logEvent(AnalyticsEvent.exerciseSetLog, {
      AnalyticsParams.exerciseId: exerciseId,
      AnalyticsParams.exerciseName: exerciseName,
      'set_number': setNumber,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
    });
  }
}
```

---

### 5. Pedometer / Steps Events

**Status**: Defined in enum, helper extension built. Need wiring.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `pedometer_enabled` | `pedometerEnabled` | `source` (`health_connect` / `sensor`) | User enables steps |
| `pedometer_disabled` | `pedometerDisabled` | — | User disables steps |
| `pedometer_permission_granted` | `pedometerPermissionGranted` | — | Grants health permission |
| `pedometer_permission_denied` | `pedometerPermissionDenied` | — | Denies health permission |
| `pedometer_sync_success` | `pedometerSyncSuccess` | `steps`, `calories`, `source` | Data synced to backend |

**Implementation file**: `lib/features/home/presentation/providers/home_providers.dart`

---

### 6. Explore / Content Events

**Status**: NEW — must add to `AnalyticsEvent` enum and wire.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `recipe_view` | `recipeView` | `recipe_id`, `recipe_name`, `content_type:recipe` | Opens recipe detail |
| `recipe_favorite` | `recipeFavorite` | `recipe_id`, `recipe_name` | Favorites a recipe |
| `recipe_unfavorite` | `recipeUnfavorite` | `recipe_id`, `recipe_name` | Unfavorites a recipe |
| `recipe_mode_select` | `recipeModeSelect` | `recipe_id`, `mode` (`ligero`/`normal`/`bestia`) | Selects recipe mode |
| `recipe_filter_apply` | `recipeFilterApply` | `meal_types`, `is_spicy`, `favorites_only` | Applies recipe filters |
| `guide_category_view` | `guideCategoryView` | `category_id`, `category_name`, `content_type:guide` | Opens guide category |
| `guide_video_play` | `guideVideoPlay` | `video_id`, `video_name`, `category_name` | Plays guide video |
| `calculator_start` | `calculatorStart` | — | Opens calorie calculator |
| `calculator_complete` | `calculatorComplete` | `goal`, `gender`, `age`, `activity_level`, `bmr`, `tdee`, `goal_calories` | Sees calculator results |
| `program_history_view` | `programHistoryView` | — | Opens training history |
| `explore_section_tap` | `exploreSectionTap` | `section_name` | Taps explore card |

**`section_name` values**: `recipes`, `guides`, `calculator`, `history`, `catalog`

**Implementation files**:
- `lib/features/explore/presentation/screens/recipe_detail_screen.dart` — recipe view/mode
- `lib/features/explore/presentation/providers/recipe_providers.dart` — recipe favorite
- `lib/features/explore/presentation/screens/explore_screen.dart` — section taps
- `lib/features/explore/presentation/screens/guide_category_screen.dart` — guide events
- `lib/features/explore/presentation/screens/calorie_calculator_result_screen.dart` — calculator

**Helper extension to add** (`AnalyticsExploreExtension`):
```dart
extension AnalyticsExploreExtension on AnalyticsService {
  Future<void> logRecipeView({
    required int recipeId,
    required String recipeName,
  }) async {
    await logEvent(AnalyticsEvent.recipeView, {
      'recipe_id': recipeId,
      'recipe_name': recipeName,
      AnalyticsParams.contentType: 'recipe',
    });
  }

  Future<void> logRecipeFavorite({
    required int recipeId,
    required String recipeName,
    required bool isFavorite,
  }) async {
    await logEvent(
      isFavorite ? AnalyticsEvent.recipeFavorite : AnalyticsEvent.recipeUnfavorite,
      {
        'recipe_id': recipeId,
        'recipe_name': recipeName,
      },
    );
  }

  Future<void> logCalculatorComplete({
    required String goal,
    required String gender,
    required int age,
    required String activityLevel,
    required int bmr,
    required int tdee,
    required int goalCalories,
  }) async {
    await logEvent(AnalyticsEvent.calculatorComplete, {
      'goal': goal,
      'gender': gender,
      'age': age,
      'activity_level': activityLevel,
      'bmr': bmr,
      'tdee': tdee,
      'goal_calories': goalCalories,
    });
    await setUserProperty(
      name: UserProperties.hasUsedCalculator,
      value: 'true',
    );
    await setUserProperty(
      name: UserProperties.fitnessGoal,
      value: goal,
    );
  }
}
```

---

### 7. Ranking / Community Events

**Status**: Partially defined in enum. Need wiring + expansion.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `ranking_view` | `rankingViewed` | `filter_type` (`global`/`age_group`) | Views ranking screen |
| `ranking_enrolled` | `rankingEnrolled` | — | Joins ranking competition |
| `ranking_filter_change` | `rankingFilterChange` (NEW) | `filter_type` | Switches ranking filter |

**Implementation file**: `lib/features/ranking/presentation/screens/community_screen.dart`

---

### 8. Profile Events

**Status**: Partially defined in enum. Need wiring + expansion.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `profile_view` | `profileViewed` | — | Opens profile screen |
| `profile_field_update` | `profileUpdated` | `field_name`, `value` | Updates any profile field |
| `profile_photo_change` | `profilePhotoChanged` | — | Changes profile picture |

**`field_name` values**: `gender`, `age`, `weight`, `height`, `name`

**Implementation file**: `lib/features/profile/presentation/screens/profile_screen.dart`

**User properties to update on profile change**:
```dart
// When gender changes
analytics.setUserProperty(name: 'gender', value: 'male');

// When age changes
analytics.setUserProperty(name: 'age_group', value: _ageToGroup(28)); // → '25_34'
```

---

### 9. Activity Logging Events

**Status**: Defined in enum. Need wiring.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `activity_create` | `activityCreated` | `activity_type`, `duration_minutes` | Logs manual activity |
| `activity_delete` | `activityDeleted` | `activity_type` | Deletes an activity |

---

### 10. App Engagement Events

**Status**: NEW — must add to `AnalyticsEvent` enum and wire.

| Event | Enum Value | Parameters | When Fired |
|-------|-----------|-----------|------------|
| `tab_select` | `tabSelect` (NEW) | `tab_name` | Bottom nav tap |
| `share_content` | `shareContent` | `content_type`, `content_id`, `item_name` | Any share action |
| `notification_received` | `notificationReceived` (NEW) | `notification_type` | Push notification arrives |
| `notification_tap` | `notificationTap` (NEW) | `notification_type`, `action` | User taps notification |

**`tab_name` values**: `home`, `training`, `ranking`, `explore`

**Implementation files**:
- `lib/core/widgets/navigation/main_scaffold.dart` — bottom nav tab_select
- Push notification handler — notification events

---

## User Properties

User properties are attributes that describe segments of your user base. They persist across sessions and are used to build Firebase Audiences for targeted campaigns.

**GA4 limit**: 25 user properties max. We use **22** (10 existing + 12 new). Leaves 3 slots for future use.

### Existing User Properties (10)

| Property | Constant | Values | Set When |
|----------|----------|--------|----------|
| `is_guest` | `UserProperties.isGuest` | `true` / `false` | Login |
| `auth_method` | `UserProperties.authMethod` | `google` / `apple` / `email` / `guest` | Login |
| `pedometer_enabled` | `UserProperties.pedometerEnabled` | `true` / `false` | Toggle pedometer |
| `notifications_enabled` | `UserProperties.notificationsEnabled` | `true` / `false` | Permission grant |
| `app_version` | `UserProperties.appVersion` | `1.2.3` | App start |
| `platform` | `UserProperties.platform` | `ios` / `android` | App start |
| `language` | `UserProperties.language` | `es` / `en` | App start |
| `theme` | `UserProperties.theme` | `dark` / `light` | App start |
| `account_created_at` | `UserProperties.accountCreatedAt` | ISO date | Registration |
| `last_login_at` | `UserProperties.lastLoginAt` | ISO date | Login |

### New User Properties to Add (12)

| Property | Values | Set When | Marketing Use |
|----------|--------|----------|---------------|
| `gender` | `male` / `female` | Profile update | Gender-targeted campaigns |
| `age_group` | `18_24` / `25_34` / `35_44` / `45_54` / `55_plus` | Profile update | Age-targeted content |
| `fitness_goal` | `lose_weight` / `maintain` / `gain_muscle` | Calculator / questionnaire | Goal-specific programs |
| `training_level` | `beginner` / `intermediate` / `advanced` | Program enrollment | Level-appropriate suggestions |
| `training_location` | `gym` / `home_bands` / `home_dumbbells` | Location selection | Location-specific programs |
| `has_active_program` | `true` / `false` | Program enroll/unenroll/complete | Re-engagement campaigns |
| `active_program_name` | Program name string | Program enrollment | Program-specific messaging |
| `completed_programs` | Count as string (`0`, `1`, `2`...) | Program completion | Loyalty/progression campaigns |
| `days_since_last_training` | `0` / `1_7` / `8_14` / `15_30` / `30_plus` | Session complete / app open | Churn prevention |
| `total_training_sessions` | Count as string | Session completion | Engagement tiers |
| `favorite_recipes_count` | Count as string | Favorite toggle | Content engagement |
| `has_used_calculator` | `true` / `false` | Calculator completion | Feature adoption |

### When to Update User Properties

| Lifecycle Moment | Properties to Set/Update |
|-----------------|-------------------------|
| **Login/Auth** | `is_guest`, `auth_method`, `account_created_at`, `last_login_at` |
| **Profile update** | `gender`, `age_group` |
| **Calculator completion** | `fitness_goal`, `has_used_calculator` |
| **Program enrollment** | `has_active_program`, `active_program_name`, `training_level`, `training_location` |
| **Session completion** | `total_training_sessions`, `days_since_last_training` (reset to `0`) |
| **Program completion** | `completed_programs` (increment), `has_active_program` (set `false`) |
| **Program unenroll** | `has_active_program` (set `false`), `active_program_name` (clear) |
| **Recipe favorite** | `favorite_recipes_count` (update count) |
| **App open** | `days_since_last_training` (recalculate), `app_version`, `platform` |

### Age Group Mapping

```dart
String ageToGroup(int age) {
  if (age < 18) return 'under_18';
  if (age <= 24) return '18_24';
  if (age <= 34) return '25_34';
  if (age <= 44) return '35_44';
  if (age <= 54) return '45_54';
  return '55_plus';
}
```

---

## Firebase Audiences

Define these in **Firebase Console > Analytics > Audiences**. They auto-populate based on events + user properties and can be used as targets for **Firebase Cloud Messaging** push notifications.

### Acquisition & Activation

| Audience | Definition | Campaign Use |
|----------|-----------|--------------|
| **New Users (7d)** | `account_created_at` within last 7 days | Welcome series, onboarding tips |
| **Guests Not Registered** | `is_guest = true` for 3+ days | Nudge to register |
| **Registered No Program** | `is_guest = false` AND `has_active_program = false` | "Start your first program!" |
| **Onboarding Dropoff** | `onboarding_start` fired but NOT `onboarding_complete` | Re-engage incomplete onboarding |

### Engagement & Retention

| Audience | Definition | Campaign Use |
|----------|-----------|--------------|
| **Active Trainers** | `training_session_complete` in last 7 days | Motivational content, new features |
| **Lapsed Trainers (7-14d)** | `has_active_program = true` AND `days_since_last_training = 8_14` | "We miss you! Get back on track" |
| **Churning Users (30d+)** | `days_since_last_training = 30_plus` | Win-back with special program offer |
| **Completed a Program** | `program_complete` event fired | "Ready for your next challenge?" |
| **High Step Counters** | `pedometer_enabled = true` AND high step patterns | Community challenges, premium features |
| **Recipe Enthusiasts** | `favorite_recipes_count >= 3` | New recipe notifications |
| **Calculator Users** | `has_used_calculator = true` | Nutrition-focused content |

### Segmentation by Profile

| Audience | Definition | Campaign Use |
|----------|-----------|--------------|
| **Gym Users** | `training_location = gym` | Gym-specific programs/tips |
| **Home Workout Users** | `training_location` starts with `home_` | Home workout content |
| **Weight Loss Goal** | `fitness_goal = lose_weight` | Diet tips, cardio programs |
| **Muscle Gain Goal** | `fitness_goal = gain_muscle` | Strength programs, protein recipes |
| **Beginners** | `training_level = beginner` | Intro content, technique guides |
| **Advanced Athletes** | `training_level = advanced` AND `total_training_sessions >= 50` | Advanced programs, PRs |
| **Men 25-34** | `gender = male` AND `age_group = 25_34` | Targeted program ads |
| **Women 25-34** | `gender = female` AND `age_group = 25_34` | Targeted program ads |

### Lifecycle

| Audience | Definition | Campaign Use |
|----------|-----------|--------------|
| **Power Users** | 5+ `training_session_complete` in 7 days | Beta features, referral program |
| **Feature Discoverers** | Used 3+ features (training + recipes + calculator + ranking) | Cross-feature promotion |
| **Notification Opted-In** | `notifications_enabled = true` | All push campaigns |

### Creating Audiences in Firebase Console

1. Go to **Firebase Console > Analytics > Audiences**
2. Click **New audience**
3. Set conditions using the event names and user properties from this document
4. Save the audience
5. Use in **Cloud Messaging > New campaign > Target > User segment**

> Audiences take up to 24-48 hours to populate after first data flows in.

---

## Implementation Guide

### Step 1: Add New Events to `AnalyticsEvent` Enum

**File**: `lib/core/analytics/analytics_service.dart`

Add these new enum values to the existing `AnalyticsEvent` enum:

```dart
enum AnalyticsEvent {
  // ... existing events ...

  // Training Onboarding (NEW)
  trainingOnboardingContinueClicked,
  programStartIntentClicked,
  programVideoViewed,
  programVideoContinueClicked,
  programEnrollIntentClicked,
  signupMethodSelected,
  signupCompleted,

  // Training (NEW)
  programView,
  programVideoPlay,
  programEnroll,
  programComplete,
  programUnenroll,
  trainingSessionStart,
  trainingSessionComplete,
  trainingSessionRate,
  exerciseStart,
  exerciseSetLog,
  exerciseVideoPlay,
  exerciseHistoryView,
  trainingTabSelect,
  catalogFilterApply,
  trainingLocationSelect,
  continuationProgramView,
  continuationReminderSet,

  // Explore (NEW)
  recipeView,
  recipeFavorite,
  recipeUnfavorite,
  recipeModeSelect,
  recipeFilterApply,
  guideCategoryView,
  guideVideoPlay,
  calculatorStart,
  calculatorComplete,
  programHistoryView,
  exploreSectionTap,

  // Ranking (NEW)
  rankingFilterChange,

  // Engagement (NEW)
  tabSelect,
  notificationReceived,
  notificationTap,
}
```

### Step 2: Add New `AnalyticsParams` Constants

**File**: `lib/core/analytics/analytics_service.dart`

```dart
class AnalyticsParams {
  // ... existing constants ...

  // Training Onboarding
  static const String templateId = 'template_id';
  static const String entryPoint = 'entry_point';
  static const String programType = 'program_type';
  static const String programGoal = 'program_goal';
  static const String programSecondaryGoal = 'program_secondary_goal';

  // Training
  static const String programId = 'program_id';
  static const String programName = 'program_name';
  static const String exerciseId = 'exercise_id';
  static const String exerciseName = 'exercise_name';
  static const String dayName = 'day_name';
  static const String weekNumber = 'week_number';
  static const String durationSeconds = 'duration_seconds';
  static const String exercisesCompleted = 'exercises_completed';
  static const String setNumber = 'set_number';
  static const String weight = 'weight';
  static const String reps = 'reps';
  static const String rating = 'rating';
  static const String perceivedEffort = 'perceived_effort';
  static const String location = 'location';
  static const String level = 'level';
  static const String totalDays = 'total_days';
  static const String completedDays = 'completed_days';
  static const String durationWeeks = 'duration_weeks';
  static const String tabName = 'tab_name';
  static const String objective = 'objective';
  static const String gender = 'gender';

  // Explore / Recipes
  static const String recipeId = 'recipe_id';
  static const String recipeName = 'recipe_name';
  static const String mode = 'mode';
  static const String mealTypes = 'meal_types';
  static const String isSpicy = 'is_spicy';
  static const String favoritesOnly = 'favorites_only';
  static const String categoryId = 'category_id';
  static const String categoryName = 'category_name';
  static const String videoId = 'video_id';
  static const String videoName = 'video_name';
  static const String sectionName = 'section_name';

  // Calculator
  static const String goal = 'goal';
  static const String age = 'age';
  static const String activityLevel = 'activity_level';
  static const String bmr = 'bmr';
  static const String tdee = 'tdee';
  static const String goalCalories = 'goal_calories';

  // Ranking
  static const String filterType = 'filter_type';

  // Profile
  static const String fieldName = 'field_name';
  static const String value = 'value';

  // Notifications
  static const String notificationType = 'notification_type';
  static const String action = 'action';
}
```

### Step 3: Add New `UserProperties` Constants

**File**: `lib/core/analytics/analytics_service.dart`

```dart
class UserProperties {
  // ... existing constants ...

  // Fitness profile (NEW)
  static const String gender = 'gender';
  static const String ageGroup = 'age_group';
  static const String fitnessGoal = 'fitness_goal';
  static const String trainingLevel = 'training_level';
  static const String trainingLocation = 'training_location';

  // Training engagement (NEW)
  static const String hasActiveProgram = 'has_active_program';
  static const String activeProgramName = 'active_program_name';
  static const String completedPrograms = 'completed_programs';
  static const String daysSinceLastTraining = 'days_since_last_training';
  static const String totalTrainingSessions = 'total_training_sessions';

  // Content engagement (NEW)
  static const String favoriteRecipesCount = 'favorite_recipes_count';
  static const String hasUsedCalculator = 'has_used_calculator';
}
```

### Step 4: Create `AnalyticsRouteObserver`

**New file**: `lib/core/analytics/analytics_route_observer.dart`

A `NavigatorObserver` that automatically logs `screen_view` for every GoRouter navigation. Register it in `lib/core/router/app_router.dart`.

```dart
class AnalyticsRouteObserver extends NavigatorObserver {
  final AnalyticsService _analytics;

  AnalyticsRouteObserver(this._analytics);

  static const _routeToScreenName = {
    '/': 'home',
    '/training': 'training',
    '/ranking': 'ranking',
    '/explore': 'explore',
    '/profile': 'profile',
    // ... full mapping from Screen Name Mapping table above
  };

  @override
  void didPush(Route route, Route? previousRoute) {
    _logScreenView(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) _logScreenView(newRoute);
  }

  void _logScreenView(Route route) {
    final path = _extractPath(route);
    final screenName = _routeToScreenName[path] ?? path;
    _analytics.logScreenView(
      screenName: screenName,
      screenClass: route.settings.name,
    );
  }
}
```

### Step 5: Add Helper Extensions

**File**: `lib/core/analytics/analytics_providers.dart`

Add `AnalyticsTrainingExtension`, `AnalyticsExploreExtension`, and `AnalyticsEngagementExtension` (see code examples in event sections above).

### Step 6: Wire Events into Feature Code

For each feature, add `logEvent()` calls at the point of user action. Example patterns:

**In a provider (Riverpod)**:
```dart
final analytics = ref.read(analyticsServiceProvider);
analytics.logEvent(AnalyticsEvent.programEnroll, {
  AnalyticsParams.programId: program.id,
  AnalyticsParams.programName: program.name,
});
```

**In a screen (widget)**:
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // Log on screen appearance (for non-route-observer cases)
  ref.listen(someProvider, (prev, next) {
    if (next.hasValue) {
      ref.read(analyticsServiceProvider).logEvent(
        AnalyticsEvent.trainingSessionComplete,
        { /* params */ },
      );
    }
  });
}
```

---

## GA4 Custom Dimensions Registration Checklist

Custom event parameters must be registered as **custom dimensions** in GA4 to appear in reports. Go to **GA4 > Admin > Custom definitions > Create custom dimension**.

### Event-Scoped Custom Dimensions

Register each unique parameter key:

| Parameter | Scope | Description |
|-----------|-------|-------------|
| `program_id` | Event | Training program identifier |
| `program_name` | Event | Training program name |
| `exercise_id` | Event | Exercise identifier |
| `exercise_name` | Event | Exercise name |
| `day_name` | Event | Training day name |
| `week_number` | Event | Training week number |
| `duration_seconds` | Event | Session duration in seconds |
| `exercises_completed` | Event | Number of exercises completed |
| `set_number` | Event | Set number within exercise |
| `weight` | Event | Weight lifted (kg) |
| `reps` | Event | Repetitions performed |
| `rating` | Event | Session rating (1-5) |
| `perceived_effort` | Event | RPE rating |
| `location` | Event | Training location |
| `level` | Event | Training level |
| `total_days` | Event | Total program days |
| `completed_days` | Event | Days completed |
| `duration_weeks` | Event | Program duration in weeks |
| `tab_name` | Event | Tab name selected |
| `recipe_id` | Event | Recipe identifier |
| `recipe_name` | Event | Recipe name |
| `mode` | Event | Recipe mode selection |
| `category_id` | Event | Guide category identifier |
| `category_name` | Event | Guide category name |
| `video_id` | Event | Video identifier |
| `video_name` | Event | Video name |
| `section_name` | Event | Explore section name |
| `goal` | Event | Fitness goal |
| `activity_level` | Event | Activity level |
| `bmr` | Event | Basal metabolic rate |
| `tdee` | Event | Total daily energy expenditure |
| `goal_calories` | Event | Target daily calories |
| `filter_type` | Event | Ranking filter type |
| `field_name` | Event | Profile field name |
| `notification_type` | Event | Push notification type |
| `action` | Event | Notification action |
| `meal_types` | Event | Recipe meal type filter |
| `is_spicy` | Event | Spicy filter toggle |
| `favorites_only` | Event | Favorites filter toggle |
| `objective` | Event | Training objective filter |
| `template_id` | Event | Program group/template identifier |
| `entry_point` | Event | Where user started enrollment (onboarding/catalog) |
| `program_type` | Event | Program type (Completo/Base/Subscripcion/Gratis) |
| `program_goal` | Event | Primary program goal |
| `program_secondary_goal` | Event | Secondary program goal |

### User-Scoped Custom Dimensions

Register each new user property:

| Property | Description |
|----------|-------------|
| `gender` | User gender |
| `age_group` | User age bracket |
| `fitness_goal` | User fitness goal |
| `training_level` | User training experience level |
| `training_location` | User preferred training location |
| `has_active_program` | Whether user has an active program |
| `active_program_name` | Name of active program |
| `completed_programs` | Number of completed programs |
| `days_since_last_training` | Days since last training session |
| `total_training_sessions` | Total sessions completed |
| `favorite_recipes_count` | Number of favorited recipes |
| `has_used_calculator` | Whether user has used calorie calculator |

> **GA4 Limits**: 50 event-scoped custom dimensions, 25 user-scoped custom dimensions per property.

---

## Verification

### 1. Code Verification
```bash
flutter analyze  # No errors after all changes
```

### 2. Debug View Testing

Enable Firebase DebugView on your test device:

**Android**:
```bash
adb shell setprop debug.firebase.analytics.app com.elmetodo.app
```

**iOS**:
Add `-FIRDebugEnabled` to Xcode scheme arguments.

Then open **Firebase Console > Analytics > DebugView** to see events in real-time.

### 3. Verification Checklist

| Check | How to Verify |
|-------|--------------|
| Screen views fire on navigation | Navigate through all tabs; verify `screen_view` with correct `screen_name` in DebugView |
| Auth events fire | Login/logout; verify `login_success`, `logout_success` events |
| Training events fire | Start a session, log sets, complete; verify full event chain |
| Explore events fire | View recipe, favorite, use calculator; verify events + parameters |
| User properties set | Check Firebase Console > Analytics > User Properties |
| Parameters visible | Click event in DebugView; verify all parameters present |
| No duplicate events | Each action fires exactly one event |
| No debug pollution | Confirm `NoopAnalyticsService` in debug, `FirebaseAnalyticsService` in prod |

### 4. Audience Verification

After 24-48 hours of data flowing:
1. Go to **Firebase Console > Analytics > Audiences**
2. Create audiences from the definitions above
3. Verify user counts match expected values
4. Test push notification targeting with a small audience

---

## Key Files Reference

### Existing Files (to modify)

| File | Changes Needed |
|------|---------------|
| `lib/core/analytics/analytics_service.dart` | Add ~40 events, ~35 params, ~12 user properties |
| `lib/core/analytics/analytics_providers.dart` | Add 3 helper extensions |
| `lib/core/router/app_router.dart` | Register route observer |
| `lib/features/auth/presentation/providers/auth_providers.dart` | Wire auth events + user properties |
| `lib/features/training/presentation/providers/training_providers.dart` | Wire training events |
| `lib/features/training/presentation/screens/training_session_screen.dart` | Session start event |
| `lib/features/training/presentation/screens/training_complete_screen.dart` | Session complete event |
| `lib/features/training/presentation/screens/training_rate_screen.dart` | Rate event |
| `lib/features/training/presentation/screens/exercise_detail_screen.dart` | Exercise/set events |
| `lib/features/training/presentation/screens/program_detail_screen.dart` | Program view event |
| `lib/features/training/presentation/widgets/active_programs_section.dart` | Tab select event |
| `lib/features/explore/presentation/screens/recipe_detail_screen.dart` | Recipe view/mode events |
| `lib/features/explore/presentation/providers/recipe_providers.dart` | Recipe favorite events |
| `lib/features/explore/presentation/screens/explore_screen.dart` | Section tap events |
| `lib/features/explore/presentation/screens/guide_category_screen.dart` | Guide events |
| `lib/features/explore/presentation/screens/calorie_calculator_result_screen.dart` | Calculator events |
| `lib/features/home/presentation/providers/home_providers.dart` | Pedometer events |
| `lib/features/profile/presentation/screens/profile_screen.dart` | Profile events |
| `lib/features/ranking/presentation/screens/community_screen.dart` | Ranking events |
| `lib/features/onboarding/presentation/screens/welcome_screen.dart` | Onboarding events |
| `lib/core/widgets/navigation/main_scaffold.dart` | Bottom nav tab_select event |
| `lib/features/training/presentation/screens/training_onboarding_tip_screen.dart` | Training onboarding continue event |
| `lib/features/training/presentation/screens/program_first_choice_screen.dart` | Program start intent event |
| `lib/features/training/presentation/screens/program_video_screen.dart` | Video viewed/continue events |
| `lib/features/training/presentation/screens/training_location_screen.dart` | Enroll intent event |
| `lib/features/auth/presentation/screens/login_method_screen.dart` | Signup method selected event |
| `lib/features/auth/presentation/screens/email_auth_screen.dart` | Email signup completed event |

### New Files (to create)

| File | Purpose |
|------|---------|
| `lib/core/analytics/analytics_route_observer.dart` | Auto screen tracking via GoRouter observer |

---

## Sources

- [GA4 Event Naming Rules](https://support.google.com/analytics/answer/13316687)
- [GA4 Recommended Events](https://support.google.com/firebase/answer/9267735)
- [Firebase Audiences](https://support.google.com/firebase/answer/6317509)
- [Custom Dimensions in GA4](https://support.google.com/analytics/answer/14240153)
- [Firebase Push with Audiences](https://onde.app/blog/firebase-how-to-create-custom-audiences-for-push-notifications)
- [GA4 Naming Conventions Best Practices](https://analytify.io/ga4-and-google-tag-manager-naming-conventions/)
