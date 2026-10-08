---
name: storage-locations
description: Where to keep Claude's memories and temporary files in this repo
metadata:
  type: feedback
---

Store memories in `.claude/memory/` (project-relative) and temporary files in `.claude/tmp/`, not in the user-home memory dir or the system scratchpad.

**Why:** User instruction (2026-10-08) — keeps memories and scratch files with the project.
**How to apply:** Write new memory files and the `MEMORY.md` index under `.claude/memory/`; put intermediate scripts/outputs under `.claude/tmp/` (gitignored).
