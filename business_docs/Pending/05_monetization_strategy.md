# Monetization Strategy — El Método

---

## Modelo actual: Freemium + IAP Subscription

### Estructura de precios (activa en producción)

| Plan | Precio total | Precio/mes efectivo | Ahorro vs mensual | Posicionamiento |
|------|-------------|--------------------|--------------------|-----------------|
| **Mensual** | €14.99/mes | €14.99 | — | Barrera de entrada |
| **Trimestral** | €89.99/3 meses | ~€29.99 | **-35%** | Más Popular ⭐ |
| **Anual** | €89.99/año | ~€7.49 | **-50%** | Mejor Valor 🏆 |

> Nota: El precio mensual efectivo del trimestral (€29.99) y anual (€7.49) están en la pantalla de paywall como argumento de venta principal.

**Trial de tienda**: 3 días gratis (App Store y Google Play gestionan el trial)
**Trial de programa**: 14 días de acceso a programas base al activar el primero (backend-gated)

---

## Análisis de pricing

### Competencia de referencia (mercado hispanohablante)
| App | Mensual | Anual | Diferencial |
|-----|---------|-------|-------------|
| Freeletics | €12.99 | €59.99 | Entrenamiento sin equipo |
| Nike Training | €14.99 | €59.99 | Brand power |
| MyFitnessPal | €19.99 | €79.99 | Nutrición dominante |
| **El Método** | **€14.99** | **€89.99** | Coaching personalizado (V2) |

### Observaciones
- El mensual (€14.99) es competitivo con el mercado.
- El anual (€89.99) está por encima de Nike Training/Freeletics → **justificar con coaching** cuando V2 esté live.
- El trimestral es el sweet spot: compromiso moderado con ahorro real.

---

## Estrategia de conversión por tier

### Free → Trial (Zona 1)
**Objetivo**: Que el usuario activo en ranking/home vea valor en el training antes de los 7 días.

| Táctica | Canal | Timing |
|---------|-------|--------|
| Mostrar preview de programas en Home | In-app | D1-D7 |
| Notificación "Prueba el primer programa gratis" | Push | D3 |
| Badge de "Trial disponible" en pestaña Training | In-app | Permanente |
| A/B test: ¿Mostrar foto de programa en Home? | In-app | Por configurar |

### Trial → Subscriber (Zona 2)
**Objetivo**: Que el usuario que inició un programa no quiera perderlo.

| Táctica | Canal | Timing |
|---------|-------|--------|
| Push: "Te quedan 7 días de trial" | Push | D7 |
| In-app banner: countdown hasta expiración | In-app | D10 |
| Push: "2 días para terminar tu trial" | Push | D12 |
| Paywall al intentar continuar programa | In-app | D14 |
| Email: oferta de bienvenida (si email capturado) | Email | D14 |

**Argumento principal del paywall**: "No pierdas tu progreso. Llevas X días de programa."

### Subscriber → Anual (upgrade)
**Objetivo**: Mover usuarios de mensual/trimestral a anual para reducir churn y mejorar LTV.

| Táctica | Canal | Timing |
|---------|-------|--------|
| Oferta "Upgrade a anual con descuento" | In-app | Tras completar programa base |
| Push: "Ahorra 50% cambiando a anual" | Push | Día 25 (mensual) |
| Banner comparativo mensual vs anual | Paywall | Siempre visible |

---

## Revenue model y proyecciones

### Supuestos del modelo

| Variable | Valor supuesto | Fuente |
|----------|---------------|--------|
| Trial conversion rate | 20-25% | Benchmarks industria fitness |
| Monthly churn | 5% mensual | Benchmarks SaaS/consumer sub |
| Plan mix target | 60% trimestral, 30% anual, 10% mensual | Por posicionamiento |
| App store fee | 15% (si <$1M revenue/año) | Apple/Google small developer |
| CAC (coste adquisición) | Por determinar post-launch | — |

### LTV estimado por plan (neto, sin comisión tienda)

| Plan | Precio neto (~85%) | Meses activos promedio (si churn=5%) | LTV estimado |
|------|-------------------|--------------------------------------|--------------|
| Mensual | ~€12.74/mes | ~7 meses | **~€89** |
| Trimestral | ~€76.49/3m | ~14 meses (~4-5 renovaciones) | **~€306** |
| Anual | ~€76.49/año | ~24 meses (2 renovaciones) | **~€153** |

> **Insight**: El trimestral puede ser el mejor LTV si retención >12 meses. El anual tiene LTV alto pero solo si renueva.

---

## Estrategia de reducción de churn

### Prevención (antes de la cancelación)

| Señal de alerta | Acción automática |
|-----------------|-------------------|
| No abre la app en 5 días | Push: "Tu progreso te espera" |
| No completa sesión en 7 días | Push: "Solo 15 min hoy" + reminder de programa |
| D-7 antes de renovación mensual | In-app: recordatorio de valor + upgrade a trimestral |
| Completa programa sin siguiente asignado | In-app: oferta inmediata de siguiente programa |

### Recuperación (después de la cancelación)

| Timeline | Acción |
|----------|--------|
| Mismo día | Email: "¿Por qué te vas? Tu feedback nos importa" |
| D+3 | Push: "Acceso activo hasta [fecha]" |
| D+30 | Email win-back: nueva feature o contenido añadido |
| D+90 | Email: oferta de retorno con descuento (si aplica) |

---

## Estrategia V2: Tier Coached

### Pricing (por definir, recomendación)

| Opción | Precio | Lógica |
|--------|--------|--------|
| Add-on sobre subscription | +€10-15/mes | No obliga a nuevo plan |
| Plan todo-incluido Coached | €24.99-29.99/mes | Más limpio, más valor |
| Bundle anual Coached | €249.99/año | Premium, para power users |

### Consideraciones V2
- El coach cobra por cliente → el pricing debe cubrir el coste del coach + margen.
- Modelo posible: coach recibe % de los ingresos de sus clientes en la plataforma.
- Diferenciación: "Coached by [nombre]" → hace premium el producto con identidad humana.

---

## Métricas clave de monetización

| Métrica | Definición | Meta |
|---------|-----------|------|
| **Trial Conversion Rate** | Trials → Paid / Total trials | >25% |
| **MRR** | Monthly Recurring Revenue | — |
| **ARPU** | Average Revenue Per User | — |
| **LTV** | Lifetime Value por plan | Ver tabla arriba |
| **CAC** | Coste adquisición usuario | <LTV/3 |
| **Payback Period** | CAC / ARPU mensual | <3 meses |
| **Monthly Churn** | Cancelaciones / Suscriptores activos | <5% |
| **Net Revenue Retention** | MRR nuevo - MRR perdido / MRR inicial | >100% |

---

## Pricing psychology aplicada

1. **Anchoring**: El plan mensual (€14.99) ancla el precio. El trimestral parece una ganga.
2. **Most Popular badge**: El trimestral tiene el badge — dirige la decisión sin forzarla.
3. **Best Value badge**: El anual tiene el badge — para los que miran el ahorro total.
4. **Precio por mes visible**: Mostrar €29.99/mes (trimestral) al lado del precio real ayuda al usuario a sentir el ahorro.
5. **Trial sin tarjeta**: El trial de programa (14 días, backend) no requiere tarjeta → fricción mínima para entrar.
6. **Urgency en paywall**: "No pierdas tu progreso" + "Llevas X días" → FOMO de progreso perdido.
