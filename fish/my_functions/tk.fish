function tk
  set -l session (tmux list-sessions -F "#{session_name}" | fzf --height 40% --reverse --prompt="Kill session> ")
  if test -n "$session"
    tmux kill-session -t "$session"
    echo "Killed session: $session"
  end
end
