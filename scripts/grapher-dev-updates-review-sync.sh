#!/usr/bin/env bash
set -euo pipefail

GRAPH=".grapher/knowledge.json"
OP="dev-updates-review-${GITHUB_SHA:-$(date -u +%Y%m%dT%H%M%SZ)}"

common=(
  --graph "$GRAPH"
  --stage developing
  --actor ChatGPT
  --actor-kind agent
  --role planning-agent
  --source chatgpt
  --provenance-integrity declared
  --operation-id "$OP"
  --phase executed
)

grapher add "${common[@]}" \
  --id docs-dev-updates-review \
  --type document \
  --title "dev/updates branch review 2026-09-10" \
  --content "Source-level review of dev/updates covering strengths, concrete production defects, route-by-route status, launch/production acceptance gates, and Wave 1/Wave 2 re-evaluation." \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,docs,review,dev-updates,roadmap,verification \
  --status current \
  --workflow-state completed \
  --verification partially_verified \
  --reason "Record the current branch review and evidence behind the roadmap rebaseline"

grapher add "${common[@]}" \
  --id docs-partials-implementation-plan \
  --type document \
  --title "Build-time partials implementation plan" \
  --content "Staged Ruby/ERB migration from runtime-fetched header/footer/testimonial fragments to build-time rendered static HTML in dist/, preserving current routes and retaining the existing runtime site as fallback until parity verification passes." \
  --path docs/PARTIALS_IMPLEMENTATION_PLAN.md \
  --tags plumbing-track,docs,partials,erb,ruby,static-build,shared-chrome \
  --status current \
  --workflow-state active \
  --verification not_applicable \
  --reason "Document the safe implementation path for replacing runtime fragments"

grapher add "${common[@]}" \
  --id docs-decision-partials-typography-palette \
  --type document \
  --title "Decision: build-time partials, Geist, and palette cleanup" \
  --content "Operator decisions: replace runtime fragment delivery with build-time partial rendering, retain Geist as the canonical site typeface, and keep cyan removed while cleaning stale cyan CSS references." \
  --path docs/DECISION_PARTIALS_TYPOGRAPHY_PALETTE.md \
  --tags plumbing-track,docs,decision,partials,geist,palette \
  --status current \
  --workflow-state completed \
  --verification not_applicable \
  --reason "Index current operator decisions controlling the partials migration and visual contract"

grapher add "${common[@]}" \
  --id decision-page-family-rebaseline \
  --type decision \
  --title "Rebaseline dedicated page family from unbuilt to implemented draft" \
  --content '{"decision":"About, Solutions and its initial child pages, Detailed Installation, Technology and its initial child pages, Resources, and FAQ are now classified as implemented first drafts rather than unbuilt Wave 2 routes.","rationale":"The current dev/updates branch contains real routed pages with page-specific content, canonical metadata, internal links, shared-shell integration, and conversion CTAs. Remaining work is hardening, source reconciliation, content depth, proof, accessibility, SEO consistency, and production verification."}' \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,decision,waves,rebaseline,page-family \
  --status current \
  --workflow-state completed \
  --verification verified \
  --reason "Correct stale roadmap tasks that still described implemented routes as unbuilt"

grapher add "${common[@]}" \
  --id decision-build-time-partials \
  --type decision \
  --title "Render shared chrome with build-time partials" \
  --content '{"decision":"Header, footer, and other truly shared fragment pieces will retain one canonical source but be rendered into deployable HTML at build time rather than fetched to create shared chrome in the browser.","rationale":"The current runtime fragment mechanism is difficult to maintain and debug, weakens static/crawlable output, and makes shared chrome depend on JavaScript and fragment fetch success. A staged Ruby/ERB build preserves centralized editing while producing ordinary static HTML."}' \
  --path docs/DECISION_PARTIALS_TYPOGRAPHY_PALETTE.md \
  --tags plumbing-track,decision,partials,shared-chrome,ruby,erb \
  --status current \
  --workflow-state completed \
  --verification verified \
  --reason "Operator approved build-time partial rendering as the replacement for runtime fragments"

