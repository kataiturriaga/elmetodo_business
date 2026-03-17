# Business Model

## Modelo de Negocio General

El Metodo opera como un **negocio de asesorías deportivas online con personal brand**:

- Inazio es la marca. Los clientes le pagan a él por sus servicios de coaching.
- Un equipo de 10+ coaches empleados ejecuta el servicio bajo su nombre.
- El dashboard es una herramienta operacional interna, no un producto vendido a terceros.

```
INAZIO (marca)
    │
    │ ← Clientes pagan asesorías (mixto: mensual + paquetes)
    │
    ├─── paga salario ──► Coaches (empleados, 10+)
    │                         │
    │                         │ usan
    │                         ▼
    │                    EL METODO DASHBOARD
    │                    (herramienta interna)
    │
    └─── paga salario ──► Jorge (jefe de coaches)
                              │
                              │ supervisa con
                              ▼
                         EL METODO DASHBOARD
```

---

## Flujo de Ingresos

**Un único flujo de ingresos**: los clientes finales pagan a Inazio por las asesorías.

**Modelos de pago del cliente** (mixto):
- Suscripción mensual recurrente
- Paquetes prepago (3, 6 o 12 meses)

**Captación de clientes**:
- Redes sociales (canal principal): Inazio como influencer deportivo
- Publicidad pagada: Meta Ads, Google Ads
- Boca a boca: clientes satisfechos que recomiendan

---

## Estructura de Costes

| Coste | Tipo | Descripción |
|---|---|---|
| Salarios coaches | Fijo | El mayor coste operacional. 10+ coaches a jornada completa o parcial |
| Salario Jorge | Fijo | Jefe de coaches |
| Salario especialista de planes | Fijo | Empleado que crea los planes de dieta y entrenamiento para los clientes |
| Infraestructura tech | Variable | Servidores, base de datos, almacenamiento de fotos |
| Marketing/Ads | Variable | Publicidad pagada para captación de nuevos clientes |
| Producción de contenido | Variable | Redes sociales de Inazio (videos, fotos, stories) |

---

## Ciclo de Valor (Value Flywheel)

```
Inazio crece su marca en redes sociales
        │
        ▼
Más seguidores → Más clientes potenciales
        │
        ▼
El equipo de coaches (con el dashboard) puede atender más clientes
sin perder calidad percibida
        │
        ▼
Los clientes tienen resultados → Renuevan + Recomiendan
        │
        ▼
Más ingresos para Inazio → Puede invertir más en marca + equipo
        │
        ▼
Inazio crece su marca ──────────────────────────────┘ (ciclo)
```

**El dashboard es el habilitador crítico del flywheel**: sin él, el equipo no podría escalar. El límite de clientes atendibles dependería del número de coaches, no de su eficiencia.

---

## Métricas Clave del Modelo de Negocio

| Métrica | Descripción |
|---|---|
| MRR (Ingresos Recurrentes Mensuales) | Suma de suscripciones activas de clientes |
| Churn de clientes | % de clientes que no renuevan al mes siguiente |
| LTV (Lifetime Value) | Ingresos medios por cliente durante toda su relación |
| CAC (Coste de Adquisición) | Gasto en marketing / nuevos clientes adquiridos |
| Ratio LTV/CAC | Debe ser > 3x para un negocio sano |
| Clientes activos totales | Clientes con suscripción activa en este momento |
| Clientes por coach | Para planificar capacidad del equipo |

---

## Análisis de Costes Variables (Tech)

- **Almacenamiento**: Fotos de revisiones (4 ángulos × cada 14 días × todos los clientes activos). Crece linealmente con la base de clientes.
- **Infraestructura**: Escala con el número de usuarios concurrentes (coaches usando el dashboard simultáneamente).

**Nota**: Los planes de dieta y entrenamiento son creados manualmente por un especialista, no por IA. No hay coste de LLM.

---

## Riesgos del Modelo de Negocio

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| **Key-person risk**: caída de la marca de Inazio | Baja-Media | Muy Alto | Diversificar la marca, crear sub-marcas o contenido de equipo |
| Inconsistencia de calidad entre coaches | Alta | Alto | Estándares claros, supervisión de Jorge, historial auditable en dashboard |
| Cliente descubre que no le lleva Inazio | Media | Alto | Gestión de expectativas en la venta, lenguaje de equipo ("el método de Inazio") |
| Coste de IA supera lo presupuestado al escalar | Media | Medio | Monitorizar coste por generación, cachear planes similares |
| Regulación GDPR / LOPD para datos de salud | Media | Alto | Compliance antes de escalar en Europa |
