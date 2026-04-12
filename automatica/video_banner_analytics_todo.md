# Video Banner — Analytics pendientes de implementar

> El screen view `/video-banner` ya se trackea automáticamente vía go_router + Firebase.
> Lo que falta son los eventos de negocio detallados a continuación.

---

## 1. Eventos nuevos a añadir al enum `AnalyticsEvent`

Archivo: `lib/core/analytics/analytics_service.dart`

```dart
// Video Banner
videoBannerShown,
videoBannerDismissed,
videoOpened,
videoClosedEarly,
videoCompleted,
videoCtaShown,
videoCtaTapped,
videoCtaDismissed,
```

---

## 2. Params nuevos a añadir a `AnalyticsParams`

Archivo: `lib/core/analytics/analytics_service.dart`

```dart
static const String videoBannerId = 'video_id';
static const String videoBannerTitle = 'video_title';
static const String userType = 'user_type';       // 'trial' | 'guest'
static const String ctaType = 'cta_type';         // 'motivation' | 'choose_program'
static const String secondsWatched = 'seconds_watched';
static const String percentWatched = 'percent_watched';
static const String daysShown = 'days_shown';
```

> Nota: `video_id` e `video_name` ya existen como `videoId` / `videoName` en `AnalyticsParams` (usados por Explore). Valorar reutilizarlos o añadir los específicos del banner.


## 4. Dónde disparar cada evento

### `VideoBannerCard` — `lib/features/home/presentation/widgets/video_banner_card.dart`

| Evento | Cuándo |
|--------|--------|
| `video_banner_shown` | Cuando `showBanner == true` y el widget se renderiza (en `build`, una vez) |
| `video_opened` | En el `onTap` del `GestureDetector`, antes del `context.push` |

### `VideoBannerVideoScreen` — `lib/features/home/presentation/screens/video_banner_video_screen.dart`

| Evento | Cuándo |
|--------|--------|
| `video_completed` | En `_onVideoUpdate`, cuando `_controller.value.position >= _controller.value.duration` |
| `video_closed_early` | En `dispose`, si el video no llegó al final (calcular `secondsWatched` y `percentWatched` del controller) |
| `video_cta_shown` | En `build`, cuando el bottom panel se renderiza (una vez) |
| `video_cta_tapped` | En el `onPressed` del `AppButton` (tanto flujo guest como active) |
| `video_cta_dismissed` | En el `CircularBackButton.onPressed` si el video no completó el CTA |

### `VideoBannerProvider` — `lib/features/home/presentation/providers/video_banner_provider.dart`

| Evento | Cuándo |
|--------|--------|
| `video_banner_dismissed` | Cuando el banner expira (lógica de los 3 días en el provider) |

---

## 5. Valor de `user_type`

| Valor | Condición en código |
|-------|---------------------|
| `'guest'` | `ref.watch(isGuestUserProvider) == true` |
| `'trial'` | usuario logado (no guest) — ampliar si hay más tiers |

---

## 6. Funnels clave a monitorizar en Firebase

1. **Apertura**: `video_banner_shown` → `video_opened`
2. **Retención**: `video_opened` → `video_completed`
3. **Conversión guest**: `video_cta_shown` → `video_cta_tapped`
