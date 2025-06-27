#!/usr/bin/enb bash

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

DOCDIR="$HOME"/.doctype

# === stylesheets === #
TOMD_XSL="$DOCDIR"/stylesheets/to-markdown.xsl
META_XSL="$DOCDIR"/stylesheets/meta.xsl

# === schemas and dtd === #
META_DTD="$DOCDIR"/dtd/document.dtd


# Extracts metadata as YML
meta()
{
  for file in "$@"; do
     xsltproc "$META_XSL" "$file"
  done
}

# Validates against dtd
valid()
{
  for file in "$@"; do
    xmllint --dtdvalid "$META_DTD" "$file" --noout && \
      echo "Document validates."
  done
}

to-md()
{
  for file in "$@"; do
      xsltproc "$TOMD_XSL" "$file"
  done
}
