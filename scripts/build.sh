#!/usr/bin/env bash
# Build the lecture page: copy the latest deck export, rebuild the starter folder,
# check that the prompts match the slides, and render the site into docs/.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DECK="${DECK:-$ROOT/../presentations}"
EXPORT="$DECK/output/final-output"
PDF_NAME="why-and-how-to-think-with-ai.pdf"

[[ -f "$EXPORT/audience-presentation.html" ]] || { echo "Run 'make export-final' in $DECK first." >&2; exit 1; }
if [[ "$EXPORT/audience-presentation.html" -ot "$DECK/presentation.qmd" ]]; then
  echo "Warning: the deck export is older than presentation.qmd. Re-export before publishing." >&2
fi

mkdir -p "$ROOT/slides" "$ROOT/downloads"
cp "$EXPORT/audience-presentation.html" "$ROOT/slides/index.html"
cp "$EXPORT/presentation.pdf" "$ROOT/downloads/$PDF_NAME"

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
cp -R "$ROOT/starter-kit/ai-lab" "$tmp/"
cp "$EXPORT/presentation.pdf" "$tmp/ai-lab/sources/$PDF_NAME"
quarto pandoc "$tmp/ai-lab/START-HERE.md" -o "$tmp/ai-lab/START-HERE.docx"
rm -f "$ROOT/downloads/ai-lab.zip"
(cd "$tmp" && python3 -c "
import os, zipfile
with zipfile.ZipFile('$ROOT/downloads/ai-lab.zip', 'w', zipfile.ZIP_DEFLATED) as z:
    for d, _, fs in os.walk('ai-lab'):
        z.write(d)
        for f in fs:
            if f != '.DS_Store':
                z.write(os.path.join(d, f))
")

python3 "$ROOT/scripts/check-sync.py" "$DECK/presentation.qmd" "$ROOT/index.qmd"
(cd "$ROOT" && quarto render)
echo "Built: $ROOT/docs/index.html"
