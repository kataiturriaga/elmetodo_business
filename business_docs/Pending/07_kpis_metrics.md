# KPIs & Metrics Framework — El Método

Framework completo de métricas para toma de decisiones de producto y negocio.

---

## North Star Metric

> **Usuarios que completan al menos 1 sesión de entrenamiento por semana (WAU activos en Training)**

**Por qué este NSM**:
- Correlaciona directamente con retención y conversión a pago
- Un usuario que entrena semanalmente tiene churn <3% vs >15% del usuario que solo pasea
- Es el comportamiento que diferencia El Método de un simple pedómetro
- Mide valor real entregado, no solo sesiones de app

**Cómo medirlo**: `session_complete` events / semana por userId único

---

## Pirámide de métricas

```
                    ┌─────────────────────┐
                    │   NORTH STAR METRIC  │
                    │  WAU Training Active │
                    └──────────┬──────────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
   ┌──────▼──────┐      ┌──────▼──────┐      ┌──────▼──────┐
   │  ACQUISITION│      │  ENGAGEMENT │      │ MONETIZATION│
   │             │      │             │      │             │
   │ • Installs  │      │ • D1/D7/D30 │      │ • Trial CVR │
   │ • Regist.   │      │ • Sessions/ │      │ • MRR       │
   │ • Trial act │      │   week      │      │ • Churn     │
   │ • CAC       │      │ • Programs  │      │ • LTV       │
   └─────────────┘      └─────────────┘      └─────────────┘
```

---

## Métricas de Adquisición

| KPI | Definición | Fórmula | Meta | Herramienta |
|-----|-----------|---------|------|-------------|
| **Installs** | Instalaciones totales | — | Crecer MoM | App Store / Play Console |
| **Install → Register** | Conversión de instalación a registro | Registros / Installs | >50% | Firebase |
| **Register → Trial** | Conversión de registro a trial de programa | Trials / Registros | >30% | Firebase |
| **CAC** | Coste de adquisición por usuario pagante | Gasto mktg / Nuevos subscribers | <LTV/3 | Manual |
| **Organic ratio** | % installs sin paid media | Organic installs / Total | >60% | App Store / Play |

### Funnel de adquisición completo

```
INSTALLS                    100%
    ↓ (health permission)
ACTIVADOS                    ~70% (permiten salud)
    ↓ (D1 retention)
D1 RETENTION                 ~40% (vuelven el día 1)
    ↓ (registro)
REGISTRADOS                  ~30% del total installs
    ↓ (activan trial)
TRIAL ACTIVADO               ~30% de registrados = ~9% de installs
    ↓ (conversión)
SUSCRIPTORES                 ~25% de trials = ~2.25% de installs
```

---

## Métricas de Engagement

| KPI | Definición | Fórmula | Meta | Frecuencia |
|-----|-----------|---------|------|------------|
| **D1 Retention** | % usuarios que vuelven al día 1 | DAU D1 / Installs D0 | >40% | Diaria |
| **D7 Retention** | % usuarios activos a 7 días | DAU D7 / Installs D0 | >25% | Semanal |
| **D30 Retention** | % usuarios activos a 30 días | DAU D30 / Installs D0 | >15% | Mensual |
| **DAU / MAU** | Stickiness del producto | DAU / MAU | >30% | Diaria |
| **Sessions/week** | Frecuencia de uso | Sesiones / Usuarios activos / semana | >3 (subscribers) | Semanal |
| **Program completion** | % que completan programa activado | Completados / Activados | >40% | Por cohorte |
| **Training session rate** | Usuarios que hacen training en 7 días | Training WAU / Total WAU | >50% (subscribers) | Semanal |

### Cohort de retención por tier

| Día | Guest | Free Trial | Subscriber |
|-----|-------|------------|------------|
| D1 | 25% | 55% | 75% |
| D7 | 10% | 35% | 60% |
| D30 | 5% | 20% | 45% |
| D90 | 2% | 10% | 35% |

*Metas estimadas basadas en benchmarks de fitness apps premium*

---

## Métricas de Monetización

