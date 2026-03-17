# Risks & Assumptions

## Assumptions (Hipótesis de Negocio)

Estas son las hipótesis sobre las que se construye el producto. Si alguna falla, el modelo de negocio cambia significativamente.

| # | Hipótesis | Validada? | Riesgo si Falla |
|---|---|---|---|
| A1 | Los coaches son suficientemente autónomos para usar el dashboard sin supervisión constante | Parcialmente (sistema en uso con 10+ coaches) | Medio — Jorge necesitaría más herramientas de control |
| A2 | El especialista de planes genera planes de calidad suficiente para que el coach los envíe con ajustes mínimos | No validado cuantitativamente | Medio — si los planes base son malos, el coach tiene que rehacer mucho trabajo |
| A3 | Los clientes aceptan la experiencia de app móvil para enviar revisiones | Asumida | Alto — si los clientes no usan la app, el ciclo de revisiones se rompe |
| A4 | El ciclo de 14 días es el ritmo correcto para el servicio de Inazio | Asumida por dominio | Medio — podría ajustarse según el tipo de cliente |
| A5 | Los clientes no perciben (o aceptan) que no es Inazio quien les atiende directamente | Asumida | Muy Alto — si se viraliza que es un equipo, daño reputacional grave |
| A6 | 10+ coaches pueden mantener estándares de calidad consistentes bajo la marca | Asumida | Alto — inconsistencia entre coaches daña la imagen de Inazio |

---

## Riesgos por Categoría

### Riesgos de Negocio

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| **Key-person risk: Inazio** — pierde comunidad, cancelación por escándalo, lesión, burnout | Baja | Muy Alto | Diversificar canales de captación (SEO, referencias). Construir comunidad de equipo. |
| **Riesgo reputacional**: cliente descubre que no le lleva Inazio | Media | Alto | Gestión de expectativas en la venta. Lenguaje de "metodología de Inazio". |
| **Inconsistencia de calidad entre coaches** | Alta | Alto | Estándares claros, supervisión de Jorge, auditoría de planes, revisiones de calidad |
| El especialista de planes se convierte en un cuello de botella al escalar | Media | Alto | Definir cuántos planes puede crear por semana. Contratar segundo especialista si es necesario. |
| Regulación GDPR / LOPD para datos de salud | Media | Alto | Compliance antes de escalar, política de privacidad clara para clientes |
| Churn alto de coaches (empleados) | Media | Medio | El historial de clientes queda en el sistema. Onboarding rápido de nuevos coaches. |

### Riesgos de Producto

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| El especialista genera planes incorrectos o inadecuados para un cliente | Baja | Alto | El coach revisa antes de enviar. Conoce el historial del cliente. |
| El ciclo de 14 días es demasiado rígido para ciertos perfiles de cliente | Media | Medio | Considerar configuración del ciclo en el futuro |
| Coaches no distinguen bien V1/V2 | Media | Bajo | Deprecar V1 progresivamente |
| Feature de rondas tarde en llegar si los coaches la piden | Media | Medio | Spec completo, prioridad alta en backlog |
| El sistema de revisiones fake puede crear falsa sensación de cliente "activo" | Media | Bajo | Jorge debe auditar el fake rate por coach |

### Riesgos Técnicos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Desincronización entre schema.ts y API real | Alta | Alto | Automatizar regeneración en CI/CD |
| Pérdida de fotos de revisiones (almacenamiento) | Baja | Muy Alto | Backup redundante, política de retención clara |
| Token JWT expirado durante sesión larga del coach | Media | Medio | Refresh automático implementado |
| Performance degradada con coaches gestionando 100+ clientes | Baja | Medio | Paginación y lazy loading en lista de clientes |

### Riesgos de Equipo (Desarrollo)

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Bus factor en conocimiento de la API/schema | Alta | Alto | Documentar bien en CLAUDE.md y docs técnicas |
| Velocidad de desarrollo limitada si el equipo es pequeño | Alta | Medio | Priorizar backlog agresivamente |

---

## Deuda de Validación

Estas son las áreas donde el negocio necesita más evidencia:

### Validar en los próximos 90 días:
1. **Calidad de los planes del especialista**: ¿Cuántos coaches envían el plan sin tocar nada? ¿Cuántos hacen cambios mayores? ¿Hay diferencias significativas entre coaches?
2. **Calidad percibida por clientes**: NPS de clientes finales. ¿Están satisfechos con el servicio?
3. **Churn de clientes por coach**: ¿Hay coaches cuya cartera tiene más churn? ¿Por qué?
4. **Tiempo ahorrado por coach/semana**: ¿El dashboard realmente permite atender más clientes?

---

## Decisiones de Diseño con Trade-offs Conocidos

| Decisión | Razonamiento | Trade-off Aceptado |
|---|---|---|
| Ciclo de 14 días fijo | Simplicidad, consistencia, operativa escalable | Algunos clientes podrían preferir revisiones más o menos frecuentes |
| Fake reviews para avanzar ciclos | Permite al coach mantenerse al día sin bloquear el sistema | Puede crear sensación de cliente "activo" que no lo está realmente |
| Especialista crea plan base, coach ajusta | División de roles: más eficiencia, cada uno hace lo que mejor sabe | Coach puede enviar sin revisar si hay presión de tiempo |
| Schema.ts generado manualmente | Tipo-seguridad máxima en el desarrollo | Proceso manual propenso a olvidos tras cambios en la API |
| V1 y V2 coexisten | Migración gradual sin disrupciones | Complejidad adicional de mantenimiento para el equipo de desarrollo |
