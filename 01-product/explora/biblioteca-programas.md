# Organización de la biblioteca de programas

31.01.26

## Update del 31 de enero del 2026

Estilo editorial con contenido por secciones + filtros mínimos

---

## Filtros

### Decisión clave
Los chips se mantienen **muy simples**, pero **cada fila funciona como single-select** (tipo “radio group”):
- En una misma fila solo puede haber **1 chip activo**.
- Al seleccionar otro chip de la misma fila, el anterior **se deselecciona automáticamente**.

### Comportamiento exacto (MVP)
#### Fila 1: Lugar de entreno (single-select)
- Gimnasio / Casa / Casa con material
- Seleccionar uno → activa ese lugar y desactiva el anterior (si lo había).
- Tocar el chip activo → **resetea** la fila a “Todos” (ningún chip activo).

#### Fila 2: Acceso (single-select)
- Gratis / Programa completo
- Seleccionar uno → activa ese tipo y desactiva el anterior (si lo había).
- Tocar el chip activo → **resetea** la fila a “Todos” (ningún chip activo).

> “Todos” no se muestra como chip (estado por defecto = ninguno seleccionado).

### UX: señal de estado sin ensuciar UI
Opcional (si hace falta claridad):
- Mostrar una línea pequeña debajo del bloque de chips:
  - **“Filtros: Gimnasio · Gratis”**
  - Si no hay selección: **“Filtros: Todos”**

### Reglas de resultados
- Los filtros modifican el contenido de abajo.
- Si una sección se queda sin programas por la combinación de filtros → **la sección desaparece**.
- Si el resultado global es 0 → mostrar estado vacío con CTA **“Limpiar filtros”**.

---

## Secciones
Las secciones son los subobjetivos (agrupando los de carrera en uno)

De momento:
- Pérdida de grasa
- Ganancia muscular
- Definición extrema
- Atleta
- Salud
- Carrera (5, 10, 20, 42)
- Hyrox

Las secciones tienen scroll horizontal.

---

## Organización dentro de las secciones
- Mostramos los programas completos agrupados por días. Abajo mostramos una etiqueta de "elige los dias" Link abajo
https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=1358-34354&t=OHQlVvYpiLeBNTvN-1 
- Los programas gratis los mostramos tal cual. Los programas de fase inicial siempre serán de 3 días

---

## Interacción al tap en un programa completo
Si el usuario tapea en un programa completo le llevará a una pantalla para elegir los días que desea entrenar (3, 4 o 5).
