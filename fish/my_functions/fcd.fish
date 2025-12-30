# NOTE: Depends on PatrickF1/fzf.fish 

# Fuzzy finds directories (including hidden) and switches to them
# If no argument is passed it looks from the current directory. Use ~ for home.
function fcd --description "Fuzzy find and change directory"
    set -l search_dir $argv[1]
    if test -z "$search_dir"
        set search_dir .
    end

    set -l dir (
        fdfind --hidden --type d . "$search_dir" 2>/dev/null |
        _fzf_wrapper \
            --prompt="Directory> " \
            --preview="eza --icons --group-directories-first --tree --level=2 {}" \
            --preview-window="right:60%:wrap"
    )

    if test -n "$dir"
        cd "$dir"
        and commandline -f repaint  # Refresh prompt after cd
    end
end
