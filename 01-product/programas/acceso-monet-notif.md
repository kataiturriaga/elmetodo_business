# Política de acceso y monetización  
qué puede hacer el usuario según zona/estado (bloqueos, requisitos, trial, tiempos).

## Modelo a 19 feberero: 14 días free en Programas Base

---

## TL;DR
- El acceso gratuito a entreno es una **fase de inicio de 14 días** (sin tarjeta) con **Programas Base**.
- Para acceder a **Programas Completos (12 semanas)** se requiere **suscripción** (tarjeta + **3 días de prueba**).
- La tab **Explora** está **bloqueada** hasta que haya suscripción.
- Al terminar los **14 días**, si el usuario no paga:
  - ✅ mantiene acceso a **Home + Comunidad**
  - ❌ se bloquea **Entreno > Tus programas** (continuar plan / sesiones / progreso)
  - ✅ se mantiene accesible **Entreno > Catálogo** (vía sub-tabs dentro de Entreno)

---

## Estructura de navegación
Nav bar: **Home · Entreno · Explora · Comunidad**

Dentro de **Entreno** (sub-tabs):
- **Tus programas** (plan activo, sesiones, calendario, progreso, historial de entreno)
- **Catálogo** (listado de programas disponibles)

---

## Estructura del producto (zonas)

### Zona 0 (sin registro)
- Acceso: **Home + Comunidad**
- Requisito: **permisos salud**
- Entreno: muestra pantalla de entrada (ProgramFirstChoice) / acceso limitado
- Explora: **bloqueada**

### Zona 1 (registro) — “Fase de inicio”
- Acceso: **Home + Comunidad + Entreno (Programas Base)**
- Requisito: **registro**
- Regla: **14 días de acceso** desde que el usuario **activa su primer Programa Base**
- Explora: **bloqueada**

### Zona 2 (suscripción)
- Acceso: **Full access** (Home + Comunidad + Explora + Entreno Base + Entreno Completo)
- Requisito: **tarjeta + suscripción**
- Oferta: **3 días de prueba** (trial) y luego suscripción

---

## Decisión
- El acceso gratuito a entreno se limita a una **fase de inicio de 14 días** (sin tarjeta).
- La tab **Explora** es un **beneficio Premium** (bloqueada hasta suscripción).
- Los **Programas Completos (12 semanas)** requieren **tarjeta** (con 3 días de prueba).
- Tras expirar la fase gratuita, se bloquea **“Tus programas”** pero se mantiene **“Catálogo”** accesible dentro de Entreno.

---

## Principio UX clave
No comunicarlo como “te corto el acceso”, sino como:
✅ “Has completado tu fase de inicio (14 días). Para continuar tu plan y desbloquear Premium, activa la prueba.”

---

## Regla de producto

### Qué se mantiene tras los 14 días (sin pagar)
✅ **Home** (cuentapasos / progreso general)  
✅ **Comunidad**  
✅ **Entreno > Catálogo** (navegable)

### Qué NO se mantiene tras los 14 días (sin pagar)
❌ **Entreno > Tus programas** (continuar plan, sesiones, calendario, progreso e historial de entreno)  
❌ **Explora** (tab completa)

> Nota: se mantiene “Catálogo” como escaparate/descubrimiento, pero el comportamiento exacto de activación/acciones se definirá más adelante.

---

## Narrativa para evitar confusión “programa 4 semanas vs 14 días”
No vendemos “programa gratis completo de 4 semanas”.
Vendemos:
- **Fase de inicio de 14 días** para probar el sistema, crear hábito y ver progreso.

Los Programas Base existen como contenido, pero la promesa y marco mental es **14 días**.

---

## Flujo de entrada a Entreno (pantalla ProgramFirstChoice)
### Objetivo
Maximizar activación: que el usuario **empiece un programa** sin fricción.

### Regla UX
- Pantalla **muy ligera** (evitar texto largo).
- Copy recomendado en 1 línea:
  - “Empieza sin tarjeta.” o “14 días gratis. Sin tarjeta.”
- Solo se muestran **Programas Base**.

### Nota de arquitectura
Aunque la tab **Explora** esté bloqueada, el usuario puede acceder al **Catálogo** desde **Entreno** gracias a los sub-tabs (“Tus programas / Catálogo”).

---

## Comunicación y timings (sin spam)
> Días desde que el usuario activa el Programa Base (inicio de Zona 1).

### D+7 — “Te queda 1 semana”
- In-app banner (suave):
  - “Te queda 1 semana de fase de inicio.”
- CTA: “Activar prueba 3 días” (lleva a paywall)

### D+11 — “Te quedan 3 días”
- Push + in-app:
  - “Te quedan 3 días de fase de inicio. ¿Seguimos?”
- CTA: “Activar prueba 3 días”

### D+14 — Fin de fase de inicio
Estados esperados:
- **Entreno > Tus programas:** estado “graduación” + CTA a trial
- **Entreno > Catálogo:** accesible (con mensajería/CTA a trial si aplica)
- **Explora:** bloqueada + CTA a trial

---

## Paywall / offer
### Premium (Programas Completos 12 semanas + acceso total)
- 3 días de prueba gratis
- después suscripción obligatoria

### Copy: continuidad y salto de nivel
- “Sigue con el método y desbloquea el siguiente nivel”
- “Más estructura, más progresión, mejores resultados”

Evitar: “pierdes acceso”, “bloqueado” como mensaje principal.

---

## Estados y comportamiento (alto nivel)

### Estado: Zona 1 activa (D0–D14)
- Entreno > Tus programas: acceso normal (programa base activo)
- Entreno > Catálogo: accesible
- Explora: bloqueada

### Estado: Expirado (D15+)
- Entreno > Tus programas: bloqueado (graduación + CTA trial)
- Entreno > Catálogo: accesible
- Explora: bloqueada
- Home + Comunidad: accesibles

---

## Métricas (por definir)

---
