# `dev/updates` Branch Review — 2026-09-10

## Purpose

This document records a fresh source-level review of `dev/updates` against `main`, `docs/INSTRUCTIONS.md`, `docs/WEBSITE_DESIGN_PLAN.md`, the current implementation roadmap, and the current operator decisions already represented in the repository and Grapher.

It answers three questions:

1. What in the branch is good and should be retained?
2. What needs improvement before the current implementation should be treated as production-ready?
3. How should the Wave 1 / Wave 2 plan be re-evaluated now that implementation has moved beyond the previous roadmap?

## Review boundary

This review inspected the repository state and implementation source on `dev/updates`. It also preserves prior browser-verification evidence already recorded in `docs/IMPLEMENTATION_ROADMAP.md`, including the 550px and 1440px shared-shell checks.

This review did **not** independently repeat a full production-host browser, GA4 DebugView, assessment API, performance, or accessibility audit. Those remain explicit verification gates rather than being inferred from source inspection.

At the review snapshot, `dev/updates` is a straight-line branch ahead of `main` with no divergence. The implementation has progressed substantially beyond the roadmap's older unchecked Wave 2 route-creation tasks.

---

# Executive re-evaluation

The most important planning correction is simple:

> **The branch is no longer waiting for most of the Wave 2A page family to be built. Those routes now exist as real first-draft pages. The next job is to harden, reconcile, deepen, and verify them.**

The following are now implemented as routed, indexable draft pages rather than future concepts:

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

The current primary navigation also exposes those destinations through the canonical shared menu. Affordable Housing remains at `/bchousing/` and Client Portal remains at `/client-portal/`.

That is meaningful progress. It also changes the risk profile: the primary danger is now publishing a large family of technically indexable pages before the crawlability, design-system consistency, content depth, analytics, source verification, and deployment behavior have been fully hardened.

The branch should therefore be treated as an **implementation-complete first-draft candidate**, not as a finished production release.

---

# What is good and should be retained

## 1. The information architecture is now real

The branch has moved from navigation concepts to actual page families. Solutions, Technology, About, Resources, FAQ, and Detailed Installation are not empty placeholders; they contain page-specific titles, descriptions, canonicals, body copy, internal links, and assessment CTAs.

This is the right architectural direction because it supports focused pages instead of recreating the previous epic-scroll model.

## 2. Explanation now correctly precedes conversion

The current How It Works decision is implemented in the architecture: visitors can learn the accessible-plumbing idea and project process before being pushed into the assessment form. Detailed Installation then provides a deeper child route.

Keep this hierarchy. Do not collapse How It Works back into a disguised assessment CTA.

## 3. Shared navigation and footer ownership is much cleaner

`templates/site-header.html` and `templates/site-footer.html` are the canonical shared-chrome sources. `shared-navigation.css` now carries a scoped shared-shell contract rather than letting page-local menu copies drift independently.

The correction ledger in the implementation roadmap is valuable and should remain. It documents the failed intermediate mobile/logo revisions instead of rewriting history as though the final CSS appeared correctly on the first attempt.

## 4. The current menu architecture is coherent

The menu now exposes:

```text
About
Our Work
Solutions
  Solutions
  Poly-B Replacement
  Kitec Replacement
  Occupied Building Repiping
  Affordable Housing
How It Works
  How It Works
  Project Process
  Detailed Installation
Our Technology
  Our Technology
  Accessible Plumbing
  Conventional vs Plumbing Track
Resources
  Resources
  FAQ
  Client Portal
Book an Assessment
```

This resolves the earlier ambiguity around non-clickable section labels. The `<summary>` itself can remain a flyout control while the flyout provides an explicit section landing-page link.

## 5. Detailed Installation uses real project imagery

`/how-it-works/installation/` is a meaningful first draft, not scaffolding. It includes an eight-step sequence and real completed-work image assets in `/img/completed-work/web/`.

