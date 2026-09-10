# Plumbing Track Website Implementation Roadmap

## Status basis

This roadmap is the living execution/status companion to `docs/WEBSITE_DESIGN_PLAN.md` and `docs/INSTRUCTIONS.md`.

The design plan remains the target architecture. This document reflects the actual state of `dev/updates` and accepts the operator's manual adjustments as the current implementation baseline.

## Main sync evaluation — 2026-09-09

`main` was recently synchronized with `dev/updates`. The substantive planning addition on `main` is the expanded **Book an Assessment — Detailed Conversion Task** in `docs/WEBSITE_DESIGN_PLAN.md`.

That expanded section is useful as an acceptance and verification specification, but it must **not** be interpreted as an instruction to rebuild the current assessment experience from scratch. Source review of the current implementation already confirms the major structural requirements:

- dedicated `/assessment/` route;
- progressive Building → Project → Contact → Review flow;
- structured building, project, contact, and attribution data;
- normal `Unsure`/unknown states rather than forcing diagnosis;
- only name and email required for follow-up;
- review and explicit success state;
- API error/retry handling and duplicate-submit guard;
- source page / CTA attribution support;
- `assessment_started`, `assessment_step_completed`, and `assessment_submitted` event emission;
- non-PII categorical parameters in the assessment-event code.

The assessment plan is therefore classified as **implemented at the source/interaction-design level, with production verification still required**. Remaining work belongs in Wave 1 hardening: production API behavior, actual GA4 initialization and DebugView verification, current CTA attribution coverage, no-PII verification, cross-device behavior, keyboard/focus/validation review, and confirmation that the live experience matches the intended visual standard.

### Shared-fragment implementation rule

The site now has an established lightweight fragment system. Shared header, footer, and testimonial-card markup are loaded from canonical templates rather than copied independently into every page.

Going forward:

- use a shared fragment when the **same markup and behavior** must stay synchronized across multiple pages;
- keep page-specific content local when it is genuinely unique;
- extend an existing fragment before creating competing copies of shared chrome or repeated proof components;
- verify fragment loading and fallback/static-serving behavior as part of Wave 1 hardening.

This is an implementation rule, not a mandate to turn every repeated sentence or page section into a fragment.

## Scope rule

**Menu clickability does not define wave membership.**

Grapher records the current navigation architecture as:

```text
About
Our Work
Solutions
How It Works
Our Technology
Resources
[ Book an Assessment ]
```

That architecture is already part of the current implementation. A section can therefore be **Wave 1** even when its menu item is currently a label/flyout rather than a standalone routed page.

Wave 2 is primarily the expansion of these already-established sections into additional dedicated, indexable pages and deeper content.

The one explicit current scope reduction recorded in Grapher is **Resources**: the menu was intentionally limited to FAQ and Client Portal until the remaining guides are ready. That reduction does not remove Resources from Wave 1.

## Current How It Works routing decision

`How It Works` is a Wave 1 explanatory destination, not a shortcut to the assessment form.

The intended first-draft flow is now:

```text
Home
  ↓
How It Works
  ↓
Accessible plumbing explanation
  ↓
Five-phase project process
  ↓
Our Work / proof
  ↓
Book an Assessment when the visitor is ready
```

The standalone `/how-it-works/` page should explain both the project sequence and why accessible routing matters. Assessment remains available as a downstream CTA, but it must not replace the explanatory step.

---

# Wave 1 — Current First Draft

Wave 1 is the current implemented site experience and the architecture already expressed through the homepage, navigation, existing public pages, shared components, and conversion flow.

## Completed or substantially implemented

