# Plumbing Track Website Implementation Roadmap

## Status basis

This is the living execution/status companion to `docs/WEBSITE_DESIGN_PLAN.md` and `docs/INSTRUCTIONS.md`.

The current `dev/updates` implementation is the baseline. For detailed review evidence, route status, risks, and rationale, see `docs/DEV_UPDATES_REVIEW_2026-09-10.md`.

For the approved shared-chrome migration, see `docs/PARTIALS_IMPLEMENTATION_PLAN.md` and `docs/DECISION_PARTIALS_TYPOGRAPHY_PALETTE.md`.

---

# Current re-evaluation — 2026-09-10

The older roadmap understated how much of the dedicated page architecture already exists.

Implemented first-draft routes now include:

- `/about/`
- `/solutions/`
- `/solutions/poly-b/`
- `/solutions/kitec/`
- `/solutions/occupied-building-repiping/`
- `/how-it-works/installation/`
- `/technology/`
- `/technology/accessible-plumbing/`
- `/technology/conventional-vs-plumbing-track/`
- `/resources/`
- `/resources/faq/`

These are real first drafts with page-specific content, metadata, internal links, and conversion CTAs.

Therefore:

> **Wave 2A route creation is largely complete. The immediate priority is production hardening, maintainability, source verification, and content depth.**

The public route set has expanded, so Wave 1 hardening now applies to the whole current site.

---

# Current operator decisions

## Build-time partials replace runtime fragment delivery — deferred execution

The current fragment system has the correct centralized-source idea but the wrong delivery mechanism for this site.

Header, footer, and other truly shared fragment pieces will move to **build-time rendered partials**. A small Ruby/ERB build is the selected implementation direction.

The migration must be staged:

```text
existing source pages + partials
          ↓ Ruby/ERB build
        dist/
          ↓ parity verification
deployment switch only after verification
          ↓
remove runtime fragment fetches
```

Do not move routes or rewrite the site architecture as part of the first partial migration. The existing runtime implementation remains the fallback until generated-output parity passes.

See `docs/PARTIALS_IMPLEMENTATION_PLAN.md` for the full implementation and rollback contract.

### Current time-box decision — 2026-09-10

The Ruby/ERB partial migration and `dist/` generation are explicitly deferred for the current time-box. Do not begin that migration or remove the existing runtime fragment loader yet. The current static/runtime-fragment architecture remains the working implementation while immediate effort goes to higher-value site hardening. The build-time partial plan remains an approved future migration, not a cancelled decision.

## Geist remains canonical

**Geist is the canonical Plumbing Track site typeface.**

The newer page family should be brought onto the same Geist typography contract rather than continuing to fall back to Arial/Helvetica as its primary treatment.

## Cyan remains removed

Cyan was intentionally removed from the design.

Remaining `--cyan` and `--cyan-soft` references are stale artifacts. Remove or replace them using the current palette/accent contract. **Do not restore cyan merely to satisfy old CSS.**

---

# Production-readiness correction

The current branch is a strong implementation baseline, not yet a production-complete release.

Current P0 issues are:

1. header/footer/testimonial shared markup is still created through browser-time fragment fetching rather than build-time/static rendering; this is a deferred migration for the current time-box;
2. root `sitemap.xml` is absent;
3. root `robots.txt` is absent;
4. stale cyan variable references remain after intentional cyan removal;
5. page-family typography still drifts from the canonical Geist contract;
6. production Assessment API, GA4, no-PII, CTA attribution, and whole-route deployment verification remain open.

Do not mark the branch production-ready until the P0 gates below are closed.

---

# Historical shared-shell correction record

The earlier Wave 1 hardening pass incorrectly treated shared fragment ownership as proof of visual consistency. Page-specific inline CSS still overrode the canonical shell at mobile widths, producing divergent menu/footer behavior. The comparison component also lost its relationship between conventional and Plumbing Track values on mobile.

The correction centralized final header/footer precedence in `shared-navigation.css`, preserved canonical shared markup ownership, restored a readable solid header for the photographic Our Work hero, improved text wrapping, and clarified the mobile comparison layout.

The lesson remains current:

> **One source of truth is necessary, but generated/rendered output must still be verified.**

## Revision ledger — canonical menu and logo corrections — 2026-09-09 to 2026-09-10

1. `f99c49b` attempted to stabilize logo variants but incorrectly centered the mobile logo and continued high-specificity override problems.
2. `03a3b52` replaced accumulated/conflicting shared-navigation blocks with one scoped canonical header/footer contract.
3. `bb7a709` reduced the desktop logo clamp by 20%, leaving the mobile rule at 168px.
4. `4881d81` incorrectly added margin to primary mobile menu rows as well as nested submenu links.
5. `b7a2c89` corrected the interpretation so only nested `.nav-flyout a` links receive the requested spacing.