The copy is also appropriately qualified: it explains that exact sequencing depends on the building and avoids promising zero disruption.

## 6. The newer copy is generally more disciplined about claims

Several new pages explicitly avoid absolute promises and tell the reader that building-specific scope depends on assessment and verified conditions. Technology copy correctly avoids claiming that accessible plumbing prevents pipe failure. The comparison page frames itself as an architectural distinction rather than a universal project guarantee.

That restraint should be retained while factual evidence is reconciled.

## 7. Assessment attribution is being carried through new CTAs

New commercial pages generally send visitors to `/assessment/` with `source_page` and `source_cta` query parameters and also expose `data-assessment-cta` for event handling.

That is a strong pattern for later CRM and GA4 attribution, subject to end-to-end verification.

## 8. Basic page-level SEO hygiene exists

The new page family generally contains:

- a unique `<title>`;
- a page-specific meta description;
- `index, follow` robots metadata;
- a canonical URL;
- a single clear page-level hero heading.

This is a useful baseline and should be extended rather than replaced.

## 9. Resources was kept intentionally lean

The current `/resources/` page exposes FAQ, Client Portal, and How It Works without pretending the unapproved Problem Guides, Decision Guides, and Project Guides already exist.

That matches the operator decision to retain removed/not-ready menu material as later-wave work instead of deleting it from the plan or publishing thin placeholder pages.

## 10. Grapher/documentation governance is improving

The branch already contains explicit documentation indexing, continuous Grapher-use policy, semantic records for the How It Works decision, the assessment-hardening interpretation, shared-fragment reuse, and correction history. The GitHub workflow installs the pinned Grapher version and runs validation/audit after documentation synchronization.

Keep this history-preserving approach.

---

# What needs improvement

## P0 — Production / launch blockers

### 1. Primary shared navigation is still client-JavaScript dependent

The page-family HTML files contain fragment mounts such as:

```html
<div data-pt-header-fragment></div>
```

`site-header.js` then fetches `/templates/site-header.html` and replaces the mount after page load. The footer follows the same pattern.

This is maintainable as a **source-fragment model**, but it conflicts with the project's own SEO requirements that primary navigation be crawlable and that important content not exist exclusively behind JavaScript.

Required improvement:

- retain canonical shared fragment source files;
- inject shared header/footer markup into deployable HTML at build/export time, or provide an equivalent static fallback;
- keep client JavaScript for interaction/enhancement, not for the existence of the primary navigation itself;
- verify direct-route/static-host behavior with JavaScript disabled or fragment fetch deliberately failed.

### 2. `sitemap.xml` is absent

The repository currently has no root `sitemap.xml` on `dev/updates` even though the branch now contains many more indexable pages.

Required improvement:

- create a canonical sitemap containing the intended public/indexable route set;
- exclude routes that should not be indexed;
- verify it matches the actual deployed canonical URLs;
- keep it synchronized as the article and project libraries expand.

### 3. `robots.txt` is absent

There is currently no root `robots.txt` on `dev/updates`.

Required improvement:

- add a deliberate production robots policy;
- reference the sitemap;
- verify that client/private/utility paths are handled intentionally rather than accidentally;
- verify staging environments are not confused with production policy.

### 4. The new page-family design tokens do not fully match the shared navigation contract

`page-family.css` defines `--ink`, `--panel`, `--paper`, `--steel`, `--gold`, and related variables, but it does **not** define the `--cyan` or `--cyan-soft` tokens used by `shared-navigation.css`.

On routes that load only `page-family.css` + `shared-navigation.css`, rules such as CTA hover/border and menu-arrow accent colors therefore rely on undefined custom properties.

Required improvement:

- establish one canonical token source or explicit compatible fallback values;
- remove cross-file assumptions about variables that a page family does not load;
- verify normal, hover, focus, scrolled, mobile-open, and active states on every page family.

### 5. Typography has drifted from the stated visual baseline

The homepage defines and uses the existing Geist typography treatment. `page-family.css` currently falls back to Arial/Helvetica and does not load the same font/token contract.

