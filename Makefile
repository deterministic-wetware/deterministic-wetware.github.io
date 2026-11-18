AI_DEFENDER_SOURCE_DIR ?= ../AIDefenderWeb/deployment
AI_DEFENDER_DEST_DIR := ai-defender
AI_DEFENDER_IMAGE := images/ai-defender.png
SUPPLY_CART_SOURCE ?= ../../Projects-15-10-2026/BlenderWithAI/out/supply_cart/viewer.html
SUPPLY_CART_DEST := supply-cart/index.html

.PHONY: build run update-ai-defender update-supply-cart

build: update-ai-defender update-supply-cart

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

# Copy the stand-alone supply cart model viewer (three.js page with the GLB
# embedded) to supply-cart/index.html.

update-supply-cart:
ifeq ($(OS),Windows_NT)
	powershell -NoProfile -Command "if (-not (Test-Path '$(SUPPLY_CART_SOURCE)' -PathType Leaf)) { Write-Error 'Missing $(SUPPLY_CART_SOURCE)'; exit 1 }; New-Item -ItemType Directory -Force (Split-Path '$(SUPPLY_CART_DEST)') | Out-Null; Copy-Item '$(SUPPLY_CART_SOURCE)' '$(SUPPLY_CART_DEST)'"
else
	test -f $(SUPPLY_CART_SOURCE)
	mkdir -p $(dir $(SUPPLY_CART_DEST))
	cp $(SUPPLY_CART_SOURCE) $(SUPPLY_CART_DEST)
endif
