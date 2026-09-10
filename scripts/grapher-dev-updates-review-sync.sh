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
  --id requirement-static-crawlable-shared-shell \
  --type requirement \
  --title "Deployable primary navigation must not depend exclusively on client JavaScript" \
  --content '{"requirement":"Canonical shared fragment files may remain the source of truth, but deployable public HTML must expose primary navigation and important shared content without requiring client JavaScript to create it.","acceptance_condition":"Production/static output contains crawlable primary navigation and footer content through build/export injection or an equivalent static fallback; JavaScript enhances interaction rather than being the sole source of the menu; direct routes remain usable when fragment fetch fails or JavaScript is unavailable."}' \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,requirement,seo,crawlability,fragments,static \
  --status current \
  --workflow-state active \
  --verification unverified \
  --reason "Current page-family HTML exposes fragment mounts while site-header.js creates the shared shell at runtime"

grapher add "${common[@]}" \
  --id requirement-seo-discovery-files \
  --type requirement \
  --title "Public route set requires deliberate sitemap and robots files" \
  --content '{"requirement":"The production site must include a root sitemap.xml matching intended indexable canonical routes and a deliberate root robots.txt that references the sitemap and handles non-public/utility routes intentionally.","acceptance_condition":"Both files exist in deployable output, validate, match production canonical URLs, and are verified against the actual route/indexing policy."}' \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,requirement,seo,sitemap,robots,crawlability \
  --status current \
  --workflow-state active \
  --verification contradicted \
  --reason "Source review found no root sitemap.xml or robots.txt on dev/updates"

grapher add "${common[@]}" \
  --id requirement-page-family-design-parity \
  --type requirement \
  --title "New page family must consume the canonical visual token and typography contract" \
  --content '{"requirement":"New page-family routes must preserve the established Plumbing Track visual identity by using compatible shared color tokens and typography rather than relying on undefined custom properties or an unrelated primary fallback font.","acceptance_condition":"All variables used by shared-navigation.css are defined through a canonical token source or explicit fallbacks; page-family routes use the intended shared typography; normal/hover/focus/scrolled/mobile states are visually verified across page families."}' \
  --path docs/DEV_UPDATES_REVIEW_2026-09-10.md \
  --tags plumbing-track,requirement,design-system,tokens,typography,css \
  --status current \
  --workflow-state active \
  --verification contradicted \
  --reason "page-family.css does not define --cyan/--cyan-soft used by shared-navigation.css and currently defaults the page family to Arial/Helvetica"

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
grapher link --graph "$GRAPH" docs-dev-updates-review docs-instructions --rel references --note "Review evaluates the branch against governing implementation requirements"
grapher link --graph "$GRAPH" docs-dev-updates-review docs-website-design-plan --rel references --note "Review evaluates current implementation against target architecture and visual/SEO direction"
grapher link --graph "$GRAPH" docs-implementation-roadmap docs-dev-updates-review --rel derived_from --note "Current roadmap rebaseline incorporates the 2026-09-10 branch review"

grapher link --graph "$GRAPH" decision-page-family-rebaseline docs-dev-updates-review --rel evidenced_by --note "Route-by-route source review supports the reclassification"
grapher link --graph "$GRAPH" decision-page-family-rebaseline docs-implementation-roadmap --rel applies_to --note "Reclassification updates the Wave 1/Wave 2 roadmap"

grapher link --graph "$GRAPH" requirement-static-crawlable-shared-shell docs-dev-updates-review --rel evidenced_by --note "Review documents runtime-only shared-shell creation as a source-confirmed production issue"
grapher link --graph "$GRAPH" requirement-static-crawlable-shared-shell docs-instructions --rel applies_to --note "Governing instructions require crawlable navigation and no important content exclusively behind JavaScript"

grapher link --graph "$GRAPH" requirement-seo-discovery-files docs-dev-updates-review --rel evidenced_by --note "Review records absence of sitemap.xml and robots.txt"
grapher link --graph "$GRAPH" requirement-seo-discovery-files docs-instructions --rel applies_to --note "Governing SEO requirements include sitemap and robots support where applicable"

grapher link --graph "$GRAPH" requirement-page-family-design-parity docs-dev-updates-review --rel evidenced_by --note "Review records token and typography drift in the new page-family CSS"
grapher link --graph "$GRAPH" requirement-page-family-design-parity docs-website-design-plan --rel applies_to --note "Design plan requires new pages to preserve and extend the current visual identity"

grapher link --graph "$GRAPH" requirement-implemented-page-depth-and-proof docs-dev-updates-review --rel evidenced_by --note "Route review distinguishes meaningful first drafts from mature content completion"
grapher link --graph "$GRAPH" requirement-implemented-page-depth-and-proof docs-website-design-plan --rel applies_to --note "Design plan specifies deeper source-backed commercial, educational, proof, and internal-linking content"

grapher validate --graph "$GRAPH"
grapher audit --graph "$GRAPH"
