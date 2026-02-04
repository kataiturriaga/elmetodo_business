# Spec campaña sorteo  
## Entrada masiva + teaser + drop a las 2 semanas

---

## TL;DR

### Tipos de programa
- **Programa base**: 4 semanas, sin tarjeta.
- **Programa completo**: 12 semanas (Fase 1–3), requiere tarjeta + prueba 3 días.

### Durante el sorteo + 2 semanas (entrada masiva)
- En el flujo de entrada a entreno solo se puede empezar un **Programa base** (0 fricción).
- El **Programa completo** puede aparecer como teaser dentro del Programa base (dropdown), pero:
  - No se puede comprar hasta **2 semanas** después del inicio del sorteo (**drop**).
  - CTA principal: **“Recordármelo”** (sin venta).

### A partir de +2 semanas (DROP)
- Se activan compra + prueba con notificaciones:
  - “Ya hemos abierto los programas completos”.

### Urgencia
- Notificaciones cuando falte **<1 semana** para terminar las 4 semanas del base.

---

## Definiciones
- **Programa base**: 4 semanas (3 días/semana).
- **Programa completo**: 12 semanas, dividido en 3 fases (Fase 1–3) y puede tener ramas 3/4/5 días según continuidad.
- **Ruta/familia**: agrupa Base + Completo dentro del mismo objetivo (misma promesa).
- **Dropdown**: navegación dentro del contexto de un programa/ruta (no es catálogo general).

---

## Flujo de entrada a Entrenos (primera vez)

### Durante el sorteo + 2 semanas
**Pantalla de entrada (cards tipo screenshot):**
- Solo muestra **Programas base (4 semanas)**.
- Copy arriba:
  - “Empieza hoy”
  - “4 semanas gratis · sin tarjeta”
- No mostrar programas completos como cards “comprables” (evitar decisión + fricción).

**Objetivo:** que el usuario empiece rápido (activación).

### Post-sorteo (opcional)
Después del periodo de entrada masiva, se puede valorar si:
- se mantiene igual, o
- se añade una entrada a “Programas completos” en esta misma pantalla.

> Fuera del alcance de este spec; por ahora el foco es sorteo + 2 semanas.

---

## Dentro del Programa base: Dropdown + Teaser del completo

### Dropdown en header del programa base
**Items:**
- Programa base (4 semanas) **[actual]**
- Programa completo (12 semanas) **[estado variable]**

---

## Estados del item “Programa completo” en dropdown

### Estado A — “En breve” (antes del drop)
- Se muestra como: “Programa completo (12 semanas) · Próximamente” + icono/candado.
- Al tocarlo: navegar a pantalla “Programa completo, en breve”.
- No mostrar paywall ni CTA de compra.

### Estado B — “Disponible para empezar” (después del drop)
**Usuario sin suscripción:**
- Al tocar “Programa completo”: abrir modal de upsell con prueba 3 días (requiere tarjeta).

### Estado C — Usuario con suscripción, pero NO tiene activada esta continuación
- Al tocar “Programa completo”: modal “Añadir/Activar programa completo” (sin lenguaje de compra).
- Mensaje: “Puedes tener varios programas en curso”.

### Estado D — Usuario con suscripción y SÍ tiene activada esta continuación
- Al tocar “Programa completo”: modal “Ir al programa completo”.

---

## Pantalla: “Programa completo, en breve” (teaser)
**Objetivo:** sembrar continuidad (“hay siguiente nivel”) sin vender y sin frustrar.

### Contenido
- Título: “Programa completo (12 semanas)”
- Sub: “Disponible el {fecha_apertura}”
- Texto corto: “Mientras tanto, sigue con tu programa base.”

### CTAs
- Primario: “Recordármelo”
- Secundario: “Volver al programa base” (acción directa, no solo texto)

---

## Comportamiento de “Recordármelo”
- Confirmación inmediata: “Hecho. Te avisaremos cuando se abra.”
- Si el usuario no tiene permisos de notificación:
  - Prompt contextual: “¿Te avisamos con una notificación cuando esté disponible?”
  - Botones: **Permitir / Ahora no**
- Si no permite notificaciones:
  - Debe existir un aviso in-app cuando se abran los completos (banner/badge en Entrenos).

### Nota
Durante el sorteo + 2 semanas, evitar que esta pantalla empuje a explorar más cosas bloqueadas.  
Si se incluye un link, que sea algo como: “Ver programas base” (vuelve a lo que sí puede hacer).

---

## Modal de upsell (cuando ya hay compra disponible tras el drop)
- Explica: “12 semanas en 3 fases (Fase 1–3)”
- CTA: “Empezar prueba gratis (3 días)”
- Secundario: “Ver otros programas”
- Microcopy:
  - “Cuentapasos sigue gratis”

---

## “Añadir/Activar” vs “Ir” (cuando el usuario ya paga)

### Regla de coherencia
Si el usuario ya tiene suscripción, aquí no se vuelve a vender.

### Diferenciar
- “Añadir/Activar” = tiene acceso, pero aún no lo tiene en sus programas activos.
- “Ir” = ya está activo/registrado.

---

## Timeline de notificaciones

### Drop de programas completos
**+2 semanas desde inicio del sorteo**
- Notificación global: “Ya están disponibles los Programas completos”
- Banner in-app en Entrenos (por si no tienen push)

### Urgencia por fin del programa base (4 semanas)
Contando desde el inicio del programa base:
- Cuando falte 1 semana: “Te queda 1 semana para seguir entrenando”
- Luego recordatorios opcionales:
  - 3 días
  - 1 día

> Este timeline debe coordinarse para que no haya “urgencia” antes de que los completos sean comprables.  
> Con drop a +2 semanas y urgencia desde semana 3 (día 21), queda alineado.

---

## Entrenos bloqueados
- “si no hay suscripción tras 4 semanas → se bloquea TODO Entrenos”

Entonces cualquier acceso a Entrenos tras expirar muestra:
- “Tu acceso a Entrenos ha terminado”
- CTA: “Activar suscripción (3 días gratis)”
- Nota: “Cuentapasos sigue disponible”

Y el usuario mantiene acceso a:
- Cuentapasos + Ranking + Explora 

> (Diseño exacto pendiente; se define en Doc 1.)

---

## Analytics mínimos
- `training_entry_view` (contexto: durante sorteo+2 semanas / post)
- `base_program_start` (programa, ruta)
- `dropdown_select_program_complete` (estado A/B/C/D)
- `premium_teaser_view`
- `premium_remind_me_tap` + resultado permiso push (permitido / denegado)
- `premium_drop_announcement_view` / `premium_drop_click`
- `paywall_view` / `trial_start` / `subscription_active`
- `base_week3_warning_shown`
- `base_expiry_locked_view` (si aplica)
