# Decision — Shared Partials, Geist, and Palette Cleanup

Date: 2026-09-10

## Operator decisions

1. **Replace runtime-fetched shared fragments with build-time rendered partials.**
   - Header, footer, and other truly shared fragment pieces should retain one canonical source.
   - Deployable HTML should contain those pieces already rendered.
   - The migration must preserve current routes and be staged so the existing site remains a fallback until generated-output parity is verified.
   - Implementation details are defined in `docs/PARTIALS_IMPLEMENTATION_PLAN.md`.

2. **Retain Geist as the canonical Plumbing Track site typeface.**
   - New page families should use the same Geist typography contract as the homepage.
   - Centralize font-face/type variables rather than allowing Arial/Helvetica drift.

3. **Cyan remains removed from the current design.**
   - Remaining `--cyan` / `--cyan-soft` references are stale artifacts.
   - Remove or replace those references with the current palette/accent contract.
   - Do not reintroduce cyan to satisfy legacy CSS.

## Scope

These decisions refine implementation and maintenance. They do not authorize a redesign, URL restructure, framework rewrite, or copy overhaul.

## Execution timing clarification — 2026-09-10

The build-time partial decision is approved as a future migration, but Ruby/ERB and `dist/` work are explicitly deferred for the current time-box because there is not time to undertake that migration now. The existing runtime fragment architecture remains active until the migration is deliberately resumed and parity-verified.
