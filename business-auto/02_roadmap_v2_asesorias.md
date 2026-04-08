# Roadmap — V2 Asesorías (Coached Tier)
**El Método · Referencia interna**

---

## Contexto

La experiencia del tier **Asesorías (Coached)** está completamente por construir. No hay pantallas, no hay flujos definidos — se parte de cero.

**Qué se está haciendo:** Diseño completo de V2 — flujos, arquitectura de navegación y UI visual final lista para desarrollo.

**Plazo:** 20–25 días (solo diseño, sin implementación técnica)

**Restricciones clave:**
- El pago de la asesoría es **externo** (no hay IAP). El usuario llega a la app ya con la asesoría contratada
- El usuario puede llegar desde **3 canales**: redes sociales / WhatsApp / desde la app de suscripción
- La misma app sirve a los 3 tiers — el router detecta el tier en runtime y cambia la navegación

---

## Preguntas abiertas a resolver durante el diseño

Estas preguntas bloquean decisiones de diseño y deben cerrarse antes o durante cada fase:

| # | Pregunta | Bloquea |
|---|----------|---------|
| 1 | ¿Hay cuestionario inicial al activar la asesoría? (edad, objetivo, nivel) | Fase 1 |
| 2 | Si el usuario llega desde un link externo sin cuenta, ¿qué flujo de registro ve? | Fase 1 |
| 3 | ¿El coached puede seguir viendo los programas genéricos de suscripción? | Fase 2 |
| 4 | ¿Cuántos tabs tiene la shell V2 y cuáles exactamente? | Fase 2 |
| 5 | ¿Las medidas opcionales del check-in (cintura, cadera) son siempre visibles o solo si el coach las activa? | Fase 4 |
| 6 | ¿Hay pantalla de "Guías" como tab propio o es parte de Perfil/Home? | Fase 5 |

---

## Fases

### Fase 0 — Definición base
**Días 1–3**

Antes de diseñar nada, cerrar las decisiones estructurales que afectan a todo lo demás.

**Entregables:**
- [ ] Mapa de estados del usuario coached (sin plan / plan activo / ventana check-in / check-in enviado / plan actualizado / pausado / cancelado)
- [ ] Arquitectura de tabs V2 decidida (número, nombres, iconos)
- [ ] Criterio visual diferenciador de V1 (paleta, tono — el coached debe sentirse "premium y personal")
- [ ] Responder preguntas 1, 2 y 3 de la tabla de arriba

**Referencia técnica:**
- Los estados del plan ya documentados en `bussiness_docs/00_coached_app_overview.md` son una propuesta, no están cerrados
- El router ya tiene lógica de redirección por tier (`lib/core/router/app_router.dart`) — el diseño debe contemplar las transiciones de tier

---

### Fase 1 — Onboarding
**Días 4–7**

El flujo de entrada es crítico porque hay 3 canales distintos y el usuario puede o no tener cuenta previa.

**Flujos a diseñar:**

```
Canal A: Llega desde link externo (redes / WhatsApp)
  └─ Sin cuenta  → Registro → Activación de asesoría → [¿Cuestionario?] → Estado "plan en preparación"
  └─ Con cuenta  → Login → Activación de asesoría → Estado "plan en preparación"

Canal B: Llega desde app (ya es suscriptor)
  └─ CTA de upgrade → Activación de asesoría → [¿Cuestionario?] → Shell V2 activa
```

**Pantallas a diseñar:**
- [ ] Pantalla de activación / bienvenida al tier coached
- [ ] Cuestionario inicial (si se decide incluirlo — Pregunta 1)
- [ ] Estado vacío: "Tu coach está preparando tu plan" (primera vez, sin contenido)
- [ ] Transición visual de la shell V1 → shell V2 (si el usuario viene de suscriptor)

---

### Fase 2 — Shell V2 + Home
**Días 8–12**

La shell es lo que diferencia visualmente V2 de V1. El Home del coached combina las métricas de V1 con la capa del ciclo de asesoría.

**Pantallas a diseñar:**
- [ ] Navigation shell V2 (bottom bar, paleta, tipografía diferenciada)
- [ ] Home — estado normal (días 1–7 del ciclo): anillo de pasos + indicador "Ciclo · Día X de 14"
- [ ] Home — ventana de check-in (días 8–14): banner prominente con CTA
- [ ] Home — check-in enviado: banner desaparece, vuelve al indicador discreto
- [ ] Home — plan actualizado por el coach: banner puntual con fecha
- [ ] Home — sin plan todavía: mensaje "Tu coach está preparando tu plan"