- ~~Preserve the existing Plumbing Track visual identity rather than rebrand the site.~~
- ~~Preserve the homepage video/hero experience.~~
- ~~Restructure Home into a compact conversion journey rather than an epic-scroll copy dump.~~
- ~~Introduce accessible-plumbing/product explanation on Home.~~
- ~~Introduce routing/exploration cards on Home to represent the broader site architecture.~~
- ~~Establish the primary navigation hierarchy: About, Our Work, Solutions, How It Works, Our Technology, Resources.~~
- ~~Create shared header/navigation and footer fragments.~~
- ~~Create shared testimonial-card markup/styles for repeated proof sections rather than maintaining divergent copies.~~
- ~~Implement responsive navigation, click-away behaviour, mobile menu corrections, scroll-state behaviour, and reduced-motion handling.~~
- ~~Create `/how-it-works/` as a standalone explanatory page.~~
- ~~Route the homepage How It Works entry points to `/how-it-works/` rather than directly to Assessment.~~
- ~~Explain accessible plumbing as part of How It Works: deliberate enclosed routing, reduced unnecessary demolition, and future service access.~~
- ~~Present the five-phase project process on the How It Works page.~~
- ~~Keep Assessment as a downstream CTA after explanation/proof rather than the explanation itself.~~
- ~~Rework **Our Work** into a stronger responsive proof/portfolio page.~~
- ~~Retain the Client Portal and align it with the shared site shell.~~
- ~~Create the dedicated **Book an Assessment** route.~~
- ~~Implement the detailed assessment structure: Building → Project → Contact → Review, structured payload, unsure states, minimal required contact fields, attribution, review/success state, API error handling, and duplicate-submit protection.~~
- ~~Instrument assessment CTA clicks, starts, step completion, and successful submissions at the event-emission level.~~
- ~~Build/revise the Affordable Housing / BC Housing audience page.~~
- ~~Apply current visual hygiene across Home, Our Work, BC Housing, Assessment, and Client Portal surfaces.~~
- ~~Add initial SEO metadata/canonical/schema treatment to major Wave 1 pages.~~
- ~~Create reusable templates/scaffolding for future detailed installation, Technology, project-proof, header, footer, and repeated proof-card work.~~
- ~~Reduce Resources intentionally to FAQ + Client Portal until remaining guides are ready.~~
- ~~Initialize and synchronize Grapher implementation/test records for the branch.~~

## Wave 1 still needs hardening

- [ ] Verify homepage video behaviour on desktop, tablet, and mobile, including reduced-motion/fallback behaviour.
- [ ] Perform final responsive QA across Home, How It Works, Our Work, Affordable Housing, Assessment, and Client Portal.
- [ ] Verify `/how-it-works/` at desktop, tablet, and mobile widths and confirm no broken shared-header/footer behavior.
- [ ] Verify shared header/footer/testimonial fragments are consistently applied where intended and load correctly under production/static-serving conditions.
- [ ] Verify non-clickable navigation labels/flyouts are intentional and visually understandable rather than appearing broken.
- [ ] Verify all active Wave 1 links, anchors, asset paths, and CTA destinations.
- [ ] Verify every current Wave 1 assessment CTA reaches the unified assessment flow and preserves useful source-page / CTA attribution.
- [ ] Verify the production assessment API end-to-end, including structured payload acceptance, compatibility fields, error handling, confirmation state, and retry behavior.
- [ ] Verify keyboard flow, focus movement, labels, validation messaging, and mobile/desktop usability of the assessment flow.
- [ ] Verify GA4 initialization exactly once on intended public pages; event-emission code alone does not complete analytics.
- [ ] Verify assessment events in GA4 DebugView/production-equivalent testing and confirm no names, email addresses, phone numbers, addresses, free text, or other sensitive form values are transmitted.
- [ ] Add/verify page-view, primary-navigation, How It Works engagement, contact/phone, Our Work engagement, and other intentional Wave 1 events required by `INSTRUCTIONS.md`.
- [ ] Verify canonical URLs, titles, meta descriptions, OG metadata, structured data, alt text, sitemap, and robots behaviour for Wave 1 indexable pages.
- [ ] Review Affordable Housing claims against authoritative source material, especially displacement, asbestos, dust, cost, and regulatory language.
- [ ] Review project facts/testimonials displayed in Our Work against verified source evidence.
- [ ] Run final broken-link, console-error, accessibility-basics, performance, and static-serving regression checks.

---

# Wave 2 — Dedicated Page Expansion

Wave 2 does **not** introduce the missing concepts from scratch. It expands the Wave 1 architecture into the fuller set of dedicated, indexable pages set out in the design plan.

## Wave 2A — Standalone destinations for established Wave 1 sections

### About

- [ ] `/about/`
- [ ] Company history / origin story
- [ ] Development of Plumbing Track
- [ ] Mission, values, credibility, founder/team material
- [ ] Assessment CTA

### Solutions

- [ ] `/solutions/` hub
- [ ] `/solutions/poly-b/`
- [ ] `/solutions/kitec/`
- [ ] `/solutions/occupied-building-repiping/`
- [ ] Integrate the existing Affordable Housing / BC Housing work into the Solutions architecture without discarding the current page

### How It Works expansion

- ~~`/how-it-works/` high-level explanation and five-phase process — promoted into Wave 1.~~
- [ ] `/how-it-works/installation/` detailed installation process
- [ ] Reuse/refine the existing project-process template for the detailed child page where useful

### Our Technology

