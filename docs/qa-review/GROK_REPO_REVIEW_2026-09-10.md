# Grok Repository Review — 2026-09-10

## Status

**Source text pending.**

The operator asked that a Grok review of `seanbman/pt-site-updates` be preserved here and treated as an advisory QA input rather than an authority. The review body itself was not included in the current ChatGPT message or attachments, and no matching review artifact was found in the connected Drive/File Library searches performed during this pass.

This file intentionally does **not** reconstruct, paraphrase, or invent Grok's missing wording.

When the raw review is supplied, place it under **Raw Grok review** below verbatim, then evaluate each point against the current `dev/updates` branch and the documentation precedence in `docs/INDEX.md`.

## Validation rule

Grok findings are secondary evidence. A finding should only change implementation when it survives comparison against:

1. current operator decisions and decision records;
2. `docs/INSTRUCTIONS.md`;
3. `docs/IMPLEMENTATION_ROADMAP.md`;
4. dedicated implementation plans;
5. `docs/DEV_UPDATES_REVIEW_2026-09-10.md`;
6. `docs/WEBSITE_DESIGN_PLAN.md`;
7. current branch behavior and source code;
8. verified source/project evidence; and
9. `docs/media/RESOURCE_REFERENCE.md` for media claims and placement.

Overlap with an existing finding increases confidence but does not make the finding authoritative by itself.

## Independently validated QA findings in the current branch

These are **not attributed to Grok**. They are recorded here because they are the repository findings against which the eventual Grok review should be reconciled.

- Shared header/footer/testimonial markup is still fetched at browser runtime by `site-header.js`; the approved direction is build-time Ruby/ERB rendering.
- Root `sitemap.xml` and `robots.txt` are still absent from the current tree.
- The newer page family still uses Arial/Helvetica even though Geist is the canonical site typeface.
- Stale palette naming/ownership remains, including old cyan terminology even where current values are no longer cyan.
- The dedicated assessment flow is structurally strong, but production API persistence/CRM delivery and analytics verification remain open launch gates.
- Assessment CTA attribution exists, but the analytics naming contract is inconsistent with the existing GA4 measurement workbook: code currently emits `assessment_cta_clicked` while the workbook specifies `assessment_cta_click`.
- The GA4 workbook identifies `generate_lead` as the critical key event, while the current assessment code emits `assessment_submitted` and does not visibly emit `generate_lead`.
- Representative public pages inspected during this pass do not contain a visible GA4 bootstrap. Event code falls back to `dataLayer`, so production must prove that one global GA4 initialization actually consumes those queued events.
- The assessment page is visually/interaction complete but does not yet carry the same metadata/social/typography contract as the newer page family; its indexing policy should be deliberate rather than accidental.
- Curated project media can materially strengthen Technology, Accessible Plumbing, Detailed Installation, Occupied Building Repiping, and Our Work, but project identity, presenter claims, resident privacy, and future-access claims must remain evidence-gated.

## Raw Grok review

> **Pending source.** Replace this note with the exact review text when supplied. Do not infer missing review content from the hardening plan or from other QA documents.

## Reconciliation record

Once the raw review is available, classify each Grok item as one of:

- **VALID — P0:** confirmed launch blocker;
- **VALID — P1:** confirmed quality/depth improvement;
- **ALREADY COVERED:** correct but already represented in current docs/roadmap;
- **PARTIALLY VALID:** useful observation with incorrect cause/scope/remedy;
- **STALE:** no longer applies to current `dev/updates`;
- **CONFLICTS WITH OPERATOR DECISION:** technically possible but contrary to an approved decision;
- **UNSUPPORTED:** cannot be established from current code/source evidence.

The companion execution plan is `docs/qa-review/WEBSITE_HARDENING_PLAN_2026-09-10.md`.
