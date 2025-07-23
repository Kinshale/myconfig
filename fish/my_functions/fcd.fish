# Fuzzy finding directories (including hidden) and switching to them
function fcd
    set -l search_dir $argv[1]
    if test -z "$search_dir"
        set search_dir $HOME
    end
    set -l dir (fd -H --type d . "$search_dir" 2>/dev/null | fzf --height 40% --reverse)
    if test -n "$dir"
        cd "$dir"
    end
end
