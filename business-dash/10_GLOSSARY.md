# Glosario del Producto

Términos usados en el producto, código y documentación. Referencia para nuevos miembros del equipo y stakeholders.

---

## Actores

| Término | Definición |
|---|---|
| **Inazio** | Propietario y cara pública de El Metodo. Marca personal en redes sociales. No usa el dashboard. Los clientes creen que él les atiende personalmente. |
| **Jorge** | Jefe de coaches. Mando intermedio. Usa el dashboard para supervisar al equipo, asignar clientes y controlar la calidad del servicio. |
| **Coach** | Entrenador personal empleado por Inazio. Usa el dashboard para gestionar su cartera de clientes asignada. No es un cliente del producto, es un usuario operacional interno. |
| **Cliente / Trainee / User** | Persona que paga las asesorías de El Metodo (entiende que contrata a Inazio). Usa la app móvil. No accede al dashboard. |
| **Especialista de Planes** | Empleado de Inazio responsable de crear los planes de dieta y entrenamiento para los clientes. No es el coach: es un rol separado. Los coaches reciben estos planes y los personalizan antes de enviarlos. |
| **Admin** | Usuario interno con acceso a funcionalidades de gestión de contenido y configuración (biblioteca de ejercicios, ingredientes, recetas, etc.). |

---

## Estados de Cliente

| Término | Código | Descripción |
|---|---|---|
| **Activo** | `active` | Cliente con suscripción vigente, asignado a un coach |
| **Pausado** | `paused` | Suscripción temporalmente detenida. Sin ciclos de revisión activos |
| **Cancelado** | `cancelled` | Suscripción terminada. Datos preservados, sin actividad |
| **Disponible** | `available` | Cliente registrado pero no asignado a ningún coach |

---

## Estados de Display del Cliente (en Dashboard)

| Término | Condición | Pantalla |
|---|---|---|
| **Nuevo** | Recién asignado, sin cuestionario completo | "Nuevo" |
| **Faltan datos** | Cuestionario incompleto | "Faltan datos" |
| **Faltan datos (Revisión)** | Cuestionario incompleto + `pending_to_submit = true` | "Faltan datos (Revisión)" |
| **Por revisar** | Revisión real pendiente de confirmar | "Por revisar" |
| **Activo** | Todo en orden, ciclo al día | "Activo" |

---

## Sistema de Revisiones

| Término | Definición |
|---|---|
| **Revisión Real** | Enviada por el cliente desde la app móvil. `coach_generated = false` |
| **Revisión Fake** | Creada por el coach cuando el cliente no envía revisión. `coach_generated = true`. Permite avanzar el ciclo |
| **Revisión Tardía** | Cliente envía revisión después de que el coach ya creó una fake. `submitted_late = true` |
| **Ciclo de Revisión** | Período de 14 días entre `last_review_date` y `next_review_date` |
| **Ventana de Envío** | 7 días dentro del ciclo en los que el cliente puede enviar la revisión |
| **Confirmar** | Acción del coach que cierra un ciclo de revisión y abre el siguiente |
| **Catch-up** | Proceso de múltiples clics en "Confirmar" para recuperar ciclos atrasados |
| **Badge** | Indicador visual rojo cuando hay una revisión tardía no vista por el coach |
| **`pending_to_submit`** | Flag que controla si el cliente ve el formulario de revisión en su app |
| **`waiting_for_review`** | Flag que controla si el coach ve el botón "Confirmar" |

---

## Planes Nutricionales (Dietas)

