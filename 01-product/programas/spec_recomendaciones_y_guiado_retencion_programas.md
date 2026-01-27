# Idea Ignacio: sistema de recomendaciones + guía continua para retener y reactivar

## Objetivo
Evitar que el usuario "termine un programa y desaparezca".
La app debe **guiar activamente** al usuario hacia el siguiente programa (y, cuando toque, hacia Asesorías),
especialmente para el gran % que **no comprará asesorías por precio**.

---

## Concepto de UX / IA
No es solo "recomendaciones" tipo catálogo.
Es **guiado total**: detectar qué busca el usuario y empujarle a un siguiente paso coherente.

En la pestaña de programas:
- Sección **Recomendados para ti**
- Sección **Nuevos** (para generar novedad + curiosidad)

Ejemplos de recomendaciones por afinidad:
- Si hace **carrera** → recomendar Técnica de carrera / Hyrox / Atleta
- Si hace **recomposición / físico** → recomendar "8 weeks out verano", "vuelta al cole", etc.

---

## Señales para segmentar (qué usuario es "este")
Aunque pueda tener varios programas abiertos, identificar el "principal":
- El que más sigue (más sesiones completadas)
- Donde más registra pesos / actividad
- Donde más constancia tiene

Clasificarlo en un "grupo" (cluster) por objetivo:
- Físico / recomposición / pérdida de grasa
- Carrera / rendimiento
- Hyrox / atleta
- (etc.)

---

## Motor de retención: triggers por finalización
Regla base:
- **2 semanas antes de acabar un programa** → activar recomendación del siguiente

Rutas posibles:
- Continuación directa del mismo "tema"
- Alternativa lógica por fatiga (p.ej. tras 12 semanas de definición, recomendar recomposición o masa)
- Recomendación ajustada por **estacionalidad** (mes actual)

---

## Estacionalidad como "guía editorial"
La recomendación no solo depende del usuario, también del calendario:
- Abril/Mayo → "camino a verano"
- Junio → retos cortos intensos (p.ej. 8 semanas "a muerte")
- Julio/Agosto → programas "mantenimiento sin locuras" (3 días, flexible)
- Septiembre → "vuelta al cole" + empuje a asesorías + novedades
- Enero → retos tipo Strava (gamificación y comunidad)

Idea de retos:
- Retos con "premio" (o incentivo simbólico) + participación + subir cambios.

---

## Canales de reactivación (escala)
Escalera propuesta:
1) WhatsApp cada X tiempo (p.ej. cada 2 meses) para empujar a asesorías / siguiente paso
2) Si no quiere WhatsApp → automatización in-app/push/email:
   - Trigger por semanas antes de acabar programa
   - Recomendación de continuación / siguiente plan
   - Oferta / llamada a asesorías cuando hay suficiente confianza

---

## Implicaciones de producto (para diseñar después)
- Necesitamos una forma de:
  - detectar "programa principal"
  - saber "progreso" y "fecha estimada de finalización"
  - mapear "programa → siguientes recomendados" (por objetivo + temporada)
- UI:
  - "Recomendados para ti" + "Nuevos"
  - pantallas de "Siguiente programa sugerido" al final / antes del final
  - mensajes/CTAs que no suenen a castigo, sino a "siguiente nivel"

---
