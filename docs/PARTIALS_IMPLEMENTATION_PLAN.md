# Build-Time Partials Implementation Plan

## Decision

Replace the current browser-fetched header/footer/testimonial fragments with **build-time rendered partials**.

The goal is to keep one editable source for shared pieces while deploying ordinary HTML that already contains those pieces.

This is a maintainability change, not a redesign.

**Geist remains the canonical Plumbing Track site typeface.** The partial migration must preserve the existing visual direction and must not reintroduce the intentionally removed cyan styling.

---

# Why change the current fragment system

The current implementation has the correct idea — one source for repeated markup — but the wrong delivery mechanism for this site.

Today:

```text
page loads
  ↓
site-header.js runs
  ↓
fetch /templates/site-header.html
fetch /templates/site-footer.html
  ↓
replace fragment mounts in browser
```

That creates several avoidable problems:

- menu/footer existence depends on JavaScript and successful runtime fetches;
- visual debugging crosses page HTML, fragment files, JavaScript, and shared CSS;
- crawlable primary navigation is weaker than ordinary static HTML;
- direct/static rendering is harder to reason about;
- changes to shared chrome can produce runtime-only failures.

Target:

```text
page source
  +
shared partials
  ↓ Ruby/ERB build
complete HTML in dist/
  ↓ deploy
browser receives header/footer already rendered
```

JavaScript should enhance menu behavior. It should not create the menu itself.

---

# Scope

Initial shared pieces:

1. site header / primary navigation;
2. site footer;
3. testimonial cards where the same markup is reused.

Do not turn every repeated sentence or page section into a partial. A partial is appropriate when identical markup must stay synchronized across pages.

---

# Implementation choice

Use a **small Ruby build script with the Ruby standard-library ERB renderer**.

No Rails dependency is required. No frontend framework migration is required.

Reasons:

- the repository remains fundamentally static;
- Ruby is sufficient for deterministic HTML generation;
- ERB makes the partial model obvious;
- the build can be introduced without changing production routes;
- generated HTML remains portable to any ordinary static/server deployment.

---

# Proposed source structure

```text
templates/
  partials/
    _site-header.html.erb
    _site-footer.html.erb
    _testimonial-cards.html.erb

scripts/
  build-site.rb

# Existing public source pages remain where they are during the first migration.
# Generated output is isolated:

dist/
  index.html
  about/index.html
  solutions/index.html
  ...
```

Do **not** move the existing route files into a new source hierarchy in the first partials PR. That would combine two migrations and make regressions harder to isolate.

A later cleanup can move page sources into `src/` or another dedicated source tree after generated-output parity is proven.

---

# Partial contract

## Header

Canonical source:

```text
templates/partials/_site-header.html.erb
```

It owns:

- logo markup;
- primary navigation hierarchy;
- flyout link markup;
- Book an Assessment header CTA;
- accessibility attributes belonging to the markup itself.

It does **not** own page-specific active-state JavaScript or page content.

## Footer

Canonical source:

```text
templates/partials/_site-footer.html.erb
```

It owns:

- footer logo;
- canonical footer navigation/contact/social markup;
- repeated footer accessibility markup.

## Testimonial cards

Canonical source:

```text
templates/partials/_testimonial-cards.html.erb
```

Use only where the exact same testimonial-card markup/data is intended to appear.

If a page needs genuinely different proof content, keep that page-specific content local rather than forcing it through a generic partial.

---

# Safe migration strategy

The migration must be staged so the current site continues to work until generated output has been proven equivalent.

## Stage 0 — freeze the current working reference

Before changing rendering:

- record the current branch commit;
- preserve existing runtime fragments and `site-header.js` behavior;
- capture representative desktop/mobile screenshots for Home, Our Work, Solutions, Technology, How It Works, Assessment, and one nested route;
- record the current navigation hierarchy and CTA destinations.

This becomes the visual/behavioral comparison baseline.

## Stage 1 — add partial sources without changing production behavior

Create:

```text
templates/partials/_site-header.html.erb
templates/partials/_site-footer.html.erb
templates/partials/_testimonial-cards.html.erb
scripts/build-site.rb
```

For the first pass, copy the current canonical fragment markup into the corresponding partials with **no intentional redesign**.

Keep the existing runtime fragment files and loader intact.

Production behavior is unchanged at this stage.

## Stage 2 — build into `dist/` only

`build-site.rb` must:

1. create/clean `dist/`;
2. copy required static assets while excluding source-only directories/files;
3. process only intended public page HTML;
4. replace header/footer/testimonial mounts with rendered partial markup;
5. preserve each route's current output path;
6. fail loudly if an expected shared mount cannot be resolved;
7. fail rather than silently emitting a half-rendered page.

Example transformation:

Source:

```html
<div data-pt-header-fragment></div>
```

Generated output:

```html
<header class="site-header" data-pt-header>
  ...complete shared navigation markup...
</header>
```

The generated file must not require `fetch('/templates/site-header.html')` for the menu to exist.

## Stage 3 — parity verification before any deployment switch

Compare `dist/` against the current runtime-rendered site.

Required checks:

- every public route builds;
- every route contains exactly one header and one footer where expected;
- no `data-pt-header-fragment` or `data-pt-footer-fragment` mount remains in generated output;
- testimonial mounts are resolved where intended;
- primary navigation hierarchy is identical;
- assessment CTA destinations/attribution remain intact;
- logo variants and scroll/mobile states still behave correctly;
- no console errors;
- no broken relative/absolute asset paths;
- no route changes;
- desktop/tablet/mobile visual comparison passes;
- pages remain usable with JavaScript disabled, except interactions that genuinely require JavaScript.

