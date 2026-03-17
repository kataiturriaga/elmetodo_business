# Executive Summary — El Método

---

## ¿Qué es El Método?

El Método es una aplicación móvil de fitness (iOS + Android) que combina seguimiento de actividad física, programas de entrenamiento estructurados y contenido de nutrición dentro de un sistema freemium con suscripción mensual/anual.

Su propuesta diferencial es la **integración de salud nativa** (HealthKit / Health Connect) con un **motor de entrenamiento progresivo** que guía al usuario desde usuario anónimo hasta atleta con entrenador personal asignado.

---

## Estado actual del producto

| Dimensión | Estado |
|-----------|--------|
| **Versión** | 1.0.0 (build 20) |
| **Plataformas** | iOS + Android (Flutter) |
| **V1 (Free + Subscriber)** | Completada, en producción |
| **V2 (Coached)** | En desarrollo activo |
| **Backend** | FastAPI (Python) + PostgreSQL |
| **Analytics** | Firebase GA4, 55/78 eventos conectados |
| **IAP** | Integrado (StoreKit 2 + Google Play Billing v7) |
| **Auth** | Guest + Email + Google + Apple |

---

## Propuesta de valor

### Para el usuario free
> "Empieza a moverte sin fricción. Registra tus pasos, compite con otros y descubre tu nivel."

### Para el suscriptor
> "Un plan de entrenamiento que evoluciona contigo. Programas de 4 a 12 semanas, recetas y guías de bienestar."

### Para el usuario con coaching
> "Tu entrenador personal en el bolsillo. Dietas, rutinas y seguimiento personalizado desde el día uno."

---

## Modelo de negocio

El Método opera con un modelo **freemium de 3 tiers** basado en suscripción:

```
ZONA 0 — GRATIS
  └─ Home + Ranking
      └─ Sin registro requerido (guest) o registrado sin pagar
      └─ Pedómetro + actividades manuales
      └─ Programas y Explora bloqueados

ZONA 1 — SUSCRIPCIÓN  ← Revenue principal
  └─ Todo + Explore (recetas, guías, calculadora calórica)
      └─ €14.99/mes | €29.99/trimestre | €89.99/año
      └─ Trial de 14 días al activar primer programa (backend-gated)
      └─ 3 días de trial de tienda (App Store / Google Play)

ZONA 2 — ASESORÍAS  ← Tier premium
  └─ Experiencia coached completa
      └─ Coach asignado (equipo de Inazio)
      └─ Dieta + rutina personalizadas
      └─ Check-in quincenal
      └─ Pricing por definir
```

---

## Tracción y métricas objetivo

| KPI | Descripción |
|-----|-------------|
| **North Star** | Usuarios activos semanales con al menos 1 sesión de entrenamiento completada |
| **Conversión trial→paid** | Objetivo: >25% (industria: 20-30%) |
| **Churn mensual** | Objetivo: <5% |
| **D30 Retention** | Objetivo: >35% |
| **ARPU mensual** | Basado en mix de planes (monthly/quarterly/annual) |

---

## Fortalezas competitivas

1. **Sin fricción inicial**: El usuario empieza sin registro y sin perder datos gracias al guest auth con device ID persistente.
2. **Progresión de tier sin fritura**: La misma app sirve a los 3 tiers — no hay app separada para coached.
3. **Datos de salud nativos**: Integración real con HealthKit y Health Connect (no solo conteo de pasos manual).
4. **Arquitectura escalable**: Clean Architecture + Riverpod permite añadir features sin deuda técnica.
5. **Single source of truth**: Un solo endpoint `/home` consolida todos los datos — latencia baja, experiencia fluida.

---

## Riesgos principales

| Riesgo | Impacto | Mitigación |
|--------|---------|------------|
| Mercado saturado (Garmin, Strava, Nike Run) | Alto | Diferenciación por coaching personalizado (V2) |
| Cambios en políticas App Store / Google Play | Medio | Validación backend de IAP, no solo client-side |
| Churn si el contenido de programas se agota | Alto | Pipeline de nuevos programas como producto |
| Dependencia de Firebase para analytics | Bajo | Migración posible a mixpanel/amplitude si se necesita |
| Trial abuse (múltiples cuentas guest) | Medio | Device ID persistente + backend detection |

---

## Próximos hitos críticos

1. **Completar V2 Coaching**: Router condicional por tier implementado, UI de V2 en Figma.
2. **Completar wiring de analytics**: 23 eventos restantes por conectar.
3. **Primer release público** con V2 coaching tier activo.
4. **Estrategia de contenido**: Pipeline de programas y recetas para suscriptores.
5. **Dashboard de métricas**: Firebase audiences configuradas para segmentación de push.
