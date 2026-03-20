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


| ID                   | Trigger                                                                              | Título                                                | Cuerpo                                                          | Audiencia                   | Cuándo                     | Dónde                                                                                                                                                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------- | --------------------------------------------------------------- | --------------------------- | -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `goal_reached_steps` | Usuario completa meta de pasos del día                                               | "¡Meta conseguida crack! 🎯"                          | "Alcanzaste 10.000 pasos hoy. A por más."                       | Todos                       | En el momento (servidor)   | Push                                                                                                                                                                                                                                    |
| `streak_at_risk`     | Racha activa ≥ 3 semanas y es viernes con < 3 sesiones completadas esa semana | "Completa {X} sesión(es) para salvar tus {N} semanas" | "Esta semana no rompas la racha, estás muy cerca."              | Todos con racha ≥ 3 semanas | Viernes 19:00 local | Push                                                                                                                                                                                                                                    |
| `streak_milestone`   | Racha de entrenos alcanza 2, 4, 8, 13, 26, 52 semanas                                | "¡{N} semanas seguidas! 🏆"                           | "Eso es constancia de verdad. Eres de los mejores en elmetodo." | Todos                       | En el momento              | In-app (modal) [https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3214-29617&t=WpddWEafb1pZouQA-1](https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3214-29617&t=WpddWEafb1pZouQA-1) |


> explicación de racha de entrenos (current_streak_weeks) abajo  
>
> ** 

---

### 2. RANKING SEMANAL (Engagement social)


| ID               | Trigger                                                               | Título                   | Cuerpo                                                | Audiencia                      | Cuándo                | Dónde                                                                                      |
| ---------------- | --------------------------------------------------------------------- | ------------------------ | ----------------------------------------------------- | ------------------------------ | --------------------- | ------------------------------------------------------------------------------------------ |
| `ranking_top3`   | Usuario entra en top 3 de su grupo en algún momento de la semana      | "¡Estás en el podio! 🥇" | "Eres #{P} en el grupo {Grupo}. No sueltes el ritmo." | Registrados con ranking activo | En el momento         | Push (preguntar carles si calcula posiciones sin abrir app, si no habria que hacer in-app) |
| `mid_week_nudge` | Jueves, usuario está fuera del top 10 pero a <20% de pasos del #10 | "Cerca del top 10 📈"    | "Llevas {N} pasos. Con un poco más entras en el top." | Registrados con ranking activo | Miércoles 10:00 local | Push                                                                                       |


**weekly_results según posición:**

#### `weekly_results` - lunes a las 12:00


| Posición        | Título                                    | Cuerpo                                                             |
| --------------- | ----------------------------------------- | ------------------------------------------------------------------ |
| Top 3           | "Top {P} de tu grupo la semana pasada 🥇" | "Increíble semana. Sigues siendo de los más activos."              |
| Top 10          | "Semana completada — #{P} en tu grupo"    | "Buena semana. Estás en el top 10 del grupo {G}."                  |
| Top 50%         | "Semana completada — #{P} en tu grupo"    | "Semana sólida. Hay margen para subir la próxima."                 |
| Bottom 50%      | "Resultados de la semana 📊"              | "Quedaste #{P}. Esta semana es tu oportunidad de remontar."        |
| Subida de grupo | "¡Subes al grupo {NuevoGrupo}! 🚀"        | "Tu actividad de esta semana te ha subido de nivel. A mantenerlo." |
| Bajada de grupo | "Esta semana, a remontar 💪"              | "Bajas al grupo {NuevoGrupo}. Una semana fuerte y vuelves."        |


---

### 3. ENTRENAMIENTO (Adherencia)


| ID                       | Trigger                                                                                    | Título                           | Cuerpo                                                           | Audiencia                                                                                             | Cuándo      | Dónde          |
| ------------------------ | ------------------------------------------------------------------------------------------ | -------------------------------- | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------- | -------------- |
| `training_reminder`      | Usuario suscrito a programa y lleva 3+ días sin completar ninguna sesión                   | "¿Seguimos con {Programa }? 🏋️" | "Llevas {X} días sin entrenar. ¿Hacemos 30 minutos hoy? ..."     | Usuarios con cualquier programa activo, en la notificación mencionamos el ultimo programa que entreno | 10:00 local | Push           |
| `training_streak_broken` | No completó el objetivo de 3 sesiones la semana anterior habiendo tenido racha ≥ 3 semanas | "Retoma tu ritmo 💪"             | "Llevabas {N} semanas cumpliendo. Vuelve a por ello esta semana" | Suscriptores con racha previa                                                                         | Lunes 08:00 | Push           |


---

### 4. CONVERSIÓN (Guest → Registro → Suscripción)


