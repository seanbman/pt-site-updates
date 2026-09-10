# Plumbing Track Website Implementation Roadmap

## Status basis

This is the living execution/status companion to `docs/WEBSITE_DESIGN_PLAN.md` and `docs/INSTRUCTIONS.md`.

The design plan remains the target architecture. This roadmap reflects the actual state of `dev/updates` and accepts the operator's manual adjustments as the current implementation baseline.

For the detailed 2026-09-10 branch review, evidence, route matrix, risks, and re-evaluation, see `docs/DEV_UPDATES_REVIEW_2026-09-10.md`.

---

# Current re-evaluation — 2026-09-10

The older roadmap understated how much of the dedicated page architecture has already been implemented.

`dev/updates` now contains real first-draft routes for:

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

These routes are not empty placeholders. They have page-specific copy, titles/descriptions, canonical URLs, shared-shell mounts, internal links, and conversion CTAs.

Therefore:

> **Wave 2A route creation is largely complete. The current priority is production hardening and content/source depth, not rebuilding those pages.**

The public route set has expanded, so Wave 1 hardening must now cover the whole current site rather than only Home, How It Works, Our Work, Affordable Housing, Assessment, and Client Portal.

## Production-readiness correction

The previous branch-handoff language that described `dev/updates` as ready to merge should be read narrowly as **ready to preserve as the current implementation baseline**, not as proof that the branch is production-ready.

The 2026-09-10 review identified concrete pre-production issues:

1. primary shared navigation/footer markup is loaded client-side by `site-header.js`, while project instructions require crawlable navigation and no important content exclusively behind JavaScript;
2. root `sitemap.xml` is absent;
3. root `robots.txt` is absent;
4. `shared-navigation.css` uses `--cyan` / `--cyan-soft`, but the new `page-family.css` routes do not define those tokens;
5. the page family falls back to Arial/Helvetica rather than consuming the homepage's existing Geist typography treatment;
6. production assessment API, GA4, no-PII, CTA attribution, and whole-route deployment verification remain open.

Do not mark the current branch production-ready until the P0 gates below are closed.

---

# Historical correction record — shared-shell fidelity failure — 2026-09-09

The earlier Wave 1 hardening pass was incorrect in claiming that shared header/footer fragments were visually consistent. Page-specific inline CSS continued to override the canonical shell at mobile widths, producing divergent menu states and footer geometry on pages including Our Work. The mobile comparison table also stacked its three cells without preserving the Conventional / Plumbing Track relationship, making the content difficult to interpret.

The correction centralized final header/footer precedence in `shared-navigation.css`, kept canonical fragments as the only menu/footer markup source, restored a readable solid header for the photographic Our Work hero, improved text wrapping, and made the mobile comparison relationship clearer.

The lesson remains current: **shared source files are not proof of shared rendered behavior. Verify the output.**

## Revision ledger — canonical menu and logo corrections — 2026-09-09 to 2026-09-10

1. `f99c49b` attempted to stabilize the two logo variants by overlapping them in one grid cell and adding mobile positioning. The positioning rule horizontally centered the mobile logo, which did not match the required left-aligned menu-bar layout and continued the stylesheet's high-specificity override problem.
2. `03a3b52` replaced the accumulated/conflicting `shared-navigation.css` blocks with one scoped canonical header/footer contract. The final contract keeps the logo on the left, vertically centers the logo and action cluster in the 68px mobile bar, swaps logo variants through opacity in one grid cell, and gives every page the same white mobile drawer state.
3. `bb7a709` reduced the desktop logo clamp by 20%, from `220px / 22vw / 300px` to `176px / 17.6vw / 240px`. The mobile rule remained `168px`.
4. `4881d81` was an incorrect spacing revision: it applied `0.5em` top and bottom margins to primary mobile menu rows as well as nested submenu links.
5. `b7a2c89` corrected that interpretation after operator clarification: primary rows returned to their prior spacing and `margin-block: 0.5em` applies only to nested `.nav-flyout a` links.

The previously recorded live-browser evidence at 550px and 1440px verified the final menu/logo state. That evidence is retained as historical verification; the 2026-09-10 source review did not independently repeat the full browser matrix.

---

# Assessment status

The expanded **Book an Assessment — Detailed Conversion Task** in `docs/WEBSITE_DESIGN_PLAN.md` remains a hardening/acceptance specification for the existing flow, not an instruction to rebuild it.