Do not switch deployment to `dist/` until this passes.

## Stage 4 — make generated HTML the deployment artifact

Only after parity verification:

- configure deployment to serve `dist/`;
- keep source files/partials outside the deploy artifact where practical;
- make CI run the build before deployment;
- make CI fail on build errors.

The public URLs must remain unchanged.

## Stage 5 — remove runtime fragment creation

After `dist/` deployment is verified:

- remove header/footer/testimonial `fetch()` creation from `site-header.js`;
- retain navigation interaction logic in JavaScript;
- remove obsolete fragment-ready promises such as `ptHeaderReady` only after callers are migrated;
- confirm `app.js` initializes correctly against header markup that exists at initial DOM parse time;
- remove legacy fragment files only after no build/runtime code references them.

This stage must be its own small reviewable change. Do not combine it with a visual redesign.

## Stage 6 — optional source-tree cleanup

Once the build path is stable, page sources may be moved into a clearer source tree such as:

```text
src/pages/
```

That is optional and must not be part of the initial partial migration.

---

# Build-script safety requirements

`build-site.rb` must be deterministic and conservative.

It must:

- use an explicit list/rule for public page sources rather than blindly rendering archived docs/site exports;
- never read from `dist/` as a source;
- delete/recreate `dist/` before a clean build;
- preserve UTF-8 content;
- preserve existing public route paths exactly;
- preserve canonical URLs already present in page heads;
- preserve query-string CTA URLs as authored;
- reject unresolved required partial markers;
- exit non-zero on missing partials or rendering failures;
- avoid modifying source files in place;
- avoid embedding timestamps/random values that make output nondeterministic.

A build must be safe to run repeatedly with identical output for identical source.

---

# JavaScript migration notes

The current application initialization waits for `window.ptHeaderReady` because header markup appears asynchronously.

Once the header is generated into the HTML, initialization can be simplified.

During migration:

1. keep the old runtime loader until generated output is proven;
2. verify `app.js` against generated markup before removing readiness handling;
3. then make DOM-present shared chrome the normal assumption;
4. preserve menu open/close, Escape handling, click-away handling, scroll-state logo behavior, reduced-motion behavior, and CTA event wiring.

Do not remove readiness code merely because the partial files exist. Remove it only after the deployed HTML contains the shared chrome at parse time.

---

# CSS and visual-contract requirements

The rendering migration must not be used as an excuse for simultaneous styling churn.

## Geist

Geist is the canonical site typeface.

The migration should centralize its font-face/type tokens so Home and newer page families consume the same typography contract.

## Palette

Cyan was intentionally removed.

The migration must:

- remove stale `--cyan` / `--cyan-soft` references;
- use the current accent/palette contract instead;
- not resurrect cyan to make legacy selectors work.

## Shared shell

`shared-navigation.css` remains the canonical behavioral/geometry stylesheet for shared chrome unless a later deliberate refactor replaces it.

Page-family styles should not redefine footer/header geometry that belongs to shared chrome.

---

# Development workflow after migration

Editing the menu should become:

```text
edit templates/partials/_site-header.html.erb
        ↓
ruby scripts/build-site.rb
        ↓
inspect dist/
        ↓
commit source + generated/deployment artifacts according to repository policy
```

Editing the footer follows the same pattern.

There should never again be a requirement to manually update the same menu/footer markup across multiple page files.

---

# CI acceptance

Add a build verification job before deployment/merge acceptance.

Minimum checks:

```text
ruby scripts/build-site.rb
```

Then verify:

- build exits 0;
- no unresolved required partial mounts exist in `dist/**/*.html`;
- generated public route count matches the expected route manifest;
- required header/footer selectors exist exactly once per applicable page;
- generated files do not reference runtime fragment fetches for shared-chrome existence;
- basic internal-link/static-route checks pass.

Grapher documentation synchronization remains separate from site compilation; one must not silently mutate the other.

---

# Rollback strategy

Until Stage 4 is accepted, the current runtime-fragment site remains the fallback.

If generated output differs materially or breaks a route:

1. do not change deployment;
2. fix the build/partial source;
3. rebuild `dist/`;
4. repeat parity checks.

After deployment has switched to generated HTML, rollback means redeploying the last verified generated artifact/commit, not manually reconstructing fragment markup page by page.

---

# Definition of done

The partial migration is complete only when:

- header/footer/testimonial shared markup has one canonical editable source;
- deployed public HTML contains that markup before JavaScript runs;
- runtime `fetch()` is no longer required to create shared chrome;
- all existing public routes and URLs remain unchanged;
- desktop/tablet/mobile shared-shell behavior matches or improves on the verified baseline;
- JavaScript-disabled pages still expose primary navigation and footer content;
- menu/footer updates require editing one source file each;
- Geist is consistently applied through the canonical typography contract;
- obsolete cyan references are gone;
- CI builds and validates generated output;
- Grapher records the migration decision and verification state.

---

# Explicit non-goals

This migration does **not** authorize:

- a visual redesign;
- a route/URL restructure;
- a Rails migration;
- a SPA/client-rendered rewrite;
- reintroduction of cyan;
- simultaneous reworking of page copy;
- deletion of historical Grapher records.

Keep the change narrow: **centralized partial source, static generated output, no site breakage.**
