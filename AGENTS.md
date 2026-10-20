# ai-thinking: public lecture page

Public repository: the page for the lecture "Why and How to Think with AI", published at <https://timgasste.github.io/ai-thinking/> from `docs/` on `main`. Only audience-facing files belong here. Write nothing private: no local paths, no student data, no drafts of unpublished material.

- Build with `scripts/build.sh`. It copies the audience slides and PDF from the sibling deck repo `puma-ai-presentations` (export the deck first), zips `starter-kit/ai-lab`, checks that every prompt on the slides appears word for word in `index.qmd`, and renders the site into `docs/`.
- Do not push without Tim's review of the rendered page. The `github-pages-site` skill describes the workflow.
- Prompts on the slides and in `index.qmd` must match word for word.
