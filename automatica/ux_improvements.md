# UX/UI Improvements — elmetodo_app

> Análisis realizado el 2026-03-31. Cubre Home screen y el flujo completo de Entreno.

---

## Home Screen

### H1 — Dos tabs que fragmentan el flujo mental
**Pantalla:** `HomeScreen` (tab toggle Diario / Semanal)  
**Impacto:** Alto | **Esfuerzo:** Alto

Diario y Semanal son datos complementarios que se consultan juntos. El tab switch añade fricción innecesaria.

**Propuesta:** Un único scroll vertical continuo: métricas de hoy arriba (con micro-chart de la semana inline), actividades abajo. Tabs solo si el research confirma que los usuarios los usan de forma independiente.

---

### H2 — El ring es un dead end visual
**Pantalla:** `_RingSection` / `StepProgressRing`  
**Impacto:** Medio | **Esfuerzo:** Medio

El `StepProgressRing` ocupa el 40-50% de la pantalla pero solo comunica una métrica a la vez. El carousel de iconos debajo añade complejidad de interacción para cambiar entre métricas.

**Propuesta A (conservadora):** Reducir el ring al 60% del ancho actual, y mostrar las 4 métricas secundarias en un grid 2×2 debajo, siempre visibles — sin carousel.  
**Propuesta B (más simple):** Reemplazar el carousel por 5 pills horizontales fijas debajo del ring.

---

### H3 — Jerarquía invertida en la card de Ranking
**Pantalla:** `RankingHomeSection`  
**Impacto:** Medio | **Esfuerzo:** Bajo

El ranking está enterrado debajo del ring y las métricas, pero es uno de los diferenciadores más fuertes del producto (comunidad + competición).

**Propuesta:** Elevar el ranking. Poner un micro-widget arriba (posición actual + flecha de tendencia) que al tappear expande al full card.

---

### H4 — El estado "Activar salud" bloquea y no motiva
**Pantalla:** `_RingSection` (disabled state) / `WeeklyChartSection` (blur overlay)  
**Impacto:** Alto | **Esfuerzo:** Medio

Cuando el pedómetro está desactivado, el ring muestra ceros y el chart aparece borroso. Es frustrante para usuarios nuevos y no explica qué ganarán al activarlo.

**Propuesta:** Mostrar el ring con datos de ejemplo (ghost/demo state), con overlay motivacional: *"Así verás tu progreso — activa el seguimiento"*. Reduce el miedo al vacío.

---

### H5 — Estado vacío de actividades es plano
**Pantalla:** `ActivityLogSection` (empty state)  
**Impacto:** Bajo | **Esfuerzo:** Bajo

"No hay actividades registradas" + un botón. Sin contexto ni sugerencia de qué registrar.

**Propuesta:** Estado vacío contextual: sugerencias basadas en hora del día (*"¿Acabas de hacer ejercicio? Regístralo"*) o actividades frecuentes del usuario si existen.

---

### H6 — No hay indicador de datos en vivo
**Pantalla:** `_RingSection` (enabled state)  
**Impacto:** Medio | **Esfuerzo:** Bajo

Los pasos se actualizan en tiempo real via `realtimeStepsNotifierProvider`, pero el usuario no lo sabe y hace pull-to-refresh innecesariamente.

**Propuesta:** Indicador sutil de estado en vivo junto al valor de pasos (dot pulsante o timestamp "Actualizado hace 2 min").

---

### H7 — Semanas anteriores sin insight comparativo
**Pantalla:** `WeekNavigator` / `WeeklyChartSection`  
**Impacto:** Medio | **Esfuerzo:** Medio

Se puede navegar a semanas anteriores pero solo se muestran datos crudos, sin aprendizaje.

**Propuesta:** Al navegar a semana anterior, mostrar un banner comparativo: *"Esta semana: +12% más pasos que la semana anterior"*.

---

### H8 — Delete por swipe sin affordance visible
**Pantalla:** `WeeklyActivityLogSection` / `ActivityLogSection`  
**Impacto:** Medio | **Esfuerzo:** Bajo

El swipe-to-delete es un gesto invisible. Usuarios que no lo descubren asumen que las actividades no se pueden borrar.

**Propuesta:** Menú de tres puntos (⋮) en cada actividad con acciones (editar, eliminar). El swipe puede quedarse como atajo para usuarios avanzados.

---

### H9 — Sin feedback motivacional al alcanzar metas
**Pantalla:** `StepProgressRing`  
**Impacto:** Alto | **Esfuerzo:** Medio

El usuario llega a 10.000 pasos y... nada. No hay refuerzo positivo.

**Propuesta:** Micro-celebración cuando el ring llega al 100%: animación breve + vibración + color change. El ring puede cambiar de color progresivamente (amarillo → verde al alcanzar meta).

---

