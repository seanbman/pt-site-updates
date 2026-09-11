# Grok Repository Review — 2026-09-10

## Status

**Raw review supplied and reconciled.**

This document preserves the Grok review as an advisory QA artifact and evaluates it against the current `dev/updates` branch and governing documentation. Grok is not authoritative; findings only become implementation work when they survive comparison against operator decisions, current docs, current code, and verified source evidence.

## Validation rule

A Grok finding may be classified as:

- **VALID — P0:** confirmed launch blocker;
- **VALID — P1:** confirmed quality/depth improvement;
- **ALREADY COVERED:** correct but already represented in current docs/roadmap;
- **PARTIALLY VALID:** useful observation with incorrect cause/scope/remedy;
- **STALE:** no longer applies to current `dev/updates`;
- **CONFLICTS WITH OPERATOR DECISION:** technically possible but contrary to an approved decision;
- **UNSUPPORTED:** cannot be established from current code/source evidence.

The companion execution plan is `docs/qa-review/WEBSITE_HARDENING_PLAN_2026-09-10.md`.

---

# Raw Grok review

Running tip of `dev/updates` locally at `http://127.0.0.1:8765` (static server from repo root). Every public route I hit returned 200.

## What you’re looking at
A static marketing site (no build step yet). Shared chrome is still `fetch()`’d at runtime from `/templates/site-header.html` and `/templates/site-footer.html` via `site-header.js`. New page families (`about`, `solutions/*`, `technology/*`, `resources/*`) share `page-family.css` + that fragment pattern. Home / How It Works keep heavier page-local CSS.

Docs (`DEV_UPDATES_REVIEW_2026-09-10`, roadmap, design plan) already match what the server shows: **route scaffolding is ahead of the old plan; hardening and depth are the real work.**

## Doc vs live (verified)
Matches the Sep 10 review:
- Hero **See How It Works** goes to `/how-it-works/` (not Assessment) — decision honored
- Full first-draft family exists with titles, canonicals, CTAs, attribution query params
- No `robots.txt` / `sitemap.xml`
- Solutions hub body has Poly-B / Kitec / Occupied only — **Affordable Housing is nav-only** (`/bchousing/`), not on `/solutions/`
- Design plan still says **LEARN**; live nav says **Resources** (intentional lean hub; plan wording lags)
- Comparison page is CSS grid rows, not a semantic `<table>` (has `aria-label`, still worth a11y revisit)

## Technical insight
1. **Partials are the right next build.** Central ownership is correct; runtime `fetch` is the liability (FOUC, SEO-empty chrome, broken offline/static hosts, double-CSS risk). How It Works even ships its own inline header styles *and* a fragment mount — that’s two chrome contracts fighting. The Ruby/ERB `dist/` plan in `PARTIALS_IMPLEMENTATION_PLAN.md` is the clean fix.

2. **Token split is a live bug, not just docs.** Homepage/HIW alias `--cyan` → gold. `page-family.css` correctly uses `--gold`. `shared-navigation.css` and `testimonial-cards.css` still call `var(--cyan)` / `var(--cyan-soft)` without defining them on family pages — so About/Solutions nav focus/hover accents can silently fail. Rename to `--gold` (or define aliases once in the shared shell), don’t resurrect a cyan brand.

3. **Geist is named, not shipped on families.** Home has real `@font-face` Geist. Page-family falls back to Arial. HIW even sets `--font-geist-sans: Arial` — the variable lies. Operator decision: Geist is canonical; wire one shared font contract into every family page.

4. **Architecture is healthy for SEO.** Focused routes, cautious claim language (“do not force a diagnosis when material is uncertain”), assessment attribution on CTAs. Assessment still needs production API + GA4 + no-PII verification before calling it done.

5. **Maintainability cliff.** ~25 HTML files × duplicated patterns. Without build-time partials, every nav/CTA change is a drift machine. Grapher + `AGENTS.md` discipline is strong; the HTML layer isn’t at that maturity yet.

## Creative / IA insight
1. **Story sequence finally works:** Problem → System → Proof → Action. Home as hub, How It Works as explanation before Assessment, Technology carrying the accessible-plumbing thesis — that’s the design-plan spine made real. Don’t collapse it back into one epic scroll.

