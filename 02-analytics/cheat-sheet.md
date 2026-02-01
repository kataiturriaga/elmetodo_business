# Qué es un evento
Un evento representa una acción o intención clara del usuario.

Ejemplos:
step_counter_activate_clicked
trial_started
subscription_confirmed

Un evento responde a:

¿Qué ha hecho el usuario?

# Qué es un param

Un param (parámetro) es un dato adicional que acompaña a un evento para indicar en qué contexto ocurrió, sin crear un evento nuevo.

Un param responde a:

¿En qué condiciones ocurrió esta acción?

Ejemplos:

origin: home | onboarding | ranking | program | push
entry_point: banner | dropdown | deeplink
cta_id: activate_steps_primary | start_trial
button_variant: primary | secondary
component: modal | banner | card
result: granted | denied | success | failure
error_code: network_error | timeout
status: enabled | disabled
method: google | apple | email
provider: stripe | iap
integration: google_fit | apple_health
program_id: p01 | p12
program_type: initial | premium
week: 1 | 2 | 3
phase: 1 | 2 | 3
user_state: anonymous | registered
subscription_state: none | trial | active
cohort: week_0 | week_1

Ejemplo

3. Evento vs param (regla clave)

Evento = intención del usuario
Param = contexto de esa intención

Ejemplo correcto
event: step_counter_activate_clicked
param: origin = home | onboarding

Ejemplo incorrecto
step_counter_activate_home_clicked
step_counter_activate_onboarding_clicked


Por qué es incorrecto:

❌ Duplica eventos

❌ Complica el análisis

❌ Rompe dashboards / consistencia histórica

4. Cuándo usar un param

Usa un param cuando:

el evento es el mismo

pero el contexto puede variar

y quieres comparar esas variantes

Ejemplos de buenos params:

origin → home / onboarding / banner

result → granted / denied

method → google / apple / email

5. Cuándo NO usar un param

No uses un param cuando:

el contexto es único

el valor no puede variar

o el contexto ya está implícito en el evento

Ejemplo:

step_counter_activate_clicked


Si solo existe un único punto de activación, no hace falta añadir origin ni screen_state.

6. Dos botones distintos, misma intención

Si dos botones diferentes representan la misma acción del usuario:

Mismo evento + param distinto

Ejemplo:

step_counter_activate_clicked
origin: home | onboarding


Regla práctica:

No se crean eventos distintos solo por cambiar el lugar donde está el CTA.

7. Intención vs resultado (evento doble)

Cuando hay interacción con el sistema (permisos, pagos, etc.), se separa en dos eventos.

Evento 1 — Intención del usuario
step_counter_activate_clicked


Mide:

voluntad

aceptación de la propuesta de valor

Evento 2 — Resultado del sistema
step_counter_permission_result
result: granted | denied


Mide:

fricción técnica

rechazo del sistema o del usuario

Nunca mezclar intención y resultado en un solo evento.

8. Los params NO son automáticos

El sistema no infiere el contexto.

Firebase / GA4 no saben el origin por sí solos.

Los params deben enviarse explícitamente desde el código.

Ejemplo conceptual:

logEvent("step_counter_activate_clicked", { origin: "home" })


Responsabilidades:

Producto define: eventos, params y valores posibles.

Desarrollo implementa: el envío correcto en cada punto.

9. Configuración de params en Analytics (GA4)

Sin esta configuración, los params llegan, pero no se pueden usar bien en informes.

9.1 Registrar el param como Custom Dimension

Ruta en GA4:

Admin → Custom definitions → Create custom dimension

Config:

Dimension name: origin (o result)

Scope: Event

Event parameter: origin (o result)

Notas:

No es retroactivo.

Empieza a recoger datos desde el momento en que lo creas.

9.2 Ver los valores del param

Ruta:

Explore → Blank

Config:

Rows: origin

Values: Event count

Filter: event_name = step_counter_activate_clicked

Resultado esperado:

home        | 120
onboarding  | 45

9.3 Cruzar contexto con resultado (análisis potente)

Si existe:

step_counter_permission_result
result: granted | denied


Config (Exploration):

Rows: origin

Columns: result

Values: Event count

Esto permite detectar:

fricción por contexto

problemas de permiso vs copy

diferencias entre entradas

10. Regla práctica sobre Analytics

Todo param que quieras analizar en GA4 debe registrarse como Custom Dimension (Event-scope).

Si no:

el dato existe,

pero no es usable para segmentar/comparar.

11. Aplicado al caso real (contador de pasos)
CTA “Activar contador de pasos”
event: step_counter_activate_clicked

System:
event: step_counter_permission_result
param:
- result: granted | denied


No se añaden más params porque:

solo hay un punto de activación

solo hay un estado posible

no hay comparación que hacer (por ahora)