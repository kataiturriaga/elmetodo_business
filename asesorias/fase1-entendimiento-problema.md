# FASE 1 — Entendimiento del Problema

> Esta fase ocurre **antes de abrir Figma en modo diseño**. Su único objetivo es que el equipo tenga claridad sobre qué están construyendo, para quién, y por qué — antes de invertir tiempo en cualquier pantalla.

---

## 01 — PROBLEM STATEMENT

### ¿Qué problema estamos resolviendo?

**Qué busca definir**
El problema central en 1-2 oraciones que cualquier persona del equipo pueda entender. Responde cuatro preguntas a la vez: ¿quién tiene el problema?, ¿cuál es exactamente?, ¿por qué importa resolverlo ahora?, ¿cómo sabremos que lo resolvimos?

**Por qué importa**
Sin problem statement claro, cada persona del equipo resuelve un problema diferente sin saberlo. El diseñador diseña para una cosa, el dev construye otra, el coach espera una tercera. Es el norte que hace coherentes todas las decisiones posteriores.

Regla: si no podés escribirlo en dos oraciones, todavía no lo entendés bien.

**Para tu rol**

- 🎨 Diseñadora → lo usás para justificar cada decisión de UI. Cuando alguien diga "agreguemos esto", volvés al problem statement para evaluar si suma o distrae.
- 📋 PM → es tu escudo contra el scope creep. Prioriza lo que resuelve el problema definido, rechaza lo que no.
- ⭐ Para crecer → aprendé a escribirlo sola, sin que nadie te lo dicte. Ese salto — de recibir instrucciones a definir el problema — es el que separa un rol ejecutor de uno estratégico.

**Framework / Plantilla**

> *"El usuario [tipo] necesita [necesidad] porque [razón], pero hoy [problema actual], lo que genera [consecuencia negativa]."*

**En este proyecto — Asesorías V2**

  
**Problem statement (cerrado):**

> "El coached paga un precio premium por tener estructura y acompañamiento real en su entrenamiento y alimentación, pero la app V1 es tan deficiente en UX que no cumple esa promesa — el coach sigue en WhatsApp (intencionalmente, por la cercanía humana) sin una app que le dé soporte estructural al coached —, lo que genera abandono antes de los 90 días y una percepción de que el servicio no vale lo que cuesta."

**Notas de contexto:**

- WhatsApp = canal humano intencional. La app V2 no lo reemplaza, lo complementa.
- Scope diferencial vs Automatica: entrenamiento + dieta + funciones en definición (ej. lista de compra).
- El coach opera desde el dashboard. La app es la experiencia exclusiva del coached.

---

## 02 — ¿PARA QUIÉN?

### Perfil del usuario — proto-persona

**Qué busca definir**
Quién es la persona concreta que va a usar la app. No un promedio estadístico — una persona con contexto de vida real, motivaciones reales y frustraciones específicas. La proto-persona es una herramienta para tomar decisiones: cuando tenés dudas de diseño, le hacés la pregunta al personaje.

**Por qué importa**
Si diseñás para "todos", diseñás para nadie. Las decisiones se vuelven defensibles cuando podés decir "este usuario necesita esto porque está en esta situación". Sin usuario definido, las discusiones del equipo son debates de opinión sin resolución.

También es la base de los JTBDs (sección siguiente): no podés saber qué trabajo contrata el usuario si no sabés quién es.

**Para tu rol**

- 🎨 Diseñadora → la proto-persona te da el contexto de uso. "¿Esta pantalla tiene demasiada info?" depende de si tu usuario está en el gym con las manos sucias o sentado en casa tranquila.
- 📋 PM → los PMs piensan en segmentos, los diseñadores en personas. Saber hacer ambas cosas te hace más valiosa en cualquier equipo.
- ⭐ Para crecer → una proto-persona honesta incluye frustraciones reales, no solo datos de marketing. Las frustraciones son las que generan oportunidades de diseño.

**Cómo construirla**
No necesitás research exhaustivo. Usá lo que ya sabés + hipótesis marcadas como tal. Una proto-persona imperfecta es infinitamente mejor que ninguna.

**Proto-persona — Usuario Coached, Asesorías V2**


| Dimensión           | Contenido                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------- |
| Quién               | Persona 25-40 años, activa, con ingresos para pagar asesoría. Quiere resultados pero no sabe estructurarse sola |
| Contexto            | Va al gym o entrena en casa. Tiempo limitado. Ya intentó con contenido genérico sin resultado                   |
| Motivación profunda | No compra contenido — compra acompañamiento y accountability                                                    |
| Frustración hoy     | Lo gestiona todo por WhatsApp. No tiene estructura. Duda de si lo que hace es correcto                          |
| Comportamiento      | Revisa el teléfono antes de entrenar. Necesita saber QUÉ hacer hoy, no elegir entre opciones                    |
| Expectativa         | Sentir que el coach la ve y ajusta su plan. No quiere contenido enlatado con su nombre                          |


