# Plumbing Track Website Hardening Plan — 2026-09-10

**Status:** Draft follow-up execution plan — revision 1 after Grok review reconciliation  
**Target branch:** `dev/updates`  
**Goal:** Turn the current implementation-complete first draft into a production-hardened, measurable, evidence-backed acquisition site without restarting the design.

## 1. Source basis and precedence

This plan extends the current repository direction rather than replacing it. It is based on:

- `docs/INSTRUCTIONS.md`
- `docs/IMPLEMENTATION_ROADMAP.md`
- `docs/DEV_UPDATES_REVIEW_2026-09-10.md`
- `docs/WEBSITE_DESIGN_PLAN.md`
- `docs/PARTIALS_IMPLEMENTATION_PLAN.md`
- current `dev/updates` source behavior
- `docs/media/RESOURCE_REFERENCE.md`
- `PlumbingTrack_GA4_API_Measurement_Plan(2).xlsx`
- `docs/qa-review/GROK_REPO_REVIEW_2026-09-10.md`

The supplied Grok review has now been preserved verbatim and reconciled. It remains secondary evidence; only findings confirmed by current code/docs or consistent with operator decisions are carried forward.

## 2. Current validated state

The current site architecture is ahead of the old route-creation plan. The immediate job is hardening, not another redesign.

Validated strengths:

- the site story now follows **Problem → System → Proof → Action**;
- Home routes rather than containing the entire brochure;
- `How It Works` explains before conversion;
- Technology carries the accessible-plumbing thesis;
- focused Solution/Technology/Resource routes exist;
- the Assessment flow already captures structured building/project/contact data and source attribution;
- CTA instrumentation exists at the source-code level;
- claim language is generally cautious;
- the media handoff provides real installation evidence for several key pages.

Validated open defects/gaps:

- shared chrome is still fetched at runtime;
- `/how-it-works/` contains its own header CSS while also mounting the shared header fragment;
- family pages use `--gold` while shared navigation still calls unresolved `--cyan` / `--cyan-soft` tokens;
- family pages previously did not load the canonical Geist font contract; the shared font source is now implemented, with full visual regression still open;
- root `sitemap.xml` and `robots.txt` were absent at review time; the source baseline now includes both, with production verification still open;
- Affordable Housing is present in navigation but absent from the Solutions hub body;
- current planning language still drifts between **Learn** and the live **Resources** label;
- comparison content is visually tabular but not encoded as a semantic table;
- GA4 event names drift from the existing measurement workbook;
- representative pages contain event-emission code but no visible common GA4 bootstrap;
- Assessment persistence/CRM delivery is not yet production-verified;
- family pages are consistent but too mechanically templated to function as memorable destinations yet;
- the stale cyan-token and unresolved shared-navigation accent defects have since been corrected in the source baseline, while the full typography/font-face and cross-route verification work remains open;

A local repo-root static-server smoke test reported 200 responses for every public route tested. Retain that result as baseline evidence only; rerun against generated `dist/` and the production-equivalent environment before closing routing QA.

## 3. Keep the current strategy

Do **not** reopen the site architecture simply because hardening exposes implementation debt.

Retain these decisions:

- Existing visual identity remains the baseline; this is not a rebrand.
- Existing homepage video remains.
- Site narrative remains **Problem → System → Proof → Action**.
- `How It Works` explains the system/process before pushing conversion.
- Focused indexable pages are preferred over one giant scrolling page.
- `Book an Assessment` remains the primary qualified-lead conversion.
- Claims are evidence-gated.
- Real Plumbing Track installations should carry the proof burden where verified.
- Runtime shared fragments migrate to build-time Ruby/ERB without changing public URLs.
- **Resources** is the current public hub/navigation label; Wave 2C educational depth grows under that strategy rather than inventing a second empty Learn library.

## 4. Definition of hardened

The site is hardened when all of the following are true:

