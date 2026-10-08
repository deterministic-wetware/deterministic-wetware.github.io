AI_DEFENDER_SOURCE_DIR ?= ../AIDefenderWeb/deployment
AI_DEFENDER_DEST_DIR := ai-defender

.PHONY: build run update-ai-defender

build: update-ai-defender

# Open the site's index.html directly from disk in Chrome.

run: build
ifeq ($(OS),Windows_NT)
	powershell -NoProfile -Command "Start-Process chrome ([Uri](Resolve-Path 'index.html').Path).AbsoluteUri"
else
	google-chrome "file://$(CURDIR)/index.html"
endif

# Replace ai-defender with the built AI Defender deployment.
# make on Windows may run recipes in cmd.exe, so use PowerShell there.

update-ai-defender:
ifeq ($(OS),Windows_NT)
	powershell -NoProfile -Command "if (-not (Test-Path '$(AI_DEFENDER_SOURCE_DIR)' -PathType Container)) { Write-Error 'Missing $(AI_DEFENDER_SOURCE_DIR)'; exit 1 }; Remove-Item -Recurse -Force -ErrorAction SilentlyContinue '$(AI_DEFENDER_DEST_DIR)'; Copy-Item -Recurse '$(AI_DEFENDER_SOURCE_DIR)' '$(AI_DEFENDER_DEST_DIR)'"
else
	test -d $(AI_DEFENDER_SOURCE_DIR)
	rm -rf $(AI_DEFENDER_DEST_DIR)
	cp -r $(AI_DEFENDER_SOURCE_DIR) $(AI_DEFENDER_DEST_DIR)
endif
