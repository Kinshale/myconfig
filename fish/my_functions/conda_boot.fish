function conda_boot --description "Lazy-load and activate base Conda environment"
    # Remove this function after first call
    functions --erase conda_boot

    # Initialize conda for fish shell
    eval /home/ale/miniconda3/bin/conda "shell.fish" "hook" | source

    # Activate base environment
    conda activate base
end