1. every intended public route serves directly and on refresh in the generated and production-equivalent environment;
2. shared chrome is rendered at build time and no critical page shell depends on browser-time fragment fetches;
3. one typography/palette contract is actually used across page families;
4. sitemap, robots, canonical, metadata and internal-linking contracts are intentional and verifiable;
5. the assessment funnel persists a lead reliably into the backend/CRM path;
6. GA4 initializes once, records a coherent funnel, and receives no PII/free-text form data;
7. CRM leads receive useful first/last-touch and behavioral context without depending on PII inside GA4;
8. responsive, Safari/iPhone, accessibility, performance and reduced-motion checks pass;
9. project claims/media have traceable evidence and privacy review;
10. Search Console/GA4 can measure organic acquisition through to accepted assessment leads.

---

# Workstream A — Build-time delivery and maintainability

## A1. Complete the approved Ruby/ERB partial migration — P0

Follow `docs/PARTIALS_IMPLEMENTATION_PLAN.md` rather than rewriting the shell again.

- [ ] Add build-time partial/layout sources for shared header, footer and testimonial structures.
- [ ] Generate isolated `dist/` output with the same public route paths.
- [ ] Compare source and generated output before deployment switch.
- [ ] Verify current-page state, mobile drawer/flyouts, Escape/click-away, scrolled header and footer behavior.
- [ ] Remove the duplicate `/how-it-works/` page-local header contract as part of the migration; do not leave shared and local chrome competing.
- [ ] Switch deployment only after parity passes.
- [ ] Remove runtime `fetch()` fragment creation from `site-header.js` only after generated deployment is proven.
- [ ] Keep a rollback path until production-equivalent direct-route tests pass.

**Acceptance:** a page remains semantically complete if JavaScript fails; header/footer HTML exists in delivered markup.

## A2. Normalize design-system ownership — P0

- [x] Move the page family onto canonical Geist typography.
- [x] Centralize one shared font-face/type token source instead of letting variables claim Geist while resolving to Arial.
- [x] Replace stale `--cyan` / `--cyan-soft` references with the current gold/accent contract; do not resurrect cyan.
- [x] Treat shared-navigation unresolved accent variables as a live hover/focus/border rendering bug.
- [x] Normalize testimonial accent tokens to the same contract rather than relying on fallback values.
- [ ] Reduce page-specific shell overrides and keep shared chrome ownership centralized.
- [x] Bring `/assessment/` onto the same typography/token contract without unnecessarily redesigning the form.

---

# Workstream B — Technical SEO and crawl architecture

## B1. Crawl/index foundation — P0

- [x] Add root `sitemap.xml` containing only canonical, intended public/indexable routes. The main-domain source contains 15 canonical public routes; the separate bchousing host and client-portal utility routes are excluded.
- [x] Add root `robots.txt` with the production sitemap reference and deliberate treatment of utility/private routes. `/client-portal/` is disallowed while the public assessment funnel remains crawlable.
- [ ] Verify canonical URLs and trailing-slash behavior for every public route.
- [ ] Verify exactly one meaningful H1, unique title and unique meta description per indexable page.
- [ ] Make an explicit index/noindex decision for `/assessment/`; substantive commercial/educational pages should do the search discovery work.
- [ ] Ensure 404 behavior returns the correct status and useful navigation.
- [ ] Submit and verify the sitemap in Google Search Console after production deployment.

## B2. Search-result presentation — P1

- [ ] Add consistent Open Graph/Twitter metadata to public page families where missing.
- [ ] Provide stable social images from verified/approved media.
- [ ] Add accurate Organization/Service/Breadcrumb structured data where appropriate.
- [ ] Add FAQ structured data only when visible content legitimately matches it.
- [ ] Add VideoObject metadata only for prominent, indexable videos with stable thumbnails and meaningful page context.

## B3. Internal linking and compositional SEO — P1

Preserve the focused funnel-page strategy:

- [ ] deepen Poly-B, Kitec and Occupied Building Repiping rather than creating duplicate sales pages;
- [ ] add Affordable Housing visibly to the Solutions hub body, pointing to `/bchousing/`, unless a different deliberate treatment is approved;
- [ ] normalize current planning language so **Resources** is the present public hub label and **Learn** is not mistaken for a second required current route family;
- [ ] build focused Wave 2C educational pages one search intent at a time;
- [ ] link educational pages → relevant Solution/Technology explanation → project proof → Assessment;
- [ ] link project proof back to the exact Solution/Technology claim it supports;
- [ ] expand FAQ from verified real customer questions;
- [ ] use verified service-region language only; do not manufacture location pages for SEO volume.

