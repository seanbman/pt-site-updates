from pathlib import Path


def replace_once(path: Path, old: str, new: str) -> None:
    text = path.read_text(encoding="utf-8")
    if new in text:
        return
    if old not in text:
        raise SystemExit(f"Expected routing/design text not found in {path}")
    path.write_text(text.replace(old, new, 1), encoding="utf-8")


index = Path("index.html")
replace_once(
    index,
    '<a class="primary-cta" href="#how-it-works">See How It Works<span aria-hidden="true">&nbsp;⌄</span></a>',
    '<a class="primary-cta" href="/how-it-works/">See How It Works<span aria-hidden="true">&nbsp;›</span></a>',
)
replace_once(
    index,
    '<a class="text-link" href="/assessment/?source_page=%2F&amp;source_cta=how-it-works-preview" data-assessment-cta="how-it-works-preview">Talk through your project <span aria-hidden="true">›</span></a>',
    '<a class="text-link" href="/how-it-works/">See how it works <span aria-hidden="true">›</span></a>',
)

plan = Path("docs/WEBSITE_DESIGN_PLAN.md")
replace_once(
    plan,
    """How It Works
        │
        ▼
5-phase project overview
        │
        ├────► Book Assessment
        │
        ▼
Detailed Installation Process
        │
        ├────► Our Technology
        ├────► Our Work
        └────► Book Assessment""",
    """How It Works
        │
        ▼
5-phase project overview + accessible plumbing context
        │
        ├────► Our Work / proof
        ├────► Book Assessment (downstream)
        │
        ▼
Detailed Installation Process
        │
        ├────► Our Technology
        ├────► Our Work
        └────► Book Assessment""",
)
replace_once(
    plan,
    """Designed primarily for boards, owners, and property managers.

Five phases:""",
    """Designed primarily for boards, owners, and property managers.

The Wave 1 page must also explain enough of the **accessible plumbing** idea to make the project process intelligible before conversion: Plumbing Track plans an enclosed accessible route rather than simply replacing pipe and burying the replacement system again. The page should route onward to proof and only then treat Assessment as the conversion step.

Five phases:""",
)