### H10 — La racha está enterrada entre métricas
**Pantalla:** `MetricIconSelector`  
**Impacto:** Alto | **Esfuerzo:** Bajo

La racha ("Streak") es un poderoso mecanismo de retención pero está al mismo nivel que distancia o calorías.

**Propuesta:** Widget prominente propio para la racha, fuera del ring. Contador siempre visible en la parte superior de la pantalla con fecha del último día activo.

---

### H11 — Goals de métricas no personalizables
**Pantalla:** `StepProgressRing` / `MetricIconSelector`  
**Impacto:** Alto | **Esfuerzo:** Alto

El objetivo de pasos está hardcodeado a 10.000. El usuario no puede cambiarlo.

**Propuesta:** Long-press en el ring o en el valor del goal abre un bottom sheet para personalizar la meta. Aumenta el engagement porque el usuario hace suya la métrica.

---

---

## Feature Entreno

### E1 — Discovery flow: demasiados pasos antes de empezar a entrenar
**Pantalla:** `MainEntrenoScreen` → `ProgramsCatalogScreen` → `ProgramDetailScreen` → `ChooseDaysScreen` → `ChooseLocationScreen`  
**Impacto:** Medio | **Esfuerzo:** Medio

Para un usuario nuevo sin suscripciones activas, hay 6-7 pantallas antes de empezar a entrenar.

**Propuesta:** Para usuarios nuevos (sin suscripciones), la pantalla principal debería ser directamente el catálogo, no el tab vacío. Para usuarios activos, eliminar el tab y mostrar catálogo al final del scroll como sección "Descubrir más".

---

### E2 — `TrainingDayScreen` es un paso intermedio sin valor
**Pantalla:** `TrainingDayScreen`  
**Impacto:** Alto | **Esfuerzo:** Medio

El usuario pulsa "Empezar ahora" en `NextTrainingCard` y llega a `TrainingDayScreen`, que le muestra los ejercicios del día. Luego tiene que pulsar *otro* botón "Empezar ahora". Es un paso extra sin valor real.

**Propuesta A:** Eliminar `TrainingDayScreen` como paso obligatorio. Ir directo al primer ejercicio. La estructura del día puede mostrarse como panel expandible dentro de `ExerciseDetailScreen`.  
**Propuesta B (conservadora):** Convertir `TrainingDayScreen` en un bottom sheet de confirmación ("Hoy toca: 3 bloques, 8 ejercicios") con un único botón "Empezar".

---

### E3 — `ExerciseDetailScreen`: sobrecarga cognitiva al registrar
**Pantalla:** `ExerciseDetailScreen`  
**Impacto:** Muy alto | **Esfuerzo:** Alto

La pantalla muestra simultáneamente: imagen full-bleed, nombre + categoría, timer de descanso, tabla de 4 columnas, textarea de notas y botón de registro. Durante el entrenamiento el usuario tiene sudor en los dedos y necesita velocidad. La tabla de 4 columnas requiere demasiada precisión de tap.

**Propuesta:** Diseño para contexto de entrenamiento activo:
- Arriba: nombre del ejercicio + categoría (compacto)
- Centro (80% de pantalla): input de la serie actual — grande, fácil de tocar
- Abajo: historial de series registradas esta sesión (compacto, scrollable)
- Valor de la sesión anterior como placeholder en el input, no en tabla separada
- Notas → icono discreto que expande, no siempre visible

---

### E4 — El timer de descanso es secundario en diseño pero primario en uso
**Pantalla:** `ExerciseDetailScreen` (rest timer)  
**Impacto:** Muy alto | **Esfuerzo:** Medio

La barra de descanso es una línea fina. Durante el descanso entre series, el timer *es* lo más importante para el usuario.

**Propuesta:** Cuando el timer está activo, flip visual: el timer ocupa el centro de la pantalla (número grande, cuenta regresiva) con botón para saltarlo. Al terminar, vuelve al modo registro. Referencia: Strong, Hevy.

---

### E5 — Supersets y Rounds: navegación inconsistente entre ejercicios
**Pantalla:** `ExerciseDetailScreen` (superset mode) / `RoundsSessionScreen`  
**Impacto:** Alto | **Esfuerzo:** Alto

En modo superset, "Next exercise" hace `push()` en el stack creando una cadena profunda. En modo rondas hay una pantalla completamente diferente (`RoundsSessionScreen`), rompiendo la consistencia.

**Propuesta:** Un único `ExerciseSessionScreen` para todos los modos (single, superset, rounds). Swipe horizontal o botones < > para navegar entre ejercicios del bloque. El timer de rounds vive en un banner fijo en la parte superior, no en pantalla separada.

---

### E6 — `TrainingCompleteScreen` es un dead end
**Pantalla:** `TrainingCompleteScreen`  
**Impacto:** Alto | **Esfuerzo:** Medio

