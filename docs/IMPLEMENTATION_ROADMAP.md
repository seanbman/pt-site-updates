# Plumbing Track Website Implementation Roadmap

## Status basis

This roadmap is the living execution/status companion to `docs/WEBSITE_DESIGN_PLAN.md` and `docs/INSTRUCTIONS.md`.

The design plan remains the target architecture. This document reflects the actual state of `dev/updates` as of the current first draft and accepts the operator's manual adjustments as the working baseline.

**Important scope rule:** pages intentionally omitted from the first-draft menu are **not cancelled**. They move to **Wave 2** unless explicitly removed later.

---

# Wave 1 — First Draft / Current Branch

Wave 1 is the smaller, launch-oriented slice represented by the current `dev/updates` branch.

## Completed or substantially implemented

- ~~Preserve the existing Plumbing Track visual identity rather than rebrand the site.~~
- ~~Preserve the homepage video/hero experience.~~
- ~~Restructure the Home page around the newer positioning and current visual system.~~
- ~~Create a shared header/navigation implementation and shared footer scaffolding.~~
- ~~Implement responsive menu behaviour and reduced-motion handling in the shared front-end code.~~
- ~~Rework **Our Work** into a stronger first-draft proof/portfolio page.~~
- ~~Retain the existing Client Portal and align it with the shared site shell where practical.~~
- ~~Create the dedicated **Book an Assessment** route.~~
- ~~Implement the multi-step assessment form, review step, API submission, success state, and source attribution.~~
- ~~Instrument assessment CTA clicks, assessment starts, step completion, and successful submissions at the event-emission level.~~
- ~~Build/revise the Affordable Housing / BC Housing page as a dedicated audience page.~~
- ~~Add initial SEO metadata/canonical/schema treatment to major Wave 1 pages.~~
- ~~Add initial reusable templates for future How It Works, Technology, header/footer, and project-proof content.~~
- ~~Initialize/synchronize Grapher state for the branch.~~

## Wave 1 still needs hardening before it should be treated as production-complete

- [ ] Verify the homepage video on desktop, tablet, and mobile, including reduced-motion behaviour and fallback behaviour.
- [ ] Perform responsive QA across Home, Our Work, Affordable Housing, Assessment, and Client Portal.
- [ ] Verify the shared header/footer is used consistently across all Wave 1 public pages where appropriate.
- [ ] Ensure first-draft navigation contains no misleading dead links. Wave 2 destinations may remain labels/placeholders until their pages exist.
- [ ] Verify all Wave 1 internal links, anchors, asset paths, and CTA destinations.
- [ ] Verify the production assessment API end-to-end, including error handling and confirmation state.
- [ ] Verify GA4 initialization itself is present exactly once on intended public pages; event-emission code alone does not complete analytics.
- [ ] Verify the assessment event taxonomy in GA4 DebugView/production-equivalent testing and confirm no sensitive form values are transmitted.
- [ ] Add/verify page-view, primary navigation, contact/phone, Our Work engagement, and other intentional Wave 1 events where required by `INSTRUCTIONS.md`.
- [ ] Verify canonical URLs, titles, meta descriptions, OG metadata, structured data, alt text, sitemap, and robots behaviour for all Wave 1 indexable pages.
- [ ] Review Affordable Housing claims against authoritative source material, especially displacement, asbestos, dust, cost, and regulatory language.
- [ ] Review project facts/testimonials displayed in Our Work against verified source evidence.
- [ ] Run a final broken-link, console-error, accessibility-basics, performance, and static-serving regression pass.

---

# Wave 2 — Core Pages Intentionally Omitted From the First-Draft Menu

These pages remain important parts of the target architecture. Their absence from the current menu is treated as first-draft scope reduction, **not removal from the site plan**.

## Wave 2A — Restore the complete primary information architecture

Highest priority because these are first-class destinations from the intended main navigation.

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
- [ ] Integrate the existing Affordable Housing / BC Housing work into the Solutions architecture without discarding the current page content

### How It Works

