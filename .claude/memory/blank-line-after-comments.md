---
name: blank-line-after-comments
description: Code style - always put a blank line after a comment, before the code it describes
metadata:
  type: feedback
---

Always leave a blank line after a comment (or comment block), separating it from the code that follows. Applies to all files I write (Makefile, scripts, etc.).

**Why:** User instruction (2026-10-08): "Always make sure there is a space after comments", given after I wrote a Makefile comment block directly above its target.
**How to apply:** When writing or editing code, insert an empty line between any comment block and the following code. If this interpretation turns out wrong (e.g. they meant a space after `#`), update this memory.
