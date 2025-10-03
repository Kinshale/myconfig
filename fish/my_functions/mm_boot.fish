# Lazy-load micromamba
function mm_boot --description "Lazy-load micromamba"
    # Remove this function after first call
    functions --erase micromamba_boot

    # Set paths (you could also leave these in config.fish if you want)
    set -gx MAMBA_EXE "/home/ale/.local/bin/micromamba"
    set -gx MAMBA_ROOT_PREFIX "/home/ale/micromamba"

    # Initialize micromamba for fish
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source

    # Optional: activate base environment immediately
    micromamba activate base
end
