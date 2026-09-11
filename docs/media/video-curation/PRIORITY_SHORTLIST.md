# Priority Video Shortlist

These clips provide the strongest immediate website value from the 66 visually reviewed videos. Selection favors visible installation facts and finished results over dialogue-dependent marketing claims.

## Selected embed set — current site

The current site does **not** need video in every section. The strongest implementation is three small, silent proof loops, each doing a different job. Keep the existing homepage hero video unchanged.

| Page / section | Source | Source window | Target web loop | Purpose | Decision |
|---|---|---:|---:|---|---|
| Technology — `See the route` | `20251204_110245.mp4` | `00:01.2–00:07.2` | ~6 s | Open enclosure with visible piping; strongest technical view of installation-stage access and route clarity. | **USE** |
| Accessible Plumbing — `In the finished room` | `20251204_153442.mp4` | `00:01.0–00:09.0` | ~8 s | Finished enclosure moving around beams, corners, and transitions; strongest architectural-finish proof. | **USE** |
| Detailed Installation — Step 05 `Install the system` | `20251205_135740.mp4` | `00:02.0–00:08.0` | ~6 s | Installer actively fitting the enclosure/profile along the upper wall and beam. | **USE** |
| Occupied Building Repiping — optional proof | `20251204_154426.mp4` | `00:01.5–00:08.5` | ~7 s | Corridor-scale localized work with repeated concentrated work zones. | **HOLD** — page already has sufficient still proof; later frames reveal a unit identifier. |

### Web derivative contract

For the three selected loops:

- Remove audio entirely.
- Encode H.264 / `yuv420p` MP4 with `faststart` for broad browser compatibility.
- Keep them portrait rather than forcing a fake landscape crop; the vertical framing explains wall/ceiling routing well.
- Use approximately 216–360 px source width depending on final rendered component size; do not serve the 4K HEVC phone originals inline.
- `muted`, `loop`, `playsinline`, lazy/near-viewport playback, and a poster still are required.
- With `prefers-reduced-motion: reduce`, leave the poster/static frame in place rather than autoplaying.
- The video is supporting evidence, not decoration: one moving proof point per page is enough.

The current prepared trim tests use roughly 216×384 at 10 fps and are approximately 22–36 KB each. Before final deployment, retain the source filename and trim window in media documentation so every derivative remains traceable to its original.

## Why these three

`20251204_110245.mp4` and `20251204_153442.mp4` form a particularly useful pair: the first shows the system **open during installation** and the second shows what that routed system **looks like after finishing**. They communicate different states of the same design idea without repeating copy.

`20251205_135740.mp4` earns its place because the Detailed Installation page is the one page where seeing a person physically fit the enclosure is more informative than another still photograph. It makes Step 05 visibly an installation step rather than another finished-result card.

The corridor clip `20251204_154426.mp4` is excellent footage, but it is not necessary yet. The Occupied Building page now has a strong photographic hero and prepare → work → finish proof sequence. Adding another autoplay loop there would create motion for motion's sake. Its safe early segment is retained as an alternate.

## Other high-value footage

| Source | Grade | Strongest use | Why it matters |
|---|---:|---|---|
| `20251018_095652.mp4` | A | Technology / Our Work | Clean finished enclosure integrated with room geometry. |
| `20251018_095809.mp4` | A | Accessible Plumbing / Occupied Buildings | Strong finished route and architectural continuity. |
| `20251018_100331.mp4` | A | Technology | Finished doorway/corner integration. |
| `20251024_124323.mp4` | A | Our Work / Technology | Finished enclosure in a constrained closet/interior. |
| `20251204_110245.mp4` | A+ | Technology / Accessible Plumbing | Open enclosure with visible red/blue piping; strongest technical visual. |
| `20251204_110306.mp4` | A | Detailed Installation | Actual connection/fitting work. |
| `20251204_111638.mp4` | A | Detailed Installation | Enclosure fabrication/cutting. |
| `20251204_135928.mp4` | A | Detailed Installation | Clear fabrication process. |
| `20251204_140648.mp4` | A | Detailed Installation | Finishing compound/application stage. |
| `20251204_140754.mp4` | A | Detailed Installation | Paint/finish stage. |
| `20251204_153442.mp4` | A+ | Technology / Accessible Plumbing / Our Work | Strongest finished transitions around beams, corners and columns. |
| `20251204_154426.mp4` | A+ | Occupied Building Repiping | Excellent corridor/localized-work context. |
| `20251204_154501.mp4` | A | Technology / Detailed Installation | Localized opening with existing plumbing visible. |
| `20251205_134853.mp4` | A+ | Detailed Installation | Excellent evidence for “open only what is needed.” |
| `20251205_135703.mp4` | A+ | Detailed Installation / Occupied Buildings | Human-scale active enclosure installation. |
| `20251205_135740.mp4` | A+ | Detailed Installation / Occupied Buildings | Active route installation around beam/ceiling. |
| `20260420_091110.mp4` | A | Detailed Installation / Technology | Corridor route continuity and open-fastener context. |

## Detailed Installation mapping

1. **Prepare the building:** `20251204_110411.mp4`, `20251204_110359.mp4`
2. **Plan the route:** `20260420_091110.mp4`, `20251205_102032.mp4`
3. **Open only what is needed:** `20251205_134853.mp4`, `20251205_134938.mp4`
4. **Coordinate the suite:** `20251205_135703.mp4` plus suitable occupied-suite context
5. **Install the system:** **selected loop `20251205_135740.mp4` (`00:02.0–00:08.0`)**; alternates `20251205_134828.mp4`, `20251205_135703.mp4`
6. **Complete the connections:** `20251204_110306.mp4`, `20251204_110245.mp4`
7. **Finish the enclosure:** `20251204_140648.mp4`, `20251204_140754.mp4`
8. **Leave future access:** **evidence gap remains**. Do not claim this step is visually proven without footage of a finished system being accessed for service.

## Second-wave video candidates

The following could materially improve later pages, but should not be deployed from visual review alone:

- `Conventional vs pt garbage amount.mp4` — potentially valuable on Conventional vs Plumbing Track after the spoken comparison is verified and any quantitative implication is sourced.
- `Conventional vs pt kitchen sample.mp4` — potentially valuable on the comparison page after dialogue verification.
- `Intro to upcoming poly b job 2.mp4` and `Intro to new residential poly b job.mp4` — useful for Poly-B / Our Work only after project identity, original pipe material, permissions, and spoken claims are verified.
- `Mosaic intro to plumbers rough in.mp4` — useful process introduction if the project identity and speech are approved.
- `Mosaic let's meet a plumber.mp4` — possible About / team material if release and intended public use are confirmed.

Do not turn these into captions or marketing claims based on filenames or visuals alone.

## Exclude from current website proof

- `lv_0_20251224163025.mp4` — holiday/cookie social montage.
- `20260228_191247.mp4` — nighttime dance/event footage.

## Evidence boundary

The selected technical-access footage demonstrates that the system is open and reachable **during installation**. It does not demonstrate a years-later maintenance event. The existing evidence gap for finished-system service access remains and should stay explicit.
