# Pantalla principal de dieta — Ideación y definición

**Estado:** En definición
**Fecha:** Abril 2026

---

## Contexto del problema

El 58% de los usuarios consulta la dieta antes de cada comida. La pantalla debe ser accesible y legible de un vistazo — es un flujo de consulta rápida, no de exploración.

El usuario tiene que tomar **dos decisiones** para llegar a la información que necesita:

- **Nivel 1:** ¿Qué comida es? (hasta 5 comidas por día)
- **Nivel 2:** ¿Qué opción elijo? (3 opciones por comida)

Hoy esas dos decisiones ocurren en pantallas separadas. Ese es el problema de fondo.

---

## Datos conocidos

| Frecuencia de uso | % usuarios |
|---|---|
| Antes de cada comida (3–5x/día) | 58% |
| Una vez al día | 35% |
| Una vez a la semana | 30% |

> Nota: los porcentajes pueden superponerse — un usuario puede consultar antes de comer Y también planear por la mañana.

---

## Soluciones evaluadas

### Solución 1 — Todo en una pantalla, mismo nivel de accesibilidad

Mostrar comidas y opciones en la pantalla principal, con navegación fluida entre ambas dimensiones al mismo tiempo.

**A favor:** No hay pantallas secundarias. El usuario puede moverse entre comidas y opciones sin cambiar de contexto.

**En contra:** Es difícil encontrar un patrón de diseño que sea legible con esa densidad de información y que sea usable en mobile.

---

### Solución 2 — Todo en una pantalla, comida como panel secundario

La opción (qué van a comer) es el protagonista. El número de comida pasa a un panel secundario, y se resuelve con contexto temporal: la app detecta la hora y muestra la comida que toca.

**A favor:** Reduce la primera decisión casi a cero si el sistema ya sabe qué comida es.

**En contra:**
- Si la configuración es por usuario y por día → 5 comidas × 7 días = 35 configuraciones. Demasiado.
- Pierde flexibilidad (el usuario no siempre come a la misma hora).

**Variante:** Usar horarios globales preestablecidos para todos los clientes, sin configuración individual. Simplifica mucho pero sacrifica personalización.

---

### Solución 3 — Dos pantallas (solución actual)

Pantalla 1: elige el número de comida. Pantalla 2: elige la opción.

**En contra:** Dos taps, dos momentos de orientación. Pierde inmediatez para el caso de uso principal.

---

## Tensión clave entre perfiles

Los dos segmentos principales tienen necesidades que parecen compatibles:

- **58% (antes de comer)** → necesita ver la comida actual + sus opciones, ya.
- **35% (una vez al día)** → necesita ver todas las comidas del día de un vistazo.

Ambas necesidades podrían resolverse con el mismo diseño si se prioriza bien la jerarquía visual: comida actual como protagonista, resto del día visible pero secundario.

---

## Perfiles de usuario

> ⚠️ **Estos perfiles son hipótesis.** Solo tenemos dato de frecuencia de apertura — el contexto, motivación y momento de uso son inferidos, no validados.

---

**Perfil 1 — La consultora frecuente**
*58% de usuarios*

Abre la app entre 3 y 5 veces al día, justo antes de cada comida. No recuerda qué toca — abre, mira, elige y cierra. El tiempo entre abrir la app y tomar una decisión debe ser mínimo. No explora, no planea: ejecuta.

- **Momento de uso:** Segundos antes de preparar o pedir la comida
- **Necesita ver:** La comida que toca ahora + las 3 opciones disponibles
- **Frustración actual:** Dos pantallas para llegar a la información que necesita

*Hipótesis alternativa: podría abrir, mirar y luego comer algo diferente de todos modos — en ese caso el problema no es velocidad sino relevancia o adherencia.*

---

**Perfil 2 — La planificadora diaria**
*35% de usuarios*

Abre la app una vez al día, normalmente a la mañana. Quiere tener el día claro: saber qué va a comer en cada momento, organizarse mentalmente y en algunos casos preparar cosas con anticipación.

- **Momento de uso:** Mañana, antes de salir o al despertarse
- **Necesita ver:** Todas las comidas del día de un vistazo, con sus opciones
- **Frustración actual:** Tiene que navegar comida por comida para ver el día completo

*Hipótesis alternativa: podría abrir a mediodía para ver qué queda del día, no necesariamente a la mañana.*

---

**Perfil 3 — La planificadora semanal**
*30% de usuarios*

Abre la app una vez a la semana, normalmente a principios de semana. Usa el menú para hacer la compra y organizarse. Una vez que lo tiene claro, no vuelve hasta la semana siguiente.

- **Momento de uso:** Inicio de semana, en casa con tiempo
- **Necesita ver:** El menú completo de la semana
- **Frustración actual:** La app no está diseñada para este modo — tiene que ir pantalla por pantalla

*Hipótesis alternativa: podría ser un usuario con baja adherencia que abre por obligación o culpa, no por planificación activa. Diseñar para planificador vs. diseñar para usuario pasivo son cosas distintas.*

---

## Decisión sobre el 30% semanal

No diseñar la pantalla principal para este perfil. Su comportamiento es demasiado diferente al resto. Si se quiere cubrir, una funcionalidad secundaria (vista semanal, compartir menú) resuelve su caso sin comprometer el diseño principal.

---

## Próximos pasos

- [ ] Validar hipótesis de perfiles — hablar con 3–4 clientes informalmente antes de que los perfiles se conviertan en verdad de diseño
- [ ] Decidir entre Solución 1 y 2 como dirección principal
- [ ] Explorar patrones de diseño para Solución 1 (el reto más difícil)
- [ ] Definir si horarios globales preestablecidos son viables para Solución 2
