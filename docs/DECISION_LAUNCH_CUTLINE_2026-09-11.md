# Launch Cutline Decision — 2026-09-11

**Status:** Current operator directive for the September 11 launch time-box  
**Branch:** `dev/updates`  
**Purpose:** Preserve the launch-critical execution order without deleting or rewriting the broader roadmap.

## Directive

Stop further visual iteration for the current launch time-box unless a visual defect is itself release-blocking.

The latest visual hardening direction is accepted as the working baseline. Immediate effort moves to release integrity, lead capture, analytics, and deployment verification.

Do **not** merge `dev/updates` to `main` or declare the site production-ready merely because the current pages look complete.

## Current launch priority order

### P0.1 — Repair the canonical deployment path

`pt-site-updates` is the canonical website-overhaul repository.

The current deployment/synchronization chain still references the legacy `seanbman/plumbing-track-static` repository from `bman-platform`. This creates a split-brain release path where a successful synchronization can deploy stale source instead of the current `pt-site-updates` branch.

Before launch:

- make the deployment source unambiguous;
- ensure `bman-platform/content/` receives the intended `pt-site-updates` release source;
- prevent the legacy bidirectional synchronization from overwriting the canonical overhaul;
- verify the deployed commit/source identity after synchronization.

**Acceptance:** the production-equivalent marketing content can be traced to the intended `pt-site-updates` release commit and cannot be silently replaced by stale `plumbing-track-static` content.

### P0.2 — Harden the Assessment backend contract

The current frontend Assessment flow sends structured building, project, contact, and attribution data, while the existing `bman-platform` Assessment controller still accepts only the legacy four-string compatibility payload and emails it.

Before launch:

- accept and validate the structured Assessment payload server-side;
- retain source-page / CTA attribution;
- retain the project/contact fields collected by the current form;
- ensure successful submission represents durable acceptance, not merely a transient client-side success state;
- add duplicate/retry protection appropriate to the production flow;
- preserve safe error handling without leaking sensitive information.

CRM persistence remains the desired destination. If the full CRM handoff cannot be completed inside the launch time-box, the launch decision must explicitly record the temporary durable persistence path rather than pretending the email-only compatibility path satisfies the documented CRM requirement.

**Acceptance:** submitted form fields required by the current Assessment design are not silently discarded, and a successful response corresponds to an accepted lead record/path that can be recovered and acted on.

### P0.3 — Configure and verify GA4

The analytics helper/event taxonomy exists in source, but analytics is not complete until the production measurement ID is actually configured and verified.

Before launch:

- configure the intended production GA4 measurement ID once;
- verify a single page-view initialization;
- verify Assessment funnel events;
- verify `generate_lead` only after accepted submission;
- inspect analytics payloads for PII/free-text leakage;
- confirm no duplicate initialization or duplicate conversion emission.

**Acceptance:** production-equivalent GA4 Realtime/DebugView receives the intended events once and receives no direct identity or free-text form contents.

### P0.4 — Run release/deployment QA

After the three items above are corrected:

- run the complete public-route verifier;
- verify sitemap and robots behavior;
- verify direct navigation and refresh behavior;
- verify referenced assets and shared fragments resolve;
- test representative mobile Safari/iPhone, Android/Chromium, and desktop routes;
- test the full landing → Assessment → backend acceptance → GA4 journey;
- verify the deployed production-equivalent source is the intended release.

Only then should `dev/updates` be considered for merge/release.

## Immediate P1 correction

The `/solutions/kitec/` hero currently uses Peregrine Point imagery even though the current project data identifies Peregrine Point as aged copper. Use a verified Kitec project image instead, such as Wilson Court, before release.

This is a factual/proof alignment correction, not a request to resume general visual redesign.

## Explicitly deferred for this time-box

The following work remains valid but does **not** outrank the launch-critical sequence above:

- Ruby/ERB build-time partial migration and `dist/` generation;
- further aesthetic refinement not required to fix a release defect;
- Wave 2C educational/article expansion;
- broader project-detail library expansion;
- nonessential structured-data/social-preview enhancements;
- additional visual differentiation beyond the accepted current baseline.

Deferral does not cancel these tasks. Their existing documentation remains authoritative for later execution.

## Documentation preservation rule

This decision is an overlay on the existing roadmap, not a replacement for it.

When priorities change:

1. preserve this document as historical evidence;
2. add a newer dated decision or explicitly supersede it;
3. update `docs/INDEX.md` and the living roadmap/status references;
4. let Grapher record the new/current relationship rather than deleting the old decision;
5. do not rewrite prior plans to make them appear as though they always contained the later decision.

The project should distinguish:

- **historical plan** — what was intended at that point in time;
- **current directive** — what currently outranks other work;
- **implementation state** — what is actually present in source;
- **verification state** — what has been independently proven;
- **deferred work** — still valid, but not currently blocking.

This distinction is the mechanism for prioritizing aggressively without erasing project history.
