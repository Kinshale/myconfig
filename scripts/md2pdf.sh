#!/bin/bash

# Root of your Organ folder
BASE_DIR="$HOME/Documents/scrivere"

# 1. Pick a Markdown file
MD_FILE=$(find "$BASE_DIR" -type f -name "*.md" | fzf --prompt="Select a Markdown file: ")

[[ -z "$MD_FILE" ]] && echo "❌ No file selected." && exit 1

# 2. Pick a CSS style
STYLE_DIR="$BASE_DIR/pdf/styles"
STYLE_FILE=$(find "$STYLE_DIR" -type f -name "*.css" | fzf --prompt="Choose a CSS style: ")

[[ -z "$STYLE_FILE" ]] && echo "❌ No style selected." && exit 1

# 3. File details
FILENAME=$(basename "$MD_FILE" .md)
FILE_DIR=$(dirname "$MD_FILE")
REL_PATH_FROM_BASE=$(realpath --relative-to="$BASE_DIR" "$FILE_DIR")
OUTPUT_DIR="$BASE_DIR/pdf/$REL_PATH_FROM_BASE"
PDF_OUTPUT="$OUTPUT_DIR/$FILENAME.pdf"

# Make sure output directory exists
mkdir -p "$OUTPUT_DIR"

# 4. Absolute path for CSS (to be embedded as file://)
STYLE_PATH_ABS="file://$(realpath "$STYLE_FILE")"

# 5. Create temporary HTML file
TMP_HTML=$(mktemp --suffix=".html")

# 6. Convert to HTML with absolute CSS path
pandoc "$MD_FILE" \
  --standalone \
  -c "$STYLE_PATH_ABS" \
  -o "$TMP_HTML"

# 7. Convert to PDF with wkhtmltopdf (local file access enabled)
wkhtmltopdf --enable-local-file-access "$TMP_HTML" "$PDF_OUTPUT"

# 8. Cleanup
rm "$TMP_HTML"

echo "✅ PDF created at: $PDF_OUTPUT"