Previously recorded browser evidence at 550px and 1440px verified the final menu/logo state. Preserve this as historical verification while the partial migration is tested against it.

---

# Assessment status

The expanded **Book an Assessment — Detailed Conversion Task** remains a hardening/acceptance specification for the existing flow, not a rebuild instruction.

Source-level structure already includes:

- dedicated `/assessment/` route;
- Building → Project → Contact → Review progression;
- structured building/project/contact/attribution data;
- `Unsure`/unknown states;
- minimal required contact data;
- review + explicit success state;
- API error/retry handling and duplicate-submit protection;
- source-page / CTA attribution support;
- assessment CTA/start/step/submit event-emission logic.

**Classification:** implemented at the source/interaction-design level; production integration verification remains P0.

---

# Current navigation architecture

```text
ABOUT → /about/
OUR WORK → /our-work/
SOLUTIONS
  Solutions → /solutions/
  Poly-B Replacement → /solutions/poly-b/
  Kitec Replacement → /solutions/kitec/
  Occupied Building Repiping → /solutions/occupied-building-repiping/
  Affordable Housing → /bchousing/
HOW IT WORKS
  How It Works → /how-it-works/
  Project Process → /how-it-works/#process
  Detailed Installation → /how-it-works/installation/
OUR TECHNOLOGY
  Our Technology → /technology/
  Accessible Plumbing → /technology/accessible-plumbing/
  Conventional vs Plumbing Track → /technology/conventional-vs-plumbing-track/
RESOURCES
  Resources → /resources/
  FAQ → /resources/faq/
  Client Portal → /client-portal/
[ BOOK AN ASSESSMENT ] → /assessment/
```

Section `<summary>` controls may remain flyout controls; each flyout already exposes the corresponding hub route.

Resources remains intentionally narrowed to ready material. Omitted Problem/Decision/Project Guides stay in Wave 2 rather than being treated as cancelled.

---

# How It Works decision

`How It Works` remains an explanatory destination, not a shortcut to Assessment.

```text
Home
  ↓
How It Works
  ↓
Accessible plumbing explanation
  ↓
Five-phase project process
  ↓
Detailed Installation / Our Work / Technology
  ↓
Book an Assessment when the visitor is ready
```

Keep this decision.

---

# Wave 1 — Current Public First Draft + Production Hardening

## Completed or substantially implemented

- ~~Preserve the existing Plumbing Track visual identity rather than rebrand the site.~~
- ~~Preserve the homepage video/hero experience.~~
- ~~Restructure Home into a compact conversion journey rather than an epic-scroll copy dump.~~
- ~~Introduce accessible-plumbing/product explanation and routing on Home.~~
- ~~Establish the primary navigation hierarchy: About, Our Work, Solutions, How It Works, Our Technology, Resources.~~
- ~~Create one canonical conceptual source for header/navigation/footer markup.~~
- ~~Create shared testimonial-card markup/styles for repeated proof sections.~~
- ~~Correct the shared mobile/desktop navigation shell and preserve correction history.~~
- ~~Create `/how-it-works/` and route explanation before conversion.~~
- ~~Present the five-phase project process on How It Works.~~
- ~~Create `/how-it-works/installation/` as a real eight-step child page using completed-work imagery.~~
- ~~Rework Our Work into a stronger proof/portfolio page.~~
- ~~Retain Client Portal in the current architecture.~~
- ~~Create and structurally implement the dedicated Assessment flow.~~
- ~~Instrument assessment CTA/start/step/submit behavior at the source-event level.~~
- ~~Build/revise Affordable Housing / BC Housing.~~
- ~~Create `/about/` first draft.~~
- ~~Create `/solutions/` hub first draft.~~
- ~~Create Poly-B, Kitec, and Occupied Building Repiping solution-page first drafts.~~
- ~~Create `/technology/`, Accessible Plumbing, and Conventional-vs-Plumbing-Track first drafts.~~
- ~~Create `/resources/` and `/resources/faq/` first drafts while intentionally deferring unready guides.~~
- ~~Add basic title/meta-description/robots/canonical treatment across the new page family.~~
- ~~Apply current CTA attribution pattern to new commercial pages.~~
- ~~Keep Grapher/documentation synchronization active and preserve correction history.~~
- ~~Decide canonical typography: Geist retained.~~
- ~~Decide palette correction: cyan remains removed.~~
- ~~Select build-time partial rendering as the replacement for runtime fragment delivery.~~

## P0 hardening gates