---

## 03 — JOBS-TO-BE-DONE

### ¿Qué trabajo le contrata el usuario al producto?

**Qué busca definir**
Los JTBDs no son features ni funcionalidades — son necesidades funcionales, emocionales y sociales. La diferencia es crucial: "ver mi plan de entreno" es una feature; "saber exactamente qué hacer hoy sin tener que pensar" es un JTBD.

**Por qué importa**
"La gente no compra un taladro, compra un agujero en la pared." Los JTBDs sobreviven a los pivots de producto. Si mañana cambiás la tecnología o el formato, los jobs del usuario siguen siendo los mismos. Diseñar para el job te protege de construir cosas que nadie usa.

**Para tu rol**

- 🎨 Diseñadora → cada JTBD principal se traduce en una pantalla o flujo central. 3 JTBDs críticos = al menos 3 pantallas principales. El JTBD define QUÉ; el diseño define CÓMO.
- 📋 PM → los JTBDs te dicen qué priorizar en el roadmap. "Construimos esto primero porque resuelve el job más frecuente y de mayor valor."
- ⭐ Para crecer → aprendé a distinguir JTBDs funcionales (hacer algo) de los emocionales (sentir algo). Los emocionales son los que generan retención real.

**Framework**

> *"Cuando [situación concreta], quiero [motivación], para [resultado esperado]."*
>
> Tipos: Funcional · Emocional · Social

**JTBDs — Asesorías V2 (priorizados)**


| Prioridad     | JTBD                                                                                                                               |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| 🔴 Crítico    | Saber qué hacer hoy: *"Cuando abro la app antes de entrenar, quiero ver mi plan del día, para no tener que pensar ni preguntar"*   |
| 🔴 Crítico    | Sentir acompañamiento: *"Cuando termino un entreno, quiero que el coach sepa cómo fue, para saber que alguien me sigue de verdad"* |
| 🟡 Importante | Trackear progreso: *"Cuando llevo semanas entrenando, quiero ver cómo evoluciono, para saber si mi inversión vale la pena"*        |
| 🟡 Importante | Recibir ajustes: *"Cuando algo no funciona, quiero que el coach adapte mi plan, para no perder tiempo con algo que no sirve"*      |
| 🟢 Secundario | Comunicación directa con el coach cuando surge una duda puntual                                                                    |
| 🟢 Secundario | Registrar métricas (peso, fotos) para que el coach tenga datos reales                                                              |


---

## 04 — CONTEXTO DE NEGOCIO

### ¿Qué necesita el negocio de este producto?

**Qué busca definir**
Los objetivos del negocio que el producto debe cumplir, las restricciones que no podés ignorar, las métricas de éxito, y los stakeholders cuya aprobación importa. El diseño no existe en el vacío.

**Por qué importa**
Un diseño brillante que ignora las restricciones del negocio no sirve. Si el pago es externo y no hay IAP, no podés proponer un checkout dentro de la app. Si el coach es el canal de adquisición principal, la app tiene que hacerle la vida más fácil al coach — no solo al usuario.

Esto diferencia al diseñador/PM junior del senior: el junior propone lo ideal, el senior propone lo posible dentro de las restricciones reales.

**Para tu rol**

- 🎨 Diseñadora → el contexto te protege de proponer soluciones imposibles o que contradigan la estrategia.
- 📋 PM → sos responsable de que el producto cumpla los objetivos de negocio. Definís las métricas antes de empezar a construir.
- ⭐ Para crecer → acostumbrate a preguntar "¿cuál es la métrica de éxito de esto?" en cada decisión. Esa pregunta sola te diferencia.

**Nota crítica — Stakeholder olvidado**
El usuario final es el coached. Pero el stakeholder más crítico para el negocio es el **coach**: si la app no le ahorra tiempo o le complica la vida, no la recomendará a sus clientes. Diseñar solo para el coached sin considerar la experiencia del coach es un error estratégico.

**Contexto — Asesorías V2**


