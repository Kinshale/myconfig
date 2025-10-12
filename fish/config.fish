if status is-interactive
    # Path for kitty terminal (installed from github)
    set -gx PATH "$HOME/.local/kitty.app/bin" $PATH
    set -g fish_greeting

    set -ga fish_function_path ~/.config/fish/my_functions

    set fish_cursor_default     block
    set fish_cursor_insert      line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      block

	# ls after cd
	functions --copy cd _cd
	function cd; _cd $argv && ls; end

	set -g fish_key_bindings fish_vi_key_bindings

	# ctrl-n as tab
    bind -e \cn
	bind --mode default \cn complete
	bind --mode insert  \cn complete
	bind --mode visual  \cn complete
	# ctrl-p as shift-tab
    bind -e \cp
	bind --mode default \cp complete-and-search
	bind --mode insert  \cp complete-and-search
	bind --mode visual  \cp complete-and-search
	# ctrl-y for accepting them
    bind -e \cy
	bind --mode default \cy accept-autosuggestion
	bind --mode insert  \cy accept-autosuggestion

    # Editor/utility shortcuts
    alias v="nvim"
    alias t="tmux"
    alias mm="micromamba"
    
    if type -q eza 
        alias ls='eza --icons --group-directories-first'
        alias exa='eza --icons --group-directories-first'
        alias tree='eza --icons --group-directories-first --tree'
    end


    # Use fzf for reverse search instead of redo
    if type -q __fzf_reverse_isearch
        bind \cr __fzf_reverse_isearch
    end

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

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
# set -gx MAMBA_EXE "/home/ale/.local/bin/micromamba"
# set -gx MAMBA_ROOT_PREFIX "/home/ale/micromamba"
# $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
