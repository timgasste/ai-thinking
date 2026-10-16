# ai-thinking

Public lecture page for Tim Gåsste's lecture *Why and How to Think with AI*:
exercise prompts with copy buttons, a downloadable `ai-lab` starter folder, the
slides, and the sources. Published (after review) at
<https://timgasste.github.io/ai-thinking/> from `docs/` on `main`.

## Build

```bash
# 1. Export the deck first (in ../puma-ai-presentations): make export-final
scripts/build.sh
```

`build.sh` copies the audience slides and PDF from
`../puma-ai-presentations/output/final-output/`, zips `starter-kit/ai-lab` (adding a Word
copy of `START-HERE.md` and the slides PDF), checks that every prompt on the
slides appears word for word in `index.qmd`, and renders the site into `docs/`.

Only audience-facing files belong in this repository. The workflow is described
in the `github-pages-site` skill.
