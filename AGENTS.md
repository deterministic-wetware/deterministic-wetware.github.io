# AGENTS.md

Static GitHub Pages site for Deterministic Wetware.

## Layout

- `index.html` — landing page (Articles, Games).
- `ai-defender/` — prebuilt game bundle (Vite output with hashed asset names). Don't hand-edit it; refresh it with `make update-ai-defender`.
- `supply-cart/index.html` — stand-alone three.js model viewer (GLB embedded), copied from `../../Projects-15-10-2026/BlenderWithAI/out/supply_cart/viewer.html`. Don't hand-edit it; refresh it with `make update-supply-cart` (override with `SUPPLY_CART_SOURCE=...`).
- `style.css` — stylesheet for `index.html`.
- `images/` — site images. `ai-defender.png` is copied from `ai-defender/assets/Ship-*.png` by `make update-ai-defender`. `supply-cart.png` is a one-off 256px thumbnail cut from the model's `previews_tex/look_hero.png` (grey background keyed out).
- `Makefile` — build tasks. Make is the build tool for this repo.

## Building

Files are served as-is; make only runs maintenance tasks.

Replace `ai-defender/` with `../AIDefenderWeb/deployment` (override with `AI_DEFENDER_SOURCE_DIR=...`):

```sh
make update-ai-defender
```

- `make build` — runs all build steps (`update-ai-defender`, `update-supply-cart`).
- `make run` — builds, then opens `index.html` from disk in Chrome.

## Conventions

- Agent memories live in `.claude/memory/` — read `.claude/memory/MEMORY.md` at session start and save new memories there.
- Temporary files go in `.claude/tmp/` (gitignored).
