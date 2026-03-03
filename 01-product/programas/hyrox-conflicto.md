# Conflictos (ordenados)

## 1) Modelo de datos / Dashboard (estructura del entreno)
- En programas tipo Hyrox, las **rondas viven dentro de un bloque** (Calentamiento → Rondas → Enfriamiento).
- Pero ahora mismo el **dashboard + modelo de datos** solo permite definir **rondas a nivel rutina completa**, no **a nivel bloque**.
- **Resultado:** no podemos representar bien “solo este bloque tiene rondas” y se fuerza una estructura artificial.

---

## 2) Experiencia en app (flujo y comportamiento real del usuario)
- Las pantallas están diseñadas para **ejercicios secuenciales** con lógica de: entrar en ejercicio → registrar → descanso → siguiente.
- En Hyrox / Metabólico / AMRAP / “for time”, los ejercicios se hacen **encadenados** y el objetivo es **mínimo tiempo** o **máximas reps**.
- **Resultado:** usar el móvil durante el circuito **penaliza la marca**, así que el flujo actual choca con el uso real.

---

## 3) Métricas y “resúmenes” (qué mostramos en Home)
- Los resúmenes de Home devuelven data de **ejercicios individuales**.
- En este tipo de rutinas, lo útil es mostrar **marca de ronda/bloque** (tiempo total, rondas completadas, etc.), no el detalle por ejercicio.
- **Resultado:** aunque el usuario entrene bien, la app **no refleja lo importante** en el resumen.

---

## 4) Infraestructura de medición (funcionalidad faltante)
- No existe un **timer de sesión** (o de bloque) como tal.
- **Resultado:** no podemos soportar bien “for time / time cap / AMRAP” sin un workaround, y sin timer es difícil dar una “marca” coherente.
