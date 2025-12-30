if status is-interactive

    # Path for kitty terminal (installed from github)
    set -gx PATH "$HOME/.local/kitty.app/bin" $PATH

    # Custom scripts directory
    set -gx PATH "$HOME/myconfig/scripts" $PATH
    set -gx PATH "$HOME/myconfig/fish/fzf_fisher/" $PATH

	set -gx EDITOR nvim

    set -g fish_greeting

    set -ga fish_function_path ~/.config/fish/my_functions

    set fish_cursor_default     block
    set fish_cursor_insert      line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      

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

    # In FZF it for searching variables. I want it for pasting.
    bind -e --mode default \cv 
    bind -e --mode insert \cv 
    bind -e --mode visual \cv 

    # FZF (fish plugin) key bindings
    bind -e \cr
    bind --mode default \cr _fzf_search_history
    bind --mode insert \cr _fzf_search_history
    bind --mode visual \cr _fzf_search_history

    bind -e \cf
    bind --mode default \cf _fzf_search_directory
    bind --mode insert \cf _fzf_search_directory
    bind --mode visual \cf _fzf_search_directory

    # Aliases
    alias v="nvim"
    alias t="tmux"
    alias mm="micromamba"
    alias fh="fcd ~"
    alias fr="fcd /"
    
    if type -q eza 
        alias ls='eza --icons --group-directories-first'
        alias exa='eza --icons --group-directories-first'
        alias tree='eza --icons --group-directories-first --tree'
    end

end
