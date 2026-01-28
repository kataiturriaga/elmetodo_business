# Spec — Estructura de pantallas y contenido (MVP)
> Alcance: decisión de IA/navegación y ubicación de contenido para evitar “pantallas de relleno” y soportar crecimiento del catálogo e historial.

## 1) Cuestión inicial (contexto + problema)
Planteamiento inicial de una pantalla **Explora** pensada para ofrecer:
- **Recetas**
- **Biblioteca de ejercicios** (para hacer ejercicios sueltos)

Ahora se cuestiona **mantener Explora** por:
1) **Duda de valor real de recetas**:
   - Riesgo de que el usuario no las use.
   - Para que se perciban valiosas se requeriría un nivel alto de calidad/precisión (curación, estructura, consistencia), con coste y tiempo que no tenemos en MVP.
2) **Poco margen para desarrollar buen contenido en Explora**:
   - Riesgo alto de que se perciba como “cajón desastre” / pantalla de relleno.
3) Paralelamente, hay una necesidad funcional clara: una pantalla **Programas** que cubra dos secciones críticas:
- **Historial de programas**:
  - Con el tiempo puede hacerse **muy extenso**.
- **Catálogo de programas**:
  - Ya es **grande** desde el inicio y puede crecer.
4) **Número de pantallas (tabs)**:
   - Si añadimos una pantalla nueva para **Programas**, podríamos irnos a 5 tabs → riesgo de demasiada complejidad en un producto de adquisición masiva.


Además, existe contenido adicional ya planeado:
- **Guías rápidas** (vídeos cortos de Ignacio + texto) que originalmente se planteaban para Explora.

**Pregunta a resolver:**
> ¿Qué estructura de tabs/pantallas nos permite cubrir (1) Catálogo + Historial (crecientes) y (2) Guías rápidas y biblioteca de ejercicios, evitando (3) Explora como cajón desastre y (4) un exceso de tabs?

## 2) Posibles soluciones

### Solución A — Eliminar “Explora” y crear pestaña “Programas” como hub (RECOMENDADA)
**Idea:**
- Se elimina la pestaña **Explora**.
- Se crea la pestaña **Programas** como hub principal para:
  - Catálogo (grande y escalable)
  - Historial (escalable)
  - Contenido “Guías rápidas” como biblioteca
- La **biblioteca de ejercicios** se integra como acceso secundario (no como pestaña principal).
- **Recetas** se posponen fuera del MVP (o se reducen a algo mínimo no-promesado como “ideas rápidas” dentro de las guias rapidas, si se considera necesario).

**Estructura sugerida de tabs (4 tabs):**
- Home
- Entreno
- Ranking
- Programas (hub)

**Programas (hub) — Vistas internas recomendadas (segmented control / tabs internas):**
1) **En curso** (programas activos + recomendado/siguiente)
2) **Historial** (lista + búsqueda + filtros básicos)
3) **Catálogo** (módulos “Recomendado / Nuevos” + búsqueda + filtros)
4) **Guías rápidas** (biblioteca de consejos)

**Biblioteca de ejercicios (dónde vive):**
- Acceso desde **Entreno** (CTA “Ejercicios sueltos” / “Biblioteca”)  
  y/o dentro de **Programas** como sección secundaria (“Herramientas”).

**Guías rápidas (dónde vive y cómo se descubre):**
- Biblioteca principal en **Programas > Guías rápidas**
- Distribución contextual:
  - Home: “Consejo del día” + CTA “Ver todas”
  - Entreno: 2–3 guías sugeridas según momento (por ejemplo: adherencia/constancia)

**Pros:**
- Evita pantalla de relleno (Explora).
- Mantiene 4 tabs (menos fricción, más claridad).
- “Programas” escala bien con catálogo e historial (search/filtros).
- Guías rápidas se convierten en herramienta de adherencia (retención), no contenido suelto.

**Contras / Riesgos:**
- Requiere diseñar bien “Programas” para que no se perciba denso (mitigar con módulos guiados arriba + search).

---

### Solución B — Mantener “Explora” y añadir “Programas” (5 tabs)
**Idea:**
- Explora se queda (recetas + ejercicios + guías rápidas).
- Se añade pestaña Programas (historial + catálogo).

**Pros:**
- Separación conceptual clara (contenido vs. programas).

**Contras / Riesgos:**
- 5 tabs puede ser demasiado en MVP y aumentar confusión.
- Explora tiende a convertirse en “cajón desastre”.
- Recetas en MVP tienen riesgo alto de percibirse “genéricas” y bajar confianza.

---

### Solución C — Mantener “Explora” sin recetas y añadir “Programas”
**Idea:**
- Explora deja de tener recetas y se convierte en “Recursos” de entreno: Guías rápidas + Biblioteca de ejercicios.
- Programas contiene historial + catálogo.

**Pros:**
- Explora deja de ser “todo vale” y gana coherencia.
- Las guías rápidas tienen un lugar propio.

**Contras / Riesgos:**
- Sigue siendo 5 tabs
- Si el contenido no se impulsa contextualmente, puede infrautilizarse.
- “Ejercicios sueltos” como pestaña principal sigue siendo discutible en MVP (más helper que destino).

---

### Solución D — Integrar “Guías rápidas” y “Ejercicios” dentro de “Entreno”; y “Programas” solo para catálogo + historial
**Idea:**
- Se elimina Explora.
- Guías rápidas y biblioteca ejercicios viven dentro de Entreno (Recursos/Ayuda).
- Programas queda “puro”: catálogo + historial.

**Pros:**
- 4 tabs, navegación simple.
- Contenido más contextual al momento de entrenar.

**Contras / Riesgos:**
- Entreno puede ensuciarse si se carga de secciones.
- Las guías rápidas podrían sentirse escondidas si no hay entry points en Home.

---

### Solución E — Mantener “Explora” solo como “Guías rápidas” (sin recetas ni ejercicios) y usar “Programas” como hub
**Idea:**
- Explora se convierte en “Consejos/Guías”.
- Programas cubre catálogo + historial.

**Pros:**
- Guías rápidas muy accesibles.

**Contras / Riesgos:**
- 5 tabs o una pestaña extra dedicada a contenido puede ser demasiado.
- Puede percibirse como redundante si las guías también aparecen en Home/Entreno.

---

## 3) Recomendación para MVP
Adoptar **Solución A**:
- **Eliminar Explora** como pestaña.
- Crear **Programas** como hub escalable que contiene:
  - En curso / Historial / Catálogo (+ search/filtros)
  - Guías rápidas como biblioteca
- Biblioteca de ejercicios como acceso secundario (Entreno y/o Programas).
- **Recetas fuera del MVP** (evita promesa débil y riesgo de baja percepción de valor).

---
