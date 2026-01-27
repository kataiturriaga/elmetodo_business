# Spec: Fases y programas (Fase inicial gratis + Programa completo premium)

## TL;DR
- Guiar al usuario para que, tras el programa gratis, **compre uno de los programas de suscripción** que lo continúa.
- También ofrecemos ver otros programas; **priorizamos el de continuación** porque convierte más.
- **Fase inicial, 4 semanas (zona:gratis)** y **Programa completo, 12 semanas (zona:subscripcion)** son **programas distintos a nivel técnico**.
- Los programas **gratis** son siempre de **3 días/semana**. 
- Los programas compeltos son de  **3, 4 o 5 días** 
- Por lo que la continuacion del inicial tiene **3 ramas** (3, 4 o 5 dias)
- ¿Cómo quedaría a nivel UX/UI?

  - En la home:
      - **Si ha comprado la continuación:**  
        Dos programas activos (inicial y completo)
  - Dentro del programa gratuito:
      - **Independiente de si ha comprado o no:**  
        El dropdown muestra **Fase inicial** y **Programa completo**.
      - **Antes de compra:**
      Con el dropdown en **programa completo**, le aparecerá un banner para comprar la continuación: (por insertar link) → **paywall**.
      - **Después de compra:**
      Con el dropdown en **programa completo**, modal de navegación "Ir al programa completo".
  - **En el programa premium:**
      El dropdown muestra **solo Fase 1/2/3**. La fase inicial no se mezcla ahí.

---

## Definiciones
- **program_id**: unidad técnica de contenido (un "programa" en backend).
- **family_id / ruta**: unidad de producto/UX que agrupa programas relacionados (precuela + completos).
- **Fase inicial (gratis)**: programa de 4 semanas (precuela).
- **Programa completo (premium)**: programa de 12 semanas con Fase 1–3.
- **Acceso premium**: el usuario tiene suscripción activa o trial válida para el `premium_program_id`.
- **Dropdown**: navegación contextual dentro de la experiencia del programa/ruta (no es un catálogo).

---

## Relación entre fase inicial y programa completo (narrativa)

Queremos que el usuario viva la experiencia como una continuidad:

- La **Fase inicial (gratis)** es una **introducción** de 4 semanas.
- El **Programa completo (subscripción)** es la **continuación** con 12 semanas divididas en 3 fases (Fase 1–3).

A nivel de producto, ambos pertenecen a la misma "ruta" (misma promesa / mismo objetivo), pero a nivel técnico pueden seguir existiendo como programas separados.

**Implicación UX clave:**
Cuando el usuario está dentro del programa gratis, la opción "Programa completo" del dropdown debe comportarse según si el usuario ya tiene acceso o no:

- Si **NO tiene acceso al programa completo** → mostrar **modal de upsell** (trial 3 días).
- Si **SÍ tiene acceso al programa completo** → mostrar **modal de navegación** ("Ir al programa completo"), nunca volver a mostrar "desbloquea".

En otras palabras:
- El dropdown del gratis sirve para "ver la introducción" o "ir a la parte completa".
- El usuario puede tener ambos programas "activos", pero la UI nunca debe tratar al usuario como si no tuviera acceso cuando ya lo tiene.

---

## Objetivo UX
- Usar el dropdown como palanca de conversión sin confundir.
- Resolver edge case: usuario compra premium pero sigue entrando al gratis.

---

## Dropdown (programa gratis)
**Muestra:**
- Fase inicial (actual)
- Programa completo (locked si no hay acceso / accesible si hay acceso)

### Comportamiento (usuario SIN acceso)
Al tocar "Programa completo":
- Modal upsell (locked)
- Explica: "12 semanas en 3 fases (1–3)"
- CTA: "Empezar prueba gratis (3 días)"
- Secundario: "Explorar otros programas"
- Microcopy: "La app sigue teniendo contenido gratuito" (+ opcional "cancela cuando quieras")

### Comportamiento (usuario CON acceso)
Al tocar "Programa completo":
- Modal navegación (no upsell)
  - Título: "Ya tienes el programa completo ✅"
  - Texto: "Las fases 1–3 están en *Recomposición total (12 semanas)*."
  - CTA: "Ir al programa completo"
- No teletransporte directo desde dropdown (para evitar rareza UX).

---

## Dropdown (programa premium)
**Muestra solo fases del premium:**
- Fase 1
- Fase 2
- Fase 3

**No** incluir "Fase inicial" en el dropdown del premium (es otro programa y mezcla jerarquías).

### Acceso a fase inicial desde premium
- Link discreto: "Ver fase inicial (4 semanas)" / "Ver fase inicial (historial)"
- O en "Mis programas / Historial" como completado/en pausa.

---

## Casos de prueba (aceptación)
| Caso | Contexto | Acción | Resultado esperado |
| 1 | En gratis, sin premium | Dropdown → Programa completo | Modal upsell + CTA trial |
| 2 | En gratis, con premium activo | Dropdown → Programa completo | Modal navegación → "Ir al programa completo" |
| 3 | En premium | Dropdown | Solo Fase 1/2/3 + link a fase inicial |

---

## Edge case 2 
- Usuario empieza con programa inicial id:1 , compra programa completo id:2
- En el programa inicial, dropdown **programa completo** aun le muestra para 


## Principios de coherencia
1) Gratis: dropdown = "fase inicial" vs "programa completo".
2) Premium: dropdown = fases internas del premium (1–3).
3) Si ya pagó: no mostrar "desbloquea", solo navegación.
