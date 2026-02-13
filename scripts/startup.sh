#!/bin/bash 

# Wait a few seconds for desktop to fully load
sleep 1

# Load xmodmap
xmodmap /home/ale/xmm

#  BUG: This doesn't work.
# Restore tmux sessions
tmux
~/.tmux/plugins/tmux-resurrect/scripts/restore.sh
