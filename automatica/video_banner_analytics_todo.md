# Video Banner — Analytics pendientes

El screen view del video banner ya se registra automáticamente. Lo que falta son los **eventos de negocio** que nos permiten entender el rendimiento del banner y su impacto en conversión.

---

## Eventos a registrar

### Banner

| Evento | Cuándo se dispara |
|--------|-------------------|
| `video_banner_shown` | Cuando el banner se muestra al usuario |
| `video_banner_dismissed` | Cuando el banner expira (tras los 3 días de vigencia) |

### Vídeo

| Evento | Cuándo se dispara |
|--------|-------------------|
| `video_opened` | Cuando el usuario pulsa el banner y abre el vídeo |
| `video_completed` | Cuando el vídeo llega al final |
| `video_closed_early` | Cuando el usuario cierra el vídeo antes de terminarlo |

### CTA (panel de conversión)

| Evento | Cuándo se dispara |
|--------|-------------------|
| `video_cta_shown` | Cuando el panel inferior con la CTA se muestra |
| `video_cta_tapped` | Cuando el usuario pulsa el botón de la CTA |
| `video_cta_dismissed` | Cuando el usuario descarta el panel sin interactuar |

---

## Propiedades a incluir en los eventos

| Propiedad | Valores posibles | Descripción |
|-----------|-----------------|-------------|
| `video_id` | ID del vídeo | Identifica qué vídeo se está mostrando |
| `video_title` | Título del vídeo | Nombre del vídeo |
| `user_type` | `guest` / `trial` | Tipo de usuario que ve el banner |
| `cta_type` | `motivation` / `choose_program` | Qué tipo de CTA se muestra |
| `seconds_watched` | Número | Segundos reproducidos antes de cerrar |
| `percent_watched` | 0–100 | Porcentaje del vídeo visto |
| `days_shown` | Número | Días que lleva activo el banner para ese usuario |

---

## Funnels clave a monitorizar

1. **Apertura** — ¿Cuántos usuarios que ven el banner lo abren?
   `video_banner_shown` → `video_opened`

2. **Retención** — ¿Cuántos usuarios que abren el vídeo lo ven entero?
   `video_opened` → `video_completed`

3. **Conversión** — ¿Cuántos usuarios interactúan con la CTA?
   `video_cta_shown` → `video_cta_tapped`
