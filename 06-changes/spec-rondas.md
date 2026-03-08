# Spec: Rondas dentro de Bloque (Rutinas v2)

> **Estado:** Pendiente de desarrollo
> **Afecta:** Backend (API) + Dashboard (frontend)
> **Prototipo visual:** `http://localhost:3000/prototype`

---

## Contexto

En el sistema actual de rutinas (v2), un día de entrenamiento puede contener:

- **Ejercicios** individuales
- **Supersets** (2 ejercicios de fuerza combinados, con registro por ejercicio)
- **Bloques** (agrupación de ejercicios y/o supersets bajo un nombre, con descanso compartido)

Se quiere añadir un nuevo tipo de elemento dentro de un **Bloque**: las **Rondas**.

---

## Qué son las Rondas

Una **Ronda** es un circuito de 2 o más ejercicios (pueden ser de fuerza, metabólicos o mixtos) que se ejecutan de forma encadenada sin parar entre ellos. El descanso ocurre entre rondas completas, no entre ejercicios.

### Diferencia clave con la Superserie

| | Superserie | Rondas |
|---|---|---|
| Número de ejercicios | Siempre 2 | 2 o más |
| Tipo de ejercicios | Fuerza | Mixto (fuerza + metabólico) |
| Descanso | Entre series | Entre rondas completas |
| Registro | Por ejercicio y serie | Al completar la ronda |
| Modalidades | Una sola | 4 modalidades distintas |

---

## Jerarquía de objetos

```
Día de entrenamiento
└── Bloque
    ├── Ejercicio (existente)
    ├── Superserie (existente)
    └── Rondas (NUEVO) ← lo que se añade
        └── Ejercicio (dentro de la ronda)
```

**Restricción importante:** Las Rondas **siempre** están dentro de un Bloque. No pueden existir a nivel de día de entrenamiento directamente.

---

## Modalidades de Rondas

Las Rondas tienen 4 modalidades. El coach elige una al crear la ronda.

### 1. Rondas Fijas
El circuito se repite un número fijo de veces con descanso entre rondas.

**Parámetros:**
- Número de rondas (entero, ej: 3)
- Descanso entre rondas (segundos, ej: 60)

**Ejemplo:** "3 rondas · 60 seg de descanso entre rondas"

---

### 2. AMRAP *(As Many Rounds As Possible)*
El usuario repite el circuito tantas veces como pueda dentro de un tiempo límite.

**Parámetros:**
- Tiempo límite (minutos, ej: 15)

**Ejemplo:** "AMRAP 15 min"

---

### 3. For Time
El usuario completa un número fijo de rondas lo más rápido posible. El tiempo es el registro.

**Parámetros:**
- Número de rondas (entero, ej: 5)

**Ejemplo:** "5 rondas · lo más rápido posible"

---

### 4. EMOM *(Every Minute On the Minute)*
El usuario empieza una nueva ronda cada X minutos, independientemente de cuándo termine la anterior.

**Parámetros:**
- Número de rondas (entero, ej: 8)
- Intervalo (minutos, ej: 3 → "cada 3 minutos")

**Ejemplo:** "8 rondas · cada 3 minutos"

---

## Ejercicios dentro de una Ronda

Cada ejercicio de una ronda tiene los mismos campos que un ejercicio normal:

- Categoría
- Nombre del ejercicio
- Repeticiones / Distancia / Tiempo (texto libre)
- Notas opcionales

**Diferencia con ejercicios fuera de ronda:** No tienen campo de "series" propio — la serie equivale a la ronda completa.

---

## Cambios en la interfaz del Dashboard

### Nuevo botón en el Bloque
En el pie de cada BloqueCard, junto a los botones "Ejercicio" y "Superserie", se añade:

> **+ Rondas** *(botón con estilo naranja)*

### Nueva tarjeta: RondaCard
Identificada visualmente con color **naranja** (`border-orange-200 bg-orange-50`), para distinguirse de:
- Bloque → verde esmeralda
- Superserie → azul
- Ejercicio → gris/blanco