grapher add "${common[@]}" \
  --id decision-geist-canonical-typeface \
  --type decision \
  --title "Retain Geist as canonical site typeface" \
  --content '{"decision":"Geist remains the canonical Plumbing Track site typeface.","rationale":"The operator explicitly prefers the existing Geist typography and wants new page families normalized to that contract rather than drifting to Arial/Helvetica."}' \
  --path docs/DECISION_PARTIALS_TYPOGRAPHY_PALETTE.md \
  --tags plumbing-track,decision,typography,geist,design-system \
  --status current \
  --workflow-state completed \
  --verification verified \
  --reason "Operator explicitly retained Geist"

grapher add "${common[@]}" \
  --id decision-cyan-remains-removed \
  --type decision \
  --title "Keep cyan removed and clean stale references" \
  --content '{"decision":"Cyan remains removed from the current Plumbing Track design; stale --cyan and --cyan-soft references must be removed or replaced with the current palette rather than restoring cyan.","rationale":"The operator confirmed cyan removal was intentional and identified remaining references as cleanup artifacts."}' \
  --path docs/DECISION_PARTIALS_TYPOGRAPHY_PALETTE.md \
  --tags plumbing-track,decision,palette,css,cleanup \
  --status current \
  --workflow-state completed \
  --verification verified \
  --reason "Correct the earlier review interpretation that treated cyan as a missing token"

grapher add "${common[@]}" \
  --id requirement-static-crawlable-shared-shell \
  --type requirement \
  --title "Render primary shared chrome into deployable HTML" \
  --content '{"requirement":"Header, footer, and other important shared public markup must have one canonical source and be rendered into deployable HTML at build time; client JavaScript may enhance behavior but must not be required to create primary navigation/footer content.","acceptance_condition":"A staged Ruby/ERB build generates complete HTML into dist/ while preserving existing route paths; parity is verified before deployment switches; runtime fragment fetch creation is removed only after generated output is proven."}' \
  --path docs/PARTIALS_IMPLEMENTATION_PLAN.md \
  --tags plumbing-track,requirement,seo,crawlability,partials,static-build \
  --status current \
  --workflow-state active \
  --verification unverified \
  --reason "Current runtime fragment delivery is being replaced by an explicitly staged build-time partial implementation"

grapher add "${common[@]}" \
  --id requirement-seo-discovery-files \
  --type requirement \
  --title "Public route set requires deliberate sitemap and robots files" \
  --content '{"requirement":"The production site must include a root sitemap.xml matching intended indexable canonical routes and a deliberate root robots.txt that references the sitemap and handles non-public/utility routes intentionally.","acceptance_condition":"Both files exist in deployable output, validate, match production canonical URLs, and are verified against the actual route/indexing policy."}' \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,requirement,seo,sitemap,robots,crawlability \
  --status current \
  --workflow-state active \
  --verification failed \
  --reason "Source review found no root sitemap.xml or robots.txt on dev/updates"

grapher add "${common[@]}" \
  --id requirement-page-family-design-parity \
  --type requirement \
  --title "Use Geist and the current palette consistently across page families" \
  --content '{"requirement":"New page-family routes must preserve the established Plumbing Track visual identity by using the canonical Geist typography contract and current non-cyan palette; obsolete cyan variable references must be removed rather than satisfied by restoring cyan.","acceptance_condition":"Geist is centralized and used across page families; stale --cyan/--cyan-soft references are gone or replaced with current palette tokens; normal/hover/focus/scrolled/mobile states are visually verified."}' \
  --path docs/DECISION_PARTIALS_TYPOGRAPHY_PALETTE.md \
  --tags plumbing-track,requirement,design-system,geist,typography,palette,css \
  --status current \
  --workflow-state active \
  --verification failed \
  --reason "Page-family typography currently drifts to Arial/Helvetica and stale cyan variables remain after intentional cyan removal"

grapher add "${common[@]}" \
  --id requirement-implemented-page-depth-and-proof \
  --type requirement \
  --title "Implemented commercial routes still require source-backed depth and proof" \
  --content '{"requirement":"Existing first-draft About, Solutions, Technology, FAQ and related routes must be deepened only with verified source-backed facts, customer questions, project proof, and useful internal links before being treated as mature SEO/commercial destinations.","acceptance_condition":"Route existence is not used as evidence of content completion; claims are reconciled against authoritative sources; relevant proof is linked; intentionally thin or unready routes receive an explicit indexing decision."}' \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,requirement,content,seo,proof,verification \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "The new pages are meaningful first drafts but several remain intentionally concise and lack the full evidence/content depth described in the design plan"

