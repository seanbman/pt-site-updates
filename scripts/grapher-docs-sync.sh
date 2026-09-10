#!/usr/bin/env bash
set -euo pipefail

GRAPH=".grapher/knowledge.json"
OP="docs-sync-${GITHUB_SHA:-$(date -u +%Y%m%dT%H%M%SZ)}"

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
  --id agents-instructions \
  --type document \
  --title "Plumbing Track agent operating instructions" \
  --content "Repository agent policy requiring continuous Grapher use during documentation work, semantic capture as decisions become durable, history-preserving updates, and validate/audit before documentation tasks are considered complete." \
  --path AGENTS.md \
  --tags plumbing-track,agents,grapher,documentation,governance \
  --status canonical_spec \
  --workflow-state active \
  --verification not_applicable \
  --reason "Index the repository-level agent operating policy in Grapher"

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
  --content "Target information architecture and design plan: preserve the existing visual identity and homepage video while expanding into focused, indexable pages. The current plan includes the detailed Book an Assessment conversion specification." \
  --path docs/WEBSITE_DESIGN_PLAN.md \
  --tags plumbing-track,docs,design,architecture,assessment \
  --status current \
  --workflow-state completed \
  --verification not_applicable \
  --reason "Index target architecture and current assessment specification in Grapher"

grapher add "${common_agent[@]}" \
  --id docs-implementation-roadmap \
  --type document \
  --title "Plumbing Track implementation roadmap" \
  --content "Living Wave 1/Wave 2 status companion to the design plan. Current implementation is the baseline; the expanded Assessment specification is treated as verification/hardening for the existing flow, and shared fragments are the preferred synchronization mechanism for repeated cross-page markup." \
  --path docs/IMPLEMENTATION_ROADMAP.md \
  --tags plumbing-track,docs,roadmap,waves,assessment,fragments \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Index current execution status and post-main-sync plan evaluation in Grapher"

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

# Explicit semantic decisions and requirements.
grapher add \
  --graph "$GRAPH" \
  --id decision-continuous-documentation-grapher \
  --type decision \
  --title "Use Grapher continuously for documentation" \
  --content '{"decision":"Agents must use Grapher continuously while creating, changing, reorganizing, or interpreting project documentation.","rationale":"Documentation and durable project knowledge must evolve together; a one-time or end-of-session sync can miss decisions, supersession, relationships, and verification state."}' \
  --path AGENTS.md \
  --tags plumbing-track,grapher,documentation,agents,decision \
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
  --reason "Operator explicitly required continuous Grapher use for documentation"

grapher add "${common_agent[@]}" \
  --id requirement-continuous-documentation-grapher \
  --type requirement \
  --title "Documentation work must stay synchronized with Grapher" \
  --content '{"requirement":"Before material documentation edits, agents must search Grapher; during the work they must record durable decisions, requirements, scope changes, relationships, supersession, and verification as they become known; before completion they must validate and audit the graph.","acceptance_condition":"Documentation changes and corresponding Grapher semantic state are updated in the same work cycle; direct hand-editing of Grapher state files is avoided; CI sync is treated as a backstop rather than a substitute for agent semantic capture."}' \
  --path AGENTS.md \
  --tags plumbing-track,requirement,grapher,documentation,continuous \
  --status canonical_spec \
  --workflow-state active \
  --verification not_applicable \
  --reason "Make continuous documentation graphing an ongoing acceptance requirement"

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

# Post-main-sync assessment plan evaluation.
grapher add "${common_agent[@]}" \
  --id requirement-assessment-detailed-conversion \
  --type requirement \
  --title "Assessment flow must be a structured building conversion experience" \
  --content '{"requirement":"The unified assessment route must progressively capture building, project, contact, review, attribution, submission, confirmation, and CRM-ready structured data without forcing visitors to diagnose unknown plumbing conditions.","acceptance_condition":"Current assessment flow satisfies the source-level structure; production API behavior, GA4 initialization and no-PII behavior, CTA attribution coverage, cross-device usability, and accessibility remain explicitly verified before launch."}' \
  --path docs/WEBSITE_DESIGN_PLAN.md \
  --tags plumbing-track,requirement,assessment,conversion,crm,ga4 \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Capture the detailed assessment conversion specification added on main"

grapher add "${common_agent[@]}" \
  --id decision-assessment-hardening-not-rebuild \
  --type decision \
  --title "Treat expanded Assessment plan as hardening, not a rebuild" \
  --content '{"decision":"The expanded Book an Assessment design section is a verification and hardening specification for the existing assessment implementation, not a greenfield rebuild instruction.","rationale":"Source review confirms the dedicated route, four-step flow, structured payload, unsure states, minimal required contact fields, attribution support, review/success/error handling, duplicate-submit guard, and assessment event emission already exist."}' \
  --path docs/IMPLEMENTATION_ROADMAP.md \
  --tags plumbing-track,assessment,roadmap,hardening,decision \
  --status current \
  --workflow-state completed \
  --verification partially_verified \
  --reason "Reconcile the newly expanded design-plan task with the implementation already present after the main sync"