| Dimensión           | Detalle                                                                 |
| ------------------- | ----------------------------------------------------------------------- |
| Objetivo            | Tier coached con mayor retención a 30/60/90 días que free y suscripción |
| Restricción dura    | Pago externo, sin IAP. La app no gestiona cobros                        |
| Métrica principal   | Retención del coached. Secundaria: NPS                                  |
| Stakeholder crítico | Los coaches — si no les ahorra trabajo, no recomendarán                 |
| Restricción técnica | Una sola app para 3 tiers, shell diferente en runtime                   |
| Estado actual       | Cero pantallas V2 implementadas                                         |


---

## 05 — SUPOSICIONES Y RIESGOS

### ¿Qué asumimos como verdadero sin haberlo validado?

**Qué busca definir**
Todo lo que el equipo asume como verdadero pero no ha verificado. Se ordenan por dos ejes: impacto si estamos equivocados, y certeza que tenemos. Las más peligrosas: alto impacto + baja certeza.

**Por qué importa**
Las suposiciones no identificadas se convierten en bugs de producto. Mejor descubrirlas en papel que después de meses de desarrollo. La diferencia entre un diseñador/PM bueno y uno mediocre es la capacidad de nombrar las propias suposiciones antes de que fallen.

**Para tu rol**

- 🎨 Diseñadora → las suposiciones de UX se validan con prototipos y tests de usabilidad. Sin código.
- 📋 PM → las suposiciones de negocio se validan con entrevistas y datos.
- ⭐ Para crecer → antes de diseñar cualquier pantalla, preguntate: *"¿Qué tendría que ser verdad para que esto funcione?"*

**Cómo priorizarlas**

```
Impacto ALTO + Certeza BAJA  → validar antes de construir cualquier cosa
Impacto ALTO + Certeza ALTA  → son hechos, documentar
Impacto BAJO + Certeza BAJA  → monitorear, no bloquear
Impacto BAJO + Certeza ALTA  → ignorar
```

**Suposiciones — Asesorías V2**


| Riesgo   | Suposición                                                         |
| -------- | ------------------------------------------------------------------ |
| 🔴 Alto  | El coach quiere y puede gestionar clientes desde la app            |
| 🔴 Alto  | El usuario llega con expectativas alineadas a lo que la app ofrece |
| 🟡 Medio | La comunicación coach-usuario puede ser asíncrona (no tiempo real) |
| 🟡 Medio | El coach genera el plan manualmente y lo carga en el sistema       |
| 🟢 Bajo  | El usuario tiene smartphone moderno y conexión estable             |
| 🟢 Bajo  | El usuario tiene experiencia previa en fitness                     |


---

## 06 — PREGUNTAS A RESOLVER ANTES DE FASE 2

### ¿Qué debe estar claro antes de wireframear?

**Qué busca definir**
Las preguntas que DEBEN tener respuesta antes de empezar la arquitectura de información. Esta lista define cuándo estás lista para avanzar. Es tu *Definition of Ready*.

**Por qué importa**
Una pregunta sin respuesta en Fase 1 se convierte en retrabajo en Fase 3, 4 o 5. El patrón más costoso en producto: diseñar pantallas hermosas para un flujo que hay que tirar porque nadie preguntó algo básico al principio.

**Para tu rol**

- 🎨 Diseñadora → te protegen de diseñar el flujo equivocado.
- 📋 PM → sos responsable de conseguir las respuestas: hablar con el coach, tech, usuarios piloto.
- ⭐ Para crecer → aprendé a distinguir qué podés asumir provisionalmente y qué bloquea el diseño. No todas las preguntas son bloqueantes.

**Preguntas — Asesorías V2**


| Urgencia      | Pregunta                                                                               |
| ------------- | -------------------------------------------------------------------------------------- |
| 🚫 Bloqueante | ¿El coach gestiona clientes en esta app o tiene dashboard separado?                    |
| 🚫 Bloqueante | ¿Cómo se comunica el usuario con el coach? ¿Chat, notas asíncronas, WhatsApp externo?  |
| 🚫 Bloqueante | ¿Qué pasa si el usuario activa el tier coached pero todavía no tiene plan asignado?    |
| ❓ Importante  | ¿Quién genera el plan — el coach manualmente o el sistema automáticamente?             |
| ❓ Importante  | ¿Hay check-ins periódicos? ¿Con qué frecuencia, quién los inicia, qué formato tienen?  |
| ❓ Importante  | ¿El usuario coached puede ver su historial de V1 si ya era usuario antes del upgrade?  |
| 💡 A explorar | ¿Qué métricas registra el usuario? ¿Peso, fotos, RPE? ¿Obligatorio u opcional?         |
| 💡 A explorar | ¿Las notificaciones del tier coached son diferentes a las de V1? ¿Quién las configura? |


---

## 07 — ENCUESTA DE USUARIO