That contradicts the design-plan rule to preserve the current typography and visual language.

Required improvement:

- centralize the shared font-face/design tokens;
- make the new page family consume the same typography contract as the existing site;
- verify the change does not regress layout at desktop/tablet/mobile widths.

### 6. Production assessment + analytics verification remains open

The source structure of the assessment flow is already mature enough that it should be hardened, not rebuilt. However source code alone does not prove production integration.

Before release, verify:

- `/api/public/assessment` against the production backend;
- successful structured payload persistence/CRM handoff;
- failure, retry, duplicate-submit, and confirmation behavior;
- every current assessment CTA's source attribution;
- exactly one GA4 initialization on each intended public page;
- assessment CTA/start/step/submit events in DebugView or an equivalent production-like test;
- no PII, free text, address, phone, email, or other sensitive form values in analytics payloads.

### 7. The complete new route set needs direct-route/static-serving regression

The branch has added enough routes that the verification matrix must expand beyond the original Wave 1 subset.

At minimum, test direct navigation and refresh behavior for every public route, fragment/static assets, internal links, canonical paths, trailing-slash behavior, and 404 behavior under the actual production server/static-serving configuration.

---

## P1 — Important quality and SEO work

### 1. Solutions pages are useful drafts but currently too thin to be considered mature SEO landing pages

The Poly-B, Kitec, and Occupied Building Repiping pages establish the correct intent and route visitors onward, but they do not yet contain the depth described in the design plan: verified problem education, stronger project proof, substantive FAQs, and richer internal links.

Do not mistake “route exists” for “search-intent coverage complete.”

### 2. Affordable Housing is not yet integrated into the Solutions hub body

The shared header correctly links Affordable Housing under Solutions, but `/solutions/` itself currently presents only Poly-B, Kitec, and Occupied Building Repiping cards.

Required improvement:

- add Affordable Housing as a first-class Solutions path;
- preserve `/bchousing/` unless a deliberate URL migration is planned;
- if a future URL changes, define an intentional redirect/canonical migration rather than creating duplicate pages.

### 3. About is implemented but incomplete against the target credibility plan

`/about/` contains origin, mission, project-management positioning, founder framing, and an assessment CTA. It does not yet carry the full intended credibility layer: verified team information, founder depth, system evolution, Dragons' Den/other credibility material where appropriate, and verified business claims.

Treat it as a strong first draft, not a finished About page.

### 4. FAQ is an initial FAQ, not the full resource destination

The current FAQ contains five useful questions. That is enough to justify the route, but not enough to mark the design-plan FAQ expansion complete.

Future improvement should be driven by real customer questions and verified source material. Add FAQ structured data only if the final visible content and implementation justify it.

### 5. New routes need richer metadata consistency

The homepage currently has Open Graph, Twitter metadata, and Organization JSON-LD in addition to basic SEO tags. New page-family routes generally stop at title/description/canonical/robots.

Required improvement:

- add consistent social metadata where useful;
- add breadcrumb/organization/service/article/project structured data only where it accurately represents the visible page;
- avoid boilerplate schema copied indiscriminately across page types.

### 6. The comparison UI should receive semantic/accessibility review

The Conventional vs Plumbing Track comparison is visually represented with nested `<div>` rows and an `aria-label`. The mobile layout was improved, but the final component should be reviewed for screen-reader comprehension, keyboard/focus behavior where applicable, and whether semantic table markup would communicate the relationship more clearly.

### 7. Source-backed claim review is still required

Specific language that deserves explicit evidence review before production includes, without limitation:

- residents staying home;
- reduced restoration / fewer openings;
- occupied-building disruption claims;
- the About-page origin/manufacturing story;
- asbestos, dust, cost, and displacement language on Affordable Housing;
- project outcomes and testimonial facts on Our Work.

Where evidence supports a claim, keep it. Where evidence is weaker, qualify or remove it rather than inventing precision.

