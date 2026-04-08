# Risk Register — El Método

Registro de riesgos de negocio, técnicos y operacionales. Actualizado: Marzo 2026.

---

## Matriz de evaluación

| Probabilidad / Impacto | Bajo | Medio | Alto |
|------------------------|------|-------|------|
| **Alta** | 🟡 Monitorear | 🟠 Mitigar | 🔴 Crítico |
| **Media** | 🟢 Aceptar | 🟡 Monitorear | 🟠 Mitigar |
| **Baja** | 🟢 Aceptar | 🟢 Aceptar | 🟡 Monitorear |

---

## Riesgos de Negocio

### R01 — Mercado saturado de fitness apps
- **Probabilidad**: Alta
- **Impacto**: Alto
- **Clasificación**: 🔴 Crítico
- **Descripción**: El mercado de fitness apps está dominado por Freeletics, Nike Training, MyFitnessPal, Strava. El usuario promedio tiene 3-5 apps instaladas y la lealtad es baja.
- **Mitigación**:
  - Diferenciación por nicho: mercado hispanohablante + coaching personalizado (V2)
  - Guest auth sin fricción: barrera de entrada prácticamente nula
  - Ranking social: elemento de retención que apps grandes no priorizan para hispanohablantes
  - Pipeline de V2 Coached como moat competitivo real
- **KPI de alerta**: D30 retention <15% indicaría falta de diferenciación

### R02 — Cambios en políticas de App Store / Google Play
- **Probabilidad**: Media
- **Impacto**: Alto
- **Clasificación**: 🟠 Mitigar
- **Descripción**: Apple y Google pueden cambiar políticas de IAP, trial gratuito, o aumentar comisiones. Historial de cambios en condiciones de pago de Apple (comisión 30% → 15% para small developers).
- **Mitigación**:
  - Validación de IAP en backend (no solo client-side) — ya implementado
  - No depender de features de store no oficiales
  - Monitorear App Store Review Guidelines regularmente
  - Plan de contingencia si eliminan el trial de 3 días del store
- **Acción inmediata**: Documentar el flujo de trial de 14 días (backend-gated) como backup del trial de tienda

### R03 — Churn alto si el catálogo de programas se agota
- **Probabilidad**: Alta
- **Impacto**: Alto
- **Clasificación**: 🔴 Crítico
- **Descripción**: Si un suscriptor completa el programa Base y el Completo sin siguiente paso, no tiene motivo para renovar. Esto es el cliff del contenido.
- **Mitigación**:
  - Feature de reactivación de programa ya implementada
  - Roadmap de nuevos programas trimestral (must-have)
  - V2 Coached como siguiente nivel natural post-programa completo
  - Explore tab (recetas, guías) como valor residual del subscriber
- **Acción inmediata**: Definir pipeline de contenido para Q2-Q3 2026. ¿Cuántos programas nuevos/trimestre?

### R04 — Pricing demasiado alto para LATAM
- **Probabilidad**: Media
- **Impacto**: Medio
- **Clasificación**: 🟡 Monitorear
- **Descripción**: €89.99/año es pricing europeo. En México o Argentina, la paridad de poder adquisitivo hace el precio prohibitivo. App Store tiene pricing local pero hay que configurarlo.
- **Mitigación**:
  - Activar App Store Pricing Tiers locales por país (Apple / Google)
  - Considerar precios en MXN, ARS, COP según mercado
  - Remote Config para mostrar precios en moneda local
  - A/B test de pricing por mercado

### R05 — Dependencia de un solo entrenador/coach estrella en V2
- **Probabilidad**: Baja
- **Impacto**: Alto
- **Clasificación**: 🟡 Monitorear
- **Descripción**: Si el V2 depende de 1-2 coaches, perder un coach significa perder el valor para sus clientes → churn masivo.
- **Mitigación**:
  - Protocolo de salida de coach: transferencia de clientes a otro coach
  - Contratos con coaches que incluyan NDA y non-compete
  - Construir el contenido como propiedad de la plataforma, no del coach
  - Mínimo 3 coaches activos antes de escalar V2

---

## Riesgos Técnicos

### R06 — Fallo en la integración HealthKit / Health Connect
- **Probabilidad**: Media
- **Impacto**: Alto
- **Clasificación**: 🟠 Mitigar
- **Descripción**: Apple y Google actualizan las APIs de salud periódicamente. Un breaking change puede romper el pedómetro para todos los usuarios.
- **Mitigación**:
  - Tests de integración en CI para health data
  - Fallback al pedómetro nativo (package `pedometer`) para dispositivos sin Health Connect
  - Monitoreo de Crashlytics para errores de health permission
  - Plan de hotfix en < 24h para breaking changes
- **Estado actual**: Pantalla explicativa de HealthKit ya implementada

### R07 — Backend single point of failure
- **Probabilidad**: Baja
- **Impacto**: Alto
- **Clasificación**: 🟡 Monitorear
- **Descripción**: Toda la lógica de acceso a tiers, validación de IAP y datos de usuario está en el backend (FastAPI). Una caída del backend = app parcialmente funcional.
- **Mitigación**:
  - Cache de auth tokens en secure storage (la app funciona offline si tokens válidos)
  - El `/home` endpoint tiene cache en app (silent refresh, datos previos visibles)
  - SLA del backend: mínimo 99.5% uptime
  - Alertas de monitoreo (latencia, errores 5xx)
  - Plan de comunicación de incidencias si hay downtime >5 min

