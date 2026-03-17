# Go-to-Market Strategy — El Método

Framework de adquisición, activación, retención y expansión (AARE).

---

## Posicionamiento de mercado

### Quiénes somos (para el mercado)
> El Método es la app de fitness en español para personas que quieren resultados reales con un plan estructurado — sin complicaciones, sin excusas.

### Diferenciación competitiva

| Vs. | Su posición | La nuestra |
|-----|------------|------------|
| **Freeletics / Nike Training** | Grandes catálogos, inglés-first | Mercado hispano, coaching personalizado |
| **MyFitnessPal** | Nutrición dominante | Entrenamiento + nutrición integrado |
| **Peloton** | Hardware + content | Solo software, sin hardware |
| **Apps de PT locales** | 1:1, cara, no escalable | Coach + app, escalable, precio accesible |

### Propuesta única de valor
1. **Sin fricción**: Empiezas sin registro. Tus datos no desaparecen.
2. **Progresión real**: De programa base a programa completo a coaching personalizado.
3. **Mercado hispano**: Contenido en español nativo. No traducido.
4. **Integración salud**: HealthKit + Health Connect reales, no solo conteo manual.

---

## Fase 1: Pre-launch (ya ejecutado)

- [x] MVP funcional en producción (V1 completa)
- [x] Fastlane CI/CD para distribución rápida
- [x] Firebase Analytics configurado
- [x] App Store + Google Play listings
- [x] Design system consistente (EMP DS)

---

## Fase 2: Launch & Early Growth

### Target audience inicial
**Primario**: Mujeres y hombres hispanohablantes, 25-40 años, con iPhone o Android, que han probado alguna app de fitness antes pero no la mantienen.

**Secundario**: Entrenadores personales que quieren una plataforma digital para sus clientes.

### Canales de adquisición

#### Canal 1: Orgánico / ASO (App Store Optimization)
**Objetivo**: Aparecer en búsquedas relevantes en España y Latinoamérica.

| Keyword target | Competencia | Volumen |
|---------------|-------------|---------|
| "app entreno español" | Media | Alto |
| "rutinas en casa" | Alta | Muy alto |
| "pedómetro pasos" | Alta | Alto |
| "plan de entrenamiento" | Alta | Alto |
| "app fitness español" | Media | Alto |

**Acciones**:
- Screenshots con resultados reales (antes/después de programa)
- Preview video mostrando el flujo completo (descarga → primer entreno)
- Reseñas activas: pedir review a usuarios con D30 retention >70%
- Ratings proactivos: in-app prompt después de completar primera sesión

#### Canal 2: Content Marketing / RRSS
**Objetivo**: Construir comunidad antes de pagar por adquisición.

| Plataforma | Formato | Frecuencia | Objetivo |
|-----------|---------|------------|---------|
| **Instagram** | Reels de ejercicios, transformaciones | 4-5/semana | Brand awareness |
| **TikTok** | Tips fitness 30-60 seg, antes/después | Diario | Viralidad + jóvenes |
| **YouTube** | Vídeos de programa completo (5-15min) | 1-2/semana | SEO + trust |
| **Pinterest** | Recetas, planes de entrenamiento | 3/semana | Nutrición + Explore |

**Contenido de alto rendimiento histórico en fitness**:
- "Prueba este ejercicio 30 días" (accountability challenge)
- "Lo que nadie te dice del [ejercicio popular]" (educación)
- "De 0 a [resultado] en 4 semanas" (transformación con programa)

#### Canal 3: Influencers / Micro-influencers
**Objetivo**: Credibilidad + installs con CTR > orgánico.

| Tier | Seguidores | Costo estimado | ROI esperado |
|------|-----------|----------------|-------------|
| Nano (UGC) | 1K-10K | Gratuito / producto | Alto (muy niche) |
| Micro | 10K-100K | €200-500/post | Medio-alto |
| Mid | 100K-500K | €500-2K/post | Medio |
| Macro | >500K | €2K-10K/post | Bajo (awareness) |

**Estrategia recomendada**: Empezar con 20 nano-influencers en España + LATAM. Código de descuento personalizado para tracking.

#### Canal 4: Paid Media (cuando tengamos unit economics validados)
> **No escalar hasta tener**: Trial CVR >20% + D30 retention >15% + LTV/CAC >3x

