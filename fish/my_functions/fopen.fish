# Fuzzy finds files (including hidden) and opens them
function fopen
    set -l search_dir $argv[1]
    if test -z "$search_dir"
        set search_dir .
    end
    set -l file (fd -H --type f . "$search_dir" 2>/dev/null | fzf --height 40% --reverse)
    if test -n "$file"
        xdg-open "$file" &>/dev/null &
    end
end
