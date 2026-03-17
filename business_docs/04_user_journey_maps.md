# User Journey Maps — El Método

Los 4 flujos críticos del producto desde el punto de vista del usuario.

## IMPORTANTE - faltan por definir todos los user journeys de la parte coached-asesorias

---

## Journey 1 — Activación: De descarga a primer valor (D0)

**Objetivo**: Conseguir que el usuario llegue al "aha moment" lo antes posible.
**Aha moment**: Ver su posición en el ranking después de caminar.

```
ACCIÓN DEL USUARIO
─────────────────────────────────────────────────────────────────────────────────
Descarga app → Splash screen → Permiso salud → Home → Ranking → Primer día activo
     │               │              │           │        │              │
  <1 seg           <1 seg        Opcional     <1 seg   1-2 mins     D1, D7

EMOCIÓN
─────────────────────────────────────────────────────────────────────────────────
Curiosidad      Confianza       Duda         Sorpresa   Motivación    Hábito
"¿qué es esto?" "carga rápido"  "¿por qué?"  "ya hay    "quiero       "vuelvo
                                             datos"     subir"        mañana"

PUNTOS DE FRICCIÓN
─────────────────────────────────────────────────────────────────────────────────
                                ↑ CRÍTICO: si pedimos permiso de salud
                                demasiado pronto → abandono.
                                Solución actual: pantalla explicativa de HealthKit.
```

**Métricas de este journey**:
- **Install → First session**: D0 (meta: >90%)
- **Session → Health permission granted**: (meta: >60%)
- **D1 retention**: (meta: >40%)

**Optimizaciones pendientes**:
- [ ] A/B test: ¿mostrar el ranking en el onboarding aumenta D1 retention?
- [ ] Push de bienvenida a las 24h: "Tus primeros pasos están contados."

---

## Journey 2 — Conversión: De Free a Subscriber (D1–D14)

**Objetivo**: Que el usuario active el trial del programa base y luego se suscriba.
**Trigger clave**: Completar 1 sesión del programa base durante el trial de 14 días.

```
ACCIÓN DEL USUARIO
──────────────────────────────────────────────────────────────────────────────────────────────
Explora Training → Ve programa → Activa trial → Completa día 1 → Paywall (D14) → Suscripción
       │               │               │               │               │               │
  Sin registro      "quiero           "gratis?        "esto           "no quiero      "ok,
  necesario         probarlo"         ok"             funciona"       perderlo"       trimestral"

EMOCIÓN
──────────────────────────────────────────────────────────────────────────────────────────────
Curiosidad         Interés          Alivio           Progreso        Ansiedad        Compromiso
"¿qué programas    "este parece     "sin             "ya              "perdí 10       "merece
hay?"              mi nivel"        tarjeta"         completé día 1"  días de prog."  la pena"

PUNTOS DE FRICCIÓN
──────────────────────────────────────────────────────────────────────────────────────────────
                       ↑ Si el catálogo           ↑ Si no completa           ↑ Si el paywall
                       parece muy difícil         al menos 3 días            es demasiado
                       o muy fácil → abandono     de programa → no           agresivo → rebote
                                                  hay conversión             sin compra
```

**Métricas de este journey**:
- **Free → Trial activation**: (meta: >30% de usuarios registrados)
- **Trial day 1 → Day 3 completion**: (meta: >50%)
- **Trial expiry → Purchase**: (meta: >25%)
- **Plan mix**: Meta → 60% trimestral, 30% anual, 10% mensual

**Optimizaciones pendientes**:
- [ ] Push a D7 del trial: "Te quedan 7 días para terminar el programa"
- [ ] Push a D12: "2 días para tu trial. No pierdas tu progreso."
- [ ] A/B test: Mostrar "días completados" en el paywall vs solo precio

---

## Journey 3 — Retención: El suscriptor activo (D15–D90)

**Objetivo**: Mantener al suscriptor activo hasta que complete un programa completo y renueve.

```
ACCIÓN DEL USUARIO
──────────────────────────────────────────────────────────────────────────────────────────────
Día 15: Paga → Semana 4: Base done → Elige Completo → Semana 16: Completo done → Renueva / Churn
    │               │                    │                   │                        │
 Euforia         Satisfacción          Motivación          Logro máximo            Decisión

RIESGO DE CHURN POR FASE
──────────────────────────────────────────────────────────────────────────────────────────────
D15-D30:            D30-D60:            D60-D90:              Post-completo:
"¿Lo uso bastante   "El programa se     "Voy bien pero        "Ya completé el
para que valga?"    está haciendo       me falta              programa, ¿para
                    repetitivo"         motivación"           qué renuevo?"

MITIGACIONES
──────────────────────────────────────────────────────────────────────────────────────────────
→ Primera semana    → Notif de progreso → Nuevos contenidos   → Reactivación de
  con video welcome   semanal            en Explore           programa como opción
→ Acceso a Explore  → Retos en ranking  → Logros y badges     → Nuevo programa
  inmediato                                                     con upgrade a Coached
```

**Métricas de este journey**:
- **M1 retention** (30 días): (meta: >70%)
- **Program completion rate**: (meta: >40% completan programa base)
- **Base → Completo upgrade**: (meta: >50% de quienes completan base)
- **M3 renewal** (trimestral): (meta: >65%)

**Optimizaciones pendientes**:
- [ ] Badge de "Programa completado" — gamificación de hitos
- [ ] "Plan de continuación" automático al terminar programa → no hay gap
- [ ] Notificación semanal de progreso con comparativa vs semana anterior
- [ ] Re-engagement push si no hay sesión en 5 días: "Tu progreso te espera"

---

## Journey 4 — Recuperación de Churned Users

**Objetivo**: Recuperar suscriptores que cancelaron antes de que su período expire.

```
TRIGGER: Suscriptor cancela renovación automática
         │
         ├─ Día de cancelación: Email/push "¿Qué pasó? Cuéntanos"
         │
         ├─ D+3: "Tu acceso sigue activo hasta el [fecha]"
         │
         ├─ D+7 (si quedan 7 días de acceso): "Esta semana es gratis, úsala"
         │
         ├─ D+0 (día de expiración): Email + push — oferta de re-suscripción
         │        Posible: descuento de retención (primer mes -30%)
         │
         ├─ D+30 (inactivo 1 mes): "Te echamos de menos. Tu progreso te espera."
         │
         └─ D+90 (inactivo 3 meses): Campaña win-back con nueva feature/contenido
```

**Métricas de este journey**:
- **Cancellation rate**: Por tier (monthly tiene más churn)
- **Win-back rate**: % de churned que re-suscriben en 90 días (meta: >15%)
- **Reactivation rate desde push/email**

---

## Resumen de momentos críticos (Make or Break)

| Momento | Qué decide | Señal de alarma |
|---------|-----------|-----------------|
| D0: Primer uso sin registro | Dar permiso de salud | Permission denied >40% |
| D1: Abrir ranking | Volver mañana | D1 retention <30% |
| D3-D7 del trial | Compromiso con el programa | <3 sesiones en D7 = churn |
| D14: Paywall | Comprar o abandonar | Conversion <15% |
| D28-D30: Fin del programa base | ¿Hay siguiente paso? | Churn post-programa >40% |
| M3: Renovación trimestral | ¿Renueva anual? | Downgrade o cancel |
| Post-coached upgrade | ¿Se queda a largo plazo? | NPS Coached <8 |


