# Plan: Definición de Notificaciones Push — elmetodo_app

## Contexto

La app ya tiene infraestructura FCM lista (firebase_service.dart, messaging_service.dart). Este plan
define las notificaciones a nivel de producto — qué enviar, cuándo, a quién y con qué copy —
antes de implementar nada en código.

**Objetivos:** Retención diaria · Engagement social (ranking) · Adherencia al entrenamiento · Conversión a pago
**Audiencia:** Todos los usuarios (guests incluidos)
**Tono:** Moderado — max 2-3 por semana por usuario, priorizando momentos de celebración y riesgo real

---

## Categorías de Notificaciones

### 1. ACTIVIDAD DIARIA (Retención)

| ID | Trigger | Título | Cuerpo | Audiencia | Cuándo |
|----|---------|--------|--------|-----------|--------|
| `goal_reached_steps` | Usuario completa meta de pasos del día | "¡Meta conseguida! 🎯" | "Alcanzaste 10.000 pasos hoy. Tu racha sigue viva." | Todos | En el momento (servidor) |
| `streak_at_risk` | Racha activa ≥ 3 semanas y es jueves/viernes con < 3 sesiones completadas esa semana | "Tu racha de {N} semanas en peligro ⚠️" | "Te falta {X} sesión(es) para cerrar la semana. ¡Tú puedes!" | Todos con racha ≥ 3 semanas | Jueves/Viernes 19:00 local |
| `streak_milestone` | Racha alcanza 4, 8, 13, 26, 52 semanas | "¡{N} semanas seguidas! 🏆" | "Eso es constancia de verdad. Eres de los mejores en elmetodo." | Todos | En el momento |

---

### 2. RANKING SEMANAL (Engagement social)

| ID | Trigger | Título | Cuerpo | Audiencia | Cuándo |
|----|---------|--------|--------|-----------|--------|
| `weekly_results` | Fin de semana de ranking (domingo noche / lunes mañana) | "Los resultados de esta semana 📊" | "Quedaste #{P} en tu grupo. {Mensaje según resultado}" | Registrados | Lunes 08:00 local |
| `ranking_promotion` | Usuario sube de grupo (relegation/promotion calculado al cerrar semana) | "¡Subiste de grupo! 🚀" | "Pasas al grupo {NuevoGrupo}. Esta semana a por más." | Registrados | Lunes 08:00 (junto con weekly_results) |
| `ranking_relegation` | Usuario baja de grupo | "Esta semana nos toca remontar 💪" | "Bajaste al grupo {NuevoGrupo}. Tienes todo para volver." | Registrados | Lunes 08:00 (junto con weekly_results) |
| `ranking_top3` | Usuario entra en top 3 de su grupo en algún momento de la semana | "¡Estás en el podio! 🥇" | "Eres #{P} en el grupo {Grupo}. No sueltes el ritmo." | Registrados | En el momento (si baja de posición) |
| `mid_week_nudge` | Miércoles, usuario está fuera del top 10 pero a <20% de pasos del #10 | "Cerca del top 10 📈" | "Llevas {N} pasos. Con un poco más entras en el top." | Registrados con ranking activo | Miércoles 10:00 local |

**Copias para weekly_results según posición:**
- Top 3: "¡Increíble semana! Eres uno de los más activos del grupo."
- Top 10: "Muy buena semana. Estás entre los mejores."
- Top 50%: "Semana sólida. Hay margen para subir."
- Bottom 50%: "La próxima semana puede ser diferente. Empieza fuerte el lunes."

---

### 3. ENTRENAMIENTO (Adherencia)

