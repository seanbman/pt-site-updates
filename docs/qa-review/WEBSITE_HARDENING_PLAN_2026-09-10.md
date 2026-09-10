# Plumbing Track Website Hardening Plan — 2026-09-10

**Status:** Draft follow-up execution plan  
**Target branch:** `dev/updates`  
**Goal:** Turn the current implementation-complete first draft into a production-hardened, measurable, evidence-backed acquisition site without restarting the design.

## 1. Source basis and precedence

This plan extends the current repository direction rather than replacing it. It was drafted from:

- `docs/INSTRUCTIONS.md`
- `docs/IMPLEMENTATION_ROADMAP.md`
- `docs/DEV_UPDATES_REVIEW_2026-09-10.md`
- `docs/WEBSITE_DESIGN_PLAN.md`
- `docs/PARTIALS_IMPLEMENTATION_PLAN.md`
- current `dev/updates` source behavior
- `docs/media/RESOURCE_REFERENCE.md`
- `PlumbingTrack_GA4_API_Measurement_Plan(2).xlsx`, whose stated implementation principle is that GA4 contains anonymous behavioral/marketing data while identified customer/property information belongs in the CRM
- `docs/qa-review/GROK_REPO_REVIEW_2026-09-10.md`

The raw Grok review text was not present in the intake message or connected sources during this pass. It is therefore **pending reconciliation** and is not treated as evidence in this draft. Grok remains advisory only when supplied.

## 2. Keep the current strategy

Do **not** reopen the site architecture simply because hardening exposes implementation debt.

Retain these decisions:

- Existing site aesthetic is the baseline; this is not a rebrand.
- Existing homepage video remains.
- Site narrative remains **Problem → System → Proof → Action**.
- `How It Works` explains the system/process before pushing conversion.
- Focused indexable pages are preferred over one giant scrolling page.
- `Book an Assessment` remains the primary qualified-lead conversion.
- Claims are evidence-gated.
- Real Plumbing Track installations should carry the proof burden where verified.
- Runtime shared fragments migrate to build-time Ruby/ERB without changing public URLs.

## 3. Definition of hardened

The site is hardened when all of the following are true:

1. every intended public route serves directly and on refresh in the production/static environment;
2. shared chrome is rendered at build time and no critical page shell depends on browser-time fragment fetches;
3. sitemap, robots, canonical, metadata and internal-linking contracts are intentional and verifiable;
4. the assessment funnel persists a lead reliably into the backend/CRM path;
5. GA4 initializes once, records a coherent funnel, and receives no PII/free-text form data;
6. CRM leads receive useful first/last-touch and behavioral context without depending on PII inside GA4;
7. responsive, Safari/iPhone, accessibility, performance and reduced-motion checks pass;
8. project claims/media have traceable evidence and privacy review;
9. Search Console/GA4 can measure organic acquisition through to accepted assessment leads.

---

# Workstream A — Static delivery and implementation hardening

## A1. Complete the approved Ruby/ERB partial migration — P0

Follow `docs/PARTIALS_IMPLEMENTATION_PLAN.md` rather than rewriting the shell again.

- [ ] Add build-time partial/layout sources for shared header, footer and testimonial structures.
- [ ] Generate isolated `dist/` output with the same public route paths.
- [ ] Compare source and generated output before deployment switch.
- [ ] Verify current-page state, mobile drawer/flyouts, Escape/click-away, scrolled header and footer behavior.
- [ ] Switch deployment only after parity passes.
- [ ] Remove runtime `fetch()` fragment creation from `site-header.js` only after generated deployment is proven.
- [ ] Keep a rollback path until production-equivalent direct-route tests pass.

**Acceptance:** a page remains semantically complete if JavaScript fails; navigation/footer HTML exists in delivered markup.

## A2. Normalize design-system ownership — P0

- [ ] Move the page family onto canonical Geist typography.
- [ ] Centralize font-face/type tokens instead of embedding divergent contracts per page.
- [ ] Remove stale `--cyan` / `--cyan-soft` naming and use the current approved palette tokens; do not restore cyan.
- [ ] Reduce page-specific shell overrides and keep shared chrome ownership centralized.
- [ ] Bring `/assessment/` onto the same typography/token contract without unnecessarily redesigning the form.

---

# Workstream B — Technical SEO and crawl architecture

## B1. Crawl/index foundation — P0

- [ ] Add root `sitemap.xml` containing only canonical, intended public/indexable routes.
- [ ] Add root `robots.txt` with the production sitemap reference and deliberate treatment of utility/private routes.
- [ ] Verify canonical URLs and trailing-slash behavior for every public route.
- [ ] Verify exactly one meaningful H1, unique title and unique meta description per indexable page.
- [ ] Make an explicit index/noindex decision for `/assessment/`; if it stays a thin transaction page, prefer search discovery through substantive commercial/educational pages rather than accidental indexing.
- [ ] Ensure 404 behavior returns the correct status and useful navigation.
- [ ] Submit/verify sitemap in Google Search Console after production deployment.