**Measurement:** connect Search Console and GA4 so organic landing pages, queries/CTR/position and lead conversion can be analyzed together.

## B4. Destination-page differentiation — P1

Shared visual language stays. Repetitive page identity does not.

- [ ] Poly-B: add one problem-specific visual/evidence module and one verified proof link.
- [ ] Kitec: add one distinct material/problem-specific visual/evidence module and one verified proof link.
- [ ] Occupied Building Repiping: emphasize resident/building coordination and localized-work evidence.
- [ ] About: add verified team/system-origin/credibility depth without inventing founder/company facts.
- [ ] Technology: remain the strongest expression of the accessible-plumbing thesis rather than being duplicated verbatim across Solutions.
- [ ] Give each Solution page a narrative spine of **problem/material → accessible-route consequence → installation consequence → proof → assessment**.

This is differentiation inside the existing component system, not a redesign.

---

# Workstream C — Lead-capture funnel hardening

## C1. Preserve the conversion journey

```text
Search / campaign / referral
        ↓
Problem or audience landing page
        ↓
System explanation (Technology / How It Works)
        ↓
Proof (Our Work / project media / FAQ)
        ↓
Book an Assessment CTA
        ↓
Building → Project → Contact → Review
        ↓
Accepted lead → CRM follow-up
```

Do not force every informational visitor directly into the form. Commercial/informational pages should normally offer both a learning/proof next step and a contextual Assessment CTA.

## C2. Standardize CTA attribution — P0

Every assessment CTA needs a controlled identifier, not arbitrary text.

Recommended contract:

- `source_page`: normalized path only, e.g. `/solutions/poly-b/`
- `cta_id`: stable controlled value, e.g. `polyb_hero_assessment`
- `cta_location`: `hero`, `inline`, `proof`, `footer`
- `site_section`: `home`, `solutions`, `technology`, `how_it_works`, `our_work`, `resources`
- optional `content_topic`: controlled value such as `poly_b`, `kitec`, `occupied_repipe`, `accessible_plumbing`

- [ ] Audit every `[data-assessment-cta]` against the controlled CTA registry.
- [ ] Preserve first-touch and last-touch CTA context through the assessment flow.
- [ ] Normalize/allowlist query-string attribution values before using them as analytics dimensions.
- [ ] Keep URLs free of contact information or other PII.

## C3. Assessment UX — P0

The existing four-step form should be hardened, not replaced.

- [ ] Keep only name + email mandatory unless business requirements change.
- [ ] Preserve `Unsure` options so uncertainty does not block a lead.
- [ ] Track progression/drop-off without sending free-text form contents to analytics.
- [ ] Add clear privacy/use-of-information copy near submission.
- [ ] Clarify what happens after submission using only source-verified promises.
- [ ] Test keyboard, focus, validation, retry and mobile flows.
- [ ] Add spam/rate-abuse protection appropriate to production without unnecessary friction.

## C4. Secondary conversions — P1

Track high-intent actions that may bypass the form:

- phone click;
- email click;
- project/case-study engagement;
- useful resource download.

A future checklist/risk-assessment lead magnet remains an experiment, not a P0 dependency.

---

# Workstream D — GA4 measurement contract

## D1. One analytics bootstrap — P0

Representative pages inspected in this review contain event-emission code but no visible shared GA4 bootstrap. Production must prove the actual initialization contract.

- [ ] Initialize GA4 exactly once across all public/generated pages.
- [ ] Ensure queued `dataLayer` events are consumed after initialization.
- [ ] Confirm production measurement ID/environment configuration.
- [ ] Confirm no duplicate page views caused by shell/build logic.
- [ ] Validate in Realtime/DebugView before launch.

## D2. Reconcile event naming before launch — P0

The existing measurement workbook is the vocabulary reference. Current code has naming drift.

