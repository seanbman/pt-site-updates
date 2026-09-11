# Plumbing Track Video Curation — Agent Instructions

## Purpose
Use the reviewed Plumbing Track video library as source material for the current `pt-site-updates` website plan without changing the site's established visual direction or inventing unsupported claims.

These instructions apply to any agent selecting, editing, exporting, placing, captioning, or documenting video from the Google Drive `Marketing/Photos/New Photos` collection.

## Governing Website Direction
1. Treat the current `pt-site-updates` implementation and `/docs` plan as authoritative for site structure and visual direction.
2. Preserve the existing homepage hero video. Do not silently replace it with another video or a static image.
3. Maintain the site's core narrative: **Problem → System → Proof**.
4. Maintain **accessible plumbing** as the technical thesis of the Plumbing Track system.
5. Prefer real project evidence over generic marketing imagery.
6. Do not turn pages into long media galleries. Video must support page intent rather than become the page intent.
7. Respect current wave/priority decisions in the repository documentation. A page being absent from navigation does not automatically mean it is omitted from the current implementation wave.

## Audit Scope and Evidence Status
The source folder contains 88 MP4 files.

- 66 videos were fully transferred and visually reviewed across their runtime.
- 22 oversized videos could not be transferred through the Drive connector because of the connector's ~256 MiB per-file download limit.
- Oversized files must remain marked **UNREVIEWED — CONNECTOR SIZE LIMIT** until they are independently opened or supplied through another path.
- Do not grade, describe, publish, or infer the contents of blocked videos from filenames alone.
- Visual review does not constitute verification of spoken claims.
- Audio tracks were present, but no speech-to-text engine was available during the audit. Presenter dialogue must therefore be manually reviewed or transcribed before copy, captions, statistics, guarantees, comparisons, or technical claims are derived from it.

## Primary Website Placements

### Home
- Keep the existing homepage hero video.
- New reviewed footage may be used only as secondary supporting media below the hero when it improves the story.
- Strong finished-installation footage is preferred over talking-head footage for secondary loops.

### Technology
Use footage that visibly demonstrates the relationship between existing plumbing, the Plumbing Track route, installation access, and the finished enclosure.

Strong candidates:
- `20251204_110245.mp4` — open enclosure/track with visible red and blue piping; strongest technical/accessibility visual.
- `20251204_154501.mp4` and `20251204_154509.mp4` — localized opening and existing plumbing context.
- `20251204_153442.mp4` — strong finished transitions and architectural integration.

### Accessible Plumbing
Good evidence can show that the system is intentionally routed and enclosed while remaining service-oriented.

Strong candidates:
- `20251204_110245.mp4`
- `20251018_095809.mp4`
- `20251204_153442.mp4`

Important limitation: the reviewed material does **not** conclusively prove a completed system being reopened years later for maintenance. Do not present installation-stage access as proof of long-term service history.

### Detailed Installation
Map footage to the documented installation sequence where the image actually supports the step:

1. **Prepare the building** — `20251204_110411.mp4`, `20251204_110359.mp4`
2. **Plan the route** — `20260420_091110.mp4`, `20251205_102032.mp4`
3. **Open only what is needed** — `20251205_134853.mp4`, `20251205_134938.mp4`
4. **Coordinate the suite** — `20251205_135703.mp4` or suitable occupied-suite context
5. **Install the system** — `20251205_134828.mp4`, `20251205_135703.mp4`, `20251205_135740.mp4`
6. **Complete the connections** — `20251204_110306.mp4`, `20251204_110245.mp4`
7. **Finish the enclosure** — `20251204_140648.mp4`, `20251204_140754.mp4`
8. **Leave future access** — evidence gap remains; do not claim this step is visually proven unless a clip clearly shows a finished system being accessed for service.

### Occupied Building Repiping
Prefer a short visual sequence that shows limited disruption and a finished result:
- `20251204_154426.mp4` — corridor/localized work
- `20251205_135703.mp4` or `20251205_135740.mp4` — active installation
- `20251018_095809.mp4` or `20251204_153442.mp4` — finished installation

### Conventional vs Plumbing Track
Purpose-shot candidates include:
- `Conventional vs pt garbage amount.mp4`
- `Conventional vs pt kitchen sample.mp4`

These are strategically useful but dependent on spoken explanation. Do not publish claims from them until the dialogue is verified.

### Poly B
Potential source clips:
- `Intro to upcoming poly b job 2.mp4`
- `Intro to new residential poly b job.mp4`

Verify the project, material, permissions, and spoken claims before using them as Poly B proof.

### Our Work
Project-specific footage may be used as case-study evidence only after project identity, location disclosure, and usage permission are verified.

### About / Team
`Mosaic let's meet a plumber.mp4` may support human/team storytelling if the subject release and intended use are confirmed.

## Priority Visual Shortlist
Start with these when building page media. They provide the clearest visual value without depending heavily on dialogue:

