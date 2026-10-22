# NOTE: fnm (Fast Node Manager) is a command-line tool used to install, manage, and switch between multiple versions of Node.js on a single machine.

function fnm_boot
    # Check if fnm is already loaded (optional, but good practice)
    if not set -q FNM_MULTISHELL_ID
        # Define the path to fnm binary
        set FNM_PATH "/home/ale/.local/share/fnm"
        if [ -d "$FNM_PATH" ]
            # Add fnm binary path to PATH
            set -g PATH "$FNM_PATH" $PATH
            # Run the environment setup command
            fnm env | source
            echo "fnm environment loaded."
        else
            echo "Error: fnm not found at $FNM_PATH"
        end
    else
        echo "fnm environment already loaded."
    end
end
