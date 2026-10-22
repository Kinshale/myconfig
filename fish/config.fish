# ==============================================================================
# Global Configuration (Executes for BOTH Interactive & Non-Interactive Shells)
# ==============================================================================

# 1. System PATH Additions (fish_add_path prevents duplicate entries automatically)
fish_add_path ~/.local/bin
fish_add_path "$HOME/.local/kitty.app/bin"
fish_add_path "$HOME/myconfig/scripts"
fish_add_path "$HOME/myconfig/fish/fzf_fisher/"

# 2. Global Environment Variables & Functions
set -gx EDITOR nvim
set -ga fish_function_path ~/.config/fish/my_functions


# ==============================================================================
# Interactive Shell Only (UI, Keybindings, Cursor, Aliases)
# ==============================================================================
if status is-interactive

    set -g fish_greeting

    # Cursor shapes
    set fish_cursor_default     block
    set fish_cursor_insert      line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      block

    # Auto ls on cd
    functions --copy cd _cd
    function cd; _cd $argv && ls; end

    # Vi key bindings
    set -g fish_key_bindings fish_vi_key_bindings

    # Custom Key Bindings
    # Ctrl-N (Tab completion)
    bind -e \cn
    bind --mode default \cn complete
    bind --mode insert  \cn complete
    bind --mode visual  \cn complete

    # Ctrl-P (Completion search)
    bind -e \cp
    bind --mode default \cp complete-and-search
    bind --mode insert  \cp complete-and-search
    bind --mode visual  \cp complete-and-search

    # Ctrl-Y (Accept autosuggestion)
    bind -e \cy
    bind --mode default \cy accept-autosuggestion
    bind --mode insert  \cy accept-autosuggestion

    # Unbind Ctrl-V from FZF
    bind -e --mode default \cv 
    bind -e --mode insert  \cv 
    bind -e --mode visual  \cv 

    # FZF Key Bindings
    bind -e \cr
    bind --mode default \cr _fzf_search_history
    bind --mode insert  \cr _fzf_search_history
    bind --mode visual  \cr _fzf_search_history

    bind -e \cf
    bind --mode default \cf _fzf_search_directory
    bind --mode insert  \cf _fzf_search_directory
    bind --mode visual  \cf _fzf_search_directory

    # Aliases
    alias v="nvim"
    alias t="tmux"
    alias g="lazygit"
    alias mm="micromamba"
    alias fh="fcd ~"
    alias fr="fcd /"
    
    if type -q eza 
        alias ls='eza --icons --group-directories-first'
        alias exa='eza --icons --group-directories-first'
        alias tree='eza --icons --group-directories-first --tree'
    end

end
