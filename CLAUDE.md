# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A product management and design documentation repository for **El Metodo** — a fitness coaching SaaS. No code, no builds, no tests. All files are Markdown.

## Repository structure

| Directory | Contents |
|-----------|----------|
| `automatica/` | Core product work: analytics, definitions, notifications, ideation, design specs, and implementation plans |
| `automatica/plans/` | Implementation plans and deep-dive specs for specific features |
| `automatica/04-notifs-motivation/` | Notification system design (in-app modals, push, motivation mechanics) |
| `business-dash/` | Business docs: personas, business model, roadmap, metrics, competitive analysis |
| `business_docs/` | Coach app docs and asesorías (advisory tier) feature planning |
| `asesorias/` | Product docs for the advisory/consulting tier (V2) |
| `Z.system/` | Legacy system notes |


## Product context

El Metodo has two main products:
- **App** — Training programs for end users (free + paid tiers)
- **Dashboard (coached)** — Tool for coaches to manage clients

The V2 initiative (`business_docs/`) adds an **asesorías tier**: coaches sell advisory services through the platform. Documentation there covers the tier architecture, flows, and pricing.

## Working conventions

- Files are named with slugs or descriptive titles; no strict naming convention across the repo.
- Notification specs live in `automatica/04-notifs-motivation/` — the main spec file is `smooth-enchanting-puddle.md`.
- Active tasks are tracked in `tareas.md` (root), not in issues or a PM tool.

## Figma workflow

Design is done directly in Figma via the **Figma Console MCP** (`mcp__figma-console__figma_execute`), not via the Figma REST API.

**Standard loop for any visual work:**
1. `figma_execute` — create or modify nodes via plugin API
2. `figma_capture_screenshot` (or `figma_take_screenshot`) — validate visually
3. Fix and repeat if needed (max ~3 iterations)

**Key conventions:**
- Always create components inside a Section or Frame — never floating on blank canvas.
- Each notification type gets its own Figma page (e.g. `streak_milestone — modal`, `training_week_done — modal`).
- Multiple variants per page: variant A (sobria/clean) and variant B (visual/illustration), each shown at 2+ representative states.

**Design system detail** (tokens, hex values, file keys, typography, layout) is in the persistent memory file `figma_design_system.md` — check memory before hardcoding values.