- `20251018_095652.mp4` — finished architectural integration
- `20251018_095809.mp4` — finished room route
- `20251018_100331.mp4` — finished doorway/corner integration
- `20251024_124323.mp4` — finished closet condition
- `20251204_110245.mp4` — open enclosure with piping
- `20251204_110306.mp4` — connection detail
- `20251204_111638.mp4` — enclosure fabrication
- `20251204_135928.mp4` — fabrication/cutting
- `20251204_140648.mp4` — finishing compound
- `20251204_140754.mp4` — paint/finish stage
- `20251204_153442.mp4` — strongest finished transitions
- `20251204_154426.mp4` — corridor/localized work
- `20251204_154501.mp4` — localized opening/existing plumbing
- `20251205_134853.mp4` — minimal wall opening
- `20251205_135703.mp4` — active enclosure installation
- `20251205_135740.mp4` — active route installation
- `20260420_091110.mp4` — corridor route continuity

## Material to Exclude From Website Proof
Unless a future editorial purpose is explicitly approved, do not use:
- `lv_0_20251224163025.mp4` — holiday/cookie social montage
- `20260228_191247.mp4` — nighttime dance/event footage

These do not materially support the current website's product, process, technology, or project-proof goals.

## Editing Rules
1. Preserve documentary truth. Do not alter physical plumbing, enclosure geometry, worksite condition, sequence, or apparent extent of work.
2. Do not use generative cleanup to remove meaningful construction evidence.
3. Conservative exposure, white-balance, rotation, crop, and stabilization are acceptable.
4. Trim dead lead-in/out and accidental camera movement where it does not remove context.
5. Prefer 4–10 second muted loops for inline process or finished-result media.
6. Presenter-led clips should normally be click-to-play, not silent autoplay, because their value is tied to speech.
7. For autoplay media use `muted`, `playsinline`, `loop`, and a poster image. Respect `prefers-reduced-motion` and provide a static fallback.
8. Strip audio from decorative/process loops unless sound is editorially necessary.
9. Never use the original 4K/HEVC files directly as ordinary page assets if a web derivative can be made.
10. Prefer modern compressed web derivatives. As a practical baseline, cap inline media at approximately 720p–1080p, use H.264 MP4 and/or an efficient WebM derivative, and enable fast-start behavior for MP4.
11. Preserve portrait orientation when it best communicates the installation. Do not crop important system detail merely to force landscape.
12. Finished-room footage should usually frame the upper architectural band where the enclosure is visible while retaining enough room context to prove integration.
13. Technical close-ups must retain enough surrounding context for a viewer to understand which part of the system is shown.

## Privacy and Release Checks
Before publication, inspect every selected clip for:
- unit or suite numbers
- street addresses
- resident names
- posted notices or paperwork
- faces of residents or bystanders
- family photographs or other identifying items
- medication, mail, financial documents, or private paperwork
- unusually distinctive possessions that could identify a resident or unit

Crop, blur, substitute another clip, or withhold publication where necessary. Do not assume permission merely because the footage exists in Marketing Drive.

## Claims and Copy Rules
- Filenames are discovery hints, not verified evidence.
- Do not infer pipe material, building type, savings, schedule, labour count, waste reduction, access benefits, or disruption levels solely from a filename or visual impression.
- When a presenter makes a claim, verify the spoken wording before converting it to captions or site copy.
- Material-specific pages such as Poly B and Kitec require material/project verification before footage is presented as proof.
- Project names, addresses, client identities, and measured outcomes require source verification and publication permission.
- If evidence is incomplete, write conservatively or omit the claim.

## Repository Workflow
When implementing media in `pt-site-updates`:
1. Read the current `/docs` plan before changing placement or page intent.
2. Inspect the current branch state rather than assuming an older sitemap or mockup is authoritative.
3. Reuse existing fragments/components when practical instead of duplicating navigation, CTA, proof, or media structures across pages.
4. Keep filenames and generated derivatives traceable to the original source filename.
5. Add meaningful alt text/poster text where applicable. Do not keyword-stuff.
6. Document source filename, derivative filename, page placement, crop/trim decisions, and any release/verification dependency.
7. Do not remove the existing homepage video unless explicitly directed by the operator.
8. Do not fill an evidence gap with AI-generated or stock footage while presenting it as Plumbing Track project evidence.

## Grapher / Documentation Requirement
Grapher must be updated continuously as documentation and implementation decisions are made. Media-placement decisions, evidence gaps, source-verification dependencies, and significant derivative-generation work should be represented in the project graph according to the repository's current Grapher workflow.

Documentation is not a one-time handoff. Keep relevant `/docs` material synchronized with implementation changes so a later agent can reconstruct why a clip was selected, what it is allowed to prove, and what still requires verification.

## Completion Standard
A video task is not complete merely because a file has been exported and placed on a page. For each published asset, the agent should be able to answer:

- What source clip did this come from?
- What page purpose does it serve?
- What visual fact does it actually prove?
- Does the copy make any claim beyond that evidence?
- Was speech verified if the clip depends on dialogue?
- Were privacy and permission risks checked?
- Is the derivative appropriately compressed and responsive?
- Is reduced-motion behavior handled?
- Is the decision documented and Grapher state updated?

If any answer is unknown, record the dependency instead of inventing certainty.
