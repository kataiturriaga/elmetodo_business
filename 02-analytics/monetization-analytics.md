# Analytics de Monetización — Spec para implementación

> **Estado**: Pendiente de implementación. Implementar cuando se construyan las features de suscripción, paywall y trial en la app.
>
> **Contexto**: Este documento complementa a `ANALYTICS.md` (que cubre lo que ya está construido). Aquí se definen los eventos, user properties y audiences necesarios para trackear el funnel de monetización.
>
> **Fuentes**: `0-general/objetives.md`, `01-product/programas/acceso-monet-notif.md`, `01-product/programas/campaña-sorteo.md`, `04-notifs-motivation/notifs-feb.md`

---

## Objetivos SMART que dependen de estos eventos

| Objetivo | Métrica | Target |
|----------|---------|--------|
| Monetización A — Trial | `Trial Start Rate` = % que hacen `trial_started` | ≥20% |
| Monetización B — Conversión | `Trial → Paid Conversion` = % de `trial_started` que pasan a `subscription_started` | ≥50% |

---

## Eventos de Monetización (12 nuevos)

### Paywall y Trial

| # | Event Name | Parámetros | Cuándo se dispara | Notas |
|---|-----------|-----------|-------------------|-------|
| 1 | `paywall_view` | `source`, `program_id` | Usuario ve modal de upsell / pantalla de pago | `source`: `dropdown`, `expiry_lock`, `catalog`, `push` |
| 2 | `trial_started` | `program_id`, `program_name` | Usuario activa trial de 3 días | Objetivo SMART #5 |
| 3 | `trial_ended` | `converted` (bool) | Trial expira | `converted: true` si pagó antes de expirar |
| 4 | `subscription_started` | `program_id`, `plan_type` | Usuario paga suscripción | `plan_type`: el tipo de plan/precio |
| 5 | `subscription_cancelled` | `reason` (opcional) | Usuario cancela suscripción | Para medir churn de pago |

### Teaser y Drop de Programas Completos (campaña sorteo)

| # | Event Name | Parámetros | Cuándo se dispara | Notas |
|---|-----------|-----------|-------------------|-------|
| 6 | `premium_teaser_view` | `program_id`, `state` | Ve el teaser del programa completo en dropdown | `state`: `coming_soon` / `available` |
| 7 | `premium_remind_me_tap` | `program_id`, `push_permission` | Toca "Recordármelo" | `push_permission`: `granted` / `denied` / `already_granted` |
| 8 | `premium_drop_announcement_view` | — | Ve el anuncio de apertura de programas completos | Push o banner in-app |
| 9 | `premium_drop_click` | `source` | Toca CTA del anuncio del drop | `source`: `push` / `banner` |

### Timeline de Urgencia (fin programa base)

| # | Event Name | Parámetros | Cuándo se dispara | Notas |
|---|-----------|-----------|-------------------|-------|
| 10 | `base_expiry_warning_shown` | `days_remaining`, `channel` | Se muestra aviso de fin de programa | `days_remaining`: `7` / `3` / `1` / `0`. `channel`: `push` / `in_app_banner` / `full_screen` |
| 11 | `base_expiry_locked_view` | — | Usuario ve pantalla de bloqueo tras 4 semanas sin pagar | Medir conversión post-bloqueo |
| 12 | `base_graduation_view` | `program_id` | Ve la pantalla de "graduación" (D+28, completó fase gratuita) | Momento emocional → CTA de trial |

---

## Enum Values para `AnalyticsEvent`

Añadir al enum cuando se implemente:

```dart
// Monetization
paywallView,
trialStarted,
trialEnded,
subscriptionStarted,
subscriptionCancelled,
premiumTeaserView,
premiumRemindMeTap,
premiumDropAnnouncementView,
premiumDropClick,
baseExpiryWarningShown,
baseExpiryLockedView,
baseGraduationView,
```

---

## Parámetros nuevos para `AnalyticsParams`

```dart
// Monetization
static const String source = 'source';
static const String planType = 'plan_type';
static const String converted = 'converted';
static const String state = 'state';
static const String pushPermission = 'push_permission';
static const String daysRemaining = 'days_remaining';
static const String channel = 'channel';
static const String reason = 'reason';
```

---

## User Properties nuevas (3)

Estas properties son **críticas** para segmentar. `subscription_status` estaba reservada en ANALYTICS.md — aquí se define.

| Property | Valores | Set When | Marketing Use |
|----------|---------|----------|---------------|
| `subscription_status` | `free` / `trial` / `active` / `expired` / `cancelled` | Cambio de estado de suscripción | **LA property más importante**. Segmenta todo: pushes, audiencias, análisis |
| `trial_start_date` | ISO date | `trial_started` | Calcular cuándo expira, targetear pre-expiración |
| `base_program_end_date` | ISO date | `program_enroll` (programa base) | Timeline de notificaciones D+21, D+25, D+28 |

> **Nota**: con estas 3 properties, el total sube a 25/25 (el máximo de GA4). Si se necesita espacio, valorar quitar `theme` (dark/light) que tiene poco valor de marketing.

### Cuándo actualizar `subscription_status`

| Momento | Valor |
|---------|-------|
| Registro / login (sin trial ni pago) | `free` |
| `trial_started` | `trial` |
| `subscription_started` | `active` |
| `trial_ended` (sin pago) | `expired` |
| `subscription_cancelled` | `cancelled` |

---

## Firebase Audiences nuevas (5)