- [ ] `/how-it-works/` five-phase project overview
- [ ] `/how-it-works/installation/` detailed installation process
- [ ] Reuse/refine the existing project-process template rather than duplicating markup unnecessarily

### Our Technology

- [ ] `/technology/` or equivalent primary Technology landing page
- [ ] Accessible Plumbing page
- [ ] Conventional vs Plumbing Track comparison page
- [ ] Reuse/refine the existing accessible-plumbing template

### Learn / Resources

- [ ] `/learn/` or `/resources/` crawlable hub
- [ ] FAQ
- [ ] Problem Guides
- [ ] Decision Guides
- [ ] Project Guides
- [ ] Keep Client Portal discoverable within this architecture

## Wave 2B — Commercial and decision child pages

- [ ] Poly-B replacement page
- [ ] Kitec replacement page
- [ ] Occupied-building repiping page
- [ ] Conventional vs Plumbing Track buying comparison
- [ ] Detailed installation page
- [ ] FAQ
- [ ] Relevant internal links from Home, Affordable Housing, Our Work, and Assessment completion state

## Wave 2C — SEO / educational funnel pages

These retain the original plan's compositional SEO strategy: multiple useful pages that link into deeper technical/commercial material rather than one giant article.

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

The current Our Work page is a Wave 1 first draft. The deeper proof architecture remains Wave 2.

- [ ] Create a reusable individual project-page implementation from the existing project-proof template
- [ ] Initial verified project detail pages
- [ ] Project gallery treatment using real completed Plumbing Track photography
- [ ] Project-to-solution and project-to-technology internal linking
- [ ] Filter/group portfolio only where project data is verified and sufficiently complete

---

# Wave 3 — Expansion After Core Architecture

These remain useful but should not delay Wave 1 hardening or Wave 2 restoration of the intentionally omitted main-menu architecture.

- [ ] Remaining verified project pages
- [ ] Deeper educational/editorial content after review and approval
- [ ] Downloadable lead resources
- [ ] Building-risk / assessment tools beyond the current form
- [ ] Geographic SEO landing pages where justified by actual service coverage and search strategy
- [ ] Additional CRM/GA4 enrichment once the basic event model is stable

---

# Re-evaluated navigation rollout

## Wave 1 navigation

The current first draft may expose only destinations that are actually ready, while preserving placeholders/labels for planned sections where useful to communicate future hierarchy.

Primary working destinations:

```text
HOME
OUR WORK
RESOURCES / CLIENT PORTAL
BOOK AN ASSESSMENT
```

Affordable Housing may continue to be reached through contextual links/CTAs while the full Solutions tree is deferred.

Do not fabricate empty destination pages just to make every planned menu label clickable.

## Wave 2 target navigation

Once the omitted pages are built, restore the fuller intended architecture:

```text
HOME

SOLUTIONS
  Poly-B Replacement
  Kitec Replacement
  Occupied Building Repiping
  Affordable Housing

HOW IT WORKS
  Project Process
  Detailed Installation

OUR TECHNOLOGY
  Accessible Plumbing
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

[ BOOK AN ASSESSMENT ]
```

---

# Acceptance rule going forward

The current branch is the implementation baseline. Future work should **extend it rather than restart it**.

For each wave:

1. Preserve the current visual language and homepage video.
2. Reuse shared components/templates where they are actually useful.
3. Keep pages focused and indexable rather than returning to epic-scroll architecture.
4. Treat verified current implementation as truth unless a concrete defect is found.
5. Treat omitted first-draft menu destinations as deferred scope, not abandoned scope.
6. Keep Grapher synchronized with material implementation decisions and verification results.
7. Do not mark analytics, SEO, accessibility, or responsive work complete without verification.

The practical order is now:

```text
Wave 1: harden what exists
        ↓
Wave 2A: restore omitted primary menu architecture
        ↓
Wave 2B: build commercial/decision child pages
        ↓
Wave 2C: expand SEO/education funnels
        ↓
Wave 2D: deepen project proof library
        ↓
Wave 3: growth features and long-tail expansion
```