- [ ] **Deferred:** Implement Stage 1 of `docs/PARTIALS_IMPLEMENTATION_PLAN.md`: add Ruby/ERB partial sources and build script without changing production behavior.
- [ ] **Deferred:** Generate the first complete `dist/` output while preserving all existing public paths.
- [ ] **Deferred:** Verify generated output parity before changing deployment.
- [ ] **Deferred:** Switch deployment to generated HTML only after parity checks pass.
- [ ] **Deferred:** Remove runtime header/footer/testimonial fragment creation only after generated deployment is verified.
- [x] Remove stale `--cyan` / `--cyan-soft` references and align shared navigation with the current palette.
- [x] Centralize Geist font-face/type variables and apply them consistently to new page families, including Assessment.
- [x] Add and verify root `sitemap.xml` for the intended public/indexable route set. The main-domain sitemap contains the 15 canonical public routes; `/bchousing/` remains on its separate canonical host and client-portal routes are excluded.
- [x] Add and verify root `robots.txt`, including the production sitemap reference and deliberate disallowance of the client-portal utility subtree.
- [ ] Verify every current public route by direct URL and refresh under the actual production/static deployment configuration.
- [ ] Perform final responsive QA across the expanded public route set.
- [ ] Verify shared nav flyouts/mobile drawer/header/footer keyboard, focus, Escape, click-away, scrolled, and reduced-motion behavior.
- [ ] Verify homepage video on desktop/tablet/mobile and reduced-motion/fallback behavior.
- [ ] Verify production Assessment API end to end, including persistence/CRM handoff, confirmation, failure, retry, and duplicate-submit protection.
- [ ] Verify every assessment CTA preserves correct source-page/source-CTA attribution.
- [ ] Verify GA4 initializes exactly once where intended and current events behave correctly in DebugView/production-equivalent testing.
- [ ] Confirm analytics receives no names, emails, phone numbers, addresses, free text, or other sensitive form values.
- [ ] Run final broken-link, missing-asset, console-error, accessibility-basics, performance, and static-serving regression checks.

## P1 hardening / quality

- [ ] Review About origin/founder/manufacturing claims against authoritative company material and add verified team/credibility depth.
- [ ] Deepen Poly-B with verified education, FAQ, project proof, and internal linking.
- [ ] Deepen Kitec with verified education, FAQ, project proof, and internal linking.
- [ ] Deepen Occupied Building Repiping with verified operational claims, resident/property-manager coordination detail, and proof.
- [ ] Add Affordable Housing as a first-class path in `/solutions/` while preserving `/bchousing/` unless a deliberate URL migration is approved.
- [ ] Review Affordable Housing displacement, asbestos, dust, cost, restoration, and regulatory language against authoritative source material.
- [ ] Review Technology and comparison claims against source/project evidence and add proof links where available.
- [ ] Review comparison semantics for screen-reader/table clarity in addition to visual mobile behavior.
- [ ] Expand FAQ from real verified customer questions; add FAQ structured data only if visible content and implementation justify it.
- [ ] Add consistent OG/social metadata across public routes where useful.
- [ ] Add page-type-appropriate structured data/breadcrumbs where accurate.
- [ ] Review image alt text and crop/quality on Detailed Installation and other real-project imagery.
- [ ] Review Our Work project facts/testimonials against verified source evidence.
- [ ] Connect solution/technology claims to relevant real projects and educational resources as those are published.
- [ ] Continue tightening CSS ownership so shared chrome lives in shared-shell CSS and page-family CSS remains page-focused.
- [ ] Make an explicit indexing decision for any route that remains too thin or unverified.

---

# Wave 2 — Depth Expansion After Current Draft Is Hardened

## Wave 2A — Dedicated route status: largely implemented

### About

- ~~`/about/` route~~ — implemented draft.
- ~~Origin / development / mission framing~~ — implemented at first-draft level.
- ~~Assessment CTA~~ — implemented.
- [ ] Add verified team, founder depth, credibility/system-evolution material and approved proof.

### Solutions

- ~~`/solutions/` hub~~ — implemented draft.
- ~~`/solutions/poly-b/`~~ — implemented draft.
- ~~`/solutions/kitec/`~~ — implemented draft.
- ~~`/solutions/occupied-building-repiping/`~~ — implemented draft.
- [ ] Integrate Affordable Housing into the Solutions hub body while preserving `/bchousing/` unless an intentional migration is approved.
- [ ] Deepen all commercial routes with source-backed education, FAQs, proof, and internal linking.

### How It Works

- ~~`/how-it-works/` high-level explanation and five-phase process~~ — implemented.
- ~~`/how-it-works/installation/` detailed eight-step process~~ — implemented draft with real job imagery.
- [ ] Verify/refine detailed process sequencing and project evidence rather than rebuilding the route.

### Our Technology

- ~~`/technology/` landing page~~ — implemented draft.
- ~~`/technology/accessible-plumbing/`~~ — implemented draft.
- ~~`/technology/conventional-vs-plumbing-track/`~~ — implemented draft.
- [ ] Deepen with verified diagrams, jobsite proof, objections, evidence links, and final accessibility/metadata treatment.

