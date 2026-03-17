# User Personas — El Método

4 arquetipos principales basados en la arquitectura de tiers y los flujos de la app.

---

## Persona 1 — El Explorador Casual (Zona 0-1)

**Nombre ficticio**: Marcos, 28 años
**Ocupación**: Diseñador freelance, trabaja desde casa
**Tier**: Guest / Free

### Contexto
Marcos lleva una vida sedentaria por la naturaleza de su trabajo. Descarga apps de fitness de vez en cuando pero las abandona en 2 semanas porque le parecen demasiado exigentes o requieren demasiada configuración para empezar.

### Motivaciones
- Quiere moverse más sin sentirse presionado
- Le gusta la gamificación (rankings, puntos, compararse con otros)
- Valora que la app "simplemente funcione" sin onboarding largo

### Frenos
- No quiere comprometerse económicamente antes de ver el valor
- Se frustra con los paywalls agresivos en las primeras pantallas
- No le interesa la nutrición, solo el movimiento

### Cómo usa El Método
1. Descarga la app, no se registra (usa como guest)
2. Ve el ranking y se motiva a caminar más para subir posiciones
3. Registra actividades manualmente cuando va al gym
4. Después de 3 semanas, ve el programa base y activa el trial
5. **Trigger de conversión**: Quiere terminar el programa que empezó

### Jobs to be done
- "Quiero sentir que me muevo más que mis amigos"
- "Quiero un punto de referencia de mi actividad diaria"

### KPIs asociados
- DAU / Sessions per week
- Ranking engagement (¿abre la pestaña Comunidad?)
- Trial activation rate

---

## Persona 2 — La Comprometida en Serio (Zona 2)

**Nombre ficticio**: Laura, 34 años
**Ocupación**: Profesora, madre de familia
**Tier**: Subscriber (trimestral)

### Contexto
Laura lleva meses queriendo retomar el ejercicio después del embarazo. Tiene tiempo limitado pero quiere resultados reales. Ya ha probado YouTube y no le funciona por la falta de estructura. Paga por Spotify y Netflix sin problema — valora la suscripción si siente que le da algo concreto.

### Motivaciones
- Un plan que no requiera pensar: "dime qué hacer hoy"
- Sentir progreso medible semana a semana
- Integración con sus datos de salud (ya usa HealthKit en iPhone)
- Contenido de nutrición para complementar el entrenamiento

### Frenos
- No puede permitirse ir al gym + suscripción → la app tiene que sustituir al gym
- Si el contenido se agota, cancela la suscripción
- Los primeros 7 días son críticos — si no ve progreso, cancela

### Cómo usa El Método
1. Se registra con Apple ID (un tap)
2. Activa el trial de 3 días del App Store
3. Se suscribe trimestral porque es "el más popular" y sale más barato
4. Completa el programa base en 4 semanas → pasa al programa completo
5. **Riesgo de churn**: Si termina el programa completo y no hay siguiente paso

### Jobs to be done
- "Quiero una rutina estructurada que se adapte a mi tiempo"
- "Quiero saber qué comer para que el entrenamiento sirva de algo"

### KPIs asociados
- Program completion rate
- Days active per week
- Recipe/guide views
- Renewal rate (trimestral → anual)

---

## Persona 3 — El Power User de Fitness (Zona 2 → Coached)

**Nombre ficticio**: Álvaro, 38 años
**Ocupación**: Ingeniero, entrena 5 días a la semana
**Tier**: Subscriber (anual) → candidato a Coached

### Contexto
Álvaro ya sabe lo que hace en el gym. Usa apps como Garmin, Apple Watch y Strava. La diferencia es que le falta alguien que ajuste su plan según sus resultados. Estaría dispuesto a pagar más si hay una persona real (o cuasi-persona) detrás.

### Motivaciones
- Personalización real: planes que cambien según su progresión
- Datos de salud integrados con sus wearables
- Quiere que el coach sepa qué hizo esta semana antes de darle la siguiente rutina

### Frenos
- Alta expectativa de calidad — si el contenido es genérico, no renueva
- Compara con apps más completas (Whoop, TrainingPeaks)
- Prefiere pagar anual si está seguro del valor

### Cómo usa El Método
1. Prueba con suscripción anual atraído por el precio
2. Completa programas base y completo
3. **Trigger V2**: Se ofrece upgrade a Coached con entrenador asignado
4. El coach sube rutinas personalizadas y dietas basadas en su historial

### Jobs to be done
- "Quiero que alguien analice mis datos y me diga exactamente qué hacer"
- "Quiero progresar de verdad, no solo mantenerme"

### KPIs asociados
- Program completion (multiple programs)
- Upgrade rate Subscriber → Coached
- Retention en Coached tier

---

## Persona 4 — El Coach (Stakeholder interno, V2)

**Nombre ficticio**: Carmen, 31 años
**Ocupación**: Entrenadora personal certificada
**Rol**: Coach asignado en el tier Coached

### Contexto
Carmen tiene clientes presenciales pero quiere escalar. El Método le ofrece una plataforma donde puede gestionar múltiples clientes digitalmente, subir planes y hacer seguimiento sin perder la relación personal.

### Motivaciones
- Escalar su negocio sin multiplicar su tiempo 1:1
- Herramientas para subir dietas, rutinas y seguimiento
- Ver métricas de sus clientes (pasos, sesiones completadas, adherencia)

### Frenos
- Si la herramienta de coach es difícil de usar, no adopta
- Necesita que los clientes vean el trabajo del coach (visibilidad del valor)
- Preocupación por si los clientes perciben el coaching como "automatizado"

### Cómo interactúa con El Método
1. Accede a un panel de coach (web o admin)
2. Sube dietas y rutinas personalizadas para cada cliente
3. Ve el progreso de cada cliente en la app
4. Clientes ven "Coach: Carmen" con foto en su app

### Jobs to be done
- "Quiero gestionar 20 clientes digitales con el mismo esfuerzo que 5 presenciales"
- "Quiero que mis clientes vean el valor de tener un coach real detrás"

### KPIs asociados (V2)
- Coach retention rate
- Clients per coach
- Client-to-coach ratio
- NPS de usuarios Coached

---

## Mapa de personas por tier

```
ZONA 0 (Guest)     → Marcos (explorador, sin fricción)
ZONA 1 (Trial)     → Marcos activando su primer programa
ZONA 2 (Subscriber)→ Laura (comprometida), Álvaro (power user)
COACHED (V2)       → Álvaro upgrade + Carmen como coach
```

---

## Tabla comparativa

| Atributo | Marcos (Guest) | Laura (Sub) | Álvaro (Power) | Carmen (Coach) |
|----------|---------------|-------------|----------------|----------------|
| Edad | 28 | 34 | 38 | 31 |
| Dispositivo | Android | iPhone | Apple Watch | Mix |
| Willingness to pay | Bajo | Medio | Alto | N/A (B2B) |
| Engagement esperado | 3-4 días/sem | 5 días/sem | 6 días/sem | Semanal (gestión) |
| Churn risk | Alto | Medio | Bajo | Bajo (si le escala) |
| Acquisition channel | Organic / Boca a boca | App Store / RRSS | Directo / Referral | Outreach directo |
