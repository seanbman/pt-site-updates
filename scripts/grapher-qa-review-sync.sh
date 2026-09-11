#!/usr/bin/env bash
set -euo pipefail

GRAPH=".grapher/knowledge.json"
OP="qa-review-sync-${GITHUB_SHA:-$(date -u +%Y%m%dT%H%M%SZ)}"

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

# QA/media documentation records introduced by the September 10 hardening pass.
grapher add "${common[@]}" \
  --id docs-media-resource-reference \
  --type document \
  --title "Website media resource reference" \
  --content "Curated September 2026 website media handoff indexing priority images and videos, recommended page placement, review limitations, privacy checks, and claim-evidence boundaries." \
  --path docs/media/RESOURCE_REFERENCE.md \
  --tags plumbing-track,docs,media,proof,reference \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Keep the curated website media reference represented in the documentation graph"

grapher add "${common[@]}" \
  --id docs-grok-review-2026-09-10 \
  --type document \
  --title "Grok repository QA review and reconciliation" \
  --content "Advisory external repo review preserved verbatim and reconciled against dev/updates, current project documentation, operator decisions, and verified source behavior." \
  --path docs/qa-review/GROK_REPO_REVIEW_2026-09-10.md \
  --tags plumbing-track,docs,qa,review,grok,reconciliation \
  --status current \
  --workflow-state completed \
  --verification partially_verified \
  --reason "Represent the supplied QA review and its project-authority reconciliation"

grapher add "${common[@]}" \
  --id docs-hardening-plan-2026-09-10 \
  --type document \
  --title "Website production hardening plan" \
  --content "Reconciled execution plan for build-time delivery, technical SEO, assessment funnel, GA4 measurement, privacy-safe CRM attribution, proof media, destination-page differentiation, accessibility, performance, and launch QA." \
  --path docs/qa-review/WEBSITE_HARDENING_PLAN_2026-09-10.md \
  --tags plumbing-track,docs,hardening,seo,ga4,crm,assessment,qa \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Represent the current follow-up hardening plan in Grapher"

# Durable requirements that the reconciled hardening plan adds or sharpens.
grapher add "${common[@]}" \
  --id requirement-ga4-crm-measurement-contract \
  --type requirement \
  --title "Keep GA4 behavioral and CRM identity data separated" \
  --content '{"requirement":"The site must measure the visitor-to-assessment funnel with controlled non-PII GA4 dimensions while identified contact/property data and summarized first-party marketing context are persisted with the CRM lead.","acceptance_condition":"GA4 initializes once; assessment_cta_click, assessment_started, assessment progression and generate_lead are verified; no name, email, phone, street address, organization, free text, or exact unit count is sent to GA4; accepted assessment leads persist CRM attribution and marketing context."}' \
  --path docs/qa-review/WEBSITE_HARDENING_PLAN_2026-09-10.md \
  --tags plumbing-track,requirement,ga4,crm,assessment,attribution,privacy \
  --status current \
  --workflow-state active \
  --verification unverified \
  --reason "Capture the hardened analytics-to-CRM attribution boundary and launch acceptance criteria"

grapher add "${common[@]}" \
  --id requirement-destination-page-differentiation \
  --type requirement \
  --title "Differentiate commercial destinations with source-backed proof" \
  --content '{"requirement":"Shared page-family components must remain visually consistent while Poly-B, Kitec, Occupied Building Repiping, About, and related destinations gain problem-specific evidence and narrative depth instead of remaining mechanically interchangeable templates.","acceptance_condition":"Each priority destination contains at least one source-backed differentiating module or proof path; Solutions connect visitor problem/material intent to the accessible-route consequence, installation approach, proof, and assessment without inventing claims."}' \
  --path docs/qa-review/WEBSITE_HARDENING_PLAN_2026-09-10.md \
  --tags plumbing-track,requirement,content,solutions,proof,seo,design \
  --status current \
  --workflow-state active \
  --verification unverified \
  --reason "Carry the validated QA insight about page-family sameness into durable hardening requirements"

grapher add "${common[@]}" \
  --id requirement-resources-current-hub-label \
  --type requirement \
  --title "Treat Resources as the current public content hub" \
  --content '{"requirement":"Current documentation and implementation work must treat Resources as the present public hub/navigation label; older Learn wording must not cause agents to create a second empty content hub.","acceptance_condition":"Current planning language is normalized; Wave 2C educational content expands the focused resource/content strategy deliberately rather than fabricating an unready Learn library."}' \
  --path docs/qa-review/WEBSITE_HARDENING_PLAN_2026-09-10.md \
  --tags plumbing-track,requirement,resources,learn,information-architecture,docs \
  --status current \
  --workflow-state active \
  --verification partially_verified \
  --reason "Resolve the validated Learn versus Resources documentation drift"

# Documentation map and provenance relationships.
grapher link --graph "$GRAPH" docs-index docs-media-resource-reference --rel references --note "Curated media source and placement reference"
grapher link --graph "$GRAPH" docs-index docs-grok-review-2026-09-10 --rel references --note "Reconciled advisory QA review"
grapher link --graph "$GRAPH" docs-index docs-hardening-plan-2026-09-10 --rel references --note "Current production hardening execution plan"

grapher link --graph "$GRAPH" docs-hardening-plan-2026-09-10 docs-dev-updates-review --rel derived_from --note "Hardening plan incorporates the current branch review and production gates"
grapher link --graph "$GRAPH" docs-hardening-plan-2026-09-10 docs-grok-review-2026-09-10 --rel derived_from --note "Validated Grok findings were reconciled into the hardening plan"
grapher link --graph "$GRAPH" docs-hardening-plan-2026-09-10 docs-website-design-plan --rel derived_from --note "Hardening preserves the approved information architecture and visual strategy"
grapher link --graph "$GRAPH" docs-hardening-plan-2026-09-10 docs-partials-implementation-plan --rel references --note "Build-time shared partial migration remains the first implementation workstream"
grapher link --graph "$GRAPH" docs-hardening-plan-2026-09-10 docs-media-resource-reference --rel references --note "Media proof work follows the curated resource reference and evidence limits"

grapher link --graph "$GRAPH" requirement-ga4-crm-measurement-contract docs-hardening-plan-2026-09-10 --rel evidenced_by --note "Hardening plan records the GA4/CRM measurement and privacy contract"
grapher link --graph "$GRAPH" requirement-ga4-crm-measurement-contract requirement-assessment-detailed-conversion --rel applies_to --note "Measurement and CRM attribution harden the existing assessment conversion flow"

grapher link --graph "$GRAPH" requirement-destination-page-differentiation docs-hardening-plan-2026-09-10 --rel evidenced_by --note "Hardening plan records the reconciled destination-page depth requirement"
grapher link --graph "$GRAPH" requirement-destination-page-differentiation requirement-implemented-page-depth-and-proof --rel applies_to --note "Differentiation sharpens the existing source-backed page-depth requirement"

grapher link --graph "$GRAPH" requirement-resources-current-hub-label docs-hardening-plan-2026-09-10 --rel evidenced_by --note "Hardening plan records Resources as the current live hub label"
grapher link --graph "$GRAPH" requirement-resources-current-hub-label docs-website-design-plan --rel deviates_from --note "Current Resources label refines older Learn terminology without discarding the educational-content strategy"

grapher validate --graph "$GRAPH"
grapher audit --graph "$GRAPH"
