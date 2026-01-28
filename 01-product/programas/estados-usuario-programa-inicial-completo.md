# Spec: Estados al acceder a “Programa completo” desde un programa inicial (gratis)

## Contexto
- El usuario puede entrar a un flujo de compra desde un **programa inicial (gratis)**.
- La **suscripción** da acceso al **catálogo** de programas premium.
- En el momento de comprar la suscripción, el usuario **siempre elige y se registra en un programa premium** (por diseño).  
  → Por tanto, no existe el estado “suscripción activa sin ningún programa premium elegido”.
- Se permite tener **varios programas premium en curso** (no se sustituye uno por otro necesariamente).
- Desde un programa inicial (gratis) puede existir una “continuación natural” en premium, pero el usuario puede haber elegido otro programa premium distinto.

---

## Estados y variantes de pantalla

### Estado 1 — Usuario SIN suscripción activa
**Condición:**
- El usuario no tiene suscripción/trial activa.

**UI:**
- Pantalla/modal upsell en cualquiera de los programas iniciales empezados, al seleccionar **programa completo** en dropdown
  - Explicar que el programa completo es 12 semanas (Fase 1–3).
  - CTA: “Empezar prueba gratis (3 días)”.
  - Link: “Explorar otros programas”.
  - Microcopy: “Tu app sigue teniendo contenido gratuito” (+ opcional “cancela cuando quieras”).

Link a pantalla:

---

### Estado 2 — Usuario CON suscripción activa, tiene programa de subscripcion en curso, pero es diferente a la continuacion del inicial al que entra.

**Condición:**
- El usuario tiene suscripción/trial activa.
- Tiene 1+ programas premium en curso.
- La continuación premium específica de este programa inicial **no está registrada/activa** para el usuario.

**Objetivo UX:**
- No vender (ya pagó), sino **invitar a añadir/activar** la continuación como un programa más en curso.

**UI: (variante “Añadir continuación”)**
- Título: “Activa el programa completo”
- Texto: “Añade la continuación de *{programa}* y empieza con las fases 1–3. Puedes tener varios programas en curso”
- CTA principal: “Añadir a mis programas” 

**Notas de copy (importante):**
- Evitar “Ir al programa completo” (presupone que ya existe para el usuario).
- Usar “Añadir / Activar / Empezar”.

**Refuerzo opcional (anti-confusión):**
- Microcopy: “No sustituye tu programa actual. Puedes tener varios en curso.”

Link a pantalla:

---

### Estado 3 — Usuario CON suscripción activa + SÍ tiene registrada la continuación de este inicial
**Condición:**
- El usuario tiene suscripción/trial activa.
- La continuación premium específica de este programa inicial **ya está registrada/activa**.

**UI: (variante “Navegar”)**
- Título: “Perfecto, ya lo tienes desbloqueado ✅”
- Texto: “Entra al programa completo y continúa con las fases 1–3.”
- CTA: “Ir al programa completo”

Link a pantalla:

---

## Principios
1) Si el usuario **ya tiene suscripción**, nunca volver a mostrar lenguaje de compra/trial en este punto.
2) Distinguir claramente:
   - “Ir” = el programa ya está activo/registrado.
   - “Añadir/Activar” = el usuario tiene acceso, pero aún no lo tiene en sus programas activos.
3) Mantener coherencia con la decisión de permitir **varios programas premium en curso**:
   - La continuación se propone como “añadir otro”, no como “cambiar” obligatoriamente.

---