### 8. Internal linking should become proof-driven, not only architecture-driven

The current draft has sensible navigational cross-links. The next layer should connect solution claims to real project evidence, technology explanations, FAQs, and educational articles. That is where the compositional SEO strategy becomes materially stronger.

### 9. CSS ownership can be tightened further

The canonical shared navigation/footer contract is much better than the earlier page-local drift, but `page-family.css` still contains some generic shell-adjacent declarations such as `footer.site-footer`.

Continue moving truly shared chrome behavior into the shared shell and keep page-family CSS focused on page-family layout/components.

---

# Route-by-route status

| Route / area | Current classification | What is good | What remains |
|---|---|---|---|
| `/` | Implemented / hardening | Existing identity, video, routing story retained | video/device QA, analytics, global SEO/static checks |
| `/about/` | Implemented draft | real origin/mission/founder content + CTA | source verification, team/credibility depth, shared design-token parity |
| `/our-work/` | Implemented Wave 1 proof page | existing proof/portfolio direction retained | verify project facts; individual project library remains later work |
| `/solutions/` | Implemented draft | clear routing hub | add Affordable Housing in body; richer proof/internal links |
| `/solutions/poly-b/` | Implemented draft | focused intent, cautious claims, assessment route | deeper verified Poly-B education, FAQ/project proof |
| `/solutions/kitec/` | Implemented draft | focused intent, cautious claims | deeper verified Kitec education, FAQ/project proof |
| `/solutions/occupied-building-repiping/` | Implemented draft | strong operational framing | verify resident/disruption claims; add proof and deeper coordination content |
| `/bchousing/` | Existing / hardening | dedicated audience page retained | source-review claims; integrate clearly from Solutions hub |
| `/how-it-works/` | Implemented | correct explanation-before-conversion flow | final responsive/a11y/static QA |
| `/how-it-works/installation/` | Implemented draft | eight-step story + real job imagery | source-check sequence, image crop/alt review, responsive/a11y QA |
| `/technology/` | Implemented draft | strong accessible-plumbing thesis, non-absolute failure language | typography/tokens, proof/claims, metadata depth |
| `/technology/accessible-plumbing/` | Implemented draft | focused concept, clearly says accessible ≠ exposed | add visual/proof depth; verify wording and cross-links |
| `/technology/conventional-vs-plumbing-track/` | Implemented draft | independently indexable buying comparison | claim verification, semantic/a11y table review, evidence links |
| `/resources/` | Implemented lean hub | intentionally publishes only ready material | later guides/article taxonomy remain Wave 2 |
| `/resources/faq/` | Implemented initial FAQ | useful real route | expand from verified customer questions; consider valid FAQ schema |
| `/client-portal/` | Existing / retained | remains in Resources architecture | production/static/shared-shell regression |
| `/assessment/` | Structurally implemented / production verification open | dedicated progressive conversion flow and attribution model | production API, GA4, no-PII, accessibility and cross-device verification |

---

# Wave rebaseline

## Wave 1 — now means production hardening of the current public site

Wave 1 should no longer be described as only the original handful of pages. The current public first draft includes the newly routed About, Solutions, Technology, Detailed Installation, Resources, and FAQ pages as well.

Wave 1 acceptance now requires the **whole current public route set** to pass the production hardening gates.

## Wave 2A — route creation is largely complete

The previous roadmap treated About, Solutions, Technology, Detailed Installation, Resources, and FAQ as routes still to be created. That is stale.

Reclassify those items as:

> **Implemented draft — refine, verify, deepen.**

The major remaining Wave 2A-style work is not basic route creation; it is content completeness, source reconciliation, visual/system consistency, and integration.

## Wave 2B — first commercial/decision pages are also largely implemented drafts

Poly-B, Kitec, Occupied Building Repiping, Conventional vs Plumbing Track, Detailed Installation, and FAQ now exist.

Their remaining work is:

- content depth;
- verified claims;
- relevant project proof;
- stronger cross-linking;
- accessibility/metadata polish;
- production QA.

## Wave 2C — educational SEO funnels remain genuinely deferred

Keep the planned article library as later-wave work. Do not remove it merely because it was omitted from the first-draft menu.

Still planned:

- What Is Poly-B?
- What Is Kitec?
- Asbestos & Repiping
- Pipe Identification Guide
- The Case for Not Burying Your Plumbing
- How Long Does a Repipe Take?
- Do Residents Need to Move Out?
- What Does It Look Like Finished?
- Preparing a Building
- Preparing Residents
- What Happens During Installation?
- What Happens After Installation?
- Why Future Access Matters

These should become focused landing/funnel articles, not one giant Learn page.

## Wave 2D — project-proof library remains genuinely deferred

The current Our Work page remains useful. Individual verified project pages, reusable project-page templates, richer completed-work galleries, project filters, and project-to-solution/technology linking remain real future work.

## Wave 3 — growth remains unchanged

Long-tail geographic SEO, downloadable lead resources, richer building-risk tools, deeper CRM/GA4 enrichment, and broader editorial expansion remain post-core growth work.

---

# Recommended execution order from this review

```text
P0: static crawlable shell + sitemap/robots + design-token/font parity
  ↓
P0: production assessment / GA4 / no-PII / CTA-attribution verification
  ↓
P0: all-route direct-load, link, asset, responsive, accessibility and static-serving regression
  ↓
P1: source verification + content depth + proof integration on current commercial pages
  ↓
P1: metadata/schema/internal-linking consistency
  ↓
Wave 2C: focused educational SEO funnels
  ↓
Wave 2D: verified individual project-proof library
  ↓
Wave 3: growth features and long-tail expansion
```

Do not restart the site. Do not rebuild the existing assessment flow from scratch. Do not discard the new page family. Harden what exists, correct the concrete defects, then deepen it with verified content and proof.

---

# Acceptance conditions before the current branch is called production-ready

- [ ] Primary navigation and footer are present in deployable/static HTML without requiring client JavaScript to exist.
- [ ] `sitemap.xml` exists and matches the intended indexable canonical route set.
- [ ] `robots.txt` exists, intentionally references the sitemap, and matches production policy.
- [ ] Shared design tokens are defined consistently; no page-family route depends on undefined `--cyan` / `--cyan-soft` variables.
- [ ] New page-family routes use the intended shared typography rather than drifting to an unrelated fallback treatment.
- [ ] Every current public route loads directly and after refresh under the real production/static-serving configuration.
- [ ] Shared navigation/flyouts/header/footer work on desktop, tablet, and mobile; keyboard and Escape behavior are verified.
- [ ] Homepage video and motion respect reduced-motion and device/browser constraints.
- [ ] Assessment API is verified end to end in the production-equivalent environment.
- [ ] GA4 is initialized exactly once where intended and the event taxonomy is verified.
- [ ] Analytics payloads contain no PII/sensitive form values.
- [ ] Every assessment CTA preserves correct source-page/source-CTA attribution.
- [ ] Source-backed claims on About, Solutions, Affordable Housing, Technology, FAQ, and Our Work are reconciled.
- [ ] Canonical/title/description/OG/social/schema/alt-text behavior is reviewed across the actual public route set.
- [ ] Broken-link, missing-asset, console-error, accessibility-basics, and performance checks pass.
- [ ] Any intentionally thin/unready route is either improved before publication or given an explicit indexing decision rather than accidentally shipping as `index, follow`.
- [ ] Grapher reflects this rebaseline and all subsequent implementation/verification findings.

## Bottom line

The branch is materially better than the old roadmap makes it look. The architecture has caught up quickly: most of the first dedicated page family exists and the shared-shell work is moving in the right direction.

The next phase should not be another redesign. It should be a disciplined production-hardening pass followed by source-backed content/proof depth. The plan has been rebaselined accordingly.
