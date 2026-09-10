# `dev/updates` Branch Review — 2026-09-10

## Purpose

This document records the current source-level review of `dev/updates` against `main`, `docs/INSTRUCTIONS.md`, `docs/WEBSITE_DESIGN_PLAN.md`, the implementation roadmap, and current operator decisions.

It answers:

1. what is good and should be retained;
2. what still needs improvement;
3. how the implementation plan should be re-evaluated now that the dedicated page family exists.

## Review boundary

This is primarily a repository/source review. Prior browser verification already recorded in the roadmap is retained as historical evidence, but this review does not pretend to replace a production-host, GA4 DebugView, API, performance, or full accessibility audit.

`dev/updates` remains the current implementation baseline.

---

# Executive re-evaluation

The branch is no longer waiting for most of the original dedicated-page expansion to be built.

The following now exist as real first-draft routes:

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

These are not empty placeholders. They contain page-specific copy, titles/descriptions, canonical URLs, internal links, and conversion CTAs.

The planning consequence is:

> **Route creation is largely ahead of the old plan. Production hardening, source verification, content depth, and maintainability are now the priority.**

The branch should be treated as an implementation-complete first-draft candidate, not as a finished production release.

---

# What is good and should be retained

## 1. The information architecture is now real

The site has moved from navigation concepts to actual focused page families. This supports the intended multi-page SEO architecture and avoids returning to a single epic-scroll site.

## 2. Explanation correctly precedes conversion

`How It Works` now functions as an explanatory destination before Assessment. Detailed Installation and Technology provide deeper routes rather than forcing every visitor directly into a form.

Keep this hierarchy.

## 3. Shared chrome has one conceptual owner

Header/footer markup is centralized instead of manually diverging across every page. That ownership model is correct even though the current **runtime fragment delivery mechanism is not the preferred long-term implementation**.

The desired end state is one source for the header/footer combined with ordinary static HTML output.

## 4. The menu architecture is coherent

The current menu exposes:

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

Section `<summary>` controls can remain flyout controls because each flyout explicitly exposes its corresponding hub route.

## 5. Detailed Installation is substantive

`/how-it-works/installation/` contains an eight-step sequence and completed-work imagery. It is useful content rather than scaffolding.

## 6. Newer copy is generally cautious about claims

The newer routes frequently qualify project-specific outcomes and avoid promising that accessible plumbing prevents failure or that every project has identical disruption, sequencing, or restoration conditions.

Retain this discipline while evidence is reconciled.

## 7. Assessment attribution is carried through new CTAs

Commercial pages generally preserve `source_page`, `source_cta`, and `data-assessment-cta` patterns. This is a strong basis for CRM/GA4 attribution once verified end to end.

## 8. Basic SEO hygiene exists

The new page family generally contains unique titles, page-specific descriptions, canonical URLs, robots metadata, and a clear top-level heading.

## 9. Resources remains intentionally lean

FAQ, Client Portal, and How It Works are published without fabricating the deferred Problem Guides, Decision Guides, or Project Guides. Those remain later-wave work.

## 10. Grapher/documentation governance is useful

The branch keeps implementation decisions, corrections, and verification state in Grapher rather than flattening history. Continue that approach.

---

# What needs improvement

## P0 — Production / launch blockers

### 1. Replace runtime fragments with build-time partial/layout rendering

Current page-family HTML contains mounts such as:

```html
<div data-pt-header-fragment></div>
```

`site-header.js` then fetches the shared header/footer and inserts them after page load.

Centralized ownership is good; **runtime fetching is the painful part**.

Preferred replacement:

```text
source page/template
      +
shared layout
      +
_header partial
_footer partial
      ↓ build
ordinary deployable HTML
```

Requirements:

- edit header/footer once in source;
- render them into every generated page at build/export time;
- deploy normal HTML containing the actual navigation/footer;
- keep JavaScript only for menu interaction and enhancement;
- remove the runtime fragment `fetch()` requirement once migration is complete.

For this static repository, a small Ruby/ERB build script is a suitable low-complexity option. Eleventy/Nunjucks or another static templating tool could also do the job, but a large framework is not required.

### 2. `sitemap.xml` is absent

Create a canonical sitemap for intended public/indexable routes and keep it synchronized as article/project libraries expand.

### 3. `robots.txt` is absent

Add a deliberate production robots policy, reference the sitemap, and explicitly decide treatment for utility/private routes.

### 4. Cyan was intentionally removed; stale cyan references remain

Previous wording incorrectly framed this as a missing-token problem and recommended restoring `--cyan` / `--cyan-soft`.

**Correction:** cyan removal is intentional.

The actual defect is that `shared-navigation.css` still references removed variables such as:

```css
var(--cyan)
var(--cyan-soft)
```

Required improvement:

- remove the stale cyan references;
- replace them with the current canonical accent/palette contract;
- do **not** reintroduce cyan merely to satisfy old CSS;
- search the repository and documentation for other obsolete cyan assumptions;
- verify normal, hover, focus, scrolled, mobile-open, and active navigation states afterward.

### 5. Typography needs one explicit canonical contract

The homepage currently embeds/uses **Geist** while `page-family.css` falls back to Arial/Helvetica.

“Geist treatment” is not a design concept. It simply refers to the current homepage's Geist font-face / font-variable implementation.

The real requirement is:

- decide which typography is canonical for the current design;
- centralize that font/token contract;
- make all page families consume it consistently;
- do not treat the name “Geist” itself as an architectural requirement if the visual direction changes.

### 6. Production Assessment + analytics verification remains open

The assessment flow should be hardened rather than rebuilt, but production verification still needs to cover:

- `/api/public/assessment`;
- structured payload persistence / CRM handoff;
- failure, retry, duplicate-submit, and success behavior;
- CTA attribution;
- exactly one GA4 initialization where intended;
- assessment events in DebugView or equivalent;
- no PII/free-text leakage into analytics.

### 7. Complete route set needs production/static regression

Direct navigation, refresh, asset loading, links, trailing slashes, 404 behavior, generated shared chrome, and deployment behavior must be tested across the complete current route set.

---

## P1 — Important quality and SEO work

### 1. Solutions pages need depth beyond route existence

Poly-B, Kitec, and Occupied Building Repiping are useful first drafts but still need stronger source-backed education, proof, FAQs, and internal links.

### 2. Affordable Housing should be first-class in the Solutions hub

The menu includes it, but the body of `/solutions/` should also expose it directly while preserving `/bchousing/` unless an intentional URL migration occurs.

### 3. About needs the remaining credibility layer

The page has a legitimate first draft, but verified team/founder/system-development credibility material remains to be added where supported.

### 4. FAQ is an initial FAQ

Five useful questions justify the route, but it should not yet be treated as the complete resource destination.

### 5. Metadata consistency should be expanded deliberately

New routes should receive appropriate social metadata and structured data where it accurately represents visible content. Avoid boilerplate schema copied across unrelated page types.

### 6. Comparison semantics/accessibility need review

The Conventional vs Plumbing Track comparison should be evaluated for screen-reader comprehension and whether semantic table markup communicates the comparison more clearly.

### 7. Source-backed claim review remains required

Review claims around residents remaining home, reduced restoration/openings, disruption, About-page history, Affordable Housing language, and project/testimonial outcomes against authoritative evidence.

### 8. Internal linking should become proof-driven

Continue connecting Solutions, Technology, FAQ, educational articles, and Our Work so claims route naturally to evidence and useful deeper explanation.

### 9. CSS ownership can tighten further

Shared chrome rules belong in the shared shell stylesheet; page-family CSS should focus on page-family layout and components.

---

# Route-by-route status

| Route / area | Classification | Main remaining work |
|---|---|---|
| `/` | Implemented / hardening | video/device QA, analytics, global SEO/static checks |
| `/about/` | Implemented draft | source verification, credibility depth, shared visual contract |
| `/our-work/` | Implemented proof page | verify project facts; later individual project library |
| `/solutions/` | Implemented draft | add Affordable Housing; proof/internal links |
| `/solutions/poly-b/` | Implemented draft | deeper verified education, FAQ/project proof |
| `/solutions/kitec/` | Implemented draft | deeper verified education, FAQ/project proof |
| `/solutions/occupied-building-repiping/` | Implemented draft | verify resident/disruption claims; deepen proof |
| `/bchousing/` | Existing / hardening | claim review; stronger Solutions integration |
| `/how-it-works/` | Implemented | final responsive/a11y/static QA |
| `/how-it-works/installation/` | Implemented draft | source-check sequence, image/alt review, responsive/a11y QA |
| `/technology/` | Implemented draft | visual-contract cleanup, proof/claims, metadata depth |
| `/technology/accessible-plumbing/` | Implemented draft | visual/proof depth; wording/internal links |
| `/technology/conventional-vs-plumbing-track/` | Implemented draft | claim verification, semantic comparison review, evidence links |
| `/resources/` | Implemented lean hub | deferred guide/article taxonomy remains later work |
| `/resources/faq/` | Implemented initial FAQ | expand from verified customer questions |
| `/client-portal/` | Existing / retained | production/generated-shell regression |
| `/assessment/` | Structurally implemented | production API, analytics, no-PII, accessibility, device verification |

---

# Wave rebaseline

## Wave 1 — production hardening of the current public site

Wave 1 now covers the whole implemented first-draft route set, including the newer About, Solutions, Technology, Detailed Installation, Resources, and FAQ pages.

## Wave 2A — route creation is largely complete

Previously planned About, Solutions, Technology, Detailed Installation, Resources, and FAQ routes are now:

> **Implemented draft — refine, verify, deepen.**

## Wave 2B — mature commercial/decision pages

Remaining work is depth rather than duplicate route creation:

- stronger Poly-B/Kitec/occupied-building content;
- verified FAQs;
- project proof;
- internal linking;
- mature comparison content;
- final About credibility material.

## Wave 2C — SEO / educational funnels

Still deferred and intentionally retained:

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

## Wave 2D — Our Work expansion

Still deferred:

- reusable project-detail implementation;
- verified project pages;
- project galleries;
- project-to-solution / project-to-technology linking;
- portfolio filters only when project data supports them.

---

# Recommended execution order

```text
1. Replace runtime header/footer fragment loading with build-time partial rendering
2. Remove obsolete cyan references and normalize the current visual/token contract
3. Establish one explicit typography contract
4. Add sitemap.xml + robots.txt
5. Run whole-route responsive/accessibility/static/deployment regression
6. Verify Assessment + GA4 + no-PII behavior in production-like conditions
7. Reconcile claims and deepen current commercial pages
8. Build educational SEO funnels
9. Expand individual project proof
```

---

# Acceptance rule

The current branch remains the implementation baseline.

Future work should extend it rather than restart it, while preserving these rules:

1. focused, independently indexable pages;
2. explanation before conversion where visitors are still learning;
3. one canonical source for shared chrome;
4. build-time/server-side rendering of shared chrome rather than runtime fetch-only existence;
5. no resurrection of intentionally removed cyan styling merely to satisfy stale CSS;
6. one explicit current typography/token contract;
7. source-backed claims and proof;
8. verified analytics with no PII;
9. Grapher synchronized with durable implementation and planning decisions;
10. route existence is not the same as production readiness or mature SEO coverage.
