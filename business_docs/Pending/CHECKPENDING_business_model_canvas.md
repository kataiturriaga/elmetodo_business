# Business Model Canvas — El Método

---

## Canvas

```
┌─────────────────────┬──────────────────────┬──────────────────────┬─────────────────────┐
│  KEY PARTNERS       │  KEY ACTIVITIES      │  VALUE PROPOSITION   │  CUSTOMER REL.      │
│                     │                      │                      │                     │
│  • Apple (App Store │  • Desarrollo de     │  GUEST/FREE:         │  • Self-service      │
│    + StoreKit 2)    │    producto mobile   │  "Empieza sin        │    (onboarding       │
│  • Google (Play     │  • Producción de     │    fricción. Mide    │    automatizado)     │
│    Store + Health   │    programas de      │    tus pasos y       │                     │
│    Connect)         │    entrenamiento     │    compite."         │  • Community         │
│  • Apple HealthKit  │  • Creación de       │                      │    (ranking global,  │
│  • Firebase         │    contenido         │  SUBSCRIBER:         │    grupos de edad)   │
│    (analytics,      │    (recetas, guías)  │  "Un plan que        │                     │
│    crashlytics,     │  • Gestión de        │    evoluciona        │  • Push notifs       │
│    remote config)   │    coaches (V2)      │    contigo."         │    (Firebase FCM)    │
│  • FastAPI/Backend  │  • Marketing y       │                      │                     │
│  • Coaches          │    adquisición       │  COACHED (V2):       │  • In-app feedback   │
│    (V2, externos)   │  • Customer support  │  "Tu entrenador      │  • Email (onboarding │
│                     │                      │    personal en el    │    + churn recovery) │
│                     │                      │    bolsillo."        │                     │
├─────────────────────┤                      ├──────────────────────┼─────────────────────┤
│  KEY RESOURCES      │                      │  CHANNELS            │  CUSTOMER SEGMENTS  │
│                     │                      │                      │                     │
│  • App mobile       │                      │  • App Store (iOS)   │  SEG 1: Activos      │
│    (Flutter)        │                      │  • Google Play       │  ocasionales         │
│  • Backend API      │                      │    (Android)         │  18-45 años, quieren │
│  • Design system    │                      │  • Organic ASO       │  moverse más         │
│    (Figma/EMP DS)   │                      │  • Social media      │  sin compromiso      │
│  • Analytics infra  │                      │    (Instagram,       │                     │
│    (Firebase GA4)   │                      │    TikTok)           │  SEG 2: Comprometidos│
│  • Catálogo de      │                      │  • Referral/boca     │  Quieren resultados  │
│    programas y      │                      │    a boca            │  medibles con un     │
│    contenido        │                      │  • App Store         │  plan estructurado   │
│  • Red de coaches   │                      │    features/editorials│                     │
│    (V2)             │                      │                      │  SEG 3: Coached      │
│                     │                      │                      │  Quieren guía        │
│                     │                      │                      │  personalizada de    │
│                     │                      │                      │  un experto          │
├─────────────────────┴──────────────────────┴──────────────────────┴─────────────────────┤
│  COST STRUCTURE                                │  REVENUE STREAMS                        │
│                                                │                                         │
│  • Desarrollo móvil (salarios/freelancers)     │  • Suscripción mensual: €14.99/mes      │
│  • Infraestructura backend (hosting, DB)       │  • Suscripción trimestral: €89.99/3m    │
│  • Firebase (analytics, push, remote config)   │    (≈€29.99/mes efectivo, -35%)         │
│  • Apple Developer Program: $99/año           │  • Suscripción anual: €89.99/año        │
│  • Google Play Developer: $25 única vez        │    (≈€7.49/mes efectivo, -50%)          │
│  • Producción de contenido (programas,         │                                         │
│    recetas, guías)                             │  FUTURO:                                │
│  • Comisiones de tienda: 15-30%                │  • Tier Coached (precio por definir)    │
│  • Marketing y adquisición de usuarios         │  • Venta de programas one-time          │
│  • Gestión y formación de coaches (V2)         │  • Partnerships con marcas de fitness   │
└────────────────────────────────────────────────┴─────────────────────────────────────────┘
```

---

## Propuesta de valor detallada por tier

### Tier Free (Zonas 0-1)
- **Quién**: Cualquier persona con móvil
- **Qué**: Pedómetro + registro manual de actividades + ranking social
- **Por qué**: Construye hábito de movimiento sin fricción. El usuario no pierde nada al probar.
- **Retención**: Competencia en el ranking motiva volver cada día.
- **Conversión**: El trial de 14 días de programas base es el gancho hacia Zona 2.

### Tier Subscriber (Zona 2)
- **Quién**: Usuario que quiere resultados con estructura
- **Qué**: Programas de 4-12 semanas + recetas + guías de bienestar + calculadora calórica
- **Por qué**: La progresión guiada (Base → Completo) da sensación de avance real.
- **Retención**: El programa activo es un "contrato" con el usuario. Cancelar = perder el progreso.
- **Churn prevention**: Re-activación de programa completado como feature para no perder el hábito.

### Tier Coached (V2 — en desarrollo)
- **Quién**: Usuario dispuesto a pagar premium por atención personalizada
- **Qué**: Coach asignado que sube dietas y rutinas específicas. Navegación V2 distinta.
- **Por qué**: Máxima personalización. Similar a tener PT pero en el móvil.
- **Revenue**: Pricing premium sobre el tier subscriber.

---

## Estructura de comisiones de tienda

| Plataforma | Comisión estándar | Comisión small developer |
|------------|-------------------|--------------------------|
| App Store (Apple) | 30% | 15% (si revenue < $1M/año) |
| Google Play | 30% | 15% (primeros €1M/año) |

> **Implicación**: El pricing debe considerar el neto después de comisión. €14.99/mes → ~€12.74/mes neto (15%) o ~€10.49/mes neto (30%).

---

## Ventaja competitiva sostenible

| Factor | El Método | Competidores genéricos |
|--------|-----------|----------------------|
| Integración salud nativa | HealthKit + Health Connect real-time | Solo lectura o manual |
| Guest auth sin fricción | Empieza sin registro, datos persistentes | Requieren registro para cualquier dato |
| Tier coaching integrado | Misma app para todos los tiers | App separada o web |
| Mercado hispanohablante | Contenido en español nativo | Traducción de inglés |
| Modelo de datos consolidado | Un endpoint `/home`, respuesta rápida | Múltiples llamadas, latencia alta |