| Término | Definición |
|---|---|
| **Dieta V1** | Sistema legacy con descripción libre de ingredientes por texto |
| **Dieta V2** | Sistema actual con ingredientes estructurados del catálogo |
| **Calorías** | Opción de cantidad calórica para una dieta (ej. 1200 kcal, 1600 kcal) |
| **Comida / Meal** | Una de las ingestas del día (desayuno, almuerzo, etc.) |
| **Opción de Comida / Meal Option** | Alternativa para una comida (ej. "opción A" y "opción B" para el desayuno) |
| **Ingrediente Estructurado** | Ingrediente del catálogo normalizado con nombre, medida y cantidad estándar |
| **Grupo de Elección** | Conjunto de ingredientes donde el cliente puede elegir uno (ej. "plátano o manzana") |
| **Sustitución Automática** | Reemplazo de ingrediente según restricciones del cliente (alergias, intolerancias) |
| **Iteración** | Versión de una dieta. Cada vez que se genera o modifica una dieta, se crea una nueva iteración |
| **POR MANDAR** | Label que indica que hay cambios pendientes de enviar al cliente |
| **Dieta Madre** | Plantilla de dieta en la biblioteca del admin, base para generar planes personalizados |

---

## Rutinas y Entrenamiento

| Término | Definición |
|---|---|
| **Rutina** | Plan de entrenamiento completo asignado a un cliente |
| **Bloque** | Agrupación de sesiones dentro de una rutina |
| **Sesión** | Entrenamiento de un día específico |
| **Grupo de Ejercicios** | Uno o más ejercicios dentro de una sesión |
| **Superset** | 2 ejercicios ejecutados en secuencia sin descanso entre ellos |
| **Ronda** | (Feature próximo) Circuito de 2+ ejercicios encadenados con descanso entre rondas completas |
| **AMRAP** | As Many Rounds As Possible — modalidad de ronda en tiempo fijo |
| **For Time** | Modalidad de ronda: completar N rondas en el menor tiempo posible |
| **EMOM** | Every Minute On the Minute — modalidad de ronda |
| **TUT** | Time Under Tension — técnica de tempo para cada repetición |
| **RIR** | Reps In Reserve — repeticiones que quedan en reserva al final de la serie |
| **Series / Sets** | Número de veces que se repite un ejercicio |
| **Repeticiones / Reps** | Número de ejecuciones por serie |

---

## Técnicas de Entrenamiento (Referencia Código)

| Código | Nombre |
|---|---|
| `ISO_HOLD` | Isométrico (mantenimiento de posición) |
| `PARCIALES` | Repeticiones parciales del rango de movimiento |
| `DESCENDENTE` | Sets descendentes (reducción de peso progresiva) |
| `DOBLE_DESCENDENTE` | Doble set descendente |
| `LASTRADA` | Con lastre añadido |
| `TUT_3_1` | Tempo 3 segundos excéntrico, 1 concéntrico |
| `TUT_4_1` | Tempo 4 segundos excéntrico, 1 concéntrico |
| `RIR_0` | Al fallo (0 repeticiones en reserva) |
| `RIR_1` | 1 repetición en reserva |
| `RIR_2` | 2 repeticiones en reserva |

---

## Acciones del Coach en Dashboard

| Término | Descripción |
|---|---|
| **Confirmar** | Cierra el ciclo de revisión actual. Si no hay revisión real, crea una fake |
| **Mandar cambios** | Envía los cambios de dieta/rutina al cliente |
| **Avanzar** | (Testing) Mueve las fechas 14 días atrás para simular retraso |
| **Siguiente cliente** | Navega automáticamente al próximo cliente pendiente de revisión |

---

## Arquitectura del Código

| Término | Descripción |
|---|---|
| **schema.ts** | Tipos TypeScript auto-generados desde la API FastAPI. Nunca editar manualmente |
| **Endpoints** | Constantes con los paths de la API. Definidos en `requests.ts` |
| **Service Layer** | Funciones en `/src/services/` que encapsulan las llamadas a la API |
| **Server Component** | Componente Next.js que corre en el servidor. Usado para data fetching |
| **Client Component** | Componente Next.js con `'use client'`. Usado para interactividad |
| **Fetch Wrapper** | Función en `requests.ts` que añade automáticamente headers de auth |
