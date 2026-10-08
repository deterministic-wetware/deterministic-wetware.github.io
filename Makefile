AI_DEFENDER_SOURCE_DIR ?= ../AIDefenderWeb/deployment
AI_DEFENDER_DEST_DIR := ai-defender
AI_DEFENDER_IMAGE := images/ai-defender.png

.PHONY: build run update-ai-defender

build: update-ai-defender

# Open the site's index.html directly from disk in Chrome.

run: build
ifeq ($(OS),Windows_NT)
	powershell -NoProfile -Command "Start-Process chrome ([Uri](Resolve-Path 'index.html').Path).AbsoluteUri"
else
	google-chrome "file://$(CURDIR)/index.html"
endif

# Replace ai-defender with the built AI Defender deployment, then copy its
# hash-named ship sprite to a stable path for index.html.
# make on Windows may run recipes in cmd.exe, so use PowerShell there.

update-ai-defender:
ifeq ($(OS),Windows_NT)
	powershell -NoProfile -Command "if (-not (Test-Path '$(AI_DEFENDER_SOURCE_DIR)' -PathType Container)) { Write-Error 'Missing $(AI_DEFENDER_SOURCE_DIR)'; exit 1 }; Remove-Item -Recurse -Force -ErrorAction SilentlyContinue '$(AI_DEFENDER_DEST_DIR)'; Copy-Item -Recurse '$(AI_DEFENDER_SOURCE_DIR)' '$(AI_DEFENDER_DEST_DIR)'"
	powershell -NoProfile -Command "if (@(Get-ChildItem '$(AI_DEFENDER_DEST_DIR)/assets/Ship-*.png').Count -ne 1) { Write-Error 'Expected one Ship-*.png in $(AI_DEFENDER_DEST_DIR)/assets'; exit 1 }; New-Item -ItemType Directory -Force (Split-Path '$(AI_DEFENDER_IMAGE)') | Out-Null; Copy-Item '$(AI_DEFENDER_DEST_DIR)/assets/Ship-*.png' '$(AI_DEFENDER_IMAGE)'"
else
	test -d $(AI_DEFENDER_SOURCE_DIR)
	rm -rf $(AI_DEFENDER_DEST_DIR)
	cp -r $(AI_DEFENDER_SOURCE_DIR) $(AI_DEFENDER_DEST_DIR)
	test $$(ls $(AI_DEFENDER_DEST_DIR)/assets/Ship-*.png | wc -l) -eq 1
	mkdir -p $(dir $(AI_DEFENDER_IMAGE))
	cp $(AI_DEFENDER_DEST_DIR)/assets/Ship-*.png $(AI_DEFENDER_IMAGE)
endif
