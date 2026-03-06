-- ============================================================
-- EL MÉTODO — BigQuery Analytics Queries
-- Proyecto: automatica-v2
-- Actualiza analytics_517999677 con el nombre real (ej: analytics_123456789)
-- ============================================================

-- INSTRUCCIONES:
-- 1. Abre BigQuery en console.cloud.google.com/bigquery
-- 2. Reemplaza `analytics_517999677` con el nombre de tu dataset (analytics_XXXXXXX)
-- 3. Cada query puedes guardarla como una "Saved Query" en BigQuery
--    o conectarla directamente a Looker Studio

-- ============================================================
-- HELPERS / VARIABLES
-- ============================================================
-- Usa esto al inicio de cualquier query para fijar el rango de fechas:
-- DECLARE start_date DATE DEFAULT '2026-03-01';
-- DECLARE end_date DATE DEFAULT CURRENT_DATE();

-- ============================================================
-- 1. INSTALLS (descargas)
-- Métrica: Adquisición — Driver
-- ============================================================
SELECT
  DATE(TIMESTAMP_MICROS(event_timestamp)) AS date,
  COUNT(DISTINCT user_pseudo_id)          AS installs
FROM `automatica-v2.analytics_517999677.events_*`
WHERE
  event_name = 'first_open'
  AND _TABLE_SUFFIX >= '20260301'
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 2. LIGHT ACTIVATION RATE (D0)
-- Métrica: % de installs con health_permission_granted OR ranking_unlock_success en D0
-- Objetivo: ≥40%
-- ============================================================
-- falta el evento de ranking enroll por meter(carles)

WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS install_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
light_activations AS (
  SELECT DISTINCT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS activation_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name IN 'pedometer_sync_success'
    AND _TABLE_SUFFIX >= '20260301'
)
SELECT
  i.install_date,
  COUNT(DISTINCT i.user_pseudo_id)  AS installs,
  COUNT(DISTINCT a.user_pseudo_id)  AS light_activations,
  ROUND(
    COUNT(DISTINCT a.user_pseudo_id) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100,
    1
  )                                  AS light_activation_rate_pct
FROM installs i
LEFT JOIN light_activations a
  ON i.user_pseudo_id = a.user_pseudo_id
  AND a.activation_date = i.install_date  -- D0: mismo día de instalación
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 3. BASE ENROLL RATE (D0–D3)  ← FOCO PRINCIPAL PRODUCTO
-- Métrica: % de installs con program_enroll en los primeros 3 días
-- Objetivo: ≥20%
-- ============================================================
WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS install_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
enrolls AS (
  SELECT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS enroll_date,
    -- Extraer parámetros del evento
    MAX(IF(ep.key = 'entry_point',  ep.value.string_value, NULL)) AS entry_point,
    MAX(IF(ep.key = 'program_type', ep.value.string_value, NULL)) AS program_type
  FROM `automatica-v2.analytics_517999677.events_*`,
  UNNEST(event_params) AS ep
  WHERE event_name = 'program_enroll'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1, 2
  HAVING MAX(IF(ep.key = 'entry_point', ep.value.string_value, NULL)) = 'onboarding'
)
SELECT
  i.install_date,
  COUNT(DISTINCT i.user_pseudo_id) AS installs,
  COUNT(DISTINCT e.user_pseudo_id) AS base_enrolls_d0_d3,
  ROUND(
    COUNT(DISTINCT e.user_pseudo_id) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100,
    1
  )                                 AS base_enroll_rate_pct,
  20.0                              AS objetivo_pct  -- línea de objetivo
FROM installs i
LEFT JOIN enrolls e
  ON i.user_pseudo_id = e.user_pseudo_id
  AND DATE_DIFF(e.enroll_date, i.install_date, DAY) BETWEEN 0 AND 3
GROUP BY 1
ORDER BY 1 DESC;


-- ACTUALMENTE ESTA ESTE:
-- Carles tiene que meter el parametro o 'program_enroll' o signup_success

WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS install_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
signups AS (
  SELECT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS signup_date,
    MAX(IF(ep.key = 'entry_point', ep.value.string_value, NULL)) AS entry_point
  FROM `automatica-v2.analytics_517999677.events_*`,
  UNNEST(event_params) AS ep
  WHERE event_name = 'signup_method_selected'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1, 2
)
SELECT
  i.install_date,
  COUNT(DISTINCT i.user_pseudo_id) AS installs,
  COUNT(DISTINCT s.user_pseudo_id) AS signups_d0_d3,
  ROUND(
    COUNT(DISTINCT s.user_pseudo_id) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100,
    1
  ) AS signup_rate_pct,
  20.0 AS objetivo_pct
FROM installs i
LEFT JOIN signups s
  ON i.user_pseudo_id = s.user_pseudo_id
  AND DATE_DIFF(s.signup_date, i.install_date, DAY) BETWEEN 0 AND 3
GROUP BY 1
ORDER BY 1 DESC;

-- creo que si que va el program_enroll. en esta query la uso y ademas le pongo entry_point=onboarding

WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS install_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
enroll_events AS (
  SELECT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS enroll_date,
    (
      SELECT ep.value.string_value
      FROM UNNEST(event_params) ep
      WHERE ep.key = 'entry_point'
      LIMIT 1
    ) AS entry_point,
    (
      SELECT ep.value.string_value
      FROM UNNEST(event_params) ep
      WHERE ep.key = 'program_type'
      LIMIT 1
    ) AS program_type
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'program_enroll'
    AND _TABLE_SUFFIX >= '20260301'
),
enrolls AS (
  SELECT
    user_pseudo_id,
    enroll_date,
    entry_point,
    program_type
  FROM enroll_events
  WHERE entry_point = 'onboarding'
)
SELECT
  i.install_date,
  COUNT(DISTINCT i.user_pseudo_id) AS installs,
  COUNT(DISTINCT e.user_pseudo_id) AS base_enrolls_d0_d3,
  ROUND(
    COUNT(DISTINCT e.user_pseudo_id) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100,
    1
  ) AS base_enroll_rate_pct,
  20.0 AS objetivo_pct
FROM installs i
LEFT JOIN enrolls e
  ON i.user_pseudo_id = e.user_pseudo_id
  AND DATE_DIFF(e.enroll_date, i.install_date, DAY) BETWEEN 0 AND 3
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 4. 6 WORKOUTS / 14 DAYS (Base Starters)
-- Métrica: % de usuarios con program_enroll que completan ≥6 sesiones en 14 días
-- Objetivo: ≥35%
-- ============================================================
WITH enrolls AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS enroll_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'program_enroll'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
sessions AS (
  SELECT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS session_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'training_session_complete'
    AND _TABLE_SUFFIX >= '20260301'
),
sessions_in_window AS (
  SELECT
    e.user_pseudo_id,
    e.enroll_date,
    COUNT(s.session_date) AS sessions_in_14d
  FROM enrolls e
  LEFT JOIN sessions s
    ON e.user_pseudo_id = s.user_pseudo_id
    AND DATE_DIFF(s.session_date, e.enroll_date, DAY) BETWEEN 0 AND 13
  GROUP BY 1, 2
)
SELECT
  enroll_date,
  COUNT(DISTINCT user_pseudo_id)                                           AS base_starters,
  COUNT(DISTINCT IF(sessions_in_14d >= 6, user_pseudo_id, NULL))          AS completed_6_workouts,
  ROUND(
    COUNT(DISTINCT IF(sessions_in_14d >= 6, user_pseudo_id, NULL))
    / NULLIF(COUNT(DISTINCT user_pseudo_id), 0) * 100,
    1
  )                                                                         AS habit_rate_pct,
  35.0                                                                      AS objetivo_pct
FROM sessions_in_window
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 5. TRIAL START RATE
-- Métrica: % de installs que hacen trial_started (en cualquier momento)
-- Objetivo: ≥20%
-- NOTA: Cuando implementes monetización, el evento será trial_started
-- ============================================================
WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS install_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
trials AS (
  SELECT DISTINCT user_pseudo_id
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'trial_started'  -- ajustar cuando esté implementado
    AND _TABLE_SUFFIX >= '20260301'
)
SELECT
  i.install_date,
  COUNT(DISTINCT i.user_pseudo_id)  AS installs,
  COUNT(DISTINCT t.user_pseudo_id)  AS trial_starts,
  ROUND(
    COUNT(DISTINCT t.user_pseudo_id) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100,
    1
  )                                  AS trial_start_rate_pct,
  20.0                               AS objetivo_pct
