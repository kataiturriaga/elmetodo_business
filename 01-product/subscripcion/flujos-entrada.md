# Flujos de entrada a suscripción

Todos los caminos por los que un usuario puede llegar al paywall / trial.

---

## Resumen de flujos

| # | Origen | Se registra en programa completo? | Elige días? | Cuándo elige días? | Paywall |
|---|--------|-----------------------------------|-------------|-------------------|---------|
| 1 | Siguiente nivel (dropdown) | Sí | Sí | Después del paywall | Sí |
| 2 | Catálogo | Sí | Sí | Antes del paywall | Sí |
| 3 | Bloqueo D+14 | No (vuelve a pantalla entreno) | No | — | Sí |
| 4 | Explora (bloqueada) | No (desbloquea contenido en explora) | No | — | Sí |
| 5 | Push / banner | No (redirige a paywall) | No | — | Sí |

---

## Flujo 1 — Desde "Siguiente nivel" (dropdown en resumen de programa)

**Contexto:** el usuario está en su programa base, abre el dropdown y selecciona "Siguiente nivel".

**Pasos:**
1. Ve una **vista/tarjeta del programa completo recomendado** (sin días asignados).
2. Toca "Empezar" / "Activar".
3. Se abre el **paywall** (trial 3 días + tarjeta).
4. Si activa trial → pasa a **pantalla de elección de días** (3, 4 o 5 días/semana).
5. Empieza el programa completo.

**Si ya tiene suscripción:** salta el paso 3 y va directo a elegir días (o a "Ir" si ya lo tenía activo).

> Detalle completo del dropdown y sus estados en `programas/tipos-programas-continuaciones.md`.

---

## Flujo 2 — Desde el Catálogo de programas

**Contexto:** el usuario navega el catálogo (accesible siempre, incluso post-expiración) y toca un programa completo.

**Pasos:**
1. Ve la **pantalla de detalle del programa** (descripción, fases, duración).
2. Toca "Empezar programa".
3. Pasa a **pantalla de elección de días** (3, 4 o 5 días/semana).
4. Entra a `DetailScreenProgram` (resumen de ejercicios del programa) para el plan de días seleccionado.
   - En esta pantalla hay un **dropdown para cambiar días** y previsualizar el mismo programa con 3/4/5 días antes de pagar.
5. Se abre el **paywall** (trial 3 días + tarjeta).
6. Si activa trial → se registra en el programa con los días elegidos.

**Si ya tiene suscripción:** salta el paso 5 y activa directamente.

**Nota sobre el orden (días antes de paywall):** en este flujo el usuario elige días **antes** del paywall. Motivo: el usuario ya ha mostrado intención concreta (eligió programa + días), lo que aumenta la probabilidad de conversión al llegar al paywall. No queremos interrumpir con el pago antes de que se haya "comprometido" mentalmente.

> Detalle de filtros y organización del catálogo en `explora/biblioteca-programas.md`.

---

## Flujo 3 — Desde el bloqueo post-14 días

**Contexto:** el usuario intenta acceder a **Entreno > Tus programas** después de que haya expirado su fase de inicio (D+14).

**Pasos:**
1. Ve una **pantalla de graduación/bloqueo**: "Has completado tu fase de inicio".
2. CTA principal: "Activar prueba 3 días".
3. Se abre el **paywall**.
4. Si activa trial → recupera acceso a "Tus programas" + desbloquea Explora.

**Tono:** no "te hemos bloqueado", sino "has completado la fase de inicio, el siguiente nivel te espera".

> Definido en la sección "Estado: Expirado (D15+)" de `programas/acceso-monet-notif.md`.

---

## Flujo 4 — Desde Explora (tab bloqueada)

**Contexto:** el usuario toca la tab **Explora** (bloqueada hasta suscripción).

**Pasos:**
1. Ve una **pantalla de bloqueo** con preview de lo que contiene Explora (recetas, guías, calculadora).
2. CTA: "Desbloquea Explora con Premium" / "Activar prueba 3 días".
3. Se abre el **paywall**.
4. Si activa trial → se desbloquea Explora completa.

**Nota:** este flujo no implica elegir programa ni días, es puramente desbloqueo de contenido.

---

## Flujo 5 — Desde push / banner de comunicación

**Contexto:** el usuario recibe una notificación push o ve un banner in-app de los timings de comunicación (D+7, D+11, D+14).

**Pasos:**
1. Toca la push o el banner.
2. Navega al **paywall** (directamente o vía la pantalla de graduación si es D+14).
3. Si activa trial → recupera/amplía acceso.

**Tipos de push que llevan a suscripción:**
- **D+7:** "Te queda 1 semana de fase de inicio"
- **D+11:** "Te quedan 3 días"
- **D+14:** "Tu fase de inicio ha terminado"
- **Post-bloqueo (D+15+):** "Tu progreso sigue ahí" (reenganche)

> Timings y copy definidos en `programas/acceso-monet-notif.md` y en `04-notifs-motivation/notifs-feb.md`.

---

## Notificaciones in-app + push (campaña)

- 16 de marzo: Hemos añadido los programas completos, ver programas completos
    - Ubicación de la notificación in-app: probablemente home
    - link diseño: [Figma - banner upload programas completos](https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=1303-31021&t=oNaCsggSSyru3vsk-1)
