# Looker Studio — Setup Guide
## El Método Analytics Dashboard

---

## Paso 1: Crear el reporte

1. Ve a [lookerstudio.google.com](https://lookerstudio.google.com)
2. Click **Blank Report**
3. En el panel de fuentes, selecciona **BigQuery**
4. Autentícate con la misma cuenta Google del proyecto `automatica-v2`
5. Selecciona: **My Projects → automatica-v2 → DATASET_ID → events_***
   > Sustituye DATASET_ID cuando lo tengas (analytics_XXXXXXX)

---

## Paso 2: Fuentes de datos (una por sección del dashboard)

En vez de conectar la tabla raw directamente, crea **Custom Queries** en Looker Studio.
Cada query del archivo `bigquery-queries.sql` se convierte en una fuente de datos independiente.

Para cada una:
1. En Looker Studio → **Add data → BigQuery → Custom Query**
2. Pega la query correspondiente
3. Ponle nombre descriptivo (ej: `KPI - Base Enroll Rate`)

### Fuentes a crear

> he metido hasta habit formation >

| Nombre en Looker Studio | Query del archivo SQL | Estado |
|-------------------------|-----------------------|--------|
| `Daily Installs` | Query #1 | ✅ |
| `Light Activation` | Query #2 | ✅ |
| `Base enroll rate` | Query #3 | ✅ |
| `Habit formation` | Query #4 | ✅ |
| `KPI - Trial Start Rate` | Query #5 | ✅ |
| `KPI - Trial to Paid` | Query #6 | ✅ |
| `RETENCIÓN D1 / D7 / D30` | Query #7 | ✅ |
| `Time to first workout` | Query #8 | ✅ |
| `GUEST- ACCOUNT CONVERSION` | Query #9 | ✅ |
| `SESIONES POR SEMANA POR USUARIO ENROLLADO` | Query #10 | ✅ |
| `TOP PROGRAMAS POR ENROLLMENT` | Query #11 | ✅ |
| `MON - Paywall Funnel` | Query #12 | ✅ |
| `MON - Paywall by Entry Point` | Query #13 | ✅ |
| `MON - Daily Monetization` | Query #14 | ✅ |
| `Summary daily KPIs` | Query Bonus Resumen | ✅ |
| `Query Bonus Funnel` | Query Bonus Funnel activación | ✅ |
| `Video Banner Funnel` | Query #15 | ⬜ |
| `Video Banner Performance` | Query #16 | ⬜ |
| `Video Banner CTA Split` | Query #17 | ⬜ |

---

## Paso 3: Estructura del dashboard (4 páginas)

### Página 1: Resumen Ejecutivo (vista diaria)

Widgets recomendados:

**Fila 1 — Scorecards (los 2 KPIs FOCO)**
- Scorecard: `base_enroll_rate_pct` — fuente: KPI - Base Enroll Rate
  - Comparison: vs objetivo 20%
- Scorecard: `trial_to_paid_rate_pct` — fuente: KPI - Trial Conversion
  - Comparison: vs objetivo 50%

**Fila 2 — Drivers**
- Scorecard: `installs` (total acumulado)
- Scorecard: `light_activation_rate_pct` — objetivo 40%
- Scorecard: `trial_start_rate_pct` — objetivo 20%

**Fila 3 — Gráfico de líneas**
- Serie temporal: `installs` + `base_enrolls_d0_d3` por fecha
- Fuente: SUMMARY - Daily KPIs
- Dimensión: `date` | Métricas: `installs`, `program_enrolls`, `active_trainers`

**Filtro de fecha global** (arriba a la derecha): Date range control → default "Last 30 days"

---

### Página 2: Funnel de Activación

**Funnel visual (usa Bar Chart horizontal)**
- Fuente: Query Bonus Funnel
- Dimensión: `event_name`
- Métrica: `unique_users`
- Ordenar por: `unique_users` DESC

Esto te muestra dónde se caen los usuarios:
```
first_open → training_onboarding_continue → program_start_intent
  → program_enroll_intent → signup_method → signup_completed → program_enroll
```

**Tabla detalle**
- Columnas: `event_name`, `unique_users`, `pct_of_installs`
- Formato condicional en `pct_of_installs`: rojo si <20%, amarillo 20-50%, verde >50%

---

### Página 3: Retención y Engagement

**Tabla de retención por cohorte**
- Fuente: KPI - Retention D1/D7/D30
- Columnas: `install_date`, `installs`, `d1_pct`, `d7_pct`, `d30_pct`
- Formato condicional:
  - D1 < 20% → rojo | 20-40% → amarillo | >40% → verde
  - D7 < 10% → rojo | 10-25% → amarillo | >25% → verde
  - D30 < 5% → rojo | 5-15% → amarillo | >15% → verde

**Scorecard: Time to First Workout**
- Fuente: KPI - Time to First Workout
- Métrica: `median_hours_to_first_workout`
- Si >48h → acción requerida en onboarding

**Gráfico de líneas: Sesiones semanales**
- Fuente: KPI - Weekly Sessions
- Dimensión: `week`
- Métricas: `avg_sessions_per_user`, `pct_3plus_sessions`

---

### Página 4: Programas y Contenido

**Tabla: Top programas**
- Fuente: KPI - Top Programs
- Columnas: `program_name`, `program_type`, `location`, `entry_point`, `total_enrolls`
- Ordenar por: `total_enrolls` DESC

**Pie chart: Enrolls por entry_point**
- Dimensión: `entry_point` (onboarding vs catalog)
- Métrica: `total_enrolls`

**Scorecards: Guest conversion**
- `total_guests`
- `guest_conversion_rate_pct`
- Breakdown: `via_google`, `via_apple`, `via_email`

---

### Página 5: Monetización

**Fila 1 — Scorecards**
- `purchases` — fuente: MON - Daily Monetization
- `trial_starts` — fuente: MON - Daily Monetization
- `conversion_paywall_pct` — fuente: MON - Daily Monetization (objetivo 15%)
- `trial_to_paid_rate_pct` — fuente: KPI - Trial to Paid (objetivo 50%)

**Fila 2 — Funnel del paywall (Bar Chart horizontal)**
- Fuente: MON - Paywall Funnel
- Dimensión: `event_name`
- Métrica: `unique_users`
- Ordena: `unique_users` DESC
- Muestra el drop en cada paso: paywall_viewed → purchase_started → purchase_completed

**Fila 3 — Entry points (Pie Chart)**
- Fuente: MON - Paywall by Entry Point
- Dimensión: `entry_point`
- Métrica: `paywall_views`
- Sirve para saber desde dónde llegan los usuarios al paywall

**Fila 4 — Serie temporal**
- Fuente: MON - Daily Monetization
- Dimensión: `date`
- Métricas: `paywall_views`, `purchases`, `trial_starts`

---

---

### Página 6: Video Banner

**Fila 1 — Funnel (Bar Chart horizontal)**
- Fuente: `Video Banner Funnel`
- Dimensión: `event_name`
- Métrica: `unique_users`
- Orden fijo: `video_banner_shown → video_opened → video_completed → video_cta_tapped`

**Fila 2 — Scorecards clave**
- `open_rate_pct` — fuente: `Video Banner Performance` (objetivo >30%)
- `completion_rate_pct` — fuente: `Video Banner Performance` (objetivo >50%)
- `cta_conversion_rate_pct` — fuente: `Video Banner Performance`

**Fila 3 — Tabla de performance por video × user_type**
- Fuente: `Video Banner Performance`
- Columnas: `video_title`, `user_type`, `banner_shown`, `open_rate_pct`, `completion_rate_pct`, `avg_percent_watched`, `cta_conversion_rate_pct`
- Formato condicional en `open_rate_pct`: <20% rojo | 20-40% amarillo | >40% verde

**Fila 4 — CTA split (Pie Chart doble)**
- Fuente: `Video Banner CTA Split`
- Gráfico 1: `cta_tapped` por `cta_type` (choose_program vs motivation)
- Gráfico 2: `tap_rate_pct` por `user_type` (guest vs trial)

---

## Paso 4: Compartir el dashboard

1. Click **Share** (arriba derecha)
2. **Manage access** → añade emails del equipo con rol **Viewer**
3. O genera un **link público** si quieres compartir con stakeholders sin cuenta Google

Para embed en Notion/Confluence:
- File → **Embed report** → copia el iframe

---

## Paso 5: Programar actualizaciones automáticas

Los datos de BigQuery se actualizan solos (streaming = cada hora).
Looker Studio refresca al abrir el reporte. Para forzar refresh manual: **Ctrl+Shift+E**.

Para alertas automáticas cuando un KPI baja de objetivo:
- Looker Studio no tiene alertas nativas
- Alternativa: crea una **Scheduled Query** en BigQuery que escriba a una tabla de alertas
  y configura notificaciones por email desde BigQuery

---

## Notas importantes

- **Coste**: Cada vez que Looker Studio abre una custom query, ejecuta una query en BigQuery.
  Para no gastar el free tier, activa **Data freshness = 12 hours** en cada fuente de datos
  (Edit data source → Data freshness). Así cachea los resultados.

- **_TABLE_SUFFIX**: Las queries usan `>= '20260301'`. Actualiza esta fecha cada trimestre
  o cámbiala a una fecha dinámica con `FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY))`.

- **DATASET_ID**: Reemplaza en todas las queries antes de conectar.
