# Minimal makefile for Sphinx documentation
# -----
# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
YAML_RST_FILES := $(patsubst ../%.yml,./yaml/%.rst,$(wildcard ../*.yml))
README_FILES := ../ansible/README.md ../config/README.md ../packer/README.md ../terraform/README.md ../terraform/dependencies/README.md
READMES := $(patsubst ../%/README.md,./readme/%.md,$(README_FILES))

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

yaml:
	mkdir yaml

./yaml/%.rst: ../%.yml
	yaml2rst $< $@

./readme/%.md: ../%/README.md
	mkdir -p $(dir $@)
	cp $< $@

./splash.md: ../README.md
	cp ../README.md ./splash.md

confluence: ./splash.md  $(READMES) yaml $(YAML_RST_FILES)
	@$(SPHINXBUILD) -M confluence "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

html: ./splash.md  $(READMES) yaml $(YAML_RST_FILES)
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

real-clean: clean
	rm -rf ./splash.md ./yaml ./readme

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: 
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)


.PHONY: help html real-clean