FROM installs i
LEFT JOIN trials t ON i.user_pseudo_id = t.user_pseudo_id
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 6. TRIAL → PAID CONVERSION  ← FOCO PRINCIPAL NEGOCIO
-- Métrica: % de trial_started que pasan a subscription_started
-- Objetivo: ≥50%
-- NOTA: Cuando implementes monetización, los eventos serán trial_started / subscription_started
-- ============================================================
WITH trials AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS trial_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'trial_started'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
conversions AS (
  SELECT DISTINCT user_pseudo_id
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'subscription_started'
    AND _TABLE_SUFFIX >= '20260301'
)
SELECT
  t.trial_date,
  COUNT(DISTINCT t.user_pseudo_id)  AS trial_starts,
  COUNT(DISTINCT c.user_pseudo_id)  AS paid_conversions,
  ROUND(
    COUNT(DISTINCT c.user_pseudo_id) / NULLIF(COUNT(DISTINCT t.user_pseudo_id), 0) * 100,
    1
  )                                  AS trial_to_paid_rate_pct,
  50.0                               AS objetivo_pct
FROM trials t
LEFT JOIN conversions c ON t.user_pseudo_id = c.user_pseudo_id
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- BONUS: FUNNEL COMPLETO DE CONVERSIÓN (onboarding → enroll)
-- Para identificar dónde se caen los usuarios en el funnel de Training Onboarding
-- ============================================================
WITH funnel_events AS (
  SELECT
    user_pseudo_id,
    event_name,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name IN (
    'first_open',
    'training_onboarding_continue_clicked',
    'program_start_intent_clicked',
    'program_enroll_intent_clicked',
    'signup_method_selected',
    'signup_completed',
    'program_enroll'
  )
  AND _TABLE_SUFFIX >= '20260301'
)
SELECT
  event_name,
  COUNT(DISTINCT user_pseudo_id) AS unique_users,
  ROUND(
    COUNT(DISTINCT user_pseudo_id)
    / NULLIF(MAX(IF(event_name = 'first_open', COUNT(DISTINCT user_pseudo_id), NULL)) OVER(), 0) * 100,
    1
  ) AS pct_of_installs
FROM funnel_events
GROUP BY 1
ORDER BY unique_users DESC;


-- ============================================================
-- 7. RETENCIÓN D1 / D7 / D30
-- La métrica más importante después de installs.
-- Te dice si estás llenando un cubo agujereado.
-- ============================================================
WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(DATE(TIMESTAMP_MICROS(event_timestamp))) AS install_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
activity AS (
  SELECT DISTINCT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS activity_date
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE _TABLE_SUFFIX >= '20260301'
    AND event_name NOT IN ('first_open', 'session_start', 'app_remove')
)
SELECT
  i.install_date,
  COUNT(DISTINCT i.user_pseudo_id) AS installs,
  COUNT(DISTINCT IF(DATE_DIFF(a.activity_date, i.install_date, DAY) = 1,  i.user_pseudo_id, NULL)) AS retained_d1,
  COUNT(DISTINCT IF(DATE_DIFF(a.activity_date, i.install_date, DAY) = 7,  i.user_pseudo_id, NULL)) AS retained_d7,
  COUNT(DISTINCT IF(DATE_DIFF(a.activity_date, i.install_date, DAY) = 30, i.user_pseudo_id, NULL)) AS retained_d30,
  ROUND(COUNT(DISTINCT IF(DATE_DIFF(a.activity_date, i.install_date, DAY) = 1,  i.user_pseudo_id, NULL)) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100, 1) AS d1_pct,
  ROUND(COUNT(DISTINCT IF(DATE_DIFF(a.activity_date, i.install_date, DAY) = 7,  i.user_pseudo_id, NULL)) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100, 1) AS d7_pct,
  ROUND(COUNT(DISTINCT IF(DATE_DIFF(a.activity_date, i.install_date, DAY) = 30, i.user_pseudo_id, NULL)) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100, 1) AS d30_pct