Source review already confirms the major structural requirements:

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

# Shared-fragment implementation rule

Shared source fragments remain the preferred way to prevent markup drift when identical chrome/behavior must stay synchronized.

Use them for canonical ownership, but distinguish **source reuse** from **deploy-time delivery**:

- canonical header/footer/testimonial markup should remain centralized;
- deployable public HTML should contain crawlable primary navigation and important shared content without requiring client JavaScript to create it;
- build/export-time fragment injection is preferred over duplicating manually maintained markup;
- page-specific content should stay local where sharing would create unnecessary coupling.

---

# Current navigation architecture

The current canonical menu is:

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

The section `<summary>` controls do not need to become links merely for clickability; each flyout now exposes the corresponding hub route explicitly.

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
Detailed Installation / Our Work / Technology as useful
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
- ~~Create canonical shared header/navigation and footer source fragments.~~
- ~~Create shared testimonial-card markup/styles for repeated proof sections.~~
- ~~Correct the shared mobile/desktop navigation shell and preserve the correction history.~~
- ~~Create `/how-it-works/` and route explanation before conversion.~~
- ~~Present the five-phase project process on How It Works.~~
- ~~Create `/how-it-works/installation/` as a real eight-step detailed child page using completed-work imagery.~~
- ~~Rework Our Work into a stronger proof/portfolio page.~~
- ~~Retain Client Portal in the current architecture.~~
- ~~Create and structurally implement the dedicated assessment flow.~~
- ~~Instrument assessment CTA/start/step/submit behavior at the source-event level.~~
- ~~Build/revise Affordable Housing / BC Housing.~~
- ~~Create `/about/` first draft.~~
- ~~Create `/solutions/` hub first draft.~~
- ~~Create Poly-B, Kitec, and Occupied Building Repiping solution-page first drafts.~~
- ~~Create `/technology/`, Accessible Plumbing, and Conventional-vs-Plumbing-Track first drafts.~~
- ~~Create `/resources/` and `/resources/faq/` first drafts while intentionally deferring unready guides.~~
- ~~Add basic title/meta-description/robots/canonical treatment across the new page family.~~
- ~~Apply current CTA attribution pattern to the new commercial pages.~~
- ~~Keep Grapher/documentation synchronization active and preserve correction history.~~

## P0 hardening gates

- [ ] Make primary navigation/footer crawlable in deployable/static HTML without requiring client JavaScript to create them; preserve canonical fragment source ownership through build/export injection or an equivalent static fallback.
- [ ] Add and verify root `sitemap.xml` for the intended public/indexable route set.
- [ ] Add and verify root `robots.txt`, including production-appropriate sitemap reference and deliberate handling of non-public/utility routes.
- [ ] Unify design tokens so all page-family routes define/use the variables expected by `shared-navigation.css`, including `--cyan` and `--cyan-soft`.
- [ ] Restore shared typography parity: new page-family routes should consume the existing site typography contract rather than drifting to Arial/Helvetica as the primary treatment.
- [ ] Verify every current public route by direct URL and refresh under the real static/server deployment configuration, including trailing-slash behavior, fragments, assets, links, and 404 handling.
- [ ] Perform final responsive QA across the **expanded** public route set, not only the original Wave 1 pages.
- [ ] Verify shared nav flyouts/mobile drawer/header/footer keyboard, focus, Escape, click-away, scrolled, and reduced-motion behavior.
- [ ] Verify homepage video on desktop/tablet/mobile and reduced-motion/fallback behavior.
- [ ] Verify production assessment API end to end, including structured payload, confirmation, failure, retry, duplicate-submit protection, and CRM/backend persistence.
- [ ] Verify every assessment CTA reaches the unified flow and preserves correct source-page/source-CTA attribution.
- [ ] Verify GA4 initializes exactly once on intended pages and the current event taxonomy behaves correctly in DebugView/production-equivalent testing.
- [ ] Confirm analytics receives no names, emails, phone numbers, addresses, free text, or other sensitive form values.
- [ ] Run final broken-link, missing-asset, console-error, accessibility-basics, performance, and static-serving regression checks.

## P1 hardening / quality

