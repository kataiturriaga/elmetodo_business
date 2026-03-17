# El Metodo — Product Overview

## Visión

Que Inazio pueda escalar su negocio de asesorías deportivas online —atendiendo a cientos de clientes simultáneamente— sin que la calidad percibida ni la imagen de marca sufran.

## Misión

Dotar al equipo interno de coaches de herramientas que automaticen el trabajo repetitivo (generación de dietas, rutinas, seguimiento de progreso) para que puedan ofrecer un servicio de alta calidad a escala, bajo la marca de Inazio.

## Propuesta de Valor

| Para Inazio (dueño) | Para el Coach (empleado) | Para el Cliente/Trainee |
|---|---|---|
| Escala el negocio sin perder calidad percibida | Gestiona más clientes con menos esfuerzo manual | Recibe planes 100% personalizados |
| Un especialista crea los planes, los coaches los ajustan y hacen seguimiento | Tiene estructura clara de qué hacer cada día | Siente que Inazio le lleva personalmente |
| El ciclo de revisión forzado reduce el churn de clientes | Los planes llegan listos, él los adapta al cliente | Tiene seguimiento constante cada 14 días |

## Producto en Una Línea

**El Metodo Dashboard** es la herramienta operacional interna del equipo de coaches de Inazio: permite gestionar cientos de clientes, personalizar planes de dieta y entrenamiento creados por el especialista de planes, y mantener un ciclo de revisión quincenal automatizado.

## Ecosistema del Producto

```
┌──────────────────────────────────────────────────────────────┐
│                    EL METODO ECOSYSTEM                        │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  INAZIO (dueño/marca)                                         │
│  └── No usa el dashboard. Es la imagen que los clientes       │
│      compran. Su crecimiento en redes atrae clientes.         │
│                                                               │
│  JORGE (jefe de coaches)                                      │
│  └── Supervisa al equipo de coaches desde el dashboard        │
│                                                               │
│  ┌──────────────────────┐   ┌──────────────────────────────┐  │
│  │  DASHBOARD (interno)  │   │  MOBILE APP (Trainees)       │  │
│  │  - Jorge              │◄─►│                              │  │
│  │  - Coaches (10+)      │   │  - Enviar revisiones         │  │
│  │  - Web                │   │  - Ver dieta/rutina          │  │
│  └──────────┬────────────┘   │  - Responder cuestionario    │  │
│             │                └──────────────────────────────┘  │
│             ▼                                                 │
│  ┌──────────────────────┐                                     │
│  │  API (Backend)        │                                     │
│  │  - FastAPI            │                                     │
│  │  - IA Generation      │                                     │
│  │  - PostgreSQL         │                                     │
│  └──────────────────────┘                                     │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

## Usuarios del Dashboard

- **Jorge (Jefe de Coaches)**: Supervisión del equipo. Controla la salud global de la cartera, asigna clientes y garantiza que los coaches cumplan los estándares de calidad.
- **Coach / Entrenador**: Empleado de Inazio. Gestiona su cartera asignada de clientes, revisa y personaliza los planes generados por IA, y cierra los ciclos de revisión.
- **Inazio (Brand Owner)**: No usa el dashboard. Es el propietario del negocio y la imagen de marca hacia los clientes.

## Los Clientes No Saben que no es Inazio

El modelo funciona bajo la premisa de que los clientes perciben que es Inazio quien les lleva personalmente. El dashboard debe reforzar esta operativa: los coaches trabajan con la máxima calidad y eficiencia posible para que el servicio sea consistente con la promesa de marca.

## Estado Actual del Producto

**Versión**: Production-ready con features avanzados en iteración continua.

**Módulos en producción**:
- Sistema de autenticación JWT
- Gestión de cartera de clientes (activos, pausados, cancelados)
- Dietas V1 y V2 (con ingredientes estructurados y sustituciones automáticas)
- Rutinas V1 y V2 (con biblioteca de ejercicios y videos)
- Sistema de revisiones quincenales (ciclos de 14 días)
- Sistema de notas con etiquetado
- Gestión de contenido (recetas, guías)
- Dashboard de feedback

**En desarrollo**:
- Rondas/Circuits para rutinas V2 (spec completo, implementación pendiente)
- Dashboard de estadísticas de equipo
