# Plan Implementación Notificaciones v2 — Para Carles

> Actualización del sistema de notificaciones basada en los mensajes de Inazio.
> Los thresholds marcados con `[PENDIENTE]` los confirma el equipo de producto antes de implementar.

---

## 1. Cambios a notificaciones existentes

### `streak_at_risk` — ampliar audiencia + copy nuevo

**Cambio:** Actualmente solo dispara para usuarios con racha ≥ 3 semanas. Ampliar a **todos los usuarios con programa activo** que llevan la semana sin completar el objetivo.


| Campo     | Antes                                                 | Ahora                                                 |
| --------- | ----------------------------------------------------- | ----------------------------------------------------- |
| Trigger   | Racha ≥ 3 sem + viernes + < 3 sesiones                | Viernes + sesiones_semana < 3 días (sin racha mínima) |
| Audiencia | Usuarios con racha ≥ 3 semanas                        | Todos con programa activo                             |
| Título    | "Completa {X} sesión(es) para salvar tus {N} semanas" | "Aun te quedan entrenos por hacer"                    |
| Cuerpo    | "Esta semana no rompas la racha, estás muy cerca."    | "Dale caña que no queda nada para acabar la semana"   |
| Cuándo    | Viernes 19:00 local                                   | Viernes 19:00 local (sin cambio)                      |
| Dónde     | Push                                                  | Push (sin cambio)                                     |


---

### `training_streak_broken` — copy nuevo

**Cambio:** Ampliar audiencia (actualmente solo racha ≥ 3 semanas previas) + copy nuevo de Inazio.


| Campo     | Antes                                                            | Ahora                                                                                                        |
| --------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| Trigger   | Semana anterior sin ≥ 3 sesiones habiendo tenido racha ≥ 3 sem   | Semana anterior sin ≥ 3 sesiones (cualquier usuario con programa activo)                                     |
| Audiencia | Suscriptores con racha previa ≥ 3 semanas                        | Todos con programa activo que no cumplieron la semana anterior                                               |
| Título    | "Retoma tu ritmo 💪"                                             | "Has fallado, y no pasa nada."                                                                               |
| Cuerpo    | "Llevabas {N} semanas cumpliendo. Vuelve a por ello esta semana" | "No intentes compensar, simplemente empieza de nuevo. Lo que hagas hoy decide si fue una pausa… o el final." |
| Cuándo    | Lunes 08:00 local (sin cambio)                                   | Lunes 08:00 local (sin cambio)                                                                               |


---

### `streak_milestone` — añadir 1, 2, 3 semaans

**Cambio 1:** Añadir milestone de 1 semanas: [https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3392-31686&t=Yt0NEs9oqtXvX831-1](https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3392-31686&t=Yt0NEs9oqtXvX831-1)

**Cambio 2:** Añadir milestone de 2 semanas: [https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3391-31111&t=Yt0NEs9oqtXvX831-1](https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3391-31111&t=Yt0NEs9oqtXvX831-1)

**Cambio 3:** Añadir milestone en **3 semanas** : [https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3391-31464&t=Yt0NEs9oqtXvX831-1](https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=3391-31464&t=Yt0NEs9oqtXvX831-1)

Secuencia milestones actualizada: 1, **2, 3, 4, 8, 13, 26, 52 semanas**

---

## 2. Notificaciones nuevas

### `training_week_zero` — onboarding: programa activo sin ningún entreno

Para usuarios que activaron su primer programa pero llevan 3 días sin completar ninguna sesión. Trigger único (no semanal).


| Campo      | Valor                                                                  |
| ---------- | ---------------------------------------------------------------------- |
| Trigger    | `total_sessions_completed` = 0 Y `days_since_first_program_start` >= 3 |
| Audiencia  | Todos con programa activo                                              |
| Título     | "Empieza hoy."                                                         |
| Cuerpo     | "Te prometiste algo y vas a cumplirlo. Empieza a entrenar hoy."        |
| Cuándo     | 3 días después de activar el primer programa, 10:00 local              |
| Dónde      | Push                                                                   |
| Frecuencia | Una sola vez por usuario                                               |


---

### `training_week_closing` — va cerrando bien a final de semana

Para usuarios que van cumpliendo pero aún no han terminado, en los últimos días.


| Campo     | Valor                                       |
| --------- | ------------------------------------------- |
| Trigger   | Viernes + `sessions_this_week` >= 3         |
| Audiencia | Todos con programa activo                   |
| Título    | "Sigue."                                    |
| Cuerpo    | "Aquí es donde la mayoría abandona. Tú no." |
| Cuándo    | Viernes 19:00 local `[PENDIENTE]`           |
| Dónde     | Push                                        |


---

### `training_week_bad_lookback` — inicio de semana tras semana mala

Para usuarios que empiezan semana nueva habiendo hecho muy poco la anterior. Distinto de `training_streak_broken` porque aplica a quien nunca tuvo racha también.


| Campo     | Valor                                                                                                    |
| --------- | -------------------------------------------------------------------------------------------------------- |
| Trigger   | Lunes + `sessions_semana_anterior` <= 1                                                                  |
| Audiencia | Todos con programa activo (incluye usuarios sin racha previa)                                            |
| Título    | "Nueva semana."                                                                                          |
| Cuerpo    | "La semana pasada no hiciste mucho... olvídate del pasado, ahora toca empezar la semana como se merece." |
| Cuándo    | Lunes 09:00 local                                                                                        |
| Dónde     | Push                                                                                                     |


> **Nota:** `training_week_bad_lookback` y `training_streak_broken` pueden disparar el mismo lunes para el mismo usuario. Aplicar regla de prioridad (ver sección 4).

---

## 3. User Properties requeridas (nuevas)


| User Property               | Tipo    | Lógica                                                                    | Cuándo actualizar                                  |
| --------------------------- | ------- | ------------------------------------------------------------------------- | -------------------------------------------------- |
| `sessions_this_week`        | Integer | Número de `training_session_complete` en la semana lunes-domingo en curso | Cada vez que se completa una sesión                |
| `sessions_semana_anterior`  | Integer | `sessions_this_week` de la semana pasada                                  | Cada lunes, antes de resetear `sessions_this_week` |
| `sessions_objetivo_semanal` | Integer | Objetivo del programa activo (o 3 si no hay programa, como ahora)         | Al activar o cambiar de programa                   |


---

## 4. Reglas de prioridad (conflictos el mismo día)

Cuando múltiples notifs podrían disparar el mismo día para el mismo usuario, usar esta jerarquía:

1. `training_week_done` — celebración siempre gana
2. `training_week_closing`
3. `training_week_pacing`
4. `streak_at_risk`
5. `training_week_zero`
6. `training_week_bad_lookback` / `training_streak_broken` (lunes — solo una de las dos)

El lunes, si aplican tanto `training_week_bad_lookback` como `training_streak_broken`, enviar solo `training_streak_broken` (el usuario que rompió racha ya tuvo racha — ese mensaje es más relevante).

---

## 5. Resumen de cambios


| Notificación                 | Tipo de cambio                 |
| ---------------------------- | ------------------------------ |
| `streak_at_risk`             | Ampliar audiencia + copy nuevo |
| `training_streak_broken`     | Ampliar audiencia + copy nuevo |
| `streak_milestone` n=2       | Copy nuevo                     |
| `streak_milestone` n=3       | Nuevo milestone                |
| `training_week_done`         | Nueva                          |
| `training_week_zero`         | Nueva                          |
| `training_week_pacing`       | Nueva                          |
| `training_week_closing`      | Nueva                          |
| `training_week_bad_lookback` | Nueva                          |