grapher add "${common_agent[@]}" \
  --id requirement-shared-fragment-reuse \
  --type requirement \
  --title "Use shared fragments for synchronized cross-page markup" \
  --content '{"requirement":"When identical markup and behavior must stay synchronized across multiple pages, extend or create a shared fragment instead of maintaining divergent copies; genuinely page-specific content should remain local.","acceptance_condition":"Shared header, footer, and testimonial-card patterns remain canonical; future repeated cross-page components reuse the fragment approach where it reduces drift without creating unnecessary coupling."}' \
  --path docs/IMPLEMENTATION_ROADMAP.md \
  --tags plumbing-track,requirement,fragments,shared-components,maintenance \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Record the fragment reuse rule established by the current implementation"

# Documentation map.
grapher link --graph "$GRAPH" docs-index agents-instructions --rel references --note "Repository agent operating policy"
grapher link --graph "$GRAPH" docs-index docs-instructions --rel references --note "Governing instructions"
grapher link --graph "$GRAPH" docs-index docs-website-design-plan --rel references --note "Target design architecture"
grapher link --graph "$GRAPH" docs-index docs-implementation-roadmap --rel references --note "Living execution status"
grapher link --graph "$GRAPH" docs-index docs-decision-how-it-works-routing --rel references --note "Current routing decision"
grapher link --graph "$GRAPH" docs-index docs-web-work-sheet --rel references --note "Supporting source evidence"
grapher link --graph "$GRAPH" docs-index docs-site-export --rel references --note "Archived source evidence"

grapher link --graph "$GRAPH" agents-instructions docs-index --rel references --note "Agents use the documentation index as the human-readable map"
grapher link --graph "$GRAPH" agents-instructions docs-instructions --rel references --note "Agent policy defers project authority and source precedence to governing instructions"
grapher link --graph "$GRAPH" decision-continuous-documentation-grapher agents-instructions --rel evidenced_by --note "The repository agent policy records the operator decision"
grapher link --graph "$GRAPH" requirement-continuous-documentation-grapher decision-continuous-documentation-grapher --rel decided_by --note "Ongoing documentation requirement follows the operator decision"
grapher link --graph "$GRAPH" requirement-continuous-documentation-grapher agents-instructions --rel evidenced_by --note "Acceptance rule is written in AGENTS.md"
grapher link --graph "$GRAPH" requirement-continuous-documentation-grapher docs-index --rel applies_to --note "Continuous Grapher discipline applies to the tracked documentation set"

grapher link --graph "$GRAPH" docs-website-design-plan docs-instructions --rel constrains 2>/dev/null || \
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

# Post-main-sync plan relationships.
grapher link --graph "$GRAPH" requirement-assessment-detailed-conversion docs-website-design-plan --rel evidenced_by --note "Detailed conversion requirement is specified in the design plan"
grapher link --graph "$GRAPH" decision-assessment-hardening-not-rebuild requirement-assessment-detailed-conversion --rel applies_to --note "Roadmap evaluation classifies the existing implementation against the expanded requirement"
grapher link --graph "$GRAPH" decision-assessment-hardening-not-rebuild docs-implementation-roadmap --rel evidenced_by --note "The post-main-sync evaluation is recorded in the roadmap"
grapher link --graph "$GRAPH" requirement-shared-fragment-reuse docs-implementation-roadmap --rel evidenced_by --note "Fragment reuse rule is recorded in the roadmap"

if grapher get --graph "$GRAPH" implementation-assessment-flow >/dev/null 2>&1; then
  grapher link --graph "$GRAPH" implementation-assessment-flow requirement-assessment-detailed-conversion --rel satisfies --note "Existing assessment implementation satisfies the source-level structure; launch verification remains open"
  grapher link --graph "$GRAPH" implementation-assessment-flow decision-assessment-hardening-not-rebuild --rel applies_to --note "Existing implementation is the baseline to harden rather than rebuild"
fi

if grapher get --graph "$GRAPH" implementation-shared-chrome >/dev/null 2>&1; then
  grapher link --graph "$GRAPH" implementation-shared-chrome requirement-shared-fragment-reuse --rel satisfies --note "Shared header/footer implementation establishes the fragment pattern"
fi

if grapher get --graph "$GRAPH" implementation-visual-hygiene >/dev/null 2>&1; then
  grapher link --graph "$GRAPH" implementation-visual-hygiene requirement-shared-fragment-reuse --rel satisfies --note "Shared testimonial-card implementation extends the fragment pattern beyond chrome"
fi

# Tie the docs map back to the pre-existing plan requirement when present.
if grapher get --graph "$GRAPH" requirement-website-design-plan >/dev/null 2>&1; then
  grapher link --graph "$GRAPH" docs-website-design-plan requirement-website-design-plan --rel references --note "Tracked design document behind the existing implementation requirement"
fi

grapher validate --graph "$GRAPH"
grapher audit --graph "$GRAPH"