- [ ] `/technology/` or equivalent Technology landing page
- [ ] Accessible Plumbing deep-dive page
- [ ] Conventional vs Plumbing Track comparison page
- [ ] Reuse/refine the existing accessible-plumbing template

### Resources / Learn

- [ ] `/learn/` or `/resources/` crawlable hub
- [ ] Expand FAQ
- [ ] Problem Guides
- [ ] Decision Guides
- [ ] Project Guides
- [ ] Keep Client Portal integrated into this architecture

## Wave 2B — Commercial and decision child pages

- [ ] Poly-B replacement page
- [ ] Kitec replacement page
- [ ] Occupied-building repiping page
- [ ] Conventional vs Plumbing Track buying comparison
- [ ] Detailed installation page
- [ ] Full FAQ destination
- [ ] Deep internal linking from Home, How It Works, Affordable Housing, Our Work, and Assessment completion state

## Wave 2C — SEO / educational funnel pages

Retain the compositional SEO strategy: multiple focused articles that act as landing/funnel points and link into deeper technical, proof, and commercial pages.

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

## Wave 2D — Our Work expansion

The current Our Work page remains Wave 1. Wave 2 deepens it into a project-proof library.

- [ ] Create reusable individual project-page implementation from the existing project-proof template
- [ ] Initial verified project detail pages
- [ ] Project gallery treatment using real completed Plumbing Track photography
- [ ] Project-to-solution and project-to-technology internal linking
- [ ] Filter/group portfolio only where project data is verified and sufficiently complete

---

# Wave 3 — Expansion After Core Architecture

- [ ] Remaining verified project pages
- [ ] Deeper educational/editorial content after review and approval
- [ ] Downloadable lead resources
- [ ] Building-risk / assessment tools beyond the current form
- [ ] Geographic SEO landing pages where justified by actual service coverage and search strategy
- [ ] Additional CRM/GA4 enrichment once the basic event model is stable

---

# Navigation rollout

## Wave 1

The current navigation hierarchy itself is already implemented:

```text
ABOUT
OUR WORK
SOLUTIONS
HOW IT WORKS → /how-it-works/
OUR TECHNOLOGY
RESOURCES
[ BOOK AN ASSESSMENT ]
```

Some entries currently function as labels/flyouts rather than standalone routes. That is a current implementation choice, not evidence that the section is outside Wave 1.

`How It Works` is now an active standalone destination because it carries explanatory content that should precede conversion.

Resources is deliberately narrowed to the ready subset while maintaining its place in the architecture.

Do not fabricate thin/empty pages simply to make every label clickable.

## Wave 2

Wave 2 makes more of the established hierarchy independently routable and indexable:

```text
SOLUTIONS
  Poly-B Replacement
  Kitec Replacement
  Occupied Building Repiping
  Affordable Housing

HOW IT WORKS
  How It Works / Accessible Plumbing overview   [Wave 1]
  Detailed Installation                         [Wave 2]

OUR TECHNOLOGY
  Accessible Plumbing deep dive
  Conventional vs Plumbing Track

OUR WORK
  Project Portfolio
  Individual Projects

LEARN / RESOURCES
  Problem Guides
  Decision Guides
  Project Guides
  FAQ
  Client Portal

ABOUT
```

---

# Acceptance rule going forward

The current branch is the implementation baseline. Future work should **extend it rather than restart it**.

1. Preserve the current visual language and homepage video.
2. Preserve the established Wave 1 navigation architecture unless a deliberate later decision changes it.
3. Do not infer scope solely from whether a menu item currently has an `href`.
4. Route explanation before conversion when the visitor is still learning how Plumbing Track works.
5. Reuse shared components/templates/fragments where the same markup or behavior must stay synchronized across pages.
6. Keep page-specific content local when sharing it would create unnecessary coupling.
7. Keep pages focused and indexable rather than returning to epic-scroll architecture.
8. Treat verified current implementation as truth unless a concrete defect is found.
9. Keep Grapher synchronized with implementation decisions and verification results continuously, not only at the end of a documentation session.
10. Do not mark analytics, SEO, accessibility, responsive, or production integration work complete without verification.
11. Treat the expanded Assessment design section as a verification/hardening specification for the existing flow unless a later operator decision explicitly calls for redesign.

Practical order:

```text
Wave 1: verify and harden the current first draft; do not rebuild already-implemented Assessment/How It Works work
        ↓
Wave 2A: add dedicated routes for the remaining established sections
        ↓
Wave 2B: deepen commercial/decision pages
        ↓
Wave 2C: expand SEO/education funnels
        ↓
Wave 2D: deepen project proof library
        ↓
Wave 3: growth features and long-tail expansion
```
