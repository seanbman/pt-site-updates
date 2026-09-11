# Plumbing Track Video Curation Audit

**Audit date:** September 10, 2026  
**Source:** Google Drive `Marketing/Photos/New Photos`  
**Website target:** `seanbman/pt-site-updates`, branch `dev/updates`

## Executive summary

The source folder contains **88 MP4 videos**. **66** were transferred and visually reviewed across their runtime. **22** exceeded the Drive connector's approximately 256 MiB per-file raw transfer limit and remain explicitly **UNREVIEWED — CONNECTOR SIZE LIMIT**. Those blocked files are inventoried but are not graded or described from filenames alone.

The strongest reusable footage is concentrated in the December 4–5 installation sequences and the October 18 finished-result clips. These should be used selectively to strengthen the current **Problem → System → Proof** site narrative rather than turning pages into galleries. The existing homepage hero video remains in place.

## Best immediate uses

- **Technology:** open enclosure/piping, localized existing-plumbing access, and finished architectural transitions.
- **Accessible Plumbing:** installation-stage access plus clean finished enclosure. Do not claim this proves years-later service history.
- **Detailed Installation:** the December 4–5 sequence maps unusually well to preparation, route planning, localized openings, installation, connections, fabrication and finishing.
- **Occupied Building Repiping:** corridor/localized-work footage paired with active installation and finished-room footage.
- **Traditional vs Plumbing Track / Poly B / project stories:** presenter clips are strategically useful only after their audio, project identity, material identity and permissions are verified.

## High-priority shortlist

See [`PRIORITY_SHORTLIST.md`](PRIORITY_SHORTLIST.md). The shortlist favors footage that proves something visually without depending on unverified dialogue.

## Evidence boundary

Visual review does not verify spoken claims. The audit environment did not have a speech-to-text engine, so presenter dialogue was not transcribed. Before publishing captions, comparisons, statistics, guarantees, material-specific claims, disruption claims or project outcomes, verify the source audio and authoritative project records.

The reviewed material also does **not** conclusively demonstrate a finished system being reopened years later for service. Installation-stage accessibility must not be presented as proof of long-term maintenance history.

## Privacy and publication checks

Before publication, inspect selected clips for unit numbers, addresses, resident names, posted notices, faces, family photographs, medication, mail, paperwork and distinctive personal possessions. Crop, blur, replace or withhold the clip when necessary. Existence in Marketing Drive is not itself proof of publication permission.

## Web derivative policy

Do not serve the large original HEVC/4K files as routine inline assets. Keep originals as provenance sources and generate traceable web derivatives. For inline loops, prefer roughly 4–10 seconds, muted, `playsinline`, `loop`, poster imagery, `prefers-reduced-motion` handling, and a static fallback. Cap routine derivatives around 720p–1080p as appropriate to the component and preserve portrait orientation when it communicates the installation better.

## Files in this audit

- `AGENTS.md` — implementation-agent rules for source selection, claims, editing, privacy and documentation.
- `inventory.csv` — machine-readable inventory of all 88 source videos and their review status.
- `PRIORITY_SHORTLIST.md` — strongest immediately useful clips and page mapping.

## Repository relationship

This directory supplements `docs/media/RESOURCE_REFERENCE.md`. The Resource Reference remains the top-level media handoff index; this folder is the detailed in-repository video audit and implementation reference. Media placement must still follow the governing website plan and current implementation state.
