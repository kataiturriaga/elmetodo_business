# Spec — Pantalla “Explora” por secciones (MVP)

## Objetivo
Convertir “Explora” en un hub claro y ordenado (no “cajón desastre”), agrupando el contenido por verticales para facilitar descubrimiento, consulta y uso recurrente.

---

## Estructura de información (IA)

### Explora
La pantalla se organiza en 3 secciones principales:

#### 1) Entreno
- **Catálogo de programas**
- **Mi historial**
  - Debe listar programas **empezados** y **completados**
  - (Opcional futuro) pausados/abandonados

#### 2) Dieta
- **Platos principales (recetas)**
- **Snacks (recetas)**

#### 3) Herramientas
- **Guías rápidas**
  - Contenido de Ignacio en **vídeo**
  - Con versión en **texto** (siempre que sea posible; mínimo viable: vídeo)
- **Catálogo de ejercicios**
  - Biblioteca para consultar ejercicios y hacer entrenos sueltos

Idea 07.feb.26 > en vez de catalogo de ejercicios, entrenos sueltos de menos de 25 minutos
o entrenos sueltos y poder filtrarlos por tiempo
Publico objetivo de esta funcionalidad: hoy quiere algo rapido sin compromiso. tiene poco tiempo y quiere ejercitarse

---

## Reglas y consideraciones (MVP)

### Claridad de navegación
- “Explora” debe funcionar como espacio de **descubrimiento/consulta**, no como pantalla operativa de entreno diario.
- El contenido debe presentarse por secciones para evitar percepción de “mezcla” o relleno.

### Escalabilidad (Catálogo + Historial)
- **Catálogo de programas**: es extenso desde el inicio y puede crecer.
- **Mi historial**: puede crecer con el tiempo.
- Recomendación MVP: incluir al menos **búsqueda simple** y/o **filtros básicos** en catálogo e historial.

### Percepción de valor (Recetas)
- La sección Dieta debe cuidar la presentación para que no parezca contenido genérico.
- Recomendación MVP: pocas recetas bien presentadas > muchas recetas mediocres.

### Descubrimiento de guías rápidas
- Aunque la biblioteca viva en Explora > Herramientas, se recomienda al menos un **entry point** desde otras zonas (p.ej. “Consejo del día”) si aplica al diseño final.

---

## Notas de naming
- La pantalla operativa del entrenamiento diario se denomina **Entreno** (no “Programa”).
