#!/usr/bin/env bash
set -euo pipefail

base_url="${BASE_URL:-http://localhost:8000}"
routes=(
  / /about/ /assessment/ /bchousing/ /client-portal/
  /client-portal/meadowbrooks-estates/ /how-it-works/
  /how-it-works/installation/ /our-work/ /resources/ /resources/faq/
  /solutions/ /solutions/kitec/ /solutions/occupied-building-repiping/
  /solutions/poly-b/ /technology/ /technology/accessible-plumbing/
  /technology/conventional-vs-plumbing-track/
)

for route in "${routes[@]}"; do
  code=$(curl -fsS -o /dev/null -w '%{http_code}' "${base_url}${route}")
  [[ "$code" == 200 ]] || { printf 'FAIL %s -> %s\n' "$route" "$code" >&2; exit 1; }
done

curl -fsS "${base_url}/sitemap.xml" -o /tmp/pt-sitemap.xml
curl -fsS "${base_url}/robots.txt" -o /tmp/pt-robots.txt

SITEMAP_FILE=/tmp/pt-sitemap.xml ROBOTS_FILE=/tmp/pt-robots.txt python3 - <<'PY'
import os
import xml.etree.ElementTree as ET

root = ET.parse(os.environ["SITEMAP_FILE"]).getroot()
ns = {"sm": "http://www.sitemaps.org/schemas/sitemap/0.9"}
urls = [node.text for node in root.findall("sm:url/sm:loc", ns)]
assert len(urls) == 14, len(urls)
assert len(urls) == len(set(urls))
assert all(url.startswith("https://www.plumbingtrack.com/") for url in urls)
assert "https://www.plumbingtrack.com/assessment/" not in urls
robots = open(os.environ["ROBOTS_FILE"], encoding="utf-8").read()
assert "Disallow: /client-portal/" in robots
assert "Sitemap: https://www.plumbingtrack.com/sitemap.xml" in robots
print(f"static_site=pass routes=18 sitemap_urls={len(urls)}")
PY
