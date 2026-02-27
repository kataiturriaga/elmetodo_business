# Brainstorming inicial

## In-app feedback 

- Si abandona una sesión / sale a mitad
“¿Qué te frenó?” (opciones: demasiado largo, demasiado difícil, no entendí, dolor/molestia, no era mi objetivo, bug)

- Tras ver un bloqueo / paywall (cuando exista)
“¿Qué te impidió continuar?” (precio, no lo necesito, no lo entendí, quiero probar más, otro)

## Boton persistente "enviar feedback" en settings

- Estructura:
    - Categoría (Bug / Confuso / Idea / Contenido / Otro)
    - Texto
    - Consentimiento para contacto (sí/no)

## Fuera de la app

- Whatsapp / instagram > hacer match con la ddbb de ander/ina

## Reglas

- Máximo 1 prompt cada 7 días por usuario (o 1 por “fase”: D0–D3).
- Cooldown: si el usuario cierra/skip → no volver a preguntar en 14 días.
- Nunca bloquear (siempre “Ahora no”).
- 1 pregunta + 1 opcional (campo texto solo si quiere).
- Sampling: solo al 20–30% de usuarios al principio (subes si hace falta).
# Decisión — estrategia de feedback en primera fase

---

# Decisión — estrategia de feedback en primera fase

Vamos a usar una estrategia **híbrida** para no molestar y a la vez conseguir señal accionable:

1) **Desde el día 1** habrá un canal pasivo: botón persistente **“Enviar feedback”** en Settings.
2) **Prompts activos solo cuando haya señal de fuga** (no preguntar “por preguntar”):
   - Se activan durante **3–7 días** en el punto del flujo con problema.
   - Si no hay problema claro, **no se muestra** ningún prompt activo.

## Qué consideramos “señal suficiente” para activar un prompt
- **Drop alto** en un paso clave (orientativo: >30–40% en el tramo que estamos midiendo).
- **Muchos reintentos / back** en la misma pantalla.
- **Tiempo muerto** repetido (p. ej. >60s sin acción).
- **Concentración de errores** (network/api) en un punto concreto.

## Cómo se desactiva
- Si tras el periodo de 3–7 días el drop baja o el problema queda entendido/solucionado → **se apaga** el prompt.

------

# Spec v1 — Funcionalidad “Enviar feedback”

## Objetivo
Recoger feedback **de forma voluntaria** (no intrusiva) pero **accionable**, con el contexto mínimo para:
- reproducir bugs,
- entender fricciones de UX/copy,
- priorizar mejoras por impacto.

## Dónde vive (entry points)
- **Perfil**: item de lista “Enviar feedback”.

## UX (flujo)
1) Usuario toca “Enviar feedback”.
2) Se abre un modal con:
   - selector de categoría,
   - campo de texto,
   - toggle de “¿Podemos contactarte?”.
3) Tap “Enviar” → estado de carga → confirmación “Gracias”.

## Campos (lo que el usuario rellena)
- **Categoría** (obligatorio):
  - `bug`
  - `confuso`
  - `idea`
  - `contenido`
  - `otro`
- **Mensaje** (obligatorio, mínimo 10–20 caracteres recomendado).
- **¿Podemos contactarte?** 
  - Si Sí: pedir **email o teléfono**

## Contexto que se adjunta automáticamente (clave para utilidad)
Adjuntar siempre (sin pedir al usuario):
- `user_id` (si existe) / `is_guest`
- `app_version`, `platform`, `device_model` (si es fácil)
- `timestamp`
- **screen_context**:
  - `program_id`, `program_name`, `week`, `day`

## Copy recomendado (no molesto)
- Título: “Enviar feedback”
- Placeholder: “¿Qué ha pasado? Si es un bug, dinos qué estabas intentando hacer.”
- CTA: “Enviar”
- Éxito: “Gracias. Lo hemos recibido.”

## Dónde cae (operativa interna)
Enviar a un sistema simple (eligir uno):
- **Email** a un inbox de soporte, o
- **Slack** (canal #feedback) con plantilla fija, o
- **Notion/Trello/Linear** como ticket con campos estructurados.


## Eventos de analytics
- `feedback_opened` (source: settings / overflow_menu)
- `feedback_submitted` (category, has_screenshot, contact_allowed)


