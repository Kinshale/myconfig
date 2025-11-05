#!/usr/bin/env bash
# interactive_restore_tmux.sh

RESURRECT_DIR="$HOME/.local/share/tmux/resurrect"
RESTORE_SCRIPT="$HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh"

# Find all saves, reverse sort (most recent first)
mapfile -t all_saves < <(ls -1 "$RESURRECT_DIR"/tmux_resurrect_*.txt 2>/dev/null | sort -r)

if [ ${#all_saves[@]} -eq 0 ]; then
  echo "No saved sessions found in $RESURRECT_DIR"
  exit 1
fi

# Take the latest 5 saves
mapfile -t saves < <(printf "%s\n" "${all_saves[@]}" | head -n 5)

# Show menu with human-readable dates
echo "Available tmux-resurrect saves (latest 5):"
for i in "${!saves[@]}"; do
  # Extract timestamp from filename and format it
  file="${saves[$i]}"
  readable=$(basename "$file" | sed -E 's/tmux_resurrect_([0-9]{4})([0-9]{2})([0-9]{2})T([0-9]{2})([0-9]{2})([0-9]{2})\.txt/\1-\2-\3 \4:\5:\6/')
  echo "[$i] $readable"
done

# Prompt user
read -rp "Enter the number of the save to restore: " choice

# Validate choice
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge "${#saves[@]}" ]; then
  echo "Invalid choice"
  exit 1
fi

# Symlink selected save to last
ln -sf "${saves[$choice]}" "$RESURRECT_DIR/last"

# Restore
tmux run-shell "$RESTORE_SCRIPT"

echo "Restored tmux session from $(basename "${saves[$choice]}")"