### Validar hipótesis con datos reales antes de diseñar

**Cuándo hacerla**
Después de completar las secciones 02 a 06 — no antes. Las secciones anteriores definen exactamente qué no sabés y qué necesitás validar. Si mandás la encuesta sin haberlas hecho, no sabés qué preguntar y terminás con datos que no podés usar.

```
02 Proto-persona     → genera hipótesis sobre quién es el usuario
03 JTBDs             → genera hipótesis sobre qué necesita
05 Suposiciones      → lista lo que no sabés
06 Preguntas         → lista lo que necesitás saber
         ↓
07 ENCUESTA          ← cada pregunta resuelve una suposición o cierra una pregunta abierta
         ↓
   Analizar resultados → actualizar proto-persona y JTBDs → cerrar checklist → pasar a Fase 2
```

**Por qué importa**
La encuesta convierte hipótesis en datos. Sin ella, la proto-persona y los JTBDs son suposiciones propias del equipo — con ella, son decisiones respaldadas por usuarios reales. Es especialmente crítica en este proyecto porque el usuario coached todavía no existe en volumen: hay que entender al usuario actual (free/suscripción) y su disposición a pagar por coaching.

**Para tu rol**

- 🎨 Diseñadora → los resultados ajustan la proto-persona y pueden cambiar qué pantallas son prioritarias.
- 📋 PM → los resultados validan (o invalidan) las suposiciones de negocio antes de comprometer recursos de desarrollo.
- ⭐ Para crecer → aprendé a diseñar encuestas con intención. Cada pregunta debe tener un objetivo claro: "si la respuesta es X, entonces tomamos la decisión Y".

**Cómo diseñarla bien**


| Criterio              | Guía                                                                                 |
| --------------------- | ------------------------------------------------------------------------------------ |
| Longitud              | Máximo 8-10 preguntas — más de eso, la gente abandona                                |
| Tipos de pregunta     | 2-3 abiertas (cualitativas) + el resto cerradas (cuantitativas)                      |
| Orden                 | Empezar con preguntas fáciles y contextuales, las más sensibles al final             |
| Objetivo por pregunta | Cada pregunta debe resolver UNA suposición o pregunta de las secciones 05/06         |
| A quién mandar        | Usuarios de distintos tiers si es posible: free, suscripción y coached si ya existen |


**Preguntas sugeridas — Asesorías V2**


| #   | Pregunta                                                                                                | Qué valida                                  |
| --- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| 1   | ¿Con qué frecuencia usás la app actualmente? (escala)                                                   | Comportamiento base del usuario             |
| 2   | ¿En qué momento del día la usás más? ¿Antes, durante o después de entrenar?                             | Contexto de uso → decisiones de UI          |
| 3   | ¿Qué es lo que más te cuesta cuando entrenás sin un coach? (abierta)                                    | JTBDs y frustraciones reales                |
| 4   | ¿Alguna vez has tenido o considerado contratar un coach personal? ¿Por qué sí o no?                     | Disposición al tier coached                 |
| 5   | Si tuvieras un coach asignado en la app, ¿qué esperarías ver cuando la abrís por primera vez? (abierta) | Expectativas del onboarding                 |
| 6   | ¿Qué tan importante es para vos poder comunicarte con el coach dentro de la app? (escala 1-5)           | Valida suposición de comunicación asíncrona |
| 7   | ¿Qué información sobre tu progreso querrías que el coach pueda ver?                                     | Métricas a registrar                        |
| 8   | ¿Qué te haría sentir que el coach realmente te está siguiendo? (abierta)                                | JTBD emocional — sentir acompañamiento      |


**Cómo analizar los resultados**

1. Buscar patrones en las respuestas abiertas — agrupar por tema
2. Para cada suposición de la sección 05: ¿los datos la confirman o la refutan?
3. Para cada pregunta de la sección 06: ¿tenés ahora una respuesta?
4. Actualizar la proto-persona con lo que aprendiste
5. Ajustar la priorización de JTBDs si alguno cambió
6. Documentar qué suposiciones siguen abiertas y decidir si bloquean el avance a Fase 2

---

## Checklist de salida — ¿Cuándo paso a Fase 2?

- Problem statement escrito en 1-2 oraciones y validado con el equipo
- Proto-persona definida con motivaciones y frustraciones reales
- JTBDs priorizados — top 3 críticos identificados
- Contexto de negocio documentado: objetivo, restricciones, métricas
- Suposiciones ordenadas por riesgo
- Preguntas bloqueantes resueltas (las 3 marcadas como 🚫)
- Encuesta enviada, resultados analizados y proto-persona actualizada