FROM installs i
LEFT JOIN activity a ON i.user_pseudo_id = a.user_pseudo_id
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 8. TIEMPO HASTA PRIMER ENTRENO (Time to First Workout)
-- Mediana de horas entre first_open → training_session_complete
-- Si la mediana es >48h, hay fricción en el onboarding.
-- ============================================================
WITH installs AS (
  SELECT
    user_pseudo_id,
    MIN(TIMESTAMP_MICROS(event_timestamp)) AS install_ts
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
first_session AS (
  SELECT
    user_pseudo_id,
    MIN(TIMESTAMP_MICROS(event_timestamp)) AS first_session_ts
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'training_session_complete'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
)
SELECT
  COUNT(DISTINCT i.user_pseudo_id)                                                          AS installs,
  COUNT(DISTINCT f.user_pseudo_id)                                                          AS reached_first_workout,
  ROUND(COUNT(DISTINCT f.user_pseudo_id) / NULLIF(COUNT(DISTINCT i.user_pseudo_id), 0) * 100, 1) AS pct_reach_first_workout,
  ROUND(APPROX_QUANTILES(TIMESTAMP_DIFF(f.first_session_ts, i.install_ts, HOUR), 100)[OFFSET(50)], 1) AS median_hours_to_first_workout,
  ROUND(APPROX_QUANTILES(TIMESTAMP_DIFF(f.first_session_ts, i.install_ts, HOUR), 100)[OFFSET(75)], 1) AS p75_hours_to_first_workout
FROM installs i
LEFT JOIN first_session f ON i.user_pseudo_id = f.user_pseudo_id
WHERE f.user_pseudo_id IS NOT NULL;


-- ============================================================
-- 9. GUEST → ACCOUNT CONVERSION
-- % de usuarios que empezaron como guest y crearon cuenta real.
-- Crítico porque tienes login de invitado.
-- ============================================================
WITH guests AS (
  SELECT DISTINCT user_pseudo_id
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'guest_login'
    AND _TABLE_SUFFIX >= '20260301'
),
converted AS (
  SELECT DISTINCT user_pseudo_id
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name IN ('sign_up_success', 'google_sign_in_success', 'apple_sign_in_success')
    AND _TABLE_SUFFIX >= '20260301'
),
-- Usuarios guest que luego se registraron (guest_upgrade)
upgraded AS (
  SELECT
    user_pseudo_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS upgrade_date,
    MAX(IF(ep.key = 'method', ep.value.string_value, NULL)) AS upgrade_method
  FROM `automatica-v2.analytics_517999677.events_*`,
  UNNEST(event_params) AS ep
  WHERE event_name = 'guest_upgrade'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1, 2
)
SELECT
  COUNT(DISTINCT g.user_pseudo_id)  AS total_guests,
  COUNT(DISTINCT u.user_pseudo_id)  AS converted_to_account,
  ROUND(COUNT(DISTINCT u.user_pseudo_id) / NULLIF(COUNT(DISTINCT g.user_pseudo_id), 0) * 100, 1) AS guest_conversion_rate_pct,
  -- Breakdown por método
  COUNT(DISTINCT IF(u.upgrade_method = 'google', u.user_pseudo_id, NULL)) AS via_google,
  COUNT(DISTINCT IF(u.upgrade_method = 'apple',  u.user_pseudo_id, NULL)) AS via_apple,
  COUNT(DISTINCT IF(u.upgrade_method = 'email',  u.user_pseudo_id, NULL)) AS via_email
FROM guests g
LEFT JOIN upgraded u ON g.user_pseudo_id = u.user_pseudo_id;


-- ============================================================
-- 10. SESIONES POR SEMANA POR USUARIO ENROLLADO
-- Calidad del engagement, no solo volumen.
-- Un usuario que entrena 3x/semana vale 10x más que uno que entrena 1x/mes.
-- ============================================================
WITH enrolled_users AS (
  SELECT DISTINCT user_pseudo_id
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'program_enroll'
    AND _TABLE_SUFFIX >= '20260301'
),
weekly_sessions AS (
  SELECT
    e.user_pseudo_id,
    DATE_TRUNC(DATE(TIMESTAMP_MICROS(s.event_timestamp)), WEEK) AS week,
    COUNT(*) AS sessions_that_week
  FROM enrolled_users e
  JOIN `automatica-v2.analytics_517999677.events_*` s ON e.user_pseudo_id = s.user_pseudo_id
  WHERE s.event_name = 'training_session_complete'
    AND s._TABLE_SUFFIX >= '20260301'
  GROUP BY 1, 2
)
SELECT
  week,
  COUNT(DISTINCT user_pseudo_id)                                                              AS active_users,
  ROUND(AVG(sessions_that_week), 2)                                                           AS avg_sessions_per_user,
  ROUND(APPROX_QUANTILES(sessions_that_week, 100)[OFFSET(50)], 1)                            AS median_sessions,
  COUNT(DISTINCT IF(sessions_that_week >= 3, user_pseudo_id, NULL))                          AS users_3plus_sessions,
  ROUND(COUNT(DISTINCT IF(sessions_that_week >= 3, user_pseudo_id, NULL)) / NULLIF(COUNT(DISTINCT user_pseudo_id), 0) * 100, 1) AS pct_3plus_sessions
FROM weekly_sessions
GROUP BY 1
ORDER BY 1 DESC;


-- ============================================================
-- 11. TOP PROGRAMAS POR ENROLLMENT
-- ¿Qué programa convierte mejor? Decide qué poner primero en el onboarding.
-- ============================================================
SELECT
  MAX(IF(ep.key = 'program_name', ep.value.string_value, NULL)) AS program_name,
  MAX(IF(ep.key = 'program_type', ep.value.string_value, NULL)) AS program_type,
  MAX(IF(ep.key = 'location',     ep.value.string_value, NULL)) AS location,
  MAX(IF(ep.key = 'entry_point',  ep.value.string_value, NULL)) AS entry_point,
  COUNT(DISTINCT user_pseudo_id)                                 AS total_enrolls,
  MAX(IF(ep.key = 'program_id',   ep.value.int_value,    NULL)) AS program_id
FROM `automatica-v2.analytics_517999677.events_*`,
UNNEST(event_params) AS ep
WHERE event_name = 'program_enroll'
  AND _TABLE_SUFFIX >= '20260301'
GROUP BY
  -- Agrupar por program_id implícitamente a través de los parámetros
  (SELECT ep2.value.int_value FROM UNNEST(event_params) ep2 WHERE ep2.key = 'program_id' LIMIT 1),
  (SELECT ep2.value.string_value FROM UNNEST(event_params) ep2 WHERE ep2.key = 'entry_point' LIMIT 1)
ORDER BY total_enrolls DESC
LIMIT 20;


-- ============================================================
-- BONUS: RESUMEN DIARIO DE KPIs (dashboard rápido)
-- Útil para conectar directamente a Looker Studio como tabla base
-- ============================================================
WITH daily_installs AS (
  SELECT DATE(TIMESTAMP_MICROS(event_timestamp)) AS date, COUNT(DISTINCT user_pseudo_id) AS installs
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'first_open' AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
daily_enrolls AS (
  -- Solo entry_point=onboarding: mide activación (North Star).
  -- Catalog enrolls = engagement de usuarios ya activos, no cuentan aquí.
  SELECT DATE(TIMESTAMP_MICROS(event_timestamp)) AS date, COUNT(DISTINCT user_pseudo_id) AS enrolls
  FROM `automatica-v2.analytics_517999677.events_*`,
  UNNEST(event_params) AS ep
  WHERE event_name = 'program_enroll'
    AND ep.key = 'entry_point' AND ep.value.string_value = 'onboarding'
    AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
),
daily_sessions AS (
  SELECT DATE(TIMESTAMP_MICROS(event_timestamp)) AS date, COUNT(DISTINCT user_pseudo_id) AS active_trainers
  FROM `automatica-v2.analytics_517999677.events_*`
  WHERE event_name = 'training_session_complete' AND _TABLE_SUFFIX >= '20260301'
  GROUP BY 1
)
SELECT
  i.date,
  i.installs,
  COALESCE(e.enrolls, 0)          AS program_enrolls,
  COALESCE(s.active_trainers, 0)  AS active_trainers,
  ROUND(COALESCE(e.enrolls, 0) / NULLIF(i.installs, 0) * 100, 1) AS enroll_rate_pct
FROM daily_installs i
LEFT JOIN daily_enrolls e  ON i.date = e.date
LEFT JOIN daily_sessions s ON i.date = s.date
ORDER BY 1 DESC;