2. **Family pages feel like templates, not destinations yet.** Same hero / 3-up / CTA rhythm on About, Solutions, Poly-B, Kitec, etc. Great for consistency; weak for memory. Differentiating moves: Poly-B/Kitec need one sharp “why this building” visual + one proof link each; About (~220 words) needs the credibility layer (team/system origin) the review calls out — without inventing facts.

3. **Resources is correctly lean** as a waiting room for Wave 2C guides. Don’t fake a Learn library. FAQ’s five answers are a good start; expand only from real customer questions.

4. **Affordable Housing is the IA awkward spot.** In the menu, missing from Solutions body — reads like an afterthought. Either a fourth Solutions card pointing at `/bchousing/`, or a deliberate “special programs” treatment. Leaving it nav-only undercuts the hub.

5. **Creative opportunity:** the product thesis (“every pipe in a wall is a pipe you can’t inspect”) is strong on Technology. Solutions pages still talk like material catalogs. Make each solution open with the *accessible route* consequence for that problem, then material specifics — so Technology, Solutions, and How It Works rhyme.

## Suggested order (same as the review, I’d run it)
1. Build-time partials  
2. Kill stale `--cyan` / unify gold + Geist  
3. `sitemap.xml` + `robots.txt`  
4. Whole-route regression  
5. Assessment + GA4 hardening  
6. Deepen Solutions / About / FAQ with source-backed proof  
7. Then Wave 2C educational funnels + project pages  

Grabbing a few local screenshots next; say if you want me to start the partials migration or the token cleanup first.

---

# Reconciliation against `dev/updates`

## Local route smoke test

**Classification: VALID EVIDENCE, NOT A CLOSED PRODUCTION GATE.**

The reported local result that every tested public route returned 200 is useful and should be retained as a baseline smoke test. It does **not** close the existing production/static deployment verification requirement because it was run from a local repo-root static server rather than the actual generated/deployed environment.

## Runtime partials / duplicated chrome contracts

**Classification: VALID — P0 / ALREADY COVERED, with one additive detail.**

The central finding is already in `DEV_UPDATES_REVIEW_2026-09-10.md`, `IMPLEMENTATION_ROADMAP.md`, and `PARTIALS_IMPLEMENTATION_PLAN.md`: runtime fragment fetching is the next architectural liability to remove.

The additive detail is valid and should be carried into implementation QA: `/how-it-works/` currently contains page-local `.site-header` styling while also mounting the shared header fragment. Build-time partial migration must remove or neutralize this duplicate chrome contract so there is one visual/behavioral owner.

## Stale `--cyan` usage

**Classification: VALID — P0.**

Confirmed in current source:

- `page-family.css` defines the current accent as `--gold` / `--gold-soft`.
- `shared-navigation.css` still references `var(--cyan)` and `var(--cyan-soft)` without declaring them itself.
- `testimonial-cards.css` still uses `--cyan` / `--cyan-soft`, although it supplies fallback gold-like values.
- `/how-it-works/` still names gold values `--cyan` and `--cyan-soft` locally.

This is not merely naming debt: unresolved custom properties in shared navigation can cause hover/focus/border accent declarations to fail on family pages. The approved fix remains to standardize on the current gold/accent token contract, not restore cyan.

## Geist typography contract

**Classification: VALID — P0.**

Confirmed in current source. `page-family.css` uses Arial/Helvetica as `--sans`; `/how-it-works/` sets `--font-geist-sans` to Arial/Helvetica. The variable name therefore implies a contract the implementation does not actually satisfy. One shared Geist font contract should be rendered across the site family, including Assessment where practical.

## SEO architecture

**Classification: VALID / ALREADY COVERED.**

Focused routes, cautious material/problem language, canonical tags, and contextual Assessment CTAs align with the design plan. This supports the current decision to harden the existing architecture rather than collapse it back into one large page.

The review correctly retains `sitemap.xml`, `robots.txt`, production analytics, Search Console, and no-PII verification as unresolved work.

## Maintainability risk

**Classification: VALID — P0 rationale.**

