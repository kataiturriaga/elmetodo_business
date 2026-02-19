# Tipos de programa y continuaciones

Cómo se estructura el entreno (fases, dropdown, siguiente nivel, continuidad).

## TL;DR

### Tipos de programa
- **Programa base**: contenido de 4 semanas, **acceso gratis 14 días**, sin tarjeta (requiere registro).
- **Programa completo**: 12 semanas (Fase 1–3), requiere **tarjeta** + **prueba 3 días**.

### Disponibilidad (desde el inicio)
- Desde el **día 1** existen **programas base y programas completos**
- En el **flujo de entrada a entreno (primera vez)** solo se muestran **Programas base** para minimizar fricción (sin tarjeta).
- Una vez dentro, el usuario puede **comprar suscripción en cualquier momento** y empezar un **Programa completo** (p. ej. desde “Siguiente nivel” o desde Catálogo).

---

## Definiciones (actualizado)

- **Programa**: unidad principal de entreno. Contiene una lista ordenada de **fases** y opcionalmente una **continuación** (siguiente programa recomendado).
- **Fase**: bloque dentro de un programa (p. ej. “Fase semilla”, “Fase 1”, “Fase 2”, “Fase 3”). Se muestra como progresión dentro del mismo programa.
- **Continuación / Siguiente nivel**: enlace desde un programa hacia **otro programa** que viene después.
  - No es “otra fase”, sino el **siguiente programa** en el camino del usuario.
  - En UI aparece como opción en el **dropdown** bajo el nombre **“Siguiente nivel”**.
  - Sirve para dirigir al usuario al “siguiente paso”:
    - **Conversión** (Base → Completo Premium)
    - **Retención** (Completo → Continuación del completo / siguiente ciclo)

---

## Modelo de progresión por tipo de programa

### Programa Base (free 14 días)
- **Fases:**  
  - `Fase semilla` (única fase)
- **Siguiente nivel (continuación):**  
  - apunta a un **Programa Completo** (Premium recomendado)
- **Objetivo:** **Conversión** (empujar a suscripción con narrativa de continuidad)

### Programa Completo (Premium)
- **Fases:**  
  - `Fase 1` → `Fase 2` → `Fase 3`
- **Siguiente nivel (continuación):**  
  - apunta a un **Programa de Continuación** (siguiente ciclo / siguiente programa completo)
- **Objetivo:** **Retención** (evitar “fin del camino”, mantener hábito y continuidad)

---

## Flujo de entrada a Entrenos (primera vez)

### Pantalla de entrada (ProgramFirstChoice)
- Solo muestra **Programas base**.
- Copy arriba: mínimo (sin explicar todo).
- No mostrar programas completos como cards “comprables” (evitar decisión + fricción).

**Objetivo:** que el usuario empiece rápido (activación).

> Nota: la existencia de Programas Completos se revela más adelante (cuando el usuario ya está dentro),
> nunca en esta primera pantalla.

---

## Dropdown dentro de Entreno (actualizado)

### Dónde aparece
El dropdown aparece **en la pagina resumen del programa**, 

### Qué representa
El dropdown permite cambiar el “contexto” de lo que estás viendo:
- una **fase** dentro del programa actual
- el **Siguiente nivel** (el siguiente programa recomendado / continuación)

---

## Items del dropdown por tipo de programa

### Programa Base
**Items:**
- **Fase semilla** (contenido 4 semanas)
- **Siguiente nivel** → **Programa completo** (12 semanas)

### Programa Completo
**Items:**
- **Fase 1**
- **Fase 2**
- **Fase 3**
- **Siguiente nivel** → **Continuación del programa** (siguiente ciclo / siguiente completo)

---

## Comportamiento del dropdown (alto nivel)

### Si el usuario selecciona una fase
- Cambia la vista al contenido de esa fase dentro del mismo programa.

### Si el usuario selecciona “Siguiente nivel”
- Mostrar una **vista/tarjeta de continuidad** con el **programa siguiente recomendado**.
- Desde esa vista, el usuario puede:
  - activar el siguiente programa (si ya tiene acceso)
  - o iniciar el flujo Premium si requiere suscripción (caso Base → Completo).

---

## Estados de “Siguiente nivel” (según suscripción)

### Estado 1 — Usuario SIN suscripción
- Al intentar acceder/activar el “Siguiente nivel” (Programa Completo):
  - abrir **paywall / trial** (requiere tarjeta, prueba 3 días).

### Estado 2 — Usuario CON suscripción, pero NO tiene activada esta continuación
- Mostrar opción “Añadir/Activar” el siguiente programa (sin lenguaje de compra).

### Estado 3 — Usuario CON suscripción y SÍ tiene activada esta continuación
- Mostrar opción “Ir” al siguiente programa.

---

## Modal de upsell (Premium) — cuando el usuario intenta abrir un completo
- Explica valor del completo (12 semanas / fases).
- CTA: trial (3 días) + tarjeta.
- Secundario: ver alternativas / volver.


## Analytics mínimos (por definir)

