# User Journeys

## Journey 1: Onboarding de un Nuevo Coach

```
PASO 1: Registro
  Coach accede a /register
  → Crea cuenta con email/password (o Google/Apple)
  → Confirma email
  → Entra al dashboard por primera vez

PASO 2: Primera toma de contacto
  Dashboard vacío: lista de clientes = 0
  → CTA: "Asignar nuevos clientes"
  → Navega a /team/new-clients

PASO 3: Asignación de clientes
  Ve lista de clientes disponibles (no asignados)
  → Busca por nombre o teléfono
  → Selecciona clientes y los mueve a "pendientes de asignar"
  → Confirma asignación en batch
  → Clientes aparecen en /clients/active con estado "Nuevo"

PASO 4: Primer ciclo de trabajo con un cliente
  Ver JOURNEY 2 →
```

---

## Journey 2: Ciclo de Trabajo Semanal del Coach (Core Loop)

**Frecuencia**: Varias veces por semana / Diaria para coaches activos

```
PASO 1: Revisión de clientes pendientes
  Abre /clients/active
  → Filtra por "Por revisar" (clientes con revisiones sin confirmar)
  → Ve contadores de estado en tabs

PASO 2: Revisión de un cliente específico
  Clic en cliente → navega a /revisions/users/{id}

  TAB REVIEWS:
  → Ve fotos de progreso (frente, lado, espalda)
  → Lee valoraciones (Pasos, Entrenamiento, Dieta, Rendimiento)
  → Compara con revisión anterior

  TAB DIETA:
  → Revisa dieta activa
  → Ajusta ingredientes si es necesario
  → Cambia nivel de calorías si el cliente no progresa

  TAB RUTINA:
  → Revisa rutina activa
  → Modifica ejercicios/series/técnicas si es necesario

  PANEL DERECHO:
  → Lee cuestionario del cliente
  → Añade nota si es relevante

PASO 3: Confirmar o enviar cambios
  Si hay cambios → clic "Mandar cambios"
  Si no hay cambios → clic "Confirmar"
  → Sistema avanza el ciclo de revisión 14 días
  → Auto-navega al siguiente cliente pendiente

PASO 4: Gestión de clientes sin revisión (inactivos)
  Para clientes que no enviaron revisión:
  → Clic "Confirmar" crea revisión fake
  → Avanza el ciclo de 14 días
  → Cliente pasa a estado "Activo" en su app
```

---

## Journey 3: Onboarding de un Nuevo Cliente

```
PASO 1: Coach asigna cliente (ver Journey 1, Paso 3)

PASO 2: Cliente completa cuestionario (en app móvil)
  Estado dashboard: "Faltan datos"
  → Coach puede ver estado en /clients/active

PASO 3: IA genera plan inicial
  Trigger automático al completar cuestionario
  → Sistema genera dieta personalizada (V2 con ingredientes estructurados)
  → Sistema genera rutina personalizada (según genero, localización, objetivos)
  Estado dashboard: "Nuevo" → esperando revisión del coach

PASO 4: Coach revisa y personaliza el plan inicial
  Coach navega a /revisions/users/{id}
  → Revisa dieta generada
  → Ajusta según sus criterios profesionales
  → Revisa rutina
  → Ajusta ejercicios/series
  → Clic "Mandar cambios"
  Estado cliente en app: plan enviado

PASO 5: Primer ciclo de revisión (14 días después)
  Ver Journey 2 →
```

---

## Journey 4: Cliente que no Envía Revisión (Gestión de Inactivos)

**Contexto**: El cliente tiene 7 días para enviar su revisión. Si no lo hace, el coach debe avanzar el ciclo manualmente.

```
SITUACIÓN: Día 0 → se abre ventana de revisión (7 días)
          Día 7 → ventana se cierra, cliente no envió revisión

DASHBOARD muestra:
  → Estado: "Faltan datos (Revisión)"
  → Botón "Confirmar" disponible

COACH: Clic en "Confirmar"
  Sistema:
  1. Crea revisión "fake" con placeholder data
  2. Marca revisión como vista (coach_viewed_at = ahora)
  3. Avanza fechas: last_review_date = next_review_date
                    next_review_date += 14 días
  4. Cliente pasa a estado "Activo" en su app
  5. Ventana para que cliente reemplace la fake se abre al final del nuevo ciclo

COACH MUY TARDE (ejemplo: 25 días de retraso):
  Necesita múltiples clics para ponerse al día
  Click 1: Crea fake para ciclo [Oct 1, Oct 15] → avanza a [Oct 15, Oct 29]
  Click 2: Crea fake para ciclo [Oct 15, Oct 29] → avanza a [Oct 29, Nov 12]
  → Regla: ~N/14 clics para recuperar N días de retraso
```

---

## Journey 5: Actualización del Cuestionario y Regeneración de Plan

```
SITUACIÓN: Cliente cambia de objetivo (ej. pierde peso → ganar músculo)

PASO 1: Coach edita cuestionario
  En /revisions/users/{id} → panel derecho
  → Modifica campos relevantes del cuestionario
  → Flujo 2 pasos: editar → confirmar cambios

PASO 2: Trigger de regeneración automática
  Sistema detecta cambios en cuestionario
  → Llama a IA para generar nueva dieta
  → Llama a IA para generar nueva rutina
  → Nuevos planes aparecen con etiqueta "POR MANDAR"

PASO 3: Coach revisa los nuevos planes
  → Compara con versión anterior (historial de iteraciones)
  → Ajusta si es necesario
  → Clic "Mandar cambios"
  → Cliente recibe nuevos planes en su app
```

---

## Journey 6: Gestión de Clientes Pausados/Cancelados

```
CLIENTE PAUSADO:
  Coach en /clients/active → menú contextual → "Pausar suscripción"
  → Cliente aparece en /clients/paused
  → No genera ciclos de revisión
  → No se genera IA
  → Coach puede reactivar en cualquier momento

CLIENTE CANCELADO:
  Coach en /clients/paused → "Cancelar suscripción"
  → Cliente en estado cancelled
  → Datos históricos preservados
  → Coach puede ver historial pero no actuar

REACTIVACIÓN:
  Coach en /clients/paused → "Reactivar"
  → Cliente vuelve a active
  → Se retoman los ciclos de revisión
  → Si el cuestionario sigue vigente, se puede mantener el plan anterior
```

---

## Moments of Truth (Momentos Críticos)

| Momento | Por qué importa |
|---|---|
| Primera semana del coach | Si no asigna clientes rápido, abandona la plataforma |
| Primera revisión confirmada | El coach experimenta el valor real del ciclo automático |
| Primer plan generado por IA | El coach debe confiar en que la IA es buena o ajustable |
| Primer cliente que renueva suscripción | El coach atribuye la retención a El Metodo |
| Primer cliente con retraso extremo | Test de la funcionalidad de multi-clic catch-up |