| Funnel action | Current code | Canonical hardening target |
|---|---|---|
| Assessment CTA | `assessment_cta_clicked` | `assessment_cta_click` |
| Form starts | `assessment_started` | `assessment_started` |
| Step completion | `assessment_step_completed` | `assessment_step_completed` |
| Submit attempt | not explicit | `assessment_submit_attempt` |
| Accepted qualified lead | `assessment_submitted` | `generate_lead` + optional diagnostic `assessment_submitted` |
| Failed submit | no explicit event | `assessment_submit_error` |

`generate_lead` should be the primary GA4 key event for a successfully accepted assessment lead. Do not double-count generic Enhanced Measurement form events as equivalent conversions.

If historical production data exists under old custom names, document a migration/alias period instead of silently breaking reports.

## D3. GA4 event parameters — P0/P1

Use controlled dimensions from the existing measurement plan:

- `content_type`
- `content_topic`
- `site_section`
- `audience_type`
- `cta_id`
- `cta_location`
- `form_type`
- `pipe_material`
- `building_type`
- `unit_count_bucket`
- `resource_type`
- `case_study_id`
- `process_step`
- `assessment_step`

Use broad categories. Do **not** send exact address, property name, organization, name, email, phone, notes, concerns, exact unit count, or user-entered free text to GA4.

Treat URL/UTM/query values as untrusted input and normalize them before analytics use.

## D4. Visitor profiling model — privacy-safe

Separate anonymous behavioral profiling from identified CRM profiling.

### GA4 anonymous behavioral profile

Use GA4 to understand cohorts and journeys through:

- acquisition source/medium/campaign;
- landing page;
- site section/content topics viewed;
- solution interest;
- case-study/proof engagement;
- video/resource engagement;
- CTA location;
- Assessment start/step/completion;
- broad pipe/building categories entered during Assessment.

### CRM lead profile after submission

On successful Assessment submission, send the backend/CRM identified lead data plus a first-party marketing-context summary:

```text
marketing_context
  first_landing_path
  first_referrer_host
  first_utm_source
  first_utm_medium
  first_utm_campaign
  last_landing_path
  assessment_source_page
  assessment_cta_id
  assessment_cta_location
  site_sections_viewed[]
  content_topics_viewed[]
  solution_interests[]
  proof_engagement[]
  resource_engagement[]
  assessment_started_at
  submitted_at
```

Prefer summarized controlled categories over an unlimited raw browsing-history dump.

The intended Sales/Marketing context is something like:

```text
Organic landing: Poly-B
→ viewed Accessible Plumbing
→ engaged with finished-install proof
→ submitted from Technology CTA
```

That context belongs beside the identified lead in the CRM, while GA4 remains free of the person's direct identity.

Do not derive a GA User-ID from email, phone, property address or another reversible customer identifier.

## D5. GA4 reporting views

Retain the existing workbook's planned reporting groups:

1. Website Overview
2. Content
3. Our Work
4. Resources & SEO
5. Marketing
6. Geography
7. Lead Funnel

Lead Funnel should report:

```text
landing sessions
→ engaged sessions
→ assessment_cta_click
→ assessment_started
→ step 1/2/3/4 progression
→ generate_lead
```

Break down by landing page, source/medium/campaign, content topic, solution interest, CTA ID/location, building type and pipe material where sample sizes are meaningful.

---

# Workstream E — Assessment API and CRM delivery

## E1. Production API contract — P0

Current client code POSTs structured building/project/contact/attribution data to `/api/public/assessment`. Harden the backend around that shape.

- [ ] Validate all fields server-side; client validation is convenience only.
- [ ] Apply sensible length/type limits and normalization.
- [ ] Generate a server-side `submission_id`.
- [ ] Implement idempotency/deduplication so retries do not create duplicate leads.
- [ ] Persist durably before returning success.
- [ ] Upsert/create the CRM lead using structured fields instead of concatenated compatibility strings.
- [ ] Persist `marketing_context` beside the lead.
- [ ] Log/monitor API and CRM delivery failures without unnecessarily logging sensitive data.
- [ ] Define a durable retry/queue path if the CRM is unavailable.
- [ ] Return useful 4xx validation responses and generic safe 5xx errors.

**Conversion rule:** fire `generate_lead` only after the server confirms durable acceptance. Do not count a click or failed request as a lead.

## E2. CRM fields useful to Sales/Marketing

Keep identified business/customer data in CRM:

