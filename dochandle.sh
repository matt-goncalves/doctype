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

SCRIPTS_PATH="$HOME"/.doctype/scripts

. "$SCRIPTS_PATH"/to-md    # Converts markup to markdown through XSL
. "$SCRIPTS_PATH"/to-xhtml # Converts markup to XHTML through XSL
. "$SCRIPTS_PATH"/to-epub  # Converts markup to EPUB through multiple XSL
. "$SCRIPTS_PATH"/valid    # Validates against DTD
. "$SCRIPTS_PATH"/meta     # Extracts metadata as YML
. "$SCRIPTS_PATH"/prev     # Previews document - Firefox
. "$SCRIPTS_PATH"/new-doc  # Creates a new document file with boilerplate

# === NodeJS-based Scripts (callers) === #
smarten()
{
  echo "Smarten's current implementation is broken. Skipping." 2> e_smarten_$(timestamp -t)
  return
}
