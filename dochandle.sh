#!/usr/bin/env bash

# === Documentation ===
#
# This Bash script contains functions that handle file manipulation through XML
# utilities like xsltproc and xmllint. Functions are imported to ~/.bashrc and
# used throughout the system.
#
# All necessary documents are inside DOCDIR.
#
# 2025-06-27T15:06:26-0300
#
# === ===

. "$HOME"/.doctype/scripts/to-md # Converts markup to markdown
. "$HOME"/.doctype/scripts/valid # Validates against DTD
. "$HOME"/.doctype/scripts/meta  # Extracts metadata as YML
