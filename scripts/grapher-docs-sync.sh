#!/usr/bin/env bash
set -euo pipefail

GRAPH=".grapher/knowledge.json"
OP="docs-sync-2026-09-09"

common_agent=(
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

# Human-readable documentation records. These are stable IDs and are safe to
# upsert repeatedly; Grapher journals changes and preserves prior state.
grapher add "${common_agent[@]}" \
  --id docs-index \
  --type document \
  --title "Plumbing Track documentation index" \
  --content "Index of current project documentation, source roles, stable Grapher identities, and relationships for docs/." \
  --path docs/INDEX.md \
  --tags plumbing-track,docs,index \
  --status current \
  --workflow-state completed \
  --verification not_applicable \
  --reason "Make the docs directory explicitly navigable in Grapher"

grapher add "${common_agent[@]}" \
  --id docs-instructions \
  --type document \
  --title "Plumbing Track implementation instructions" \
  --content "Governing project instructions covering source precedence, site architecture, SEO, GA4, verification, and execution discipline." \
  --path docs/INSTRUCTIONS.md \
  --tags plumbing-track,docs,instructions,governance \
  --status canonical_spec \
  --workflow-state completed \
  --verification not_applicable \
  --reason "Index governing instructions in Grapher"

grapher add "${common_agent[@]}" \
  --id docs-website-design-plan \
  --type document \
  --title "Plumbing Track website design plan" \
  --content "Target information architecture and design plan: preserve the existing visual identity and homepage video while expanding into focused, indexable pages." \
  --path docs/WEBSITE_DESIGN_PLAN.md \
  --tags plumbing-track,docs,design,architecture \
  --status current \
  --workflow-state completed \
  --verification not_applicable \
  --reason "Index target architecture in Grapher"

grapher add "${common_agent[@]}" \
  --id docs-implementation-roadmap \
  --type document \
  --title "Plumbing Track implementation roadmap" \
  --content "Living Wave 1/Wave 2 status companion to the design plan. Menu clickability does not define wave membership; current implementation is the baseline." \
  --path docs/IMPLEMENTATION_ROADMAP.md \
  --tags plumbing-track,docs,roadmap,waves \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Index current execution status in Grapher"

grapher add "${common_agent[@]}" \
  --id docs-decision-how-it-works-routing \
  --type document \
  --title "Decision document: How It Works routing" \
  --content "Current operator decision: How It Works must explain the process and accessible plumbing before asking the visitor to complete the assessment form." \
  --path docs/DECISION_HOW_IT_WORKS_ROUTING.md \
  --tags plumbing-track,docs,decision,how-it-works,accessible-plumbing \
  --status current \
  --workflow-state completed \
  --verification not_applicable \
  --reason "Index the current How It Works routing decision"

grapher add "${common_agent[@]}" \
  --id docs-web-work-sheet \
  --type document \
  --title "Plumbing Track web work sheet" \
  --content "Supporting website worksheet retained as lower-precedence source evidence under the current implementation instructions." \
  --path "docs/plumbing track web work sheet.pdf" \
  --tags plumbing-track,docs,source-evidence,worksheet \
  --status historical \
  --workflow-state not_applicable \
  --verification not_applicable \
  --reason "Represent supporting worksheet in the documentation graph"

grapher add "${common_agent[@]}" \
  --id docs-site-export \
  --type document \
  --title "Archived Squarespace site export" \
  --content "Archived Squarespace material retained for reference and source reconciliation; lower precedence than current operator decisions and tracked planning documents." \
  --path docs/site-export/ \
  --tags plumbing-track,docs,archive,squarespace \
  --status historical \
  --workflow-state not_applicable \
  --verification not_applicable \
  --reason "Represent archived site material in the documentation graph"

# Explicit semantic decision and requirement records.
grapher add \
  --graph "$GRAPH" \
  --id decision-how-it-works-routing \
  --type decision \
  --title "Explain How It Works before assessment" \
  --content '{"decision":"Route How It Works entry points to a standalone explanatory page before assessment conversion.","rationale":"Visitors should understand the Plumbing Track process and accessible-plumbing approach before being asked for building details."}' \
  --path docs/DECISION_HOW_IT_WORKS_ROUTING.md \
  --tags plumbing-track,how-it-works,accessible-plumbing,routing \
  --stage developing \
  --status current \
  --workflow-state completed \
  --verification verified \
  --actor operator \
  --actor-kind human \
  --role operator \
  --source chatgpt \
  --provenance-integrity declared \
  --operation-id "$OP" \
  --phase canonical \
  --reason "Operator explicitly rejected direct How It Works to assessment routing"

grapher add "${common_agent[@]}" \
  --id requirement-explain-before-assessment \
  --type requirement \
  --title "How It Works must explain before conversion" \
  --content '{"requirement":"How It Works must route to its own explanatory page containing accessible-plumbing context and the project process instead of directly to the assessment form.","acceptance_condition":"Homepage and navigation How It Works entry points resolve to /how-it-works/; the page explains accessible plumbing and the five-phase process; Assessment remains a downstream CTA."}' \
  --path docs/DECISION_HOW_IT_WORKS_ROUTING.md \
  --tags plumbing-track,requirement,how-it-works,routing \
  --status current \
  --workflow-state completed \
  --verification partially_verified \
  --reason "Capture current routing acceptance criteria"

grapher add "${common_agent[@]}" \
  --id component-how-it-works-page \
  --type component \
  --title "Standalone How It Works page" \
  --content "Wave 1 /how-it-works/ explanatory page combining accessible-plumbing context, the five-phase project process, proof routing, and downstream assessment CTA." \
  --path how-it-works/index.html \
  --tags plumbing-track,component,how-it-works,accessible-plumbing \
  --status current \
  --workflow-state completed \
  --verification partially_verified \
  --reason "Record the new explanatory route implementation"

# Documentation map.
grapher link --graph "$GRAPH" docs-index docs-instructions --rel references --note "Governing instructions"
grapher link --graph "$GRAPH" docs-index docs-website-design-plan --rel references --note "Target design architecture"
grapher link --graph "$GRAPH" docs-index docs-implementation-roadmap --rel references --note "Living execution status"
grapher link --graph "$GRAPH" docs-index docs-decision-how-it-works-routing --rel references --note "Current routing decision"
grapher link --graph "$GRAPH" docs-index docs-web-work-sheet --rel references --note "Supporting source evidence"
grapher link --graph "$GRAPH" docs-index docs-site-export --rel references --note "Archived source evidence"

grapher link --graph "$GRAPH" docs-website-design-plan docs-instructions --rel constrained_by 2>/dev/null || \
  grapher link --graph "$GRAPH" docs-website-design-plan docs-instructions --rel applies_to --note "Design plan operates under governing instructions"
grapher link --graph "$GRAPH" docs-implementation-roadmap docs-website-design-plan --rel derived_from --note "Roadmap applies target architecture to current implementation state"
grapher link --graph "$GRAPH" docs-decision-how-it-works-routing docs-website-design-plan --rel deviates_from --note "Refines the earlier direct-to-assessment process routing without discarding the wider design plan"
grapher link --graph "$GRAPH" docs-web-work-sheet docs-website-design-plan --rel referenced_by 2>/dev/null || \
  grapher link --graph "$GRAPH" docs-website-design-plan docs-web-work-sheet --rel references --note "Supporting website source"
grapher link --graph "$GRAPH" docs-website-design-plan docs-site-export --rel references --note "Archived legacy reference"

# Decision -> requirement -> implementation.
grapher link --graph "$GRAPH" decision-how-it-works-routing docs-decision-how-it-works-routing --rel evidenced_by --note "Decision is documented in the tracked decision file"
grapher link --graph "$GRAPH" requirement-explain-before-assessment decision-how-it-works-routing --rel decided_by --note "Requirement follows the operator routing decision"
grapher link --graph "$GRAPH" component-how-it-works-page requirement-explain-before-assessment --rel satisfies --note "Standalone page fulfills the explanatory routing requirement"
grapher link --graph "$GRAPH" component-how-it-works-page decision-how-it-works-routing --rel implements --note "Implementation realizes the routing decision"

# Tie the new docs map back to the pre-existing plan requirement when present.
if grapher get --graph "$GRAPH" requirement-website-design-plan >/dev/null 2>&1; then
  grapher link --graph "$GRAPH" docs-website-design-plan requirement-website-design-plan --rel references --note "Tracked design document behind the existing implementation requirement"
fi

grapher validate --graph "$GRAPH"
grapher audit --graph "$GRAPH"