| KPI | Definición | Fórmula | Meta |
|-----|-----------|---------|------|
| **Trial CVR** | Conversión trial → suscripción | Nuevos pagos / Trials | >25% |
| **MRR** | Monthly Recurring Revenue | Suma de pagos mensuales normalizados | Crecer 20% MoM |
| **ARPU** | Average Revenue Per User | MRR / Usuarios activos | — |
| **ARPPU** | Average Revenue Per Paying User | MRR / Subscribers | ~€12-15 |
| **Monthly Churn** | % suscriptores que cancelan | Cancelaciones / Suscriptores | <5% |
| **Annual Churn** | Churn anualizado | 1 - (1 - monthly churn)^12 | <46% |
| **LTV** | Lifetime value promedio | ARPPU / Churn rate | >€150 |
| **LTV/CAC ratio** | Rentabilidad de adquisición | LTV / CAC | >3x |
| **Plan mix** | Distribución de planes | % mensual / trimestral / anual | 10/60/30 |
| **NRR** | Net Revenue Retention | (MRR inicio + expansión - churn) / MRR inicio | >100% |

### Impacto del plan mix en métricas

| Plan mix dominante | Impacto en MRR | Impacto en Churn | Impacto en LTV |
|-------------------|---------------|-----------------|----------------|
| 80% mensual | Alto pero volátil | Alto (5-8%) | Bajo (~€90) |
| 60% trimestral | Estable | Medio (3-5%) | Medio (~€300) |
| 60% anual | Predecible | Bajo (<3%) | Alto (~€150+) |

> **Insight**: Incentivar trimestral > mensual mejora el LTV en 3x con el mismo volumen.

---

## Métricas de Salud del Producto

| KPI | Definición | Meta | Herramienta |
|-----|-----------|------|-------------|
| **Crash rate** | % sesiones con crash | <0.1% | Firebase Crashlytics |
| **ANR rate (Android)** | App Not Responding | <0.5% | Google Play Console |
| **App Store rating** | Puntuación media | >4.5 ⭐ | App Store Connect |
| **Google Play rating** | Puntuación media | >4.3 ⭐ | Play Console |
| **API latency (p99)** | Latencia de llamadas al backend | <500ms | Backend monitoring |
| **Health permission grant** | % usuarios que otorgan permiso | >60% | Firebase |

---

## Firebase Events & Tracking Map

### Eventos de compra (críticos para negocio)

| Evento | Trigger | Propiedades clave |
|--------|---------|-------------------|
| `paywall_viewed` | Pantalla paywall visible | entry_point, user_tier |
| `purchase_started` | Tap en plan | plan_id, plan_price |
| `purchase_completed` | Compra confirmada | plan_id, revenue, currency |
| `purchase_cancelled` | Usuario cancela flujo | plan_id, reason |
| `purchase_failed` | Error en compra | plan_id, error_code |

### Eventos de engagement (críticos para retención)

| Evento | Trigger | Propiedades clave |
|--------|---------|-------------------|
| `program_enroll` | Usuario activa programa | program_id, program_type |
| `session_complete` | Sesión de entreno finalizada | program_id, session_number, duration |
| `program_complete` | Programa completo terminado | program_id, weeks_taken |
| `activity_log` | Actividad manual registrada | activity_type, duration |
| `day_rate` | Usuario puntúa su día | rating, day_number |

### User Properties (para segmentación)

| Propiedad | Valores | Uso |
|-----------|---------|-----|
| `access_level` | zone0/zone1/zone1_blocked/zone2 | Segmentar por tier |
| `trial_active` | true/false | Audiencias de trial |
| `has_ever_subscribed` | true/false | Win-back campaigns |
| `subscription_tier` | monthly/quarterly/yearly | Análisis de plan mix |
| `preferred_program_type` | base/complete | Recomendación de contenido |

---

## Dashboards recomendados

### Dashboard Diario (operaciones)
- Installs del día / semana
- Trials activados
- Conversiones a pago
- Churn del día
- Crashes activos

### Dashboard Semanal (producto)
- Cohorte de retención semanal
- NSM: WAU Training Active
- Program completion rate
- Top features usadas

### Dashboard Mensual (negocio)
- MRR + MoM growth
- CAC vs LTV
- Plan mix
- NPS / App Store rating
- Churn por segmento
