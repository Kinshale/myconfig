# NOTE: Depends on PatrickF1/fish for _fzf_wrapper
function fopen --description "Fuzzy find and open files"
    set -l search_dir $argv[1]
    if test -z "$search_dir"
        set search_dir .
    end

    set -l file (
        fd --hidden --type f . "$search_dir" 2>/dev/null |
        _fzf_wrapper \
            --prompt="File> " \
    )

    if test -n "$file"
        xdg-open "$file" &>/dev/null &
    end
end