## B2. Search-result presentation — P1

- [ ] Add consistent Open Graph/Twitter metadata to the public page family where missing.
- [ ] Provide stable social images from verified/approved media.
- [ ] Add accurate Organization/Service/Breadcrumb structured data where appropriate.
- [ ] Add FAQ structured data only when the visible content and implementation legitimately match it; do not treat schema as a substitute for useful FAQ content.
- [ ] Add VideoObject metadata only for prominent, indexable videos that have stable thumbnails and meaningful page context.

## B3. Internal linking and compositional SEO — P1

Preserve the planned funnel-page strategy:

- [ ] deepen Poly-B, Kitec and Occupied Building Repiping rather than creating duplicate sales pages;
- [ ] integrate Affordable Housing clearly into the Solutions body/navigation path;
- [ ] build focused educational pages from Wave 2C one intent at a time;
- [ ] link educational pages → relevant solution/technology explanation → project proof → assessment;
- [ ] link project proof back to the exact solution/technology claim it supports;
- [ ] expand FAQ from verified real questions;
- [ ] use verified service-region language only; do not manufacture city pages or location claims for SEO volume.

**Measurement:** link Search Console to GA4 so organic clicks, CTR, position, landing pages and lead conversion can be reported together as already anticipated by the GA4 measurement workbook.

---

# Workstream C — Lead-capture funnel hardening

## C1. Preserve the conversion journey

The intended qualified journey is:

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

Do not force every informational visitor immediately into the form. Pages should normally offer both a useful learning/proof next step and a contextual assessment CTA.

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
- [ ] Do not allow raw arbitrary query-string values to become GA4 parameters without normalization/allowlisting.
- [ ] Keep URLs free of contact information or other PII.

## C3. Assessment UX — P0

The existing four-step form should be hardened, not replaced.

- [ ] Keep only name + email as mandatory contact fields unless business requirements change.
- [ ] Preserve `Unsure` options so uncertainty does not block a lead.
- [ ] Track progression/drop-off without sending free-text form contents to analytics.
- [ ] Add clear privacy/use-of-information copy near submission.
- [ ] Clarify what happens after submission and expected follow-up process using only source-verified promises.
- [ ] Test keyboard, focus, validation, retry and mobile flows.
- [ ] Add spam/rate-abuse protection appropriate to production without adding unnecessary user friction.

## C4. Secondary conversions — P1

Track high-intent actions that bypass the form:

- phone click
- email click
- project/case-study engagement
- useful resource download

A future checklist/risk-assessment lead magnet remains an experiment, not a P0 dependency. It should only be added if it improves qualified lead capture rather than creating a second competing funnel.

---

# Workstream D — GA4 measurement contract

## D1. One analytics bootstrap — P0

Representative pages inspected in this pass contain event-emission code but no visible GA4 bootstrap. Production must prove the actual initialization contract.

- [ ] Initialize GA4 exactly once across all public/generated pages.
- [ ] Ensure queued `dataLayer` events are consumed after initialization.
- [ ] Confirm production measurement ID/environment configuration.
- [ ] Confirm no duplicate page views caused by shell/build logic.
- [ ] Validate in Realtime/DebugView before launch.

## D2. Reconcile event naming before launch — P0

The existing measurement workbook is the analytics vocabulary reference, but current code has naming drift.

| Funnel action | Current code | Canonical hardening target |
|---|---|---|
| Assessment CTA | `assessment_cta_clicked` | `assessment_cta_click` |
| Form starts | `assessment_started` | `assessment_started` |
| Step completion | `assessment_step_completed` | `assessment_step_completed` |
| Submit attempt | not explicit | `assessment_submit_attempt` |
| Accepted qualified lead | `assessment_submitted` | `generate_lead` + optional diagnostic `assessment_submitted` |
| Failed submit | no analytics event | `assessment_submit_error` |

`generate_lead` should be configured as the primary GA4 key event for a successfully accepted assessment lead, matching the existing workbook. Generic Enhanced Measurement `form_start`/`form_submit` may remain available, but dashboard conversion logic should not double-count them against the explicit assessment events.

If historical production data already exists under old custom names, preserve a documented migration/alias period rather than silently breaking reports.

## D3. GA4 event parameters — P0/P1

Register/report the workbook's useful controlled dimensions rather than sending arbitrary strings:

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

Additional funnel parameter:

- `assessment_step`

Use broad categories. Do **not** send exact address, property name, organization, name, email, phone, notes, concerns, exact unit count, or user-entered free text to GA4.

Google Analytics policy also requires URLs, titles, event parameters, campaign dimensions and User-ID values to remain free of impermissible PII. Treat URL/UTM values as untrusted input even though they are marketing fields.

