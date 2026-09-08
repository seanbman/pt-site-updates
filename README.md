# plumbing-track-static

Static marketing sites for Plumbing Track, served from `bman-platform` `content/`.

| Entry | Purpose |
|-------|---------|
| `index.html` | Main site: apex / `www` and `/main` |
| `our-work/index.html` | Our Work: featured projects, testimonials, clients & partners |
| `bchousing/index.html` | BC Housing landing: `bchousing.plumbingtrack.com` |
| `app.js` | Shared interactions (header, stack motion, testimonials, assessment form) |
| `img/` | Shared media |
| `img/our-work/` | Our Work project photos and partner logos |
| `docs/site-export/` | Archived Squarespace text + images for reference |

Asset URLs are root-absolute (`/img/...`, `/app.js`) so both sites and `/main` resolve correctly.
