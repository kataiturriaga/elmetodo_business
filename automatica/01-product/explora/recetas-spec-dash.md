# SPEC PRODUCTO — Dashboard · Sección “Recetas” (CMS)

## 1) Objetivo
Crear una sección en el dashboard para **crear, editar, organizar y publicar recetas** que luego consumirá la app.

---

## 2) Navegación
**Sidebar**
- Contenido
  - Recetas

**Rutas**
- `/dashboard/recipes` → listado
- `/dashboard/recipes/new` → crear
- `/dashboard/recipes/:id/edit` → editar

---

## 3) Pantalla 1 — Listado de recetas

### 3.1 Tabla (columnas)
- **Imagen** (thumbnail)
- **Nombre**
- **Meal type**: Desayuno / Comida / Cena / Snack
- **Picante** (sí/no, icono 🌶️)
- **Tags** (máx 2 visibles + “+X”)
- **Estado**: Borrador / Publicada / Archivada
- **Última edición**
- **Acciones**: Editar · Duplicar · Archivar (menú ⋯)

### 3.2 Acciones clave
- **Crear receta** (botón primario)
- **Duplicar** (crea copia en borrador)
- **Archivar** (la saca de la app, no la borra)

### 3.3 Filtros / búsqueda
- **Buscar** por nombre
- **Filtrar** por:
  - Meal type (Desayuno/Comida/Cena/Snack)
  - Picante sí/no

---

## 4) Pantalla 2 — Crear / Editar receta

### 4.1 Layout
**Header fijo**
- “Nueva receta” / “Editar receta”
- Badge estado: Borrador / Publicada / Archivada
- Botones: **Guardar** · **Publicar** · **Archivar**

**Cuerpo por secciones (scroll)**
1. Identidad  
2. Clasificación  
3. Modos (Ligero, Normal, Bestia)  
4. Ingredientes (por modo)  
5. Nutrición (por modo)  
6. Tags  
7. Receta (pasos) (no dependiente del modo)

---

## 5) Campos (contenido editable)

### 5.1 Identidad (obligatorio para publicar)
- **Nombre de receta**
- **Imagen hero** (upload)
- (Opcional) Subtítulo / frase corta

### 5.2 Clasificación (obligatorio para publicar)
- **Meal type** (single select): Desayuno / Comida / Cena / Snack
- **Picante** (toggle)
- (Opcional) Tiempo total (min)
- (Opcional) Dificultad

---

## 6) Modos + edición por modo (núcleo)

### 6.1 Concepto
- Los modos (**Ligero / Normal / Bestia**) son **variantes de la receta**.
- Cada variante puede tener **ingredientes y cantidades distintas** y, por coherencia, **información nutricional distinta**.
- **Normal** es el modo base y **siempre existe**.

### 6.2 UI — Selector de modos (chips)
Sección “Modos”:
- Chips toggle: **Ligero · Normal · Bestia**
- **Normal** fijo/activo.
- **Ligero/Bestia** activables.

**Al activar un modo**
- Se crea la variante **clonando desde Normal** (para no empezar de cero).

**Al desactivar un modo**
- Confirm modal: “¿Eliminar variante de este modo?”
- Acciones: **Eliminar variante** / **Cancelar**

---

## 7) Ingredientes (por modo) — Editor

### 7.1 Requisitos
- El bloque **Ingredientes** debe ser **dependiente del modo** seleccionado.

**Formato por ingrediente**
- Nombre (texto)
- Cantidad (número) + Unidad (selector): `g | ml | u | cucharada | cucharadita | al gusto`
- Notas (opcional): “opcional”, “para la crema”, etc.
    - Poder añadir notas despues del nombre

**Acciones**
- Añadir ingrediente
- Eliminar ingrediente
- Reordenar (drag)
- Duplicar ingrediente (opcional)

---

## 8) Nutrición (por modo)

### 8.1 Nutrición editable por modo
Motivo: si cambian ingredientes, cambian macros (evita incoherencias).

**Por cada modo activo, campos por 1 porción**
- Kcal
- Proteínas (g)
- Hidratos (g)
- Grasas (g)

**Secundarios**
- Azúcares (g)
- Fibra (g)
- Saturadas (g)
- Sal (g)

**Reglas UX**
- Si un secundario está vacío → no se muestra luego (no forzar 0)


---

## 9) Tags (obligatorio mínimo 1)
- Selector tipo **dropdown + añadir** (como el que tenemos en Programas)

---

## 10) Receta / Pasos (obligatorio para publicar)
**Editor por bloques**
- Bloque = `{ título opcional + texto }`
- Soporta bullets dentro

**Acciones**
- Añadir bloque
- Reordenar
- Duplicar
- Eliminar

**Regla**
- Los pasos son **comunes a todos los modos**
- No se añadirán cantidades en pasos

---

## 11) Estados
- **Borrador**: editable, no sale en app
- **Publicada**: visible en app
- **Archivada**: no visible en app, pero se conserva