## D4. Visitor profiling model — privacy-safe

“Profile” two different things deliberately:

### GA4 anonymous behavioral profile

Use GA4 to understand anonymous cohorts and journeys:

- acquisition source/medium/campaign;
- landing page;
- site section/content topics viewed;
- solution interest;
- case-study/proof engagement;
- video/resource engagement;
- CTA location;
- assessment start/step/completion;
- broad pipe/building categories entered during the assessment.

### CRM lead profile after submission

On assessment submission, send the CRM/backend the existing identified lead data **plus a first-party marketing-context object** assembled from the session. Recommended fields:

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

This gives Sales/Marketing useful context such as “arrived organically on Poly-B → viewed Accessible Plumbing → watched finished-install proof → submitted from Technology” without putting the person's identity into GA4.

If later implementation needs GA client/session identifiers inside the CRM for attribution/debugging, treat them as pseudonymous identifiers, document the purpose, disclose their use appropriately, and never send CRM PII back into GA4. Do not derive a GA User-ID from email, phone, property address, or another reversible customer identifier.

## D5. GA4 reporting views

Retain the workbook's planned console reporting pages:

1. Website Overview
2. Content
3. Our Work
4. Resources & SEO
5. Marketing
6. Geography
7. Lead Funnel

The Lead Funnel should report:

```text
landing sessions
→ engaged sessions
→ assessment_cta_click
→ assessment_started
→ step 1/2/3/4 progression
→ generate_lead
```

Break down by landing page, source/medium/campaign, content topic, solution interest, CTA ID/location, building type and pipe material where volumes are sufficient.

---

# Workstream E — Assessment API and CRM delivery

## E1. Production API contract — P0

Current client code POSTs structured building/project/contact/attribution data to `/api/public/assessment`. Harden the backend contract around that structure.

- [ ] Validate all fields server-side; client validation is convenience only.
- [ ] Apply sensible length/type limits and normalization.
- [ ] Generate a server-side `submission_id`.
- [ ] Implement idempotency/deduplication so retries cannot create accidental duplicate leads.
- [ ] Persist durably before returning a success state.
- [ ] Upsert/create the CRM lead using structured fields rather than relying on concatenated compatibility strings.
- [ ] Persist `marketing_context` beside the lead.
- [ ] Log/monitor API and CRM delivery failures without logging sensitive data unnecessarily.
- [ ] Define a durable retry/queue path if the CRM is unavailable.
- [ ] Return useful 4xx validation responses and generic safe 5xx errors.

**Conversion rule:** fire the client `generate_lead` event only after the server confirms the assessment has been durably accepted. Do not count a button click or failed request as a lead.

## E2. CRM fields useful to Sales/Marketing

Keep identified business data in CRM:

- contact name/email/phone/preference;
- organization and role;
- building/property details;
- pipe material and issue/reason;
- project timing/concerns/notes;
- source page and CTA;
- first/last acquisition context;
- anonymous content-interest summary captured before submit;
- submission timestamps/status;
- lead status/owner and subsequent sales outcome.

This allows later closed-loop reporting without contaminating GA4 with customer identity.

---

# Workstream F — Media, proof and claim hardening

Use `docs/media/RESOURCE_REFERENCE.md` as the curation map.

## F1. Priority placements — P1

- **Technology / Accessible Plumbing:** use open-system/connection detail plus finished architectural integration.
- **Detailed Installation:** use localized opening, connection and installation footage to support actual process steps.
- **Occupied Building Repiping:** use corridor/localized-work → installer action → finished-result sequence.
- **Our Work:** use verified project-specific photos/video only after identity/permission checks.
- **Homepage:** preserve the existing hero video; curated media is supporting evidence, not a replacement.

## F2. Web media derivatives

- [ ] Create optimized WebP/AVIF still derivatives with explicit width/height.
- [ ] Create short H.264/WebM derivatives for inline video rather than shipping raw 4K HEVC originals.
- [ ] Use poster images, lazy loading where appropriate, `playsinline`, muted loops only where meaningful and reduced-motion fallbacks.
- [ ] Keep long presenter clips click-to-play and caption/transcribe them only after spoken claims are reviewed.
- [ ] Strip unnecessary audio from silent process loops.

## F3. Evidence/privacy gates

- [ ] Verify project identity/material before calling footage Poly-B/Kitec proof.
- [ ] Review resident possessions, unit numbers, addresses and notices; crop/blur where necessary.
- [ ] Do not derive marketing/technical claims from presenter audio until transcribed and verified.
- [ ] Do not present installation-open footage as proof of years-later service access. The current media audit still has a future-access evidence gap.
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

Prioritize direct-route loads, refreshes, menu behavior, forms, hero/video behavior and pages with comparison tables/media.