# Documentation and plan relationships.
grapher link --graph "$GRAPH" docs-index docs-dev-updates-review --rel references --note "Current branch review and re-evaluation evidence"
grapher link --graph "$GRAPH" docs-index docs-partials-implementation-plan --rel references --note "Safe implementation plan for build-time shared partials"
grapher link --graph "$GRAPH" docs-index docs-decision-partials-typography-palette --rel references --note "Current operator decisions for partial rendering, Geist, and palette cleanup"
grapher link --graph "$GRAPH" docs-dev-updates-review docs-instructions --rel references --note "Review evaluates the branch against governing implementation requirements"
grapher link --graph "$GRAPH" docs-dev-updates-review docs-website-design-plan --rel references --note "Review evaluates current implementation against target architecture and visual/SEO direction"
grapher link --graph "$GRAPH" docs-implementation-roadmap docs-dev-updates-review --rel derived_from --note "Current roadmap rebaseline incorporates the 2026-09-10 branch review"
grapher link --graph "$GRAPH" docs-partials-implementation-plan docs-decision-partials-typography-palette --rel decided_by --note "Implementation plan follows the operator-approved shared-rendering and visual-contract decisions"

grapher link --graph "$GRAPH" decision-page-family-rebaseline docs-dev-updates-review --rel evidenced_by --note "Route-by-route source review supports the reclassification"
grapher link --graph "$GRAPH" decision-page-family-rebaseline docs-implementation-roadmap --rel applies_to --note "Reclassification updates the Wave 1/Wave 2 roadmap"
grapher link --graph "$GRAPH" decision-build-time-partials docs-decision-partials-typography-palette --rel evidenced_by --note "Operator decision is recorded in the current decision document"
grapher link --graph "$GRAPH" decision-build-time-partials docs-partials-implementation-plan --rel implements --note "Staged Ruby/ERB plan implements the build-time partial decision"
grapher link --graph "$GRAPH" decision-geist-canonical-typeface docs-decision-partials-typography-palette --rel evidenced_by --note "Operator typography decision is recorded explicitly"
grapher link --graph "$GRAPH" decision-cyan-remains-removed docs-decision-partials-typography-palette --rel evidenced_by --note "Operator palette decision corrects the earlier missing-token interpretation"

grapher link --graph "$GRAPH" requirement-static-crawlable-shared-shell decision-build-time-partials --rel decided_by --note "Build-time partial rendering is the selected implementation for crawlable shared chrome"
grapher link --graph "$GRAPH" requirement-static-crawlable-shared-shell docs-partials-implementation-plan --rel evidenced_by --note "Implementation and parity requirements are documented in the migration plan"
grapher link --graph "$GRAPH" requirement-static-crawlable-shared-shell docs-instructions --rel applies_to --note "Governing instructions require crawlable navigation and no important content exclusively behind JavaScript"

grapher link --graph "$GRAPH" requirement-seo-discovery-files docs-dev-updates-review --rel evidenced_by --note "Review records absence of sitemap.xml and robots.txt"
grapher link --graph "$GRAPH" requirement-seo-discovery-files docs-instructions --rel applies_to --note "Governing SEO requirements include sitemap and robots support where applicable"

grapher link --graph "$GRAPH" requirement-page-family-design-parity decision-geist-canonical-typeface --rel decided_by --note "Geist is the chosen canonical typography contract"
grapher link --graph "$GRAPH" requirement-page-family-design-parity decision-cyan-remains-removed --rel decided_by --note "Current palette excludes cyan and stale references must be cleaned"
grapher link --graph "$GRAPH" requirement-page-family-design-parity docs-website-design-plan --rel applies_to --note "Design plan requires new pages to preserve and extend the current visual identity"

grapher link --graph "$GRAPH" requirement-implemented-page-depth-and-proof docs-dev-updates-review --rel evidenced_by --note "Route review distinguishes meaningful first drafts from mature content completion"
grapher link --graph "$GRAPH" requirement-implemented-page-depth-and-proof docs-website-design-plan --rel applies_to --note "Design plan specifies deeper source-backed commercial, educational, proof, and internal-linking content"

grapher validate --graph "$GRAPH"
grapher audit --graph "$GRAPH"
