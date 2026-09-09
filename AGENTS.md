# Plumbing Track Agent Instructions

This repository is governed by the current project documentation in `docs/` and by the project-local Grapher knowledge graph in `.grapher/`.

Before material work, read the relevant current documentation, especially:

- `docs/INSTRUCTIONS.md`
- `docs/WEBSITE_DESIGN_PLAN.md`
- `docs/IMPLEMENTATION_ROADMAP.md`
- `docs/INDEX.md`

Treat the current implementation and explicit operator decisions as the working baseline unless a concrete defect or later decision supersedes them.

## Grapher is mandatory for documentation work

**Use Grapher continuously while creating, changing, reorganizing, or interpreting project documentation.** Documentation and Grapher must evolve together; Grapher is not a one-time indexing step performed after the work is finished.

For any material documentation task:

1. **Before editing:** search Grapher for existing requirements, decisions, current implementation state, superseded records, and relevant document nodes.
2. **During editing:** create or update Grapher nodes and relationships as soon as a meaningful requirement, decision, scope change, interpretation, dependency, or implementation consequence becomes durable.
3. **When changing direction:** preserve history. Supersede or explicitly relate prior records rather than silently rewriting the graph as though the old decision never existed.
4. **When adding or moving documentation:** keep `docs/INDEX.md`, stable document-node identities, paths, and Grapher relationships aligned.
5. **Before considering the documentation task complete:** run Grapher validation and audit, and verify that the graph expresses the material state represented by the documentation.

A change to `docs/**` is **not complete** merely because the Markdown/PDF/file was committed. The corresponding Grapher state must be current in the same work cycle.

## Continuous semantic capture

Do not wait until the end of a large implementation session to record documentation-relevant knowledge. Record significant findings and decisions when they become known, including:

- operator scope decisions;
- Wave 1 / Wave 2 classification changes;
- navigation and routing decisions;
- source-precedence or factual conflicts;
- SEO/GA4 requirements and verification findings;
- implementation decisions that alter documented architecture;
- intentionally deferred work;
- corrections to prior assumptions;
- acceptance criteria and verification outcomes.

Use precise node types and relationships where available. Keep truth status, workflow state, verification, provenance, and history distinct.

## Grapher mutation rules

Use the Grapher CLI/API for semantic mutations. **Do not directly hand-edit** `.grapher/knowledge.json` or `.grapher/history.jsonl` to manufacture graph state.

The repository currently uses the Grapher format compatible with the pinned documentation-sync automation. Do not migrate or upgrade the graph format casually as part of unrelated website work.

The automated `Grapher docs sync` workflow is a safety net that keeps stable tracked documentation records synchronized. **It does not replace continuous agent use of Grapher.** Agents remain responsible for recording the actual semantic decisions, relationships, supersession, evidence, and verification created by their work.

## Documentation authority

Follow the source-precedence and verification rules in `docs/INSTRUCTIONS.md`. Do not use Grapher as permission to invent facts: graph records must remain grounded in operator decisions, verified implementation, and the authoritative sources defined by the project instructions.