| # | Audience | Condición | Uso para Push / Campañas |
|---|---------|-----------|--------------------------|
| 1 | **Trial Activo** | `subscription_status = trial` | **NO enviar** push de monetización (ya está en proceso) |
| 2 | **Trial Expirado sin Pagar** | `trial_ended` con `converted = false` | Win-back: "Tu prueba terminó. Vuelve con X% descuento" |
| 3 | **Programa Base Semana 3** | `base_program_end_date` en próximos 7 días | Push D+21: "Te queda 1 semana" (según `notifs-feb.md`) |
| 4 | **Bloqueados Post-4-Semanas** | `subscription_status = free` + `base_expiry_locked_view` | Push de reenganche: "Tu progreso sigue ahí" |
| 5 | **Sorteo Cohort** | `first_open` durante periodo de sorteo | Medir la cohorte de adquisición del sorteo vs orgánico |

---

## Funnels a construir en GA4

### Funnel 1: Programa Base → Trial → Pago

```
program_enroll (base) → training_session_complete (×6) → base_expiry_warning_shown → paywall_view → trial_started → subscription_started
```

### Funnel 2: Teaser → Drop → Conversión

```
premium_teaser_view → premium_remind_me_tap → premium_drop_announcement_view → premium_drop_click → paywall_view → trial_started
```

### Funnel 3: Bloqueo → Reenganche

```
base_expiry_locked_view → paywall_view → trial_started → subscription_started
```

---

## Dimensiones custom a registrar en GA4 Console

### Event-Scoped

| Parámetro | Descripción |
|-----------|-------------|
| `source` | Origen del paywall (dropdown, expiry_lock, catalog, push) |
| `plan_type` | Tipo de plan de suscripción |
| `converted` | Si el trial convirtió a pago |
| `state` | Estado del teaser (coming_soon / available) |
| `push_permission` | Resultado del permiso de push |
| `days_remaining` | Días restantes del programa base |
| `channel` | Canal del aviso (push / in_app_banner / full_screen) |
| `reason` | Motivo de cancelación |

### User-Scoped

| Property | Descripción |
|----------|-------------|
| `subscription_status` | Estado de suscripción del usuario |
| `trial_start_date` | Fecha de inicio del trial |
| `base_program_end_date` | Fecha de fin del programa base |

---

## Valores de `notification_type` para eventos de notificación

Para los eventos `notification_received` y `notification_tap` definidos en `ANALYTICS.md`, estos son los valores que debe tomar el parámetro `notification_type` según la estrategia de `notifs-feb.md`:

| Valor | Categoría | Ejemplo |
|-------|-----------|---------|
| `monetization_t7` | Monetización | D+21 — "Te queda 1 semana" |
| `monetization_t3` | Monetización | D+25/26 — "Te quedan 3 días" |
| `monetization_graduation` | Monetización | D+28 — "Graduación" |
| `monetization_reenganche` | Monetización | D+29/30 — "Tu progreso sigue ahí" |
| `monetization_drop` | Monetización | Apertura de programas completos |
| `habit_steps` | Hábito | "Hoy a por los 10k" |
| `habit_training` | Hábito | "Hoy toca sesión" |
| `community_ranking_start` | Comunidad | Lunes — nueva semana ranking |
| `community_ranking_mid` | Comunidad | Miércoles — "estás cerca de X" |
| `community_ranking_end` | Comunidad | Domingo — último empujón |
| `community_ranking_result` | Comunidad | Cierre — tu posición final |

---

## Archivos a modificar (cuando se implemente)

| Archivo | Cambios |
|---------|---------|
| `lib/core/analytics/analytics_service.dart` | Añadir 12 eventos al enum + 8 params + 3 user properties |
| `lib/core/analytics/analytics_providers.dart` | Añadir `AnalyticsMonetizationExtension` |
| Pantalla de paywall (nueva) | Wire `paywall_view` |
| Lógica de trial (nueva) | Wire `trial_started`, `trial_ended` |
| Lógica de suscripción (nueva) | Wire `subscription_started`, `subscription_cancelled` |
| Dropdown de programa completo (existente/nuevo) | Wire `premium_teaser_view`, `premium_remind_me_tap` |
| Sistema de notificaciones | Wire `base_expiry_warning_shown`, drop events |
| Pantalla de bloqueo (nueva) | Wire `base_expiry_locked_view` |
| Pantalla de graduación (nueva) | Wire `base_graduation_view` |

---

## Helper Extension propuesta

```dart
extension AnalyticsMonetizationExtension on AnalyticsService {
  Future<void> logPaywallView({
    required String source,
    int? programId,
  }) async {
    await logEvent(AnalyticsEvent.paywallView, {
      'source': source,
      if (programId != null) AnalyticsParams.programId: programId,
    });
  }

  Future<void> logTrialStarted({
    required int programId,
    required String programName,
  }) async {
    await logEvent(AnalyticsEvent.trialStarted, {
      AnalyticsParams.programId: programId,
      AnalyticsParams.programName: programName,
    });
    await setUserProperty(
      name: 'subscription_status',
      value: 'trial',
    );
    await setUserProperty(
      name: 'trial_start_date',
      value: DateTime.now().toIso8601String(),
    );
  }

  Future<void> logSubscriptionStarted({
    required int programId,
    required String planType,
  }) async {
    await logEvent(AnalyticsEvent.subscriptionStarted, {
      AnalyticsParams.programId: programId,
      'plan_type': planType,
    });
    await setUserProperty(
      name: 'subscription_status',
      value: 'active',
    );
  }

  Future<void> logBaseExpiryWarning({
    required int daysRemaining,
    required String channel,
  }) async {
    await logEvent(AnalyticsEvent.baseExpiryWarningShown, {
      'days_remaining': daysRemaining,
      'channel': channel,
    });
  }
}
```