La pantalla de completado muestra datos básicos y un botón "¡Vamos!". No hay resumen de progreso del programa, comparación con sesiones anteriores, ni sharing.

**Propuesta:** Resumen motivacional:
- Animación de celebración al entrar (1 seg máximo)
- Record batido destacado: *"Nuevo record en Sentadilla: 70kg"*
- Progreso del programa: barra visual "Día 8 de 24 — 33% completado"
- Share card: imagen generada con métricas para compartir en RRSS
- Próxima sesión: *"Tu próximo entreno es en 2 días — Martes"*

---

### E7 — `ProgramsCatalogScreen`: filtros sin feedback visual
**Pantalla:** `ProgramsCatalogScreen`  
**Impacto:** Medio | **Esfuerzo:** Bajo

No hay diferencia visual entre "tengo filtros activos" y "no tengo filtros activos". El usuario no sabe qué está filtrando.

**Propuesta:**
- Badge contador en chips activos: `Location (1)`
- Botón "Limpiar filtros" que aparece solo cuando hay filtros activos
- Número de resultados visible y dinámico: *"12 programas"*

---

### E8 — `ProgramDetailScreen`: expandir días es tedioso para evaluar el programa
**Pantalla:** `ProgramDetailScreen`  
**Impacto:** Medio | **Esfuerzo:** Bajo

Los días de programa están colapsados por defecto. Para evaluar si un programa es adecuado, el usuario tiene que hacer 10+ taps.

**Propuesta:**
- Mostrar los primeros 3 ejercicios del primer día directamente (sin expandir)
- Añadir chips de grupos musculares trabajados en el header del programa
- Botón "Ver todos los días" que expande todo de golpe

---

### E9 — Sin indicador de progreso durante la sesión
**Pantalla:** `ExerciseDetailScreen`  
**Impacto:** Alto | **Esfuerzo:** Bajo

Mientras el usuario entrena no hay indicador de cuánto le falta. No sabe si quedan 5 minutos o 40.

**Propuesta:** Barra de progreso de sesión persistente en la parte superior (thin bar, no intrusiva): *"Ejercicio 3 de 8"* o *"Bloque 1 de 3"*. Incrementa la motivación para terminar (efecto progreso).

---

### E10 — Selección de programa con video: flujo interrumpido e impredecible
**Pantalla:** `ProgramsCatalogScreen` → `ProgramDetailScreen`  
**Impacto:** Bajo | **Esfuerzo:** Bajo

`navigateToProgramWithVideo()` decide condicionalmente si mostrar el video o ir al detalle. Este comportamiento es impredecible para el usuario.

**Propuesta:** El video siempre es opt-in. Botón "Ver presentación" prominente en `ProgramDetailScreen` pero no bloqueante.

---

## Resumen por impacto

| ID | Pantalla | Descripción | Impacto | Esfuerzo |
|----|----------|-------------|---------|----------|
| E4 | ExerciseDetail | Timer de descanso como pantalla principal | Muy alto | Medio |
| E3 | ExerciseDetail | Input de serie grande, tabla compacta | Muy alto | Alto |
| E9 | ExerciseDetail | Barra de progreso de sesión | Alto | Bajo |
| H9 | StepProgressRing | Micro-celebración al alcanzar meta | Alto | Medio |
| H10 | MetricIconSelector | Racha como widget prominente | Alto | Bajo |
| E2 | TrainingDay | Eliminar paso intermedio | Alto | Medio |
| E6 | TrainingComplete | Records + progreso + share | Alto | Medio |
| H4 | RingSection | Estado vacío motivacional (demo mode) | Alto | Medio |
| E5 | ExerciseDetail | Navegación unificada superset/rounds | Alto | Alto |
| H11 | StepProgressRing | Goals personalizables | Alto | Alto |
| H3 | RankingHomeSection | Ranking elevado en jerarquía | Medio | Bajo |
| H6 | RingSection | Indicador de datos en vivo | Medio | Bajo |
| H7 | WeekNavigator | Comparativa semanas anteriores | Medio | Medio |
| H8 | ActivityLogSection | Menú de acciones en actividades | Medio | Bajo |
| H2 | StepProgressRing | Grid de métricas vs carousel | Medio | Medio |
| E7 | ProgramsCatalog | Filtros con feedback visual | Medio | Bajo |
| E8 | ProgramDetail | Días más accesibles sin tanto colapso | Medio | Bajo |
| E1 | MainEntreno | Discovery flow para nuevos usuarios | Medio | Medio |
| H1 | HomeScreen | Un solo scroll vs dos tabs | Alto | Alto |
| H5 | ActivityLogSection | Estado vacío contextual | Bajo | Bajo |
| E10 | ProgramDetail | Video siempre opt-in | Bajo | Bajo |