- contact name/email/phone/preference;
- organization and role;
- building/property details;
- pipe material and issue/reason;
- project timing/concerns/notes;
- source page and CTA;
- first/last acquisition context;
- summarized content/solution/proof engagement;
- submission timestamps/status;
- lead status/owner and subsequent sales outcome.

This gives future closed-loop reporting without contaminating GA4 with customer identity.

---

# Workstream F — Media, proof and claim hardening

Use `docs/media/RESOURCE_REFERENCE.md` as the curation map.

## F1. Priority placements — P1

- **Technology / Accessible Plumbing:** use open-system/connection detail plus finished architectural integration.
- **Detailed Installation:** use localized opening, connection and installation footage to support actual process steps.
- **Occupied Building Repiping:** use corridor/localized-work → installer action → finished-result sequence.
- **Poly-B / Kitec:** use material/project-specific proof only when identity/material is separately verified.
- **Our Work:** use verified project-specific photos/video only after identity/permission checks.
- **Homepage:** preserve the existing hero video; curated media is supporting evidence, not a replacement.

## F2. Web media derivatives

- [ ] Create optimized WebP/AVIF still derivatives with explicit width/height.
- [ ] Create short H.264/WebM derivatives for inline video rather than shipping raw 4K HEVC originals.
- [ ] Use poster images, lazy loading where appropriate, `playsinline`, meaningful muted loops and reduced-motion fallbacks.
- [ ] Keep long presenter clips click-to-play and caption/transcribe only after spoken claims are reviewed.
- [ ] Strip unnecessary audio from silent process loops.

## F3. Evidence/privacy gates

- [ ] Verify project identity/material before calling footage Poly-B/Kitec proof.
- [ ] Review resident possessions, unit numbers, addresses and notices; crop/blur where necessary.
- [ ] Do not derive marketing/technical claims from presenter audio until transcribed and verified.
- [ ] Do not present installation-open footage as proof of years-later service access; the current media audit still has a future-access evidence gap.
- [ ] Do not AI-beautify away construction evidence.

---

# Workstream G — Responsive, accessibility and performance QA

## G1. Browser/device matrix — P0

Test the actual generated/production build on:

- modern iPhone Safari, including older supported iPhones;
- Android Chrome;
- desktop Safari;
- Chrome/Chromium;
- Firefox;
- narrow mobile, tablet and wide desktop breakpoints.

Prioritize direct-route loads, refreshes, menu behavior, forms, hero/video behavior and pages with comparison/media components.

## G2. Accessibility — P0/P1

- [ ] keyboard-only navigation and Assessment completion;
- [ ] visible focus and logical focus movement;
- [ ] correct headings/landmarks;
- [ ] form labels/errors/status announcements;
- [ ] review the comparison component as genuinely tabular information: use semantic `<table>` structure where appropriate or provide equivalent explicit relationships; `aria-label` alone is not enough;
- [ ] descriptive alt text for meaningful proof images;
- [ ] decorative imagery marked appropriately;
- [ ] reduced-motion parity;
- [ ] sufficient contrast under the final palette.

## G3. Performance — P0/P1

- [ ] remove runtime fragment waterfalls;
- [ ] optimize hero and priority proof media;
- [ ] avoid loading full-resolution video/images below the fold;
- [ ] cache generated/static assets appropriately;
- [ ] confirm no render-blocking analytics or media regressions;
- [ ] run Lighthouse/Core Web Vitals checks on Home plus representative Solution, Technology, Our Work and Assessment routes.

---

# Workstream H — Launch QA and acceptance

## H1. Automated/static checks

The current local static-server 200-route result is the starting smoke-test baseline.

- [ ] rerun the complete route inventory against generated `dist/`;
- [ ] rerun against production-equivalent serving/deployment;
- [ ] confirm internal links resolve;
- [ ] confirm referenced assets resolve;
- [ ] confirm no console errors on representative routes;
- [ ] confirm sitemap URLs return 200 and canonicalize correctly;
- [ ] confirm robots rules match indexing decisions;
- [ ] confirm required metadata exists and is unique;
- [ ] inspect analytics payloads/URLs for PII leakage;
- [ ] confirm build output is reproducible.

