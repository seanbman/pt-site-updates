# Plumbing Track Documentation Index

This directory is the human-readable planning and source layer for `pt-site-updates`.

Grapher records should reference these paths rather than duplicating full documents into semantic entries. The stable IDs below are the intended graph identities for documentation-level records.

| Grapher ID | Path | Role | Current status |
|---|---|---|---|
| `docs-instructions` | `docs/INSTRUCTIONS.md` | Governing implementation instructions and source precedence | Current |
| `docs-website-design-plan` | `docs/WEBSITE_DESIGN_PLAN.md` | Target website architecture and design plan | Current |
| `docs-implementation-roadmap` | `docs/IMPLEMENTATION_ROADMAP.md` | Living Wave 1 / Wave 2 execution status | Current |
| `docs-decision-how-it-works-routing` | `docs/DECISION_HOW_IT_WORKS_ROUTING.md` | Current routing decision: explain before assessment | Current |
| `docs-web-work-sheet` | `docs/plumbing track web work sheet.pdf` | Earlier source / supporting website worksheet | Source evidence |
| `docs-site-export` | `docs/site-export/` | Archived Squarespace material | Historical source evidence |

## Documentation relationships

```mermaid
flowchart TD
    I[docs/INSTRUCTIONS.md]
    D[docs/WEBSITE_DESIGN_PLAN.md]
    R[docs/IMPLEMENTATION_ROADMAP.md]
    H[docs/DECISION_HOW_IT_WORKS_ROUTING.md]
    W[docs/plumbing track web work sheet.pdf]
    S[docs/site-export/]

    I --> D
    D --> R
    I --> R
    H --> R
    H --> D
    W --> D
    S --> D
```

## Current precedence inside `docs/`

For current implementation decisions:

1. explicit current operator decisions recorded in a current decision document;
2. `docs/INSTRUCTIONS.md`;
3. `docs/IMPLEMENTATION_ROADMAP.md` for current implementation/wave status;
4. `docs/WEBSITE_DESIGN_PLAN.md` for target architecture and design intent;
5. source/supporting documents and archived exports.

This local ordering does not replace the broader source-precedence rules in `docs/INSTRUCTIONS.md`; it only clarifies how the tracked project documentation relates to itself.

## Current routing note

`How It Works` is now a Wave 1 explanatory page. Homepage and navigation entry points should route to `/how-it-works/`; Assessment is a downstream conversion action rather than the destination used to explain the process.

See `docs/DECISION_HOW_IT_WORKS_ROUTING.md`.