- [ ] Review About origin/founder/manufacturing claims against authoritative company material and add verified team/credibility depth from the design plan.
- [ ] Deepen Poly-B page with verified problem education, relevant FAQ, project proof, and richer internal linking.
- [ ] Deepen Kitec page with verified problem education, relevant FAQ, project proof, and richer internal linking.
- [ ] Deepen Occupied Building Repiping page with verified operational claims, resident/property-manager coordination detail, and proof.
- [ ] Add Affordable Housing as a first-class card/path on `/solutions/` while preserving `/bchousing/` unless a deliberate URL migration is approved.
- [ ] Review Affordable Housing displacement, asbestos, dust, cost, restoration, and regulatory language against authoritative source material.
- [ ] Review Technology and comparison claims against source/project evidence; add proof links where available.
- [ ] Review the comparison component for semantic table/screen-reader clarity in addition to visual mobile behavior.
- [ ] Expand FAQ from real verified customer questions; add FAQ structured data only if the visible content and implementation justify it.
- [ ] Add consistent OG/social metadata across public routes where useful.
- [ ] Add page-type-appropriate structured data/breadcrumbs where accurate; do not copy generic schema indiscriminately.
- [ ] Review image alt text and actual crop/quality on Detailed Installation and other real-project imagery.
- [ ] Review Our Work project facts/testimonials against verified source evidence.
- [ ] Connect solution/technology claims to relevant real projects and educational resources as those are published.
- [ ] Continue tightening CSS ownership so shared chrome lives in shared-shell CSS and page-family CSS remains page-focused.
- [ ] Make an explicit indexing decision for any route that remains too thin or unverified; do not accidentally publish unfinished pages as `index, follow`.

---

# Wave 2 — Depth Expansion After Current Draft Is Hardened

## Wave 2A — Dedicated route status: largely implemented

### About

- ~~`/about/` route~~ — implemented draft.
- ~~Origin / development / mission framing~~ — implemented at first-draft level.
- ~~Assessment CTA~~ — implemented.
- [ ] Add verified team, founder depth, credibility/system-evolution material and other approved proof from the design plan.

### Solutions

- ~~`/solutions/` hub~~ — implemented draft.
- ~~`/solutions/poly-b/`~~ — implemented draft.
- ~~`/solutions/kitec/`~~ — implemented draft.
- ~~`/solutions/occupied-building-repiping/`~~ — implemented draft.
- [ ] Integrate Affordable Housing into the Solutions hub body while preserving the current `/bchousing/` route unless an intentional migration is approved.
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

## Wave 2B — Commercial / decision-page depth

The route-creation portion of this wave is largely complete:

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
- [ ] deeper internal linking from Home, How It Works, Affordable Housing, Our Work, solution pages, Technology, and Assessment completion state;
- [ ] accessibility + metadata polish;
- [ ] source reconciliation before strong quantitative/absolute claims.

## Wave 2C — SEO / educational funnel pages

Retain the compositional SEO strategy: multiple focused articles act as landing/funnel points and link into deeper technical, proof, and commercial pages.

These remain planned even though they were intentionally omitted from the first-draft menu:

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

The current Our Work page remains part of the current draft. The project-proof library remains genuinely open:

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
2. Preserve the established navigation architecture unless a deliberate later decision changes it.
3. Keep How It Works explanatory before conversion.
4. Keep canonical shared fragments/components where synchronized source ownership prevents drift.
5. Do not make primary navigation or other important public content dependent exclusively on client JavaScript; generate or provide static deployable markup.
6. Keep page-specific content local when sharing would create unnecessary coupling.
7. Keep pages focused and indexable rather than returning to epic-scroll architecture.
8. Treat route existence as implementation progress, not automatic SEO/content completion.
9. Treat verified current implementation as truth unless a concrete defect or later decision supersedes it.
10. Keep Grapher synchronized continuously with implementation decisions, defects, reclassification, evidence, and verification results.
11. Do not mark analytics, SEO, accessibility, responsive behavior, source claims, or production integration complete without verification.
12. Treat the expanded Assessment section as hardening/acceptance criteria for the existing flow unless a later operator decision explicitly requests redesign.
13. Preserve intentionally deferred menu/content items in the later-wave plan rather than silently dropping them.

## Practical order

```text
P0 production blockers
  ↓
Whole-site Wave 1 hardening of the expanded current route set
  ↓
P1 source/content/proof/SEO depth on implemented commercial pages
  ↓
Wave 2C educational funnel library
  ↓
Wave 2D project-proof library
  ↓
Wave 3 growth features and long-tail expansion
```
