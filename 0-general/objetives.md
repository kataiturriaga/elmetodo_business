# SMART Objectives 

## Definiciones
- **Activación ligera (sin registro):** el usuario completa **1 acción de valor** en la primera sesión:
  - `health_permission_granted` (conectar salud / permisos pasos) **o**
  - `ranking_unlock_success` (desbloquea ranking; puede requerir registro)
- **Activación fuerte (North Star):** el usuario **crea cuenta + inicia Programa Base 4 semanas**:
  - `base_program_enroll_success`

> Nota: “Activar ranking” mejor medirlo como **éxito** (unlock), no solo como tap.

---

## 1) Adquisición (descargas)
**Objetivo:** Alcanzar **20.000 descargas** durante la campaña del sorteo.  
- **Métrica:** `Installs`  
- **Fecha:** **X mar 2026 → X mar 2026**

---

## 2) Activación ligera (primer valor)
**Objetivo:** Lograr que **≥40%** de nuevos usuarios completen **activación ligera** en su primera sesión.  
- **Métrica:** `Light Activation Rate (D0)`
  - Definición: % de `Installs` con (`health_permission_granted` OR `ranking_unlock_success`) en D0
- **Fecha:** antes del **XX XX 2026**

---

## 3) Activación fuerte (North Star)
**Objetivo:** Conseguir que **≥20%** de todos los nuevos usuarios completen **cuenta + inicio de Programa Base**
en los **primeros 3 días** desde instalación.  
- **Métrica:** `Base Enroll Rate (D0–D3)`
  - Definición: % de `Installs` con `base_program_enroll_success` en D0–D3
- **Fecha:** antes del **XX XX 2026**

---

## 4) Enganche del programa (hábito temprano)
**Objetivo:** Lograr que **≥35%** de quienes inician el Programa Base completen **6 sesiones en 14 días**.  
- **Métrica:** `6 Workouts / 14 Days (Base Starters)`
  - Definición: % de usuarios con `base_program_enroll_success` que generan ≥6 `workout_completed` en 14 días
- **Fecha:** antes del **XX XX 2026**


---

## 5) Monetización A — Inicio de trial (drop premium)
**Objetivo:** Conseguir que **≥20%** inicien el **trial de 3 días**.  
- **Métrica:** `Trial Start Rate`
  - Definición: % que hacen `trial_started` (en cualquier momento)
- **Fecha:** **XX XX 2026 → XX XX 2026**

---


## 6) Monetización B — Conversión a pago
**Objetivo:** Conseguir que **≥50%** de usuarios que iniciaron el **trial** conviertan a suscripción de pago.  
- **Métrica:** `Trial → Paid Conversion`
  - Definición: % de `trial_started` que pasan a `subscription_started`
- **Fecha:** **XX XX 2026 → XX XX 2026**

