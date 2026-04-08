# Video Marketing Flow — El Método App

## Concepto

Flujo de soft marketing mediante videos informativos/motivacionales que reflejan la mentalidad de la app. Visible para todos los usuarios (logados y no logados), con CTAs diferenciados según estado de suscripción.

## Características del contenido

- **Duración**: 2-3 minutos por video
- **Frecuencia de publicación**: vamos viendo
- **Objetivo**: retención de usuarios existentes + conversión a suscripción / trial de programa base

## Flujos de usuario

### Flujo A — Usuario con programa activo

```
Abre la app
  → Banner "Nuevo video" en home (visible 3 días)
    → Toca el banner → Modal full-screen con video reproduciéndose
      → CTA fijo en parte inferior: "Configurar recordatorio de entreno"
        → Pantalla configurar horario de entreno
          → "Listo, configurar notificaciones" / "Ahora no"
```

### Flujo B — Usuario Guest (sin programa activo)

```
Abre la app
  → Banner "Nuevo video" en home (visible 3 días)
    → Toca el banner → Modal full-screen con video reproduciéndose
      → CTA fijo en parte inferior: "Ver programas de fuerza · Y llega a tus objetivos"
        → Elige el plan (género + programa + "Empezar programa")
          → Escoge lugar de entrenamiento (Gimnasio / Casa con gomas / Casa con mancuernas)
            → Registro / login (Google, Apple, Email)
              → "¡Todo listo para empezar!"
```

---

## Pantallas del flujo (prototipadas en Figma)

| # | Pantalla | Descripción |
|---|----------|-------------|
| 1 | Home + Banner | Card no intrusiva con thumbnail, badge "NUEVO", título y duración |
| 2A | Modal video (Trial) | Video full-screen + CTA inferior "Configurar recordatorio de entreno" |
| 2B | Modal video (Guest) | Video full-screen + CTA inferior "Ver programas de fuerza" |
| 3 | Configurar horario | Días toggleables, time picker, opciones de recordatorio (5/15/30 min antes) |
| 4 | Elige el plan | Selector de género + carrusel de programas con "Empezar programa" |
| 5 | Lugar de entreno | Opciones: Gimnasio / Casa con gomas / Casa con mancuernas |
| 6 | Registro / login | Google, Apple, Email + "Continuar" |

> Diseño en **App Automatica → 📌 Final screens → 🎬 Video Marketing Flow**

---

## Detalle de cada paso

### 1. Trigger
Al abrir la app, se verifica si hay un video nuevo publicado que el usuario no haya visto aún.

### 2. Banner no intrusivo
Si hay video nuevo → aparece un banner/card en la home (no bloquea el contenido) con:
- Thumbnail del video
- Título
- Duración ("Nuevo video · 2 min")

El banner permanece visible durante **3 días** desde la publicación del video. Desaparece si el usuario lo ve o cuando pasan los 3 días.

### 3. Modal full-screen con CTA contextual
El video se reproduce en pantalla completa. **El CTA aparece fijo en la parte inferior mientras el video se reproduce**, diferenciado por tipo de usuario:

| Usuario | CTA en modal |
|---------|-------------|
| **Con programa activo** | "Configurar recordatorio de entreno" |
| **Guest** | "Ver programas de fuerza · Y llega a tus objetivos" |

### 4. Configurar horario (flujo Trial)
Pantalla de recordatorios de entreno:
- **Días**: selección de días de la semana (L M X J V S D)
- **Hora**: time picker tipo drum scroll
- **Recordatorio**: 5 / 15 / 30 minutos antes
- CTA: "Listo, configurar notificaciones" + "Ahora no"

### 5. Selección de programa (flujo Guest)
- Selector de género (Hombre / Mujer)
- Carrusel de programas con tags (tipo de entreno, acceso gratis 14 días)
- CTA "Empezar programa" + "Ver cómo funciona"

### 6. Marcado como visto
Una vez visto, el banner desaparece inmediatamente. Se almacena localmente el ID del video visto y la fecha de publicación (`last_seen_video_id`, `video_published_at`).

## Analytics

### Eventos a integrar

| Evento | Cuándo se dispara | Propiedades |
|--------|-------------------|-------------|
| `video_banner_shown` | Banner visible en home | `video_id`, `video_title`, `user_type` (trial / guest) |
| `video_banner_dismissed` | Banner desaparece por expiración (3 días sin ver) | `video_id`, `days_shown` |
| `video_opened` | Usuario toca el banner y abre el modal | `video_id`, `video_title`, `user_type` |
| `video_closed_early` | Usuario cierra el modal antes de terminar | `video_id`, `seconds_watched`, `percent_watched`, `user_type` |
| `video_completed` | Video llega al final | `video_id`, `user_type` |
| `video_cta_shown` | Pantalla de CTA post-video se muestra | `video_id`, `cta_type` (motivation / choose_program), `user_type` |
| `video_cta_tapped` | Usuario toca el CTA de elegir programa (guest) | `video_id`, `user_type` |
| `video_cta_dismissed` | Usuario toca "Cerrar" / "Ahora no" | `video_id`, `cta_type`, `user_type` |

### Funnels clave a monitorizar

1. **Alcance del banner**: `video_banner_shown` → `video_opened` (tasa de apertura)
2. **Retención de video**: `video_opened` → `video_completed` (completion rate)
3. **Conversión guest**: `video_cta_shown` → `video_cta_tapped` → (onboarding completado)

### Propiedad `user_type`

| Valor | Descripción |
|-------|-------------|
| `trial` | Usuario con programa activo en periodo de prueba |
| `guest` | Usuario sin programa activo |