| ID | Trigger | Título | Cuerpo | Audiencia | Cuándo |
|----|---------|--------|--------|-----------|--------|
| `training_reminder` | Usuario suscrito a programa y lleva 3+ días sin completar ninguna sesión | "¿Seguimos con {Programa}? 🏋️" | "Llevas {X} días sin entrenar. Retómalo cuando puedas." | Suscriptores con programa activo | 10:00 local |
| `training_day_done` | Usuario completa sesión de training | "Día {N} completado ✅" | "Semana {S} casi lista. Queda {X} sesión(es) esta semana." | Suscriptores | Inmediato post-completar |
| `training_week_done` | Usuario completa todas las sesiones de la semana | "¡Semana {N} terminada! 🔥" | "{X}% del programa completado. Siguiente semana disponible." | Suscriptores | Inmediato |
| `training_program_done` | Usuario completa el programa completo | "¡Programa completado! 🏆" | "Terminaste {Programa}. Ya tienes disponible tu siguiente reto." | Suscriptores | Inmediato |
| `training_streak_broken` | No completó el objetivo de 3 sesiones la semana anterior habiendo tenido racha ≥ 3 semanas | "Retoma tu ritmo 💪" | "Llevabas {N} semanas cumpliendo tu meta. Esta semana puedes volver a hacerlo." | Suscriptores con racha previa | Lunes 08:00 |

---

### 4. CONVERSIÓN (Guest → Registro → Suscripción)

| ID | Trigger | Título | Cuerpo | Audiencia | Cuándo |
|----|---------|--------|--------|-----------|--------|
| `guest_register_nudge` | Guest activo ≥ 7 días con buena actividad (racha ≥ 3 o ranking top 30%) | "Guarda tu progreso 🔐" | "Llevas {N} días activo. Crea una cuenta para no perder tu historial." | Guests activos | Día 7 o 14 de actividad |
| `trial_expiring_3d` | Trial expira en 3 días | "Tu acceso completo termina en 3 días" | "Tienes 3 días para suscribirte y no perder tus entrenamientos." | Trial activo | 3 días antes |
| `trial_expiring_1d` | Trial expira mañana | "Último día de acceso completo ⏳" | "Mañana termina tu trial. Suscríbete hoy y sigue sin interrupciones." | Trial activo | 1 día antes |
| `trial_expired` | Trial acaba de expirar | "Tu trial ha finalizado" | "Puedes seguir con pasos y ranking. Suscríbete para acceder al entrenamiento." | Trial expirado (zona1Blocked) | Día de expiración |

---

## Copy Detallado por Notificación

> **Tono elegido: Reto directo** — contundente, accionable, sin condescendencia. Tuteo.
> **Idioma: Solo español**
> Variables dinámicas entre `{llaves}`.

---

### ACTIVIDAD DIARIA

#### `daily_reminder` — Recordatorio si no has abierto la app

| | Título | Cuerpo |
|---|---|---|
| **A — emocional** | "¿Hoy entrenamos?" | "Tu racha te está esperando. Aún tienes tiempo para sumar una sesión." |
| **B — directo** | "Hoy falta tu sesión" | "Completa una sesión para seguir con tu racha de {N} semanas." |

*Usar variante A si racha = 0. Variante B si racha ≥ 1.*

---

#### `streak_at_risk` — Racha en peligro

| | Título | Cuerpo |
|---|---|---|
| **A — urgencia suave** | "Tu racha de {N} semanas, en peligro 🔥" | "Te falta {X} sesión(es) para cerrar la semana. Tienes hasta el domingo." |
| **B — reto directo** | "{X} sesión(es) para salvar {N} semanas" | "Esta semana no rompas la racha. Ya estás tan cerca." |

*Recomendado: B. Más accionable.*

---

#### `streak_milestone` — Hito de racha alcanzado

| Hito | Título | Cuerpo |
|---|---|---|
| 4 semanas (1 mes) | "Un mes cumpliendo tu meta 🔥" | "4 semanas seguidas. Estás entre el top de usuarios de elmetodo." |
| 8 semanas (2 meses) | "Dos meses de racha 💪" | "Lo que empezó como un hábito ya es parte de ti." |
| 13 semanas (3 meses) | "Un trimestre sin fallar 🏆" | "13 semanas. Eso no lo hace casi nadie. Sigue." |
| 26 semanas (6 meses) | "Medio año. Eres constancia pura." | "Pocos llegan aquí. Tú ya eres uno de ellos." |
| 52 semanas (1 año) | "Un año. Leyenda 🥇" | "52 semanas cumpliendo tu meta. Elmetodo te saluda." |

---

#### `goal_reached_steps` — Meta de pasos conseguida

