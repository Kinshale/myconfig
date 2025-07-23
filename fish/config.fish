if status is-interactive
    # Path for kitty terminal (installed from github)
    set -gx PATH "$HOME/.local/kitty.app/bin" $PATH
    set -g fish_greeting

    set -ga fish_function_path ~/.config/fish/my_functions

    set fish_cursor_default     block
    set fish_cursor_insert      line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      block

    function fish_user_key_bindings
        fish_default_key_bindings -M insert
        fish_vi_key_bindings --no-erase insert

        bind -e \cv  # Erase existing Ctrl+V binding
        bind -M insert \cv 'fish_clipboard_paste'  # Ctrl+V in insert mode
        bind -M default \cv 'fish_clipboard_paste' # Ctrl+V in normal mode

    end

    # Editor/utility shortcuts
    alias v="nvim"
    alias t="tmux"

end

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#if test -f /home/ale/miniconda3/bin/conda
#    eval /home/ale/miniconda3/bin/conda "shell.fish" "hook" $argv | source
#else
#    if test -f "/home/ale/miniconda3/etc/fish/conf.d/conda.fish"
#        . "/home/ale/miniconda3/etc/fish/conf.d/conda.fish"
#    else
#        set -x PATH "/home/ale/miniconda3/bin" $PATH
#    end
#end
## <<< conda initialize <<<
#
