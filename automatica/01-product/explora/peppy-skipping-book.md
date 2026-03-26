# Spec: Pantalla Dashboard — Gestión de Alimentos Saciantes

## Contexto

Nueva sección en la app móvil (Explora → "Crea tu propia dieta") que muestra una lista de alimentos con alto poder saciante. El equipo de contenido necesita una pantalla en el dashboard para crear y editar estos alimentos sin tocar código.

El dashboard ya existe en Next.js 15 + shadcn/ui + Tailwind. Esta pantalla sigue el mismo patrón que la sección de Recetas (`/contenido/recetas`).

---

## Rutas

```
/contenido/alimentos-saciantes              → lista de todos los alimentos
/contenido/alimentos-saciantes/new          → crear nuevo alimento
/contenido/alimentos-saciantes/[id]/edit    → editar alimento existente
```

---

## Pantalla: Formulario de creación / edición

Esta es la pantalla principal para subir y editar la información de un alimento.

---

### SECCIÓN 1 — Información básica

| Campo | Componente | Validación |
|-------|-----------|-----------|
| **Nombre** | `Input` text | Obligatorio. Máx. 80 caracteres. Ej: "Pollo a la plancha" |
| **Categoría** | `Select` | Obligatorio. Opciones: Proteínas / Verduras / Legumbres / Cereales / Grasas sanas |
| **Nivel de saciedad** | `Select` | Obligatorio. Opciones: Muy alta / Alta / Media |
| **Estado** | `Select` o `Switch` | Obligatorio. Opciones: Borrador / Publicado. Default: Borrador |
| **Orden de display** | `Input` número | Opcional. Entero positivo. Si vacío → se añade al final de la lista |

---

### SECCIÓN 2 — Imagen principal

| Campo | Componente | Validación |
|-------|-----------|-----------|
| **Imagen** | `input type="file"` + preview | Obligatorio. Formatos: JPG, PNG. Mín. 800×600px. Máx. 5MB |

**Comportamiento:**
- Muestra área de drag & drop o botón "Subir imagen"
- Al seleccionar archivo: muestra preview inmediata (antes de guardar)
- Si ya hay imagen guardada: muestra la actual con botón "Cambiar imagen"
- La imagen se sube al guardar el formulario (o en el mismo momento si se quiere UX más fluida)

---

### SECCIÓN 3 — Contenido editorial

| Campo | Componente | Validación |
|-------|-----------|-----------|
| **Razón breve** | `Input` text + contador | Obligatorio. Máx. 60 caracteres. Aparece como chip en la lista de la app: `"Alta proteína · Bajo IG"` |
| **¿Por qué sacia?** | `Textarea` + contador | Obligatorio. Máx. 400 caracteres. Aparece en la pantalla de detalle del alimento |

**Nota para el redactor:**
- La *razón breve* debe ser concisa: máx. 2 atributos separados por `·`
- El texto de *¿por qué sacia?* debe mencionar el mecanismo fisiológico (proteínas que activan hormonas, fibra que ralentiza digestión, etc.)

---

### SECCIÓN 4 — Valores nutricionales por 100g

Tres campos numéricos en la misma fila:

| Campo | Componente | Validación |
|-------|-----------|-----------|
| **Proteína (g)** | `Input` número decimal | Obligatorio. Paso: 0.1. Ej: `31.0` |
| **Fibra (g)** | `Input` número decimal | Obligatorio. Paso: 0.1. Ej: `2.5` |
| **Calorías (kcal)** | `Input` número entero | Obligatorio. Ej: `165` |

---

### SECCIÓN 5 — Recetas asociadas

Permite vincular recetas existentes que contienen este alimento. Estas recetas se muestran en la pantalla de detalle del alimento en la app (sección "Recetas con este alimento").

**Componente:** autocomplete con multi-selección (patrón idéntico al selector de tags de recetas).

**Flujo:**
1. El admin escribe en un campo de búsqueda
2. Se muestran resultados en tiempo real buscando sobre `/api/dashboard/recipes?search={query}`
3. El admin hace clic en una receta para añadirla
4. Las recetas seleccionadas aparecen como pills con botón ×
5. Se pueden eliminar en cualquier momento antes de guardar

**Datos que muestra cada resultado en el dropdown:**
- Miniatura de imagen
- Nombre de la receta
- Tipo de comida (Desayuno / Comida / Cena / Snack)
- Tiempo total (ej: "25 min")