| | Título | Cuerpo |
|---|---|---|
| **A — celebración** | "¡{N} pasos! Meta del día ✅" | "Lo conseguiste. Tu racha sigue viva ({S} días)." |
| **B — sin racha activa** | "Meta del día completada 🎯" | "{N} pasos. Hoy ha sido un buen día." |

---

### RANKING SEMANAL

#### `weekly_results` — Resultados del lunes

| Posición | Título | Cuerpo |
|---|---|---|
| Top 3 | "Top {P} de tu grupo esta semana 🥇" | "Increíble semana. Sigues siendo de los más activos." |
| Top 10 | "Semana completada — #{P} en tu grupo" | "Buena semana. Estás en el top 10 del grupo {G}." |
| Top 50% | "Semana completada — #{P} en tu grupo" | "Semana sólida. Hay margen para subir la próxima." |
| Bottom 50% | "Resultados de la semana 📊" | "Quedaste #{P}. Esta semana es tu oportunidad de remontar." |

---

#### `ranking_promotion` — Subida de grupo

| | Título | Cuerpo |
|---|---|---|
| **Único** | "¡Subes al grupo {NuevoGrupo}! 🚀" | "Tu actividad de esta semana te ha subido de nivel. A mantenerlo." |

---

#### `ranking_relegation` — Bajada de grupo

| | Título | Cuerpo |
|---|---|---|
| **A — motivador** | "Esta semana, a remontar 💪" | "Bajas al grupo {NuevoGrupo}. Una semana fuerte y vuelves." |
| **B — neutro** | "Cambio de grupo esta semana" | "Pasas al grupo {NuevoGrupo}. Tienes todo para subir de nuevo." |

*Recomendado: A. La bajada necesita energía, no frialdad.*

---

#### `mid_week_nudge` — Empujón de mitad de semana

| | Título | Cuerpo |
|---|---|---|
| **A** | "Cerca del top 10 📈" | "Llevas {N} pasos. Con {X} más entras en el top 10 del grupo." |
| **B** | "{X} pasos te separan del top 10" | "Es miércoles. Aún tienes tiempo para subir esta semana." |

---

### ENTRENAMIENTO

#### `training_reminder` — Recordatorio tras días sin sesión

| | Título | Cuerpo |
|---|---|---|
| **A — sin culpa** | "¿Seguimos con {Programa}? 🏋️" | "Llevas {X} días sin entrenar. Retómalo cuando puedas." |
| **B — directo** | "{X} días sin entrenar" | "El programa sigue donde lo dejaste. Cuando quieras, aquí está." |

*Recomendado: A. No asumimos que "hoy toca" — el usuario decide sus días.*

---

#### `training_day_done` — Sesión completada

| | Título | Cuerpo |
|---|---|---|
| **A** | "Día {N} completado ✅" | "Semana {S} casi lista. Queda {X} sesión(es)." |
| **Con esfuerzo percibido** | "Día {N} completado — esfuerzo {E} 💪" | "Cada sesión cuenta. Queda {X} para cerrar la semana." |

---

#### `training_week_done` — Semana de entrenamiento completada

| | Título | Cuerpo |
|---|---|---|
| **Único** | "¡Semana {N} terminada! 🔥" | "{X}% del programa completado. Próxima semana disponible." |

---

#### `training_program_done` — Programa completado

| | Título | Cuerpo |
|---|---|---|
| **Con continuación** | "¡{Programa} completado! 🏆" | "Lo terminaste. Tu siguiente reto ya está disponible." |
| **Sin continuación** | "¡{Programa} completado! 🏆" | "Increíble. Terminaste el programa completo. Descansa y vuelve fuerte." |

---

#### `training_streak_broken` — Volver tras días sin sesión

| | Título | Cuerpo |
|---|---|---|
| **A — sin culpa** | "¿Volvemos a entrenar esta semana?" | "Llevabas {N} semanas cumpliendo tu meta. Esta semana puedes retomarlo." |
| **B — reto** | "El día {N} de {Programa} te espera" | "La semana pasada se escapó. Esta empieza hoy." |

*Recomendado: A. Evita culpa, invita.*

---

### CONVERSIÓN

#### `guest_register_nudge` — Guest activo sin cuenta