## G2. Accessibility — P0/P1

- [ ] keyboard-only navigation and assessment completion;
- [ ] visible focus and logical focus movement;
- [ ] correct headings/landmarks;
- [ ] form labels/errors/status announcements;
- [ ] comparison semantics beyond visual columns;
- [ ] descriptive alt text for meaningful proof images;
- [ ] decorative imagery marked appropriately;
- [ ] reduced-motion parity;
- [ ] sufficient contrast under the final palette.

## G3. Performance — P0/P1

- [ ] remove runtime fragment waterfalls;
- [ ] optimize hero and priority proof media;
- [ ] avoid loading full-resolution video/images below the fold;
- [ ] cache hashed/static assets appropriately;
- [ ] confirm no render-blocking analytics or media regressions;
- [ ] run Lighthouse/Core Web Vitals checks on Home plus representative Solution, Technology, Our Work and Assessment routes.

---

# Workstream H — Launch QA and acceptance

## H1. Automated/static checks

- [ ] generated route inventory matches intended public route inventory;
- [ ] internal links resolve;
- [ ] referenced assets resolve;
- [ ] no console errors on representative routes;
- [ ] sitemap URLs return 200 and canonicalize correctly;
- [ ] robots rules match indexing decisions;
- [ ] required metadata exists and is unique;
- [ ] no obvious PII appears in analytics event payloads/URLs;
- [ ] build output is reproducible.

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

Verify the CRM record contains source/CTA/marketing context and contact/project fields while the matching GA4 events contain only allowed anonymous behavioral dimensions.

## H3. Launch gate

Do not declare production-ready until:

- Ruby/ERB generated output is live and stable;
- P0 route/browser regressions pass;
- sitemap/robots/canonicals are verified;
- GA4 is visible in DebugView/Realtime with one initialization;
- `generate_lead` is configured and validated as the primary key event;
- an assessment creates a durable lead/CRM record with attribution;
- analytics payload inspection confirms no PII/free text;
- source/claim/media review has no unresolved high-risk publication issue.

---

# Recommended implementation sequence

## Phase 1 — Platform and crawlability

1. Stage Ruby/ERB partial build.
2. Generate and parity-check `dist/`.
3. Normalize Geist/palette/shared CSS ownership.
4. Add sitemap, robots and canonical/indexing checks.
5. Run direct-route/static-serving regression.

## Phase 2 — Measurement and lead delivery

1. Establish one GA4 bootstrap/config source.
2. Reconcile analytics event names with the measurement workbook.
3. Add `generate_lead`, submit-attempt/error events and custom dimensions.
4. Implement first-party marketing-context aggregation.
5. Extend assessment payload/backend schema.
6. Validate persistence, dedupe, CRM handoff and failure recovery.
7. Run the full landing→CRM→GA4 test.

## Phase 3 — Proof and SEO depth

1. Deploy curated media to Technology/Installation/Occupied pages.
2. Verify claims and project identities.
3. Deepen Poly-B/Kitec/Occupied/Affordable Housing pages.
4. Expand FAQ and internal proof links.
5. Publish focused Wave 2C educational funnels in priority order.
6. Add verified project pages/case studies.

## Phase 4 — Final launch hardening

1. Browser/device/accessibility regression.
2. Performance/media regression.
3. Search Console + sitemap verification.
4. GA4/CRM dashboard smoke test.
5. Production assessment test.
6. Documentation/Grapher sync and final release checkpoint.

---

# Current highest-value fixes

If only the next ten items are worked immediately, do them in this order:

1. build-time shared partials + `dist/` parity;
2. sitemap.xml and robots.txt;
3. Geist/palette normalization;
4. one global GA4 initialization;
5. reconcile `assessment_cta_clicked` vs `assessment_cta_click`;
6. emit/configure `generate_lead` only after accepted submission;
7. add privacy-safe first/last-touch + behavioral marketing context to CRM submissions;
8. verify backend persistence, idempotency/dedupe and CRM delivery;
9. full mobile/Safari/direct-route regression;
10. integrate the strongest curated proof media and then deepen SEO content around claims it can actually support.

## External policy references used for analytics validation

- Google Analytics — Best practices to avoid sending PII: https://support.google.com/analytics/answer/6366371
- Google Analytics — User-ID guidance: https://support.google.com/analytics/answer/9213390
- Google Analytics — Event parameters: https://support.google.com/analytics/answer/13675006
- Google Analytics — Custom dimensions: https://support.google.com/analytics/answer/14240153
- Google Analytics recommended events: https://developers.google.com/analytics/devguides/collection/ga4/reference/events

These references validate the privacy boundary already stated in the Plumbing Track GA4 workbook: identified customer data belongs in the CRM; GA4 should receive controlled anonymous/pseudonymous behavioral and marketing dimensions only.
