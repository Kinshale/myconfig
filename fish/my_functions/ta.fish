function ta
  set -l session (tmux list-sessions -F "#{session_name}" | fzf --height 40% --reverse --prompt="Attach session>")
  if test -n "$session"
    tmux attach-session -t "$session"
  end
end