**Nota de diseño:**
El anillo de pasos mantiene el protagonismo siempre. La capa coached es contextual, no invasiva.

---

### Fase 3 — Entreno + Dieta
**Días 13–17**

El contenido core de la asesoría. A diferencia de V1 (programas genéricos), aquí todo es asignado y gestionado por el coach.

**Entreno:**
- [ ] Vista principal: días de la semana con sesiones asignadas
- [ ] Vista de sesión: ejercicios con series × reps, técnica, notas del coach
- [ ] Ejecución de sesión: timer de descanso, marcar series, pantalla de celebración al completar
- [ ] Soporte para supersets (agrupados visualmente)
- [ ] Estado sin rutina asignada

**Dieta:**
- [ ] Vista principal: plan organizado por comidas del día (desayuno → cena)
- [ ] Detalle de comida: ingredientes con cantidades, calorías, sustituciones
- [ ] Selector de opción calórica (déficit / mantenimiento / volumen) si el coach las configura
- [ ] Total de calorías y macros del día (visual)
- [ ] Estado sin plan de dieta asignado

---

### Fase 4 — Check-in
**Días 18–21**

El check-in es el motor del ciclo de asesoría y el momento de mayor fricción — el diseño debe hacerlo fácil y no intimidante.

**El check-in NO es un tab** — se accede desde el CTA de Home o desde Perfil.

**Flujo de envío (5 pasos):**
- [ ] Paso 1 — Fotos: 3 fotos (frente, lateral, espalda) con guía visual de postura
- [ ] Paso 2 — Métricas: peso + medidas opcionales (Pregunta 5)
- [ ] Paso 3 — Valoraciones: 4 escalas (entreno, dieta, energía, descanso)
- [ ] Paso 4 — Comentarios: campo libre opcional
- [ ] Paso 5 — Resumen + envío + confirmación

**Estados del check-in:**
- [ ] Ventana cerrada (días 1–7): no aparece CTA
- [ ] Ventana abierta (días 8–14): CTA en Home
- [ ] Enviado: estado "Enviado ✓" con fecha
- [ ] Expirado sin enviar: gestión manual por el coach

**Histórico:**
- [ ] Lista de check-ins enviados (desde Perfil)
- [ ] Vista de check-in individual: fotos comparativas, métricas, gráfico de evolución de peso

---

### Fase 5 — Cierre y pulido
**Días 22–25**

Revisión global, pantallas secundarias y preparación para handoff.

**Pantallas pendientes:**
- [ ] Comunidad: badge de tier "Coached" en el ranking (igual que V1 en funcionalidad)
  - _Nota: el muro social queda fuera del scope de V2 — pendiente de definir en una fase posterior_
- [ ] Perfil del coached: check-ins, historial, acceso a "Mi progreso"
- [ ] Pantalla de asesoría pausada (con CTA de reactivación)
- [ ] Pantalla de asesoría cancelada (acceso a histórico, CTA de volver a contratar)
- [ ] Guías (Pregunta 6 — ¿tab o desde perfil/home?)

**Revisión transversal:**
- [ ] Consistencia visual entre todas las pantallas V2
- [ ] Todos los estados vacíos cubiertos
- [ ] Todos los estados de error cubiertos
- [ ] Notificaciones push: revisar que los 4 triggers clave tienen un estado correspondiente en la UI
- [ ] Handoff en Figma listo para desarrollo

---

## Resumen de hitos

| Fase | Días | Entregable clave |
|------|------|-----------------|
| 0 — Definición base | 1–3 | Estructura de tabs + estados del ciclo cerrados |
| 1 — Onboarding | 4–7 | Flujos de entrada para los 3 canales |
| 2 — Shell + Home | 8–12 | Navigation shell V2 + Home con capa coached |
| 3 — Entreno + Dieta | 13–17 | Contenido core del plan personalizado |
| 4 — Check-in | 18–21 | Flujo completo + histórico |
| 5 — Cierre | 22–25 | Pantallas secundarias + handoff Figma |

---

## Referencias técnicas útiles

| Qué consultar | Dónde |
|---------------|-------|
| Router actual (lógica de redirección por tier) | `lib/core/router/app_router.dart` |
| AccessLevel enum (zona0-2) | `lib/features/subscription/domain/entities/access_level.dart` |
| ProgramZone enum (free/subscription/consultancy) | `lib/features/training/domain/entities/program_zone.dart` |
| HomeContentModel (datos del /home endpoint) | `lib/features/home/data/models/home_content_model.dart` |
| AuthUser (feature flags: hasDiets, hasTraining) | `lib/features/auth/domain/entities/auth_user.dart` |
