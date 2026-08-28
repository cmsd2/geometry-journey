#!/usr/bin/env bash
# Generate docs/pages/index.html from built HTML notebook pages.
# Stage subdirectories under notebooks/ become section headers; notebooks
# inside each stage are listed in their natural sort order (the leading
# number determines order).

set -euo pipefail

OUTPUT_DIR="${OUTPUT_DIR:-docs/pages}"

cat > "$OUTPUT_DIR/index.html" <<'HEADER'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Geometry — A Journey</title>
<style>
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; max-width: 720px; margin: 2rem auto; padding: 0 1rem; color: #222; line-height: 1.55; }
  h1 { font-size: 1.6rem; border-bottom: 1px solid #ddd; padding-bottom: 0.5rem; margin-bottom: 0.4rem; }
  .subtitle { color: #666; font-style: italic; margin-top: 0; margin-bottom: 1.5rem; }
  h2 { font-size: 1.15rem; margin-top: 1.8rem; color: #333; }
  ul { list-style: none; padding: 0; }
  li { margin: 0.35rem 0; }
  a { color: #0366d6; text-decoration: none; }
  a:hover { text-decoration: underline; }
  .stage-num { color: #888; font-variant-numeric: tabular-nums; margin-right: 0.4rem; }
  footer { margin-top: 2.5rem; border-top: 1px solid #ddd; padding-top: 0.75rem; font-size: 0.9rem; color: #777; }
</style>
</head>
<body>
<h1>Geometry — A Journey</h1>
<p class="subtitle">A self-contained tour from Euclidean geometry up to Riemannian geometry, Lie groups and gauge theory, built as a sequence of Maxima notebooks.</p>
<p>The spine is Klein's Erlangen program: a geometry is a space, a group of
transformations, and the quantities they leave alone. Companion to
<a href="https://github.com/cmsd2/topology-journey">topology-journey</a> and
<a href="https://github.com/cmsd2/analysis-journey">analysis-journey</a>,
which build the smooth-manifold machinery this one measures with.
Read top to bottom.</p>
HEADER

# Collect stages (subdirectory names under notebooks/) in numerical order.
shopt -s nullglob globstar
declare -a stages
for d in notebooks/*/; do
  stages+=("$(basename "$d")")
done

# Repair the few labels that a plain hyphen-split renders awkwardly.
prettify() {
  sed -e 's/Non Euclidean/Non-Euclidean/' \
      -e 's/Mobius/Möbius/' \
      -e 's/Frenet Serret/Frenet–Serret/' \
      -e 's/Gauss Bonnet/Gauss–Bonnet/' \
      -e 's/Cross Ratio/Cross-Ratio/' \
      -e 's/Arclength/Arc Length/' \
      -e 's/Kahler/Kähler/' \
      -e 's/Tests Of Gr$/Tests Of GR/'
}

humanise() {
  # 03-curves-and-surfaces -> "Curves And Surfaces"
  # Strips the leading numeric prefix so we can render it separately.
  local s="${1#[0-9][0-9]-}"
  echo "$s" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | prettify
}

stage_number() {
  # 03-curves-and-surfaces -> "3"
  local s="$1"
  echo "${s%%-*}" | sed 's/^0*//'
}

notebook_label() {
  # 02-isometries-of-the-plane -> "Isometries Of The Plane"
  local s="${1#[0-9][0-9]-}"
  echo "$s" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | prettify
}

notebook_number() {
  local s="$1"
  echo "${s%%-*}" | sed 's/^0*//'
}

for stage in "${stages[@]}"; do
  stage_label="$(humanise "$stage")"
  stage_n="$(stage_number "$stage")"
  any_notebook=0
  for nb in notebooks/"$stage"/*.macnb; do
    name="$(basename "$nb" .macnb)"
    html="$OUTPUT_DIR/$name.html"
    [[ -f "$html" ]] || continue
    if (( any_notebook == 0 )); then
      echo "<h2>Stage $stage_n — $stage_label</h2>" >> "$OUTPUT_DIR/index.html"
      echo "<ul>" >> "$OUTPUT_DIR/index.html"
      any_notebook=1
    fi
    nb_label="$(notebook_label "$name")"
    nb_n="$(notebook_number "$name")"
    {
      echo "  <li><span class=\"stage-num\">${stage_n}.${nb_n}</span><a href=\"${name}.html\">${nb_label}</a></li>"
    } >> "$OUTPUT_DIR/index.html"
  done
  if (( any_notebook == 1 )); then
    echo "</ul>" >> "$OUTPUT_DIR/index.html"
  fi
done

cat >> "$OUTPUT_DIR/index.html" <<'FOOTER'
<footer>Source on <a href="https://github.com/cmsd2/geometry-journey">GitHub</a>.
Built with <a href="https://github.com/cmsd2/aximar">Aximar</a> and
<a href="https://github.com/cmsd2/maxima-numerics">numerics</a>.
Licensed <a href="https://creativecommons.org/publicdomain/zero/1.0/">CC0 1.0</a>.</footer>
</body>
</html>
FOOTER
