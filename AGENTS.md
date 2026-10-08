# AGENTS.md

Static GitHub Pages site for Deterministic Wetware.

## Layout

- `index.html` — landing page (Articles, Games).
- `ai-defender/` — prebuilt game bundle (Vite output with hashed asset names). Don't hand-edit it; refresh it with `make update-ai-defender`.
- `images/` — site images. `ai-defender.png` is copied from `ai-defender/assets/Ship-*.png` by `make update-ai-defender`.
- `Makefile` — build tasks. Make is the build tool for this repo.

## Building

Files are served as-is; make only runs maintenance tasks.

Replace `ai-defender/` with `../AIDefenderWeb/deployment` (override with `AI_DEFENDER_SOURCE_DIR=...`):

```sh
make update-ai-defender
```

- `make build` — runs all build steps (currently `update-ai-defender`).
- `make run` — builds, then opens `index.html` from disk in Chrome.

## Conventions

- Agent memories live in `.claude/memory/` — read `.claude/memory/MEMORY.md` at session start and save new memories there.
- Temporary files go in `.claude/tmp/` (gitignored).
