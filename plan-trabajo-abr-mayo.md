# Plan de trabajo — Abril–Mayo 2026

## Contexto

Dos tracks en paralelo durante 8 semanas:

- **Asesorías V2** — entregable concreto: diseño Figma completo + handoff a Carles antes del 30 mayo. Contrato de sueldo fijo; hay que cumplir.
- **Automática — empuje** — la app acaba de salir, modelo de % sobre resultados → interés económico directo. Objetivo: recoger feedback real de usuarios y traducirlo en mejoras de producto (UX + conversión).

Notificaciones: cerradas. UX improvements: se atacan en función del feedback recogido, no como lista fija.

---

## Semana 1 — 7–11 abril

**V2 Asesorías**
- Resolver preguntas bloqueantes antes de dibujar nada:
  - ¿Onboarding con cuestionario inicial o directo al contenido?
  - ¿El usuario coached puede ver programas de suscripción genérica?
  - ¿Guías como tab separado o dentro de Perfil/Home?
- Phase 0: definir arquitectura de tabs (5 tabs confirmados), diferenciación visual vs. V1, y los 3 estados de usuario (recién llegado, ciclo activo, ventana de check-in)

**Automática**
- Diseñar y lanzar feedback campaign: encuesta corta a usuarios activos (3–5 preguntas). Preguntar sobre fricciones reales, no features hipotéticas.
- Coordinar con Carles el canal (in-app, email, WhatsApp)

---

## Semana 2 — 14–18 abril

**V2 Asesorías**
- Phase 1: Onboarding flows en Figma — los 3 canales de entrada:
  1. Link externo (sin cuenta → registro → app coached)
  2. WhatsApp (deep link directo)
  3. In-app upgrade desde suscripción estándar

**Automática**
- Analytics: inventario de los 23 eventos GA4 pendientes de conexión
- Kick-off Looker Studio con Carles: qué datos hay disponibles hoy y qué falta para el funnel básico (install → activación → trial → paid)

---

## Semana 3 — 21–25 abril

**V2 Asesorías**
- Phase 2: Shell de la app + pantalla Home con indicador de ciclo (día X de 14, ventana de check-in abierta/cerrada)

**Automática**
- Analizar respuestas de feedback:
  - ¿Qué fricciones aparecen con más frecuencia?
  - ¿Qué valoran más los usuarios?
- Decidir qué UX improvements atacar primero (puede coincidir o no con los ya priorizados: E3, E4, H9, H10)
- Brainstorm: ¿hay algo más que hacer para empujar la automática que no sea solo producto? (contenido, comunidad, recomendaciones...)

---

## Semana 4 — 28 abril–2 mayo

**V2 Asesorías**
- Phase 3a: Tab Entreno — sesiones asignadas por coach, progreso semanal, acceso a ejercicios

**Automática**
- Diseñar las 2 mejoras UX top identificadas en semana 3
- Spec + handoff a Carles para que arranque implementación

---

## Semana 5 — 5–9 mayo

**V2 Asesorías**
- Phase 3b: Tab Dieta — plan de comidas personalizado, macros, opciones de sustitución

**Automática**
- Diseñar las siguientes mejoras en cola
- Review de lo que Carles tenga implementado → iterar si hace falta

---

## Semana 6 — 12–16 mayo

**V2 Asesorías**
- Phase 4: Flujo de check-in completo (5 pasos: fotos x3, peso, ratings, notas) + vista histórica de check-ins

**Automática**
- Dashboard Looker: ¿ya hay datos suficientes para ver el funnel? Revisar métricas clave (activación D0, enrollement D3, trial → paid)
- Ajustar según lo que muestren los datos

---

## Semana 7 — 19–23 mayo

**V2 Asesorías**
- Phase 5: Polish + pantallas secundarias (notificaciones, settings, estados vacíos, errores)
- Preparar handoff Figma: anotaciones, flows, estados, specs de componentes

**Automática**
- Seguimiento de mejoras en producción
- Identificar si hay algo puntual para Q3 que haya emergido de los datos/feedback

---

## Semana 8 — 26–30 mayo

**V2 Asesorías**
- Handoff final a Carles: sesión de review, resolver dudas de diseño, confirmar que todo está cubierto
- Buffer para ajustes que salgan de esa sesión

**Automática**
- Retrospectiva de los 2 meses: ¿qué ha movido la aguja en activación y conversión?
- Mini-plan Q3: siguientes mejoras, próximas iniciativas

---

## Archivos clave

| Track | Archivos principales |
|-------|---------------------|
| V2 Asesorías | `asesorias/`, `business_docs/`, notas de reunión Jorge (16-mar) e Inazio (17-mar) |
| UX improvements | `automatica/ux_improvements.md` |
| Analytics | `automatica/plans/dashboard_kpis_looker.plan.md` |

## Métricas a vigilar (automática)

- Activación D0: ≥40% completan 1 acción (salud o ranking)
- Enroll base program D0–D3: ≥20%
- 6 entrenos en 14 días: ≥35%
- Trial → paid: ≥50%
