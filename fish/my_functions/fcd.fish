# Fuzzy finds directories (including hidden) and switches to them
# If no argument is passed it looks from the current directory. Use ~ for home.
function fcd
    set -l search_dir $argv[1]
    if test -z "$search_dir"
        set search_dir .  # Default to current directory instead of $HOME
    end
    set -l dir (fd -H --type d . "$search_dir" 2>/dev/null | fzf --height 40% --reverse)
    if test -n "$dir"
        cd "$dir"
    end
end
