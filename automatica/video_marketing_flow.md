# Video Marketing Flow — El Método App

## Concepto

Flujo de soft marketing mediante videos informativos/motivacionales que reflejan la mentalidad de la app. Visible para todos los usuarios (suscriptores y no suscriptores), con CTAs diferenciados según estado de suscripción.

## Características del contenido

- **Duración**: 2-3 minutos por video
- **Frecuencia de publicación**: semanal
- **Almacenamiento**: Firebase Storage
- **Objetivo**: retención de usuarios existentes + conversión a suscripción

## Flujo propuesto (híbrido)

### 1. Trigger contextual
Al abrir la app el primer uso del día, o después de registrar una actividad, la app verifica si existe un video nuevo no visto por el usuario.

### 2. Banner no intrusivo
Si hay video nuevo → aparece un banner/card en la home (no bloquea el contenido) con:
- Thumbnail del video
- Título
- Duración ("Nuevo video · 2 min")

### 3. Modal full-screen (al tocar el banner)
El usuario elige abrir el video. Se reproduce en un modal pantalla completa, cerrable en cualquier momento.

### 4. CTA al finalizar el video

| Usuario | CTA |
|---------|-----|
| **Suscriptor** | Mensaje de motivación + CTA a registrar actividad |
| **No suscriptor** | CTA suave a suscribirse ("Entrena con método. Empieza hoy.") |

### 5. Marcado como visto
Una vez visto, el video se marca localmente. El banner no reaparece hasta el próximo video nuevo.

## Implementación técnica (alto nivel)

### Firestore — modelo de video
```
videos/
  {videoId}/
    title: string
    url: string (Firebase Storage)
    thumbnail_url: string
    published_at: timestamp
    description: string (opcional)
```

### Estado local (SharedPreferences)
- `last_seen_video_id`: ID del último video visto por el usuario

### Componentes Flutter a crear
1. `VideoCheckService` — lógica para comparar video más reciente vs. último visto
2. `VideoBannerWidget` — banner no intrusivo en la home
3. `VideoPlayerModal` — modal full-screen con reproductor
4. `VideoCtaWidget` — CTA diferenciado según estado de suscripción

### Dónde se integra en la home
- El banner se inserta en `HomeScreen` / `DiarioTabContent`
- El trigger se activa en el `build()` del provider de home o en un listener de primer uso del día

## Por qué este enfoque (vs. modal periódico puro)

- **No interrumpe**: el usuario elige si abre el video
- **No se siente spam**: aparece solo una vez por video nuevo (frecuencia semanal)
- **Contexto relevante**: post-actividad hace que el mensaje de mentalidad aterrice mejor
- **Conversión natural**: el CTA al final del video llega cuando el usuario ya está enganchado con el contenido

---

## Edge cases

| Situación | Comportamiento esperado |
|-----------|------------------------|
| Sin conexión al abrir la app | No se muestra el banner; se reintenta en el próximo lanzamiento |
| Error al cargar el video | Mostrar mensaje de error + botón "Reintentar"; no marcar como visto |
| El usuario cierra el video antes de terminar | Se marca como visto igualmente — si lo cerró, ya no le interesa |
| Hay un video más nuevo que el anterior no visto | Mostrar solo el más reciente; ignorar el no visto |
| Primer uso (sin `last_seen_video_id` local) | Tratar como "hay video nuevo" → mostrar banner |
| No hay ningún video publicado en Firestore | No mostrar banner; sin error visible |
| Suscripción cambia mientras el video está abierto | El CTA post-video refleja el estado al momento de cerrar el modal |

**Lógica de "visto":** el video se marca como visto en el instante en que el usuario inicia la reproducción. Si lo cierra al segundo 1, no volverá a aparecer.

---

## Métricas de éxito

### Eventos Firebase Analytics

| Evento | Cuándo se dispara |
|--------|------------------|
| `video_banner_shown` | Banner visible en home |
| `video_banner_tapped` | Usuario toca el banner |
| `video_started` | Comienza la reproducción |
| `video_completed` | Video llega al final (para medir engagement real del contenido) |
| `video_cta_tapped` | Usuario toca el CTA post-video |
| `video_dismissed` | Usuario cierra el modal antes de terminar |

### KPIs objetivo
A revisar a las 4 semanas del lanzamiento:

| KPI | Objetivo |
|-----|----------|
| Tap-through rate del banner (`tapped` / `shown`) | >30% |
| Completion rate (`completed` / `started`) | >50% |
| CTA click rate — no suscriptores (`cta_tapped` / `completed`) | >15% |

---

## Plan de implementación por fases

### Fase 1 — MVP (1–2 semanas)
- `VideoCheckService`: consulta Firestore, compara con `last_seen_video_id` local
- `VideoBannerWidget`: card no intrusiva en home con thumbnail + título
- Reproductor básico (`video_player` package) en modal cerrable
- Al iniciar la reproducción → guardar `last_seen_video_id` en SharedPreferences + disparar `video_started`

### Fase 2 — CTA y analytics (1 semana)
- `VideoCtaWidget` con lógica diferenciada suscriptor / no suscriptor
- Integración completa de eventos Firebase Analytics
- Manejo de edge cases (sin conexión, error de carga)

### Fase 3 — Optimización (tras 4 semanas de datos)
- Revisar KPIs y ajustar threshold de "visto" si fuera necesario
- Evaluar trigger post-registro de actividad (el banner aparece justo después de completar un entrenamiento)
- Considerar A/B test de posición del banner (arriba vs. centro de home)
