---
name: Dashboard KPIs Looker
overview: Crear un dashboard diario en Looker Studio para los KPIs definidos en `0-general/objetives.md`, usando fuente mixta (GA4 + BigQuery) y modelado en BigQuery para métricas de cohorte/ventanas (D0–D3 y 6/14).
todos:
  - id: inventory-data
    content: Inventariar qué hay en GA4 vs BigQuery (tablas, campos, ids, campañas) y confirmar la definición de install_date
    status: pending
  - id: bq-mart
    content: Crear dataset/vistas agregadas diarias para los KPIs (cohortes y ventanas)
    status: pending
  - id: looker-build
    content: Montar el dashboard en Looker Studio con páginas, filtros globales y objetivos
    status: pending
  - id: qa
    content: Validar 2–3 días de datos y ajustar definiciones/denominadores
    status: pending
  - id: docs
    content: Documentar en el repo definiciones, fuentes y mantenimiento del dashboard
    status: pending
isProject: false
---

## KPIs a cubrir (según `0-general/objetives.md`)

- **Adquisición**: Installs
- **Activación ligera (D0)**: % de Installs con (`health_permission_granted` o `ranking_unlock_success`) en D0
- **Activación fuerte (D0–D3)**: % de Installs con `base_program_enroll_success` en D0–D3
- **Enganche**: % de `base_program_enroll_success` con ≥6 `workout_completed` en 14 días
- **Monetización A**: % usuarios con `trial_started`
- **Monetización B**: % `trial_started` que llegan a `subscription_started`

## Decisiones de modelado (para que Looker sea simple)

- Definir un **install_date** único por usuario (desde GA4 export en BQ, o tabla propia).
- Definir **user_id** consistente (GA4 `user_pseudo_id` si no hay login; si hay, mapear a `user_id`).
- Calcular KPIs de cohortes/ventanas en BigQuery y exponerlos como **vistas agregadas por día**.

## Preparación de datos (BigQuery)

- Crear (o reutilizar) un dataset tipo `analytics_mart`.
- Crear vistas/tablas agregadas diarias:
  - `kpi_installs_daily`: installs por día (+ dimensiones: platform, country, campaign/source/medium)
  - `kpi_light_activation_d0_daily`: installs, light_activated_d0, rate
  - `kpi_base_enroll_d0d3_daily`: installs, base_enrolled_d0d3, rate
  - `kpi_base_6of14_daily`: base_starters, base_6of14, rate
  - `kpi_trial_start_daily`: eligible_users/installs (según def.), trial_started_users, rate
  - `kpi_trial_to_paid_daily`: trial_started_users, paid_users, conversion
- Si algunas dimensiones solo están en GA4 (y no en BQ), decidir:
  - o bien enriquecer en BQ (recomendado)
  - o bien hacer blending en Looker solo para vistas simples (evitar blending para cohortes).

## Diseño del dashboard (Looker Studio)

- **Controles globales**: selector de fecha (diario), platform, país, source/medium, campaign.
- **Página 1 — Executive overview**:
  - Scorecards: Installs, Light Activation D0, Base Enroll D0–D3, 6/14, Trial Start, Trial→Paid
  - Serie temporal diaria por KPI con línea de objetivo (40%, 20%, 35%, 20%, 50%).
  - Bloque “North Star” resaltando Activación fuerte.
- **Página 2 — Activación**:
  - Mini-funnel: Installs → Light Activation (D0) → Base Enroll (D0–D3)
  - Breakdown por plataforma/país/campaña.
- **Página 3 — Enganche**:
  - 6/14 rate por cohortes de install/enroll date.
  - Distribución de workouts en 14 días (si está disponible en BQ).
- **Página 4 — Monetización**:
  - Trial Start Rate (tendencia + breakdown)
  - Trial→Paid Conversion (tendencia + lag de conversión si se modela)

## Validación

- Validar métricas con queries puntuales en BQ para 2–3 días.
- Revisar definiciones (qué cuenta como Install, qué usuario entra en denominadores) para evitar dobles conteos.

## Entregables

- Dashboard publicado en Looker Studio (link) + doc corto en el repo describiendo:
  - fuentes
  - definiciones
  - queries/vistas en BQ
  - cómo mantenerlo.

