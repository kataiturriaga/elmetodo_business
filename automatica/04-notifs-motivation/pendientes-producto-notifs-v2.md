# Pendientes Producto — Notificaciones v2

> Lo que hay que definir o diseñar antes de que Carles pueda implementar.
> Referencia: [plan-carles-notifs-v2.md](plan-carles-notifs-v2.md)

---

## Decisiones a tomar

### 1. `training_week_done` — ¿push o in-app modal?

La celebración de semana completada podría ser un momento fuerte visualmente (como `streak_milestone`).

- **Si es in-app modal:** diseñar el modal en Figma (misma línea que el modal de streak milestone ya diseñado)
- **Si es push:** solo confirmar el copy — ya está definido

**Opciones de copy:** tiene 3 variantes. Decidir si:
- A) La variante se elige según si el usuario tiene racha activa (ver tabla en plan de Carles)
- B) Se rotan aleatoriamente (más simple para Carles)
- C) Se rotan en secuencia determinista

---

### 2. Milestone racha 3 semanas — ¿push o in-app modal?

Los milestones de racha actuales son in-app. ¿El de 3 semanas sigue el mismo patrón?

- Si es in-app: diseñar variante del modal de streak_milestone para n=3
- Si cambia a push para los más tempranos (2, 3 semanas) y in-app para los mayores: actualizar spec

---

### 3. Thresholds `training_week_pacing`

Definir qué significa "mucha semana y poco cumplimiento":

- Propuesta: % semana transcurrida >= **60%** Y % sesiones completadas < **40%** del objetivo
- ¿Cambiamos los números? ¿Hace falta testear contra datos reales primero?

Preguntar a Carles si puede sacar una distribución de usuarios que caerían en este threshold en semanas pasadas, para calibrar.

---

### 4. Threshold `training_week_closing`

Definir qué significa "va rellenando bastante a final de semana":

- Propuesta: jueves o viernes + sesiones >= **50%** del objetivo Y < 100%
- Alternativa más ajustada: >= **66%** (2 de 3 sesiones hechas, falta 1)

---

### 5. Día y hora de `training_week_zero`

- Propuesta: miércoles si sessions_this_week = 0
- Alternativa: jueves (darle más margen antes de alertar)
- ¿Repetir el jueves si el miércoles no abrió la app y sigue en 0? Necesita lógica de ventana.

---

### 6. Conflicto lunes: `training_week_bad_lookback` vs `training_streak_broken`

El plan de Carles prioriza `training_streak_broken` si aplican los dos. ¿Estás de acuerdo? O quizás:
- Para racha de 1 semana rota: `training_week_bad_lookback` (más suave)
- Para racha de 2+ semanas rota: `training_streak_broken` (más fuerte, menciona la racha)

---

## Diseño Figma pendiente

| Elemento | Necesario si... | Notas |
|---|---|---|
| Modal `training_week_done` | Se decide hacer in-app | Variante A (con racha) y variante B/C (sin racha) |
| Modal `streak_milestone` n=3 | Se decide hacer in-app | Puede reutilizar estructura del de n=2 con copy distinto |
| Actualizar modal `streak_milestone` n=2 | Siempre | Copy cambia — actualizar en Figma aunque la estructura sea igual |

---

## Copy a validar con Inazio

Algunos mensajes de Inazio tienen un tono muy específico. Confirmar que los ajustes son correctos:

| Mensaje original | Adaptación en spec | Revisar |
|---|---|---|
| "Letsss go! Finalizada la semana con fuerza. Si sigues así... no te van a reconocer en unas semanas🧐" | "Letsss go. Finalizada la semana con fuerza..." | ¿"Letsss go" intencional o typo? ¿Con o sin emoji? |
| "Semana CHEECK" | "Semana completada." | Se simplificó el título — ¿ok o quiere mantener el tono informal? |
| "3 semanas seguidas!! Ni yo en mis mejores tiempos⚡️ ahora esto se pone serio" | Se mantiene casi igual | ¿La voz de "Ni yo en mis mejores tiempos" funciona en notif push o es demasiado largo? |
| "VAMOS! Una semana más que suma. La gota de agua..." | Se mantiene casi igual | El cuerpo es largo para push — ¿recortar o dejar? |

---

## Checklist antes de dar luz verde a Carles

- [ ] Decidir push vs in-app para `training_week_done`
- [ ] Decidir push vs in-app para `streak_milestone` n=3
- [ ] Confirmar thresholds de pacing y closing
- [ ] Confirmar día/hora de `training_week_zero`
- [ ] Confirmar lógica de prioridad en lunes
- [ ] Diseñar modales si aplica
- [ ] Validar copy con Inazio
- [ ] Actualizar spec principal (`smooth-enchanting-puddle.md`) con todos los cambios