| ID                     | Trigger                                                                               | Título                                 | Cuerpo                                                                                  | Audiencia                                               | Cuándo                  | Dónde |
| ---------------------- | ------------------------------------------------------------------------------------- | -------------------------------------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------- | ----------------------- | ----- |
| `guest_register_nudge` | Guest activo ≥ 7 días con buena actividad (mirar carles como calcular esta actividad) | "Guarda tu progreso 🔐"                | "Llevas {N} días activo. Crea una cuenta y disfruta de nuestro catalogo de programas de entrenamiento | Guests activos                                          | Día 7 o 14 de actividad | Push  |
| `trial_expiring_3d`    | Trial expira en 3 días                                                                | "Tu acceso completo termina en 3 días" | "Tienes 3 días para suscribirte y no perder tus entrenamientos."                        | Trial activo no ha abierto la app en los últimos 3 días | 3 días antes            | Push  |
| `trial_expiring_1d`    | Trial expira mañana                                                                   | "Último día de acceso completo ⏳"      | "Mañana termina tu trial. Suscríbete hoy y sigue sin interrupciones."                   | Trial activo                                            | 1 día antes             | Push  |
| `trial_expired`        | Trial acaba de expirar                                                                | "Tu trial ha finalizado"               | "Puedes seguir con pasos y ranking. Suscríbete para acceder al entrenamiento."          | Trial expirado (zona1Blocked)                           | Día de expiración       | Push  |


---

### 5. RECUPERACIÓN (Churned Subscribers)



| ID             | Trigger                                   | Título                                | Cuerpo                                                                                                | Audiencia                                                   | Cuándo                                | Dónde                |
| -------------- | ----------------------------------------- | ------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------------------- | -------------------- |
| `churn_day0`   | Suscriptor cancela renovación automática  | "¿Qué ha pasado?"                     | "Cancelaste tu suscripción. Si fue un problema, cuéntanoslo, estamos para ayudar."                    | `subscription_status = cancelled`                           | Mismo día de cancelación, 18:00 local | Push + Email (later) |
| `churn_d3`     | D+3 desde cancelación, acceso aún activo  | "Tu acceso sigue activo"              | "Tienes acceso hasta el {fecha}. Aprovéchalo, tus programas y progreso siguen ahí."                   | `subscription_status = cancelled`                           | D+3 a las 10:00 local                 | Push                 |
| `churn_expiry` | Día de expiración del período pagado      | "Tu acceso termina hoy"               | "Hoy es el último día. Vuelve cuando quieras, tu progreso no va a ningún lado. {descuento si aplica}" | `subscription_status = cancelled`                           | Día de expiración, 09:00 local        | Push + Email (later) |
| `churn_d30`    | 30 días sin actividad desde la expiración | "Te echamos de menos"                 | "Llevas un mes fuera. Tu progreso sigue guardado. Cuando quieras, aquí estamos."                      | `subscription_status = cancelled` + sin sesiones en 30 días | D+30 a las 10:00 local                | Push + Email (later) |
| `churn_d90`    | 90 días desde la expiración               | "Mucho ha pasado desde que te fuiste" | "Han salido contenidos nuevos. Tu historial sigue guardado. ¿Volvemos?"                               | `subscription_status = cancelled` + sin sesiones en 90 días | D+90 a las 10:00 local                | Email (later)        |


**Notas:**

- `churn_expiry`: el descuento de retención está **pendiente de definir con Carles** (posible -30% primer mes). Si se implementa, se personaliza el cuerpo de la notificación y el destino del deep link es un paywall con precio especial.
- `churn_d90` solo por email — si llevan 3 meses sin abrir la app, el push probablemente no lo ven.
- Deep link para todas: paywall de re-suscripción (no el home).
- Estas notificaciones no computan en el límite de 1 notif/día porque el usuario ya no es suscriptor activo.

---

## Copy Detallado por Notificación

> **Tono elegido: Reto directo** — contundente, accionable, sin condescendencia. Tuteo.
> **Idioma: Solo español**
> Variables dinámicas entre `{llaves}`.

---

## Reglas Globales

1. **Límite diario:** Máximo 1 notificación por usuario por día (excepto lunes con weekly_results + promotion/relegation que cuentan como 1)
2. **Quiet hours:** No enviar entre 22:00 y 08:00 hora local del usuario
3. **Opt-out respetado:** Registro del estado de permisos en backend
4. **Deep links:** Cada notificación tiene un destino claro en la app (home, ranking, training session, suscripción)

---

## Deep Links por Notificación


| Notificación                                               | Destino                           |
| ---------------------------------------------------------- | --------------------------------- |
| `streak_at_risk`, `streak_milestone`, `goal_reached_steps` | Home screen (pasos)               |
| `weekly_results`, `ranking`_*, `mid_week_nudge`            | Pantalla de Ranking               |
| `training`_*                                               | Sesión de training del día        |
| `guest_register_nudge`                                     | Pantalla de registro              |
| `trial_expiring`_*, `trial_expired`                        | Pantalla de suscripción (paywall) |


---

## User Properties requeridas (spec para Carles)


| User Property          | Tipo    | Lógica                                                   | Cuándo actualizar                                      |
| ---------------------- | ------- | -------------------------------------------------------- | ------------------------------------------------------ |
| `current_streak_weeks` | Integer | Semanas consecutivas con ≥ 3 `training_session_complete` | Cada lunes, evaluando la semana lunes-domingo anterior |


**Lógica de cálculo:**

- Objetivo fijo: **3 sesiones por semana** para todos los usuarios (mínimo común de cualquier programa)
- Cada lunes: ¿la semana pasada tuvo ≥ 3 `training_session_complete`? → `current_streak_weeks +1`; si no → `current_streak_weeks = 0`
- Si el usuario no tiene historial, empieza en 0

**Por qué no por días:** los usuarios eligen sus días de entreno libremente — no existe un objetivo de días concretos. La semana es la unidad natural de adherencia.