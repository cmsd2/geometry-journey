# Render notebooks to HTML for GitHub Pages.
#
#   make            execute every notebook (writes outputs back into
#                   the .macnb), then render to docs/pages/*.html
#   make html       render only — assumes the .macnb already has
#                   outputs baked in
#   make index      regenerate docs/pages/index.html only
#   make clean      remove docs/pages
#
# Override AXIMAR_MCP / FORMAT / OUTPUT_DIR on the command line if
# needed:
#   make AXIMAR_MCP=/path/to/aximar-mcp

AXIMAR_MCP ?= aximar-mcp
OUTPUT_DIR ?= docs/pages
FORMAT     ?= maxima_html

NOTEBOOKS  := $(wildcard notebooks/*/*.macnb)
# Map notebooks/<stage>/<name>.macnb -> docs/pages/<name>.html
HTML_FILES := $(addprefix $(OUTPUT_DIR)/,$(addsuffix .html,$(basename $(notdir $(NOTEBOOKS)))))

.PHONY: all clean index html

all: $(HTML_FILES) index

# Per-notebook rule: execute, then convert.
define nb_rule
$(OUTPUT_DIR)/$(basename $(notdir $(1))).html: $(1) | $(OUTPUT_DIR)
	$$(AXIMAR_MCP) run --allow-dangerous $$<
	uv run jupyter nbconvert --to $$(FORMAT) --output-dir $$(OUTPUT_DIR) --output $$(basename $$(notdir $$<) .macnb) $$<
endef

$(foreach nb,$(NOTEBOOKS),$(eval $(call nb_rule,$(nb))))

$(OUTPUT_DIR):
	mkdir -p $@

index: $(HTML_FILES) | $(OUTPUT_DIR)
	@./gen-index.sh

html: | $(OUTPUT_DIR)
	@for nb in $(NOTEBOOKS); do \
		name=$$(basename "$$nb" .macnb); \
		echo "$$nb -> $(OUTPUT_DIR)/$$name.html"; \
		uv run jupyter nbconvert --to $(FORMAT) --output-dir $(OUTPUT_DIR) --output "$$name" "$$nb"; \
	done
	@./gen-index.sh

clean:
	rm -rf $(OUTPUT_DIR)