**Contenido de la tarjeta:**
1. Cabecera con icono, label "Rondas", número de orden, y botón eliminar
2. Selector de modalidad (pestañas: Rondas fijas / AMRAP / For Time / EMOM)
3. Parámetros según modalidad (campos de número/tiempo)
4. Descripción breve de la modalidad (texto de ayuda)
5. Lista de ejercicios del circuito
6. Botón "+ Añadir ejercicio" dentro de la ronda

### Reordenación
Las Rondas deben poder reordenarse dentro del Bloque con drag & drop, igual que los ejercicios y supersets existentes.

---

## Cambios necesarios en el Backend (API)

### 1. Nuevo modelo: `RondaV2`

```
RondaV2:
  - id
  - bloque_id          ← referencia al bloque padre (obligatorio)
  - position           ← para ordenar dentro del bloque
  - mode               ← "rounds" | "amrap" | "for_time" | "emom"
  - rounds             ← número de rondas (null si AMRAP)
  - rest_time          ← segundos de descanso (solo para "rounds")
  - time_limit         ← minutos (solo para "amrap")
  - interval           ← minutos entre rondas (solo para "emom")
  - note               ← texto libre opcional
  - exercises[]        ← lista de ejercicios de la ronda
```

### 2. Nuevos endpoints necesarios

| Acción | Endpoint sugerido |
|---|---|
| Crear ronda | `POST /bloques/{bloque_id}/rondas/` |
| Actualizar ronda | `PATCH /rondas/{ronda_id}/` |
| Eliminar ronda | `DELETE /rondas/{ronda_id}/` |
| Añadir ejercicio a ronda | `POST /rondas/{ronda_id}/exercises/` |
| Reordenar items del bloque | Extender endpoint existente de reorden de bloque para incluir rondas |

### 3. Cambios en `BloqueV2Response`
El bloque debe devolver también sus rondas al cargarse:

```
BloqueV2Response:
  - ...campos actuales...
  - rondas: RondaV2[]   ← NUEVO
```

### 4. Cambios en el reorden de items del Bloque
El endpoint de reordenación de items de un bloque debe aceptar también items de tipo `ronda`, no solo `exercise` y `superset`.

---

## Validaciones importantes

- Una Ronda **no puede existir fuera de un Bloque**
- `mode` es obligatorio
- Si `mode = "amrap"` → `time_limit` es obligatorio, `rounds` puede ser null
- Si `mode = "rounds"` → `rounds` y `rest_time` son obligatorios
- Si `mode = "for_time"` → `rounds` es obligatorio
- Si `mode = "emom"` → `rounds` e `interval` son obligatorios
- Una Ronda debe tener al menos 1 ejercicio para poder guardarse (recomendado: al menos 2)

---

## Ejemplo real de uso (programa Hyrox)

```
Día 1 — Fuerza + Conditioning

└── Bloque: FUERZA
    └── Rondas (Rondas fijas · 3 rondas · 90 seg descanso)
        ├── Zancadas con barra — 10 reps
        ├── Zancadas con saco — 20m (@Peso de la prueba)
        └── Press militar con mancuernas sentado — 12 reps

└── Bloque: CONDITIONING
    └── Rondas (AMRAP · 15 min)
        ├── Ski Erg — 250m
        ├── Burpee over hurdle — 5 reps
        └── Sled push — 25m
```

---

## Resumen de prioridades para el dev

1. **Backend primero:** crear modelo `RondaV2`, endpoints CRUD, y actualizar `BloqueV2Response`
2. **Regenerar tipos TypeScript** en el dashboard tras los cambios de API (`npm run types:generate`)
3. **Frontend:** añadir `RondaCard` en `TrainingDayEditor.tsx`, botón "+ Rondas" en `BloqueCard`, y servicios en `routine-v2-services.ts`
4. **Reorden:** incluir rondas en el sistema de drag & drop del bloque
