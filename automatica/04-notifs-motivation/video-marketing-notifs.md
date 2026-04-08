# Notificaciones — Video Marketing Flow

Notificaciones asociadas al flujo de video marketing. Complementan el mecanismo in-app (banner en home visible 3 días).

---

## Tabla de notificaciones

| ID | Trigger | Título | Cuerpo | Audiencia | Cuándo | Canal |
|---|---|---|---|---|---|---|
| `new_video_published` | Se publica un nuevo video | "Nuevo video en El Método 🎬" | "{video_title} · 2 min" | Todos los usuarios registrados (trial + guest registrado) | Día de publicación, 18:00 local | Push |
| `training_scheduled_reminder` | Llega la hora configurada por el usuario en el flujo del video | "Es hora de entrenar 🏋️" | "Tienes {Programa} esperándote. ¿Empezamos?" | Usuarios que configuraron horario desde el flujo del video | A la hora configurada, con la antelación elegida (5/15/30 min antes) | Push |
| `training_scheduled_no_show` | Usuario tenía sesión programada ese día y no abrió la app en las 2h siguientes | "¿Olvidaste el entreno de hoy?" | "Todavía tienes tiempo. Son 30 minutos." | Usuarios con horario configurado que no registraron sesión | 2h después de la hora configurada | Push |

---

## Detalle

### `new_video_published`
- El body usa el título real del video (`{video_title}`) + duración para ser concreto.
- Solo a usuarios registrados — guests sin cuenta no tienen token push.

### `training_scheduled_reminder`
- Consecuencia directa de completar la pantalla "Configurar horario" del flujo.
- Se programa localmente en el dispositivo (scheduled notification), no requiere servidor.
- Si el usuario no tiene programa activo, el cuerpo es genérico: "Tienes un entreno programado para hoy."

### `training_scheduled_no_show`
- Solo si no hay registro de sesión completada ni apertura de app en las 2h post-horario.
- Máx 1 vez por semana para no saturar.
- Si ya existe `training_reminder` activo para ese usuario, esta notif tiene prioridad por ser más contextual.