| Canal | Formato | Targeting |
|-------|---------|-----------|
| Meta Ads (Instagram/Facebook) | Video 15-30s | Lookalike de suscriptores + intereses fitness |
| TikTok Ads | Spark Ads (amplificar UGC) | 18-35 años, interés fitness, ES/LATAM |
| Google UAC | App install campaigns | Keywords fitness español |
| Apple Search Ads | Search + Browse | Competidores + keywords fitness |

---

## Fase 3: Activation (D0–D7)

### Estrategia de activación por canal

**Objetivo**: Llevar al usuario del install al "aha moment" lo antes posible.

#### D0: Primer uso
1. **Splash rápido** (<400ms) → confianza desde el primer segundo
2. **No pedir registro** → mostrar Home con pedómetro activo inmediatamente
3. **Permiso de salud con contexto** → pantalla explicativa antes de pedir el permiso
4. **Ranking visible** → motivación social inmediata

#### D0-D1: Push de bienvenida
- 2h después del install: "¡Bienvenido a El Método! Tus primeros pasos ya están contados."
- CTA: Abrir app y ver posición en ranking

#### D2-D3: Descubrimiento del training
- Push: "¿Sabías que puedes acceder a un programa de entrenamiento gratis?"
- CTA: Abrir catálogo de programas

#### D5-D7: Invitación al trial
- Push: "Activa tu programa base. Es gratis los primeros 14 días."
- CTA: Activar trial directamente

---

## Fase 4: Retention (D7–D90)

### Estrategia de retención por segmento

#### Usuarios en Trial (D0-D14 del trial)
| Día | Acción | Canal |
|-----|--------|-------|
| Trial D1 | "¡Completaste tu primer día! Llevas 1/28." | Push |
| Trial D3 | Progreso visual (barra de programa) | In-app |
| Trial D7 | "A mitad de tu trial. ¿Cómo va?" | Push |
| Trial D10 | In-app banner: "Solo 4 días de prueba" | In-app |
| Trial D12 | "2 días para no perder tu progreso" | Push + email |
| Trial D14 | Paywall con progreso guardado | In-app |

#### Suscriptores activos (semana 1-4)
| Señal | Acción |
|-------|--------|
| Sin sesión en 3 días | Push: "Solo 15 min hoy. Tu programa te espera." |
| Completa semana 1 | Push: "¡Semana 1 completada! Tu cuerpo ya nota el cambio." |
| Completa programa base | In-app: Celebración + CTA para programa completo |

#### Suscriptores en riesgo (sin actividad 7+ días)
| Día sin actividad | Acción |
|------------------|--------|
| 5 días | Push suave: "Tu progreso te espera" |
| 7 días | Email: "¿Todo bien? Tu programa sigue aquí" |
| 14 días | Email con oferta de "reactivación": tip gratuito de coach |
| 30 días | Win-back campaign |

---

## Fase 5: Expansion (D90+)

### Upsell de plan
**Mensual → Trimestral**: Push a D25 con comparativa de ahorro. In-app banner en Home.
**Trimestral → Anual**: Oferta tras completar un programa completo.
**Subscriber → Coached (V2)**: CTA post-completar programa completo + intro al coach.

### Referral Program (backlog)
- Compartir logros en RRSS con invitación ("Conseguí X con El Método — descárgala")
- Código de invitación: "Un mes gratis si tu amigo se suscribe"
- Meta: 15-20% de installs desde referral

### Reviews & Ratings
- In-app rating prompt: después de completar primera sesión (D3-D7)
- Email a suscriptores de M3+ pidiendo review en tienda
- Respuesta activa a reviews negativos en App Store / Play Store

---

## Mercados prioritarios

| Mercado | Prioridad | Justificación |
|---------|-----------|---------------|
| **España** | P1 | Mercado home, idioma nativo, mayor LTV |
| **México** | P1 | Mayor mercado hispanohablante, iOS + Android |
| **Argentina** | P2 | Alto engagement fitness, IAP en USD |
| **Colombia** | P2 | Crecimiento de smartphones y fitness apps |
| **USA (hispanohablantes)** | P3 | Alta intención de pago, community fuerte |

---

## Métricas de GTM

| KPI | Objetivo Q2 2026 |
|-----|----------------|
| Installs mensuales | 10.000/mes |
| Registros | >30% de installs |
| Trials activos | >1.000 activos |
| Suscriptores | >250 pagantes |
| App Store rating | >4.5 ⭐ |
| CAC | <€20 |
| LTV/CAC | >3x |