## H2. End-to-end funnel test

Run at least one controlled test journey from a tagged landing page:

```text
landing page
→ solution/technology content
→ proof interaction
→ assessment CTA
→ assessment_started
→ step completions
→ API submit
→ durable lead/CRM record
→ generate_lead in GA4
```

Verify the CRM record contains source/CTA/marketing context and contact/project fields while matching GA4 events contain only allowed anonymous behavioral dimensions.

## H3. Launch gate

Do not declare production-ready until:

- Ruby/ERB generated output is live and stable;
- P0 route/browser regressions pass;
- sitemap/robots/canonicals are verified;
- shared gold/Geist contracts are resolved;
- GA4 is visible in DebugView/Realtime with one initialization;
- `generate_lead` is configured and validated as the primary key event;
- an Assessment creates a durable CRM lead with attribution;
- analytics payload inspection confirms no PII/free text;
- source/claim/media review has no unresolved high-risk publication issue.

---

# Recommended implementation sequence

## Phase 1 — Platform and crawlability

1. Stage Ruby/ERB partial build.
2. Remove the competing How It Works chrome contract during the migration.
3. Generate and parity-check `dist/`.
4. Normalize gold/accent tokens and Geist typography.
5. Add sitemap, robots and canonical/indexing checks.
6. Run whole-route generated-output regression.

## Phase 2 — Measurement and lead delivery

1. Establish one GA4 bootstrap/config source.
2. Reconcile analytics event names with the measurement workbook.
3. Add `generate_lead`, submit-attempt/error events and required custom dimensions.
4. Implement first-party marketing-context aggregation.
5. Extend Assessment payload/backend schema.
6. Validate persistence, dedupe, CRM handoff and failure recovery.
7. Run the full landing → CRM → GA4 test.

## Phase 3 — Proof, IA and SEO depth

1. Add Affordable Housing visibly to the Solutions hub.
2. Normalize Resources/Learn terminology in current docs.
3. Deploy curated media to Technology/Installation/Occupied pages.
4. Differentiate Poly-B/Kitec/Occupied/About with source-backed proof modules.
5. Align each Solution narrative with the accessible-route thesis.
6. Expand FAQ and internal proof links from real source material.
7. Publish focused Wave 2C educational funnels in priority order.
8. Add verified project pages/case studies.

## Phase 4 — Final launch hardening

1. Browser/device/accessibility regression.
2. Performance/media regression.
3. Search Console + sitemap verification.
4. GA4/CRM dashboard smoke test.
5. Production Assessment test.
6. Documentation/Grapher sync and final release checkpoint.

---

# Current highest-value fixes

If only the next twelve items are worked immediately, do them in this order:

1. build-time shared partials + `dist/` parity;
2. remove the duplicate How It Works header/chrome contract;
3. fix unresolved `--cyan*` usage and standardize gold/accent tokens;
4. wire canonical Geist across page families;
5. add `sitemap.xml` and `robots.txt`;
6. run whole-route generated/static regression;
7. establish one global GA4 initialization;
8. reconcile `assessment_cta_clicked` vs `assessment_cta_click` and emit `generate_lead` only after accepted submission;
9. add privacy-safe first/last-touch + behavioral marketing context to CRM submissions;
10. verify backend persistence, idempotency/dedupe and CRM delivery;
11. add Affordable Housing to the Solutions hub and normalize Resources/Learn planning language;
12. integrate the strongest curated proof media and deepen Solutions/About/FAQ before Wave 2C expansion.

## External analytics references retained by this plan

- Google Analytics — Best practices to avoid sending PII: https://support.google.com/analytics/answer/6366371
- Google Analytics — User-ID guidance: https://support.google.com/analytics/answer/9213390
- Google Analytics — Event parameters: https://support.google.com/analytics/answer/13675006
- Google Analytics — Custom dimensions: https://support.google.com/analytics/answer/14240153
- Google Analytics recommended events: https://developers.google.com/analytics/devguides/collection/ga4/reference/events

These references support the privacy boundary already established in the Plumbing Track GA4 workbook: identified customer/property data belongs in the CRM; GA4 receives controlled anonymous/pseudonymous behavioral and marketing dimensions only.
