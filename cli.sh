# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BRIGHT_BLUE=$(tput setaf 12)
MAGENTA=$(tput setaf 5)
WHITE=$(tput setaf 7)
RESET=$(tput setaf 0)

# Terraform workspace
__trfrm_ps1() {
    if [ -d ".terraform" ]; then
        echo "[$(/usr/local/bin/terraform workspace show)]"
    else
        echo ""
    fi
}

# kube-ps1
function remove_username_from_cluster() {
    echo "$1" | cut -d '@' -f2
}
export KUBE_PS1_CLUSTER_FUNCTION=remove_username_from_cluster
export KUBE_PS1_SYMBOL_ENABLE="false"
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"

# nvm code
__nvm_ps1() {
    if [[ -f package.json && -f package-lock.json && -d node_modules ]]; then
        echo "[$(nvm current)]"
    else
        echo ""
    fi
}

# Git
__git_ps1_custom() {
    git_prompt=$(__git_ps1)
    if [ ${#git_prompt} -ge 20 ]; then 
        git_prompt=${git_prompt::20}"...)"
    fi
    echo $git_prompt
}

# The cli
if [ $TERM_PROGRAM == "Apple_Terminal" ]; then
    export PS1='\[$GREEN\]\t$(battery-status)$(ping-speed)\[$BLUE\]$(__nvm_ps1)\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\[$YELLOW\]$(~/bash_profile/scripts/short_pwd.py)\[\033[m\]\[$MAGENTA\]$(__git_ps1_custom)\[$MAGENTA\]$(__trfrm_ps1)\[$WHITE\]$(kube_ps1)\$ '
else
    export PS1='\[$GREEN\]\t$(battery-status)\[$BLUE\]$(__nvm_ps1)\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\[$YELLOW\]$(~/bash_profile/scripts/short_pwd.py)\[\033[m\]$(__trfrm_ps1)\[$WHITE\]\$ '
fi
