# User Personas

## Persona 0: El Propietario de la Marca — "Inazio"

**Perfil**
- Dueño y fundador de El Metodo
- Cara pública del negocio: influencer deportivo con comunidad en redes sociales
- Atrae clientes a través de su imagen personal y contenido en redes
- **No usa el dashboard**. Su presencia es la razón por la que los clientes pagan.

**Motivaciones**
- Escalar los ingresos sin multiplicar proporcionalmente el trabajo propio
- Mantener la percepción de calidad y personalización a pesar de tener un equipo
- Crecer la marca personal para captar más clientes

**Relación con el producto**
- El dashboard existe para que su equipo pueda operar de forma eficiente bajo su marca
- Todo lo que ocurre en el dashboard debería ser invisible para los clientes finales
- Necesita confiar en que el equipo de coaches ofrece el nivel de calidad que él prometió

---

## Persona 1: El Jefe de Coaches — "Jorge"

**Perfil**
- Mando intermedio entre Inazio y los coaches
- Usa el dashboard para supervisar al equipo
- Tiene visión global de toda la cartera de clientes

**Motivaciones**
- Que el equipo de coaches cumpla los estándares de calidad de la marca
- Detectar coaches que no están haciendo bien su trabajo (revisiones atrasadas, clientes inactivos)
- Asignar nuevos clientes de forma equitativa al equipo

**Cómo usa El Metodo**
- Asigna nuevos clientes a coaches específicos desde `/team/new-clients`
- Revisa el estado global de la cartera para detectar problemas
- Supervisa métricas de actividad por coach
- Puede actuar sobre clientes de cualquier coach si es necesario

**Métricas de éxito para Jorge**
- % de coaches activos (confirmando revisiones regularmente)
- Tasa de revisiones reales vs. fake (indicador de engagement de clientes)
- Clientes en estado "Por revisar" sin atender > 3 días

---

## Persona 2: El Coach — "Carlos"

**Perfil**
- Entrenador personal empleado por Inazio
- Gestiona entre 20-60 clientes activos asignados por Jorge
- Cobra un salario fijo (no depende directamente de la retención de sus clientes)
- Trabaja bajo la marca de Inazio, no la suya propia

**Motivaciones**
- Hacer bien su trabajo y mantener su puesto
- Terminar su jornada sin clientes pendientes de atender
- Que sus clientes progresen (es la evidencia de que está trabajando bien)

**Frustraciones**
- Volumen alto de clientes difícil de gestionar sin herramientas
- Clientes que no envían revisiones y hay que crear revisiones fake
- Cambios de última hora en planes que ya habían sido enviados

**Cómo usa El Metodo**
- Cada mañana: revisa la lista de "Por revisar" — clientes con revisiones pendientes
- Diariamente: ciclo de confirmaciones (clic en "Confirmar") para clientes atrasados
- Revisa y ajusta los planes de dieta y entrenamiento creados por el especialista de planes
- Usa las notas para registrar observaciones relevantes sobre cada cliente

**Métricas de éxito para Carlos**
- Ningún cliente en "Por revisar" al final del día
- Tiempo dedicado por cliente/semana < 15 min
- Clientes activos (engagement real) > 70% de su cartera

---

## Persona 3: El Cliente / Trainee — "Javier"

**Perfil**
- 28-45 años, trabaja a jornada completa
- Objetivos: perder peso, ganar músculo o ambos
- Experiencia variable con el deporte (principiante a intermedio)
- Usa la app móvil (NO el dashboard)
- **Cree que le está llevando Inazio personalmente**

**Motivaciones**
- Tener un plan personalizado sin tener que pensar
- Sentir que "Inazio" (la marca en la que confía) le hace seguimiento real
- Ver resultados en 2-3 meses

**Frustraciones actuales**
- Otros coaches le mandan PDFs genéricos
- No sabe si está progresando bien
- Le da pereza rellenar formularios largos

**Touchpoints con El Metodo**
- Recibe la dieta y rutina en la app (bajo la marca de Inazio)
- Cada 14 días: envía revisión (fotos + métricas + valoraciones)
- Puede ver su historial de progreso

**Lo que determina si Javier renueva su suscripción**
1. Recibe feedback rápido (aunque no sepa que es de un coach empleado)
2. Siente que el plan cambia según su progreso
3. La app es fácil de usar

---

## Mapa de Actores y Flujos

```
INAZIO (marca/propietario)
  │
  │ Define los estándares de calidad
  │ No opera en el dashboard
  │
  ▼
JORGE (jefe de coaches) ──────────────────────────────────────────┐
  │                                                               │
  │ Asigna clientes                                              │
  │ Supervisa al equipo                                          │
  ▼                                                              │
COACHES (empleados) ← paga salario ← INAZIO                      │
  │                                                              │
  │ (creen que es Inazio)                                        │
  │ ← Envía revisión c/14 días ─────────────────────────────────┐│
  │   (fotos, peso, valoraciones)                               ││
  │                                                             ││
  │ ──── Confirma/ajusta plan ─────────────────────────────────►││
  │      (nueva dieta/rutina)                                   ││
  │                                                             ││
CLIENTES (app móvil) ── paga asesoría ──► INAZIO ────────────────┘│
                                                                  │
                        DINERO ───────────────────────────────────┘
```
