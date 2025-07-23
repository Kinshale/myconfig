#!/bin/bash

# Define source files and destination directory
FILES=(~/.p10k.zsh ~/.bashrc ~/.zshrc)
DEST=~/my-config/terminal/rc

# Create destination directory if it doesn't exist
mkdir -p "$DEST"

# Copy files
for FILE in "${FILES[@]}"; do
  if [ -f "$FILE" ]; then
    cp "$FILE" "$DEST"
    echo "Backed up $FILE to $DEST"
  else
    echo "Warning: $FILE does not exist"
  fi
done
