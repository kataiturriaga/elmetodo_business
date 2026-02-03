# Cuestiones a resolver

## Monetización: ¿se lanza con venta o no?

Ahora que no hay fecha fija, hay 2 caminos:

Decisión:

- Plan A: lanzar ya con monetización activa (trial + suscripción)

- Plan B: lanzar sin monetización y activarla después (soft launch)

    5 El punto clave que tu spec no resuelve: “no te vendemos nada aún”
    Ahora que el sorteo ya no tiene fecha fija, podéis decidir esto con calma. Pero tu spec actual vende premium desde el dropdown en cualquier momento.
    Si queréis mantener la promesa de “no vendemos nada al principio” sin liaros, añade una regla simple:
    Regla recomendada: upsell solo a partir de semana 3
    Semanas 1–2: dropdown “Programa completo” muestra info/preview + “Disponible más adelante”
    CTA: “Seguir con Fase inicial”
    Semana 3: ahí sí, modal upsell con trial 3 días (como ya tienes)
    Semana 4: countdown fuerte
    Día 28: bloqueo total si no paga
    Esto encaja perfecto con lo que Inazio quería (urgencia) y con tu idea de fricción progresiva (no vender minuto 0).
    Output: una frase: “en lanzamiento, monetización = ON/OFF” + fecha/condición de activación si es OFF.

## Flujo de entrada entreno

Plan A: Mostrarle solo los programas iniciales
    PROS: decision rapida, bajo riesgo> no tiene que meter tarjeta
    CONS: pierde atractivo para los usuarios mas experimientados: parace que solo tiene programas iniciales

Plan B: Mostrarle las dos opciones (iniciales + completos)
    PROS: hay mas variedad de inicio
    CONS: mas opciones, decision mas lenta. Dificil de simplicar el tema de: con los programas gratuitos tienes 4 semanas gratis (sin meter tarjeta), con los programas avanzados metes tarjeta y te dan 3 dias gratis. Ademas hay que resolver el tema de dejarle tambien ir por la via de programa inicial. flujos de momento muy complejos de entrada