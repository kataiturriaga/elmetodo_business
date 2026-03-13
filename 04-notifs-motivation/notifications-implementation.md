# Plan de Implementación — Notificaciones elmetodo_app

---

## Quién implementa cada notificación

> **Firebase Console (tú)** = mensajes estáticos, sin variables dinámicas por usuario.
> **Código — Carles** = mensajes personalizados con datos del usuario, in-app modals, y cualquier lógica condicional compleja.

| Notificación | Tipo | ¿Quién? | Motivo |
|---|---|---|---|
| `daily_reminder` | Push | ✅ Firebase Console | Mensaje genérico, sin variables de usuario |
| `weekly_results` | Push | ✅ Firebase Console (versión genérica) | El copy con `#{P}` posición requiere Carles |
| `trial_expiring_3d` | Push | ✅ Firebase Console | No necesita datos personalizados |
| `trial_expiring_1d` | Push | ✅ Firebase Console | No necesita datos personalizados |
| `trial_expired` | Push | ✅ Firebase Console | No necesita datos personalizados |
| `guest_register_nudge` | Push | ⚠️ Firebase Console (versión genérica) | El `{N} días activo` requiere Carles |
| `streak_at_risk` | Push | ❌ Carles | Necesita `{N}` semanas y `{X}` sesiones por usuario |
| `streak_milestone` | In-app modal | ❌ Carles | Necesita detectar el hito exacto de cada usuario |
| `ranking_promotion` | Push | ❌ Carles | Necesita `{NuevoGrupo}` por usuario |
| `ranking_relegation` | Push | ❌ Carles | Necesita `{NuevoGrupo}` por usuario |
| `ranking_top3` | In-app modal | ❌ Carles | Requiere datos de ranking en tiempo real |
| `mid_week_nudge` | Push | ❌ Carles | Necesita `{N}` pasos y `{X}` diferencia por usuario |
| `training_reminder` | Push | ❌ Carles | Necesita `{X}` días sin sesión y `{Programa}` por usuario |
| `training_day_done` | In-app banner | ❌ Carles | Se dispara dentro de la app al completar sesión |
| `training_week_done` | In-app modal | ❌ Carles | Se dispara dentro de la app, necesita % del programa |
| `training_program_done` | In-app modal | ❌ Carles | Se dispara dentro de la app al completar programa |
| `training_streak_broken` | Push | ❌ Carles | Necesita `{N}` semanas de racha por usuario |

---

## Fase 1 — Push notifications básicas

### Tu parte (sin código)

**Paso 1 — Alinear con Carles antes de empezar**
- [ ] Confirmar que implementa `current_streak_weeks` como user property en Firebase
- [ ] Confirmar que el ranking se cierra el domingo (afecta timing de `weekly_results`)
- [ ] Decidir si los triggers los calcula el servidor o el cliente

**Paso 2 — Configurar Firebase Cloud Messaging**
- [ ] Crear campaña `daily_reminder`
  - Audiencia: todos los usuarios
  - Scheduling: diario 18:00 local
  - Copy: variante B ("Hoy falta tu sesión")
- [ ] Crear campaña `streak_at_risk`
  - Audiencia: users con `current_streak_weeks ≥ 3`
  - Scheduling: jueves y viernes 19:00 local
  - Copy: variante B ("{X} sesión(es) para salvar {N} semanas")
- [ ] Crear campaña `weekly_results`
  - Audiencia: usuarios registrados
  - Scheduling: lunes 08:00 local

**Paso 3 — Verificar que llegan**
- [ ] Instalar la app en tu móvil como usuario de prueba
- [ ] Comprobar que recibes las notifs en los horarios configurados
- [ ] Comprobar que el deep link abre la pantalla correcta al hacer tap

---

### Parte de Carles (código)

- [ ] User property `current_streak_weeks` — calculada cada lunes (ver spec en smooth-enchanting-puddle.md)
- [ ] Deep links: cada notif abre la pantalla correcta al hacer tap
- [ ] Respetar quiet hours (no enviar entre 22:00-08:00)

---

## Fase 2 — In-app modals (celebración)

### Tu parte

**Paso 4 — Diseñar los modales en Figma**

| Modal | Tipo | Contenido |
|---|---|---|
| `training_day_done` | Banner ligero | "Día {N} completado ✅ · Queda {X} sesión(es) esta semana" |
| `training_week_done` | Modal de celebración | Título grande + % del programa completado + CTA "Ver siguiente semana" |
| `training_program_done` | Pantalla completa | Trofeo/animación + copy + CTA "Ver siguiente reto" |

Cada modal necesita: título, subtítulo, icono o animación, botón CTA.

**Paso 5 — Entregar diseños a Carles**
- [ ] Exportar frames de Figma con todas las variantes
- [ ] Especificar la lógica de disparo de cada modal (cuándo aparece exactamente)

### Parte de Carles

- [ ] Implementar los 3 modales en Flutter
- [ ] Lógica de disparo:
  - `training_day_done` → después de registrar `training_session_complete`
  - `training_week_done` → después de `training_session_complete` si era la última sesión de la semana
  - `training_program_done` → después de `training_session_complete` si era la última sesión del programa

---

## Fase 3 — Push notifications avanzadas

- [ ] `training_reminder` — requiere user property "días desde última sesión" (Carles)
- [ ] `guest_register_nudge` + `trial_expiring_*` — requieren audiencias basadas en estado de cuenta/trial
- [ ] `ranking_top3`, `mid_week_nudge` — requieren datos de ranking en tiempo real
- [ ] `streak_milestone` — requiere que `current_streak_weeks` esté funcionando (Fase 1)
