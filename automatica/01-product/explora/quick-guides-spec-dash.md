# SPEC PRODUCTO — Dashboard · Guias rapidas (Vídeos por categorías)

## 1) Objetivo
Crear en el dashboard una sección para **gestionar vídeos tipo “Guias rapidas”** grabados por Inazio, organizados por **categorías**.

- Cada **categoría** corresponde a una “card” en el grid de la app. https://www.figma.com/design/629ryw0MF7hzDxIFiZJ5Un/App-Automatica?node-id=1740-38560&t=LJ78vMkpqVgFidpx-1
- Cada **vídeo** pertenece a **una categoría**.

---

## 2) Navegación (Dashboard)
**Sidebar**
- Contenido
  - Recetas
  - **Guias rapidas**

**Rutas**
- `/dashboard/guias-rapidas` → módulo Guias rapidas con 2 tabs: Categorías / Vídeos

quick guides = guias rapidas


---

## 3) Entidades (modelo conceptual)

### 3.1 Categoría (QuickGuideCategory)
Una categoría representa una card del grid.

**Campos**
- **Nombre** (ej: “Nutrición”)
- **Imagen de portada** (obligatoria)  
- (Opcional) **Descripción corta** (1–2 líneas)
- **Orden** (para controlar el orden del grid)
- **Estado**: Borrador / Publicada / Oculta (o Archivada)

### 3.2 Vídeo (QuickGuideVideo)
Vídeo individual dentro de una categoría.

**Campos**
- **Categoría** (obligatoria)
- **Título** (obligatorio)
- (Opcional) Descripción breve
- **Video URL** (obligatorio) — link a archivo subido en Firebase
- **Thumbnail**
- **Orden** (para controlar orden dentro de SU categoría)
- **Estado**: Borrador / Publicado / Oculto (o Archivado)

---

## 4) Estructura del módulo (2 tabs principales)
El módulo Guias rapidas se compone de **2 tabs**:
- **Tab 1: Categorías** (tabla de categorías)
- **Tab 2: Vídeos** (tabla de vídeos global, cada uno asociado a una categoría)


---

## 5) Tab 1 — Listado de Categorías (tabla)

### 5.1 Tabla (columnas)
- Portada (thumbnail)
- Nombre
- # vídeos (contador, opcional)
- Estado
- Orden
- Última edición
- Acciones: **Editar**

### 5.2 Acciones clave
- **Crear categoría** (botón primario)
- Reordenar categorías (de visualizacion dentro de la app): input numérico “Orden”

---

## 6) Tab 2 — Listado de Vídeos (tabla global)

### 6.1 Tabla (columnas)
- Thumbnail
- Título
- **Categoría** (nombre de la categoría)
- Estado
- Orden (orden dentro de la categoría)
- Link (Video URL)
- Última edición
- Acciones: **Editar** 

### 6.2 Acciones clave
- **Añadir vídeo** (botón primario)
- Reordenar vídeos:
  - input Orden 

### 6.3 Filtros / búsqueda
- Buscar por título
- Filtro por **Categoría** (dropdown)

---

## 7) Modo edición (patrón del dashboard)
**Requisito UI:** la edición de records se hace en un **panel/modal lateral derecho**, como en:
`https://dashboard.dev.apps.elmetodoapp.com/entreno-v2/ejercicios`

- La tabla/listado se mantiene visible a la izquierda
- El editor se abre a la derecha
- Botones de acción arriba (header fijo)

---

## 8) Modal/Panel 1 — Crear/Editar Categoría (lateral derecho)

### 8.1 Layout
**Header fijo**
- “Nueva categoría” / “Editar categoría”
- Badge estado
- Botones: **Guardar** · **Publicar** (y cerrar/cancelar)

**Cuerpo (campos)**
1) **Nombre** (obligatorio)
2) **Portada** (obligatorio) — upload + preview
3) Descripción (opcional)
4) Orden

---

## 9) Modal/Panel 2 — Crear/Editar Vídeo (lateral derecho)

### 9.1 Campos (mínimos)
- **Categoría** (obligatorio) — dropdown selector
- **Título** (obligatorio)
- (Opcional) Descripción corta
- **Video URL** (obligatorio)
- Thumbnail
- Orden (dentro de la categoría)
- Estado: Borrador / Publicado