### R08 — IAP fraud / receipt tampering
- **Probabilidad**: Baja
- **Impacto**: Medio
- **Clasificación**: 🟡 Monitorear
- **Descripción**: Usuarios pueden intentar manipular receipts de compra para acceder a contenido premium sin pagar.
- **Mitigación**:
  - Validación de IAP en backend ya implementada (Apple App Store Server API + Google Play API)
  - El nivel de acceso viene del backend, no del cliente
  - Logging de transacciones sospechosas (múltiples purchases en poco tiempo)

### R09 — Performance degradada en Android gama baja
- **Probabilidad**: Media
- **Impacto**: Medio
- **Clasificación**: 🟡 Monitorear
- **Descripción**: LATAM tiene alta penetración de Android gama baja. El uso de videos, animaciones y salud puede degradar el rendimiento.
- **Mitigación**:
  - Test en dispositivos representativos de LATAM (Xiaomi, Samsung A-series)
  - Lazy loading de videos (no precargar)
  - Cached Network Image para imágenes
  - Firebase Performance Monitoring activo
  - Flutter flavor sin features pesadas para dispositivos limitados (futuro)

### R10 — Deuda técnica en el dual-mode (automated/manual)
- **Probabilidad**: Alta
- **Impacto**: Bajo
- **Clasificación**: 🟡 Monitorear
- **Descripción**: El sistema de dos modos (automated/manual) compilados por dart-define añade complejidad. Si el modo manual queda obsoleto, puede acumular deuda técnica.
- **Mitigación**:
  - Decisión estratégica pendiente: ¿el modo manual sigue siendo relevante para V2?
  - Si V2 unifica todo en una app, deprecar el modo manual y simplificar
  - Documentar claramente cuándo se usa cada modo

---

## Riesgos Regulatorios / Legales

### R11 — GDPR / privacidad de datos de salud
- **Probabilidad**: Media
- **Impacto**: Alto
- **Clasificación**: 🟠 Mitigar
- **Descripción**: Los datos de salud (pasos, calorías, actividad) son datos sensibles bajo GDPR en Europa. Un incidente de datos o audit de Apple puede tener consecuencias legales y de reputación.
- **Mitigación**:
  - Privacy Policy actualizada con datos de salud explícitos
  - HealthKit: Apple exige declaración explícita de uso de datos de salud en App Store Connect
  - Datos de salud: no compartir con terceros sin consentimiento explícito
  - DPA (Data Processing Agreement) con todos los proveedores (Firebase, backend hosting)
  - Derecho de supresión: la feature de "delete account" ya implementada

### R12 — Rechazo en revisión de App Store
- **Probabilidad**: Baja
- **Impacto**: Alto
- **Clasificación**: 🟡 Monitorear
- **Descripción**: Apple puede rechazar updates por cambios en la app que violen las guidelines (IAP obligatorio, datos de salud, screenshots).
- **Mitigación**:
  - Review checklist antes de cada release
  - Screenshots y descripción de App Store correctamente localizados
  - No usar terminología médica ("diagnóstico", "tratamiento") en copywriting
  - Plan de respuesta a rejection: resolver en <48h

---

## Resumen ejecutivo de riesgos

| ID | Riesgo | Clasificación | Owner | Estado |
|----|--------|---------------|-------|--------|
| R01 | Mercado saturado | 🔴 Crítico | Product | V2 como diferenciador |
| R02 | Cambios App Store | 🟠 Mitigar | Dev | Backend validation ✅ |
| R03 | Cliff de contenido | 🔴 Crítico | Product | Pipeline Q2 pendiente |
| R04 | Pricing LATAM | 🟡 Monitorear | Product/Biz | Pricing local pendiente |
| R05 | Dependencia coach | 🟡 Monitorear | Ops | Aceptar hasta V2 live |
| R06 | Health API changes | 🟠 Mitigar | Dev | Fallback ✅ |
| R07 | Backend downtime | 🟡 Monitorear | Dev/Ops | Cache ✅, SLA pendiente |
| R08 | IAP fraud | 🟡 Monitorear | Dev | Backend validation ✅ |
| R09 | Android perf | 🟡 Monitorear | Dev | Testing en gama baja |
| R10 | Dual-mode deuda | 🟡 Monitorear | Dev | Decisión estratégica |
| R11 | GDPR salud | 🟠 Mitigar | Legal/Dev | Privacy policy review |
| R12 | App Store rejection | 🟡 Monitorear | Dev | Checklist pre-release |

---

## Acciones inmediatas (Top 3)

1. **R03 — Pipeline de contenido**: Definir cuántos programas nuevos se lanzan por trimestre y quién los produce. Sin esto, el churn post-programa es inevitable.

2. **R04 — Pricing local LATAM**: Activar App Store / Google Play pricing por país. Puede aumentar significativamente la conversión en México y Argentina.

3. **R11 — Audit GDPR**: Revisar Privacy Policy con foco en datos de salud antes de escalar paid media en Europa. Un audit fallido en este punto puede detener el marketing.