### Resources

- ~~`/resources/` crawlable hub~~ — implemented lean first draft.
- ~~`/resources/faq/` initial FAQ~~ — implemented.
- ~~Client Portal retained in Resources architecture.~~
- [ ] Expand FAQ from verified real questions.
- [ ] Problem Guides — intentionally deferred.
- [ ] Decision Guides — intentionally deferred.
- [ ] Project Guides — intentionally deferred.

## Wave 2B — Commercial / decision-page maturity

The route-creation portion is largely complete:

- ~~Poly-B replacement route~~ — first draft exists.
- ~~Kitec replacement route~~ — first draft exists.
- ~~Occupied-building repiping route~~ — first draft exists.
- ~~Conventional vs Plumbing Track comparison route~~ — first draft exists.
- ~~Detailed installation route~~ — first draft exists.
- ~~FAQ route~~ — initial first draft exists.

Still required:

- [ ] verified technical/problem content;
- [ ] stronger project proof;
- [ ] richer FAQ support;
- [ ] deeper internal linking from Home, How It Works, Affordable Housing, Our Work, Solutions, Technology, and Assessment completion state;
- [ ] accessibility + metadata polish;
- [ ] source reconciliation before strong quantitative/absolute claims.

## Wave 2C — SEO / educational funnel pages

Retain the compositional SEO strategy: focused articles act as landing/funnel points and link into deeper technical, proof, and commercial pages.

These remain planned even though intentionally omitted from the first-draft menu:

- [ ] What Is Poly-B?
- [ ] What Is Kitec?
- [ ] Asbestos & Repiping
- [ ] Pipe Identification Guide
- [ ] The Case for Not Burying Your Plumbing
- [ ] How Long Does a Repipe Take?
- [ ] Do Residents Need to Move Out?
- [ ] What Does It Look Like Finished?
- [ ] Preparing a Building
- [ ] Preparing Residents
- [ ] What Happens During Installation?
- [ ] What Happens After Installation?
- [ ] Why Future Access Matters

Do not collapse these into one giant Learn article. Their value is focused search intent, useful internal linking, and compositional coverage.

## Wave 2D — Our Work expansion

The current Our Work page remains part of the current draft. The project-proof library remains open:

- [ ] create/reconcile the reusable individual project-page implementation;
- [ ] publish initial verified project detail pages;
- [ ] build project galleries using real completed Plumbing Track photography;
- [ ] link projects directly to the solution/technology claims they prove;
- [ ] add filters/grouping only where verified project data is sufficiently complete.

---

# Wave 3 — Growth After Core Architecture

- [ ] Remaining verified project pages.
- [ ] Deeper educational/editorial content after review and approval.
- [ ] Downloadable lead resources.
- [ ] Building-risk / assessment tools beyond the current form.
- [ ] Geographic SEO landing pages where justified by actual service coverage and search strategy.
- [ ] Additional CRM/GA4 enrichment once the basic event model is stable.

---

# Acceptance rule going forward

The current branch is the implementation baseline. Future work should **extend and harden it rather than restart it**.

1. Preserve the current visual language and homepage video.
2. Preserve Geist as the canonical site typeface unless a later explicit operator decision changes it.
3. Keep cyan removed; stale cyan references are cleanup artifacts, not design requirements.
4. Preserve the established navigation architecture unless a deliberate later decision changes it.
5. Keep How It Works explanatory before conversion.
6. Maintain one canonical source for shared header/footer/testimonial markup.
7. Render shared public chrome into deployable HTML at build time rather than requiring runtime fetches for its existence.
8. Follow the staged partial migration and parity/rollback rules in `docs/PARTIALS_IMPLEMENTATION_PLAN.md`.
9. Keep page-specific content local when sharing would create unnecessary coupling.
10. Keep pages focused and indexable rather than returning to epic-scroll architecture.
11. Treat route existence as implementation progress, not automatic SEO/content completion.
12. Keep Grapher synchronized continuously with decisions, defects, reclassification, evidence, and verification results.
13. Do not mark analytics, SEO, accessibility, responsive behavior, source claims, or production integration complete without verification.
14. Treat the expanded Assessment section as hardening/acceptance criteria for the existing flow unless a later operator decision explicitly requests redesign.
15. Preserve intentionally deferred menu/content items in the later-wave plan rather than silently dropping them.

## Practical order

```text
Palette + Geist normalization
  ↓
Sitemap / robots / whole-site production hardening
  ↓
Assessment + GA4 production verification
  ↓
P1 source/content/proof/SEO depth
  ↓
Wave 2C educational funnel library
  ↓
Wave 2D project-proof library
  ↓
Wave 3 growth features
  ↓
Build-time partial migration in isolated dist/ when the time-box allows
```