**Datos que muestra cada pill seleccionado:**
- Nombre de la receta
- Tipo de comida
- Botón × para eliminar

Este campo es **opcional** — un alimento puede guardarse sin recetas asociadas.

---

### Footer del formulario

```
[Cancelar]          [Guardar borrador]          [Publicar]
```

| Botón | Comportamiento |
|-------|---------------|
| **Cancelar** | Navega de vuelta a la lista sin guardar. Si hay cambios sin guardar, muestra confirmación |
| **Guardar borrador** | Guarda con estado `draft`. No valida campos opcionales. El alimento NO es visible en la app |
| **Publicar** | Valida todos los campos obligatorios. Guarda con estado `published`. El alimento es visible en la app inmediatamente |

---

## Pantalla: Lista de alimentos

Pantalla de gestión rápida. Sirve de punto de entrada a la creación/edición.

```
Alimentos Saciantes                               [+ Nuevo alimento]

[🔍 Buscar por nombre]   [Categoría ▾]   [Estado ▾]

┌────────────────────────────────────────────────────────────────────┐
│  Imagen │ Nombre               │ Categoría  │ Saciedad │ Estado    │ Acciones │
│─────────┼──────────────────────┼────────────┼──────────┼───────────┼──────────│
│  [img]  │ Pollo a la plancha   │ Proteínas  │ Alta     │ Publicado │ [Editar] [⋮] │
│  [img]  │ Brócoli              │ Verduras   │ Media    │ Borrador  │ [Editar] [⋮] │
└────────────────────────────────────────────────────────────────────┘

Mostrando 1–25 de 47    [Anterior]  1  2  [Siguiente]
```

**Acciones del menú ⋮:**
- Editar → va al formulario de edición
- Cambiar estado → toggle Borrador ↔ Publicado sin abrir el formulario
- Eliminar → modal de confirmación antes de borrar

**Filtros:**
- Búsqueda: filtra por nombre en tiempo real
- Categoría: filtro por enum de categoría
- Estado: Todos / Publicado / Borrador

---

## Modelo de datos

Campos que el backend debe persistir por alimento:

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | int | Auto-generado |
| `name` | string | Nombre del alimento |
| `category` | enum | `proteins` / `vegetables` / `legumes` / `cereals` / `healthy_fats` |
| `satiety_level` | enum | `very_high` / `high` / `medium` |
| `status` | enum | `draft` / `published` |
| `display_order` | int? | Posición en la lista (null = al final) |
| `hero_image_url` | string? | URL de la imagen subida |
| `short_reason` | string | Chip de la lista: "Alta proteína · Bajo IG" |
| `why_it_satiates` | string | Texto del detalle |
| `protein_g` | decimal | Proteína por 100g |
| `fiber_g` | decimal | Fibra por 100g |
| `calories_kcal` | int | Calorías por 100g |
| `associated_recipe_ids` | int[] | IDs de recetas vinculadas |

---

## Endpoints API necesarios

```
# Dashboard (admin)
GET    /api/dashboard/satiating-foods                    lista paginada con filtros
GET    /api/dashboard/satiating-foods/{id}               detalle para formulario de edición
POST   /api/dashboard/satiating-foods                    crear nuevo
PUT    /api/dashboard/satiating-foods/{id}               actualizar existente
DELETE /api/dashboard/satiating-foods/{id}               eliminar
POST   /api/dashboard/satiating-foods/{id}/image         subir imagen (multipart)
PATCH  /api/dashboard/satiating-foods/{id}/status        cambiar estado desde la lista

# Mobile (app)
GET    /mobile/satiating-foods                           lista pública (solo published)
GET    /mobile/satiating-foods/{id}                      detalle + recetas asociadas
```

---

## Preguntas abiertas para el equipo

Antes de implementar, confirmar:

1. **¿Favoritos?** — ¿Los usuarios de la app podrán marcar alimentos como favoritos (igual que las recetas)?
2. **¿Relación bidireccional con recetas?** — Si se vincula una receta desde aquí, ¿aparece algo en el detalle de esa receta en la app?
3. **¿Campo de contenido en agua?** — Para alimentos que sacian por hidratación (pepino, sandía). ¿Se añade `water_pct` como cuarto macro?
4. **¿Orden manual o automático?** — ¿El `display_order` lo gestiona el admin manualmente, o se ordena por otro criterio (nivel de saciedad, categoría)?