| | Título | Cuerpo |
|---|---|---|
| **A — urgencia de pérdida** | "No pierdas tu progreso 🔐" | "Llevas {N} días activo. Crea una cuenta para proteger tu historial." |
| **B — beneficio** | "Desbloquea el ranking completo" | "Con una cuenta gratuita compites con usuarios de todo el mundo." |

*Recomendado: A para usuarios con racha. B para usuarios sin racha pero activos.*

---

#### `trial_expiring_3d` — Trial expira en 3 días

| | Título | Cuerpo |
|---|---|---|
| **Único** | "Tu acceso completo termina en 3 días" | "Suscríbete para seguir con tus entrenamientos sin interrupción." |

---

#### `trial_expiring_1d` — Trial expira mañana

| | Título | Cuerpo |
|---|---|---|
| **Único** | "Último día de acceso completo ⏳" | "Mañana termina tu trial. Suscríbete hoy y continúa donde lo dejaste." |

---

#### `trial_expired` — Trial expirado

| | Título | Cuerpo |
|---|---|---|
| **Único** | "Tu prueba ha finalizado" | "Sigues teniendo acceso a pasos y ranking. Para el entrenamiento, suscríbete." |

---

## Reglas Globales

1. **Límite diario:** Máximo 1 notificación por usuario por día (excepto lunes con weekly_results + promotion/relegation que cuentan como 1)
2. **Quiet hours:** No enviar entre 22:00 y 08:00 hora local del usuario
3. **No duplicar:** Si un usuario ya abrió la app hoy, no enviar `daily_reminder`
4. **Opt-out respetado:** Registro del estado de permisos en backend
5. **Deep links:** Cada notificación tiene un destino claro en la app (home, ranking, training session, suscripción)
6. **Prioridad de envío cuando hay conflicto en el mismo día:**
   `streak_at_risk` > `training_reminder` > `daily_reminder`

---

## Priorización para la primera fase (MVP notificaciones)

**Fase 1 — Mayor impacto, más fácil de implementar:**
1. `daily_reminder` — retención básica
2. `streak_at_risk` — retención de usuarios comprometidos
3. `streak_milestone` — celebración, viralidad
4. `weekly_results` + `ranking_promotion/relegation` — engagement social

**Fase 2:**
5. `training_reminder` + `training_day_done`
6. `guest_register_nudge` + `trial_expiring_3d/1d`

**Fase 3:**
7. `goal_reached_steps`, `ranking_top3`, `mid_week_nudge`, `training_program_done`

---

## Deep Links por Notificación

| Notificación | Destino |
|---|---|
| `daily_reminder`, `streak_at_risk`, `streak_milestone`, `goal_reached_steps` | Home screen (pasos) |
| `weekly_results`, `ranking_*`, `mid_week_nudge` | Pantalla de Ranking |
| `training_*` | Sesión de training del día |
| `guest_register_nudge` | Pantalla de registro |
| `trial_expiring_*`, `trial_expired` | Pantalla de suscripción (paywall) |

---

## User Properties requeridas (spec para Carles)

| User Property | Tipo | Lógica | Cuándo actualizar |
|---|---|---|---|
| `current_streak_weeks` | Integer | Semanas consecutivas con ≥ 3 `training_session_complete` | Cada lunes, evaluando la semana lunes-domingo anterior |

**Lógica de cálculo:**
- Objetivo fijo: **3 sesiones por semana** para todos los usuarios (mínimo común de cualquier programa)
- Cada lunes: ¿la semana pasada tuvo ≥ 3 `training_session_complete`? → `current_streak_weeks +1`; si no → `current_streak_weeks = 0`
- Si el usuario no tiene historial, empieza en 0

**Por qué no por días:** los usuarios eligen sus días de entreno libremente — no existe un objetivo de días concretos. La semana es la unidad natural de adherencia.

---

## Preguntas abiertas para alinear antes de implementar

- ¿El servidor calcula el trigger o el cliente? (recomiendo servidor vía backend job)
- ¿Hay preferencia de idioma/localización? (la app parece ser en español exclusivamente)
- ¿Se quiere A/B testing en copy desde el principio?
- ¿El ranking se cierra un día específico? (afecta timing de weekly_results)