The exact `~25 HTML files` count is an approximate observation and should not be treated as a durable project metric. The underlying insight is valid: duplicated page patterns plus runtime shared fragments create a drift surface that build-time partials are intended to reduce.

## Affordable Housing placement

**Classification: VALID — P1.**

This was already noted in the current roadmap. `/bchousing/` is reachable through navigation but is absent from the `/solutions/` hub body. That weakens the hub's information architecture.

Recommended implementation choice: add a fourth Solutions entry pointing to `/bchousing/` unless a deliberate special-programs treatment is approved. Do not invent a new URL migration merely to fix the hub.

## `Learn` vs `Resources` terminology

**Classification: VALID DOCUMENTATION DRIFT — P1.**

The live navigation intentionally uses **Resources** as the lean current hub while the design plan still uses **Learn** in places. This is not a live-site defect by itself. The docs should be normalized so agents do not mistake `Learn` for a second required current navigation label.

Current interpretation:

- **Resources** = present public hub and navigation label.
- Wave 2C focused educational pages = future depth inside/under that content strategy.
- Do not fabricate a broad Learn library before those pages exist.

## Comparison-page semantics

**Classification: VALID — P1 ACCESSIBILITY.**

The current comparison implementation uses visual grid rows rather than a semantic HTML table. An `aria-label` helps identify the region but does not automatically encode row/column relationships. The hardening pass should test with screen-reader semantics and either adopt a semantic table where the content is tabular or provide equivalent explicit relationships.

## Family-page sameness

**Classification: VALID — P1 CONTENT/DESIGN DEPTH.**

Consistency should be preserved, but the repeated hero → feature grid → CTA rhythm should not be the only identity of every destination.

The useful additions are:

- Poly-B: one problem-specific visual/evidence module plus a verified proof link.
- Kitec: one distinct material/problem-specific visual/evidence module plus a verified proof link.
- Occupied Building Repiping: emphasize resident/building coordination and localized work evidence.
- About: add source-backed team/system-origin/credibility depth without inventing founder or company history.
- Technology: remain the strongest expression of the accessible-plumbing thesis.

This is differentiation inside the existing design system, not a redesign.

## Resources / FAQ depth

**Classification: VALID — P1 / ALREADY COVERED.**

Keep Resources lean until real educational content exists. Expand FAQ from verified customer questions rather than padding the page for word count or schema opportunities.

## Solutions narrative alignment

**Classification: VALID — P1.**

This is the most useful creative addition from the review. Solution pages should not read only as material catalogs. Each should connect the visitor's known problem to the consequence of the Plumbing Track approach:

**problem/material → accessible route consequence → how installation changes → proof → assessment**

Material-specific technical content still belongs on each page; the accessible-plumbing concept should create narrative continuity with Technology and How It Works.

## Suggested execution order

**Classification: VALID / ALIGNS WITH CURRENT HARDENING PLAN.**

The proposed order is consistent with the existing hardening plan. The reconciled sequence remains:

1. build-time partials and generated-output parity;
2. shared gold/accent and Geist contract cleanup;
3. sitemap/robots/crawl foundation;
4. whole-route/browser regression;
5. Assessment API + GA4 + CRM attribution hardening;
6. source-backed destination-page differentiation and proof;
7. Wave 2C educational funnels and project-detail expansion.

## Net-new actions carried forward

The following items are specifically strengthened or added by this review:

- [ ] remove the duplicate page-local/shared header contract from `/how-it-works/` during the partial migration;
- [ ] treat unresolved `--cyan` references in shared navigation as a live rendering/focus-state bug, not cosmetic nomenclature only;
- [ ] normalize **Resources** vs legacy **Learn** wording in current planning docs;
- [ ] make a deliberate semantic choice for the comparison component rather than relying on `aria-label` alone;
- [ ] add Affordable Housing visibly to the Solutions hub body or explicitly document another intentional treatment;
- [ ] differentiate family pages with one problem/evidence module each while retaining shared components;
- [ ] make each Solution page connect material/problem intent to the accessible-route thesis before proof and conversion;
- [ ] retain the successful local 200-route smoke test as baseline evidence, but rerun against generated `dist/` and production-equivalent serving before launch.
