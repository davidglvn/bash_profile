# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BRIGHT_BLUE=$(tput setaf 12)
MAGENTA=$(tput setaf 5)
WHITE=$(tput setaf 7)
RESET=$(tput setaf 0)

# Terraform worksapce
__trfrm_ps1() {
    if [ -d ".terraform" ]; then
        echo "[$(/usr/local/bin/terraform workspace show)]"
    else
        echo ""
    fi
}

# kube-ps1
export KUBE_PS1_SYMBOL_ENABLE="false"
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"

# The cli
export PS1='\[$GREEN\]\t$(battery-status)$(ping-speed)\[$BLUE\][$(nvm current)]\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\[$YELLOW\]$(~/bash_profile/scripts/short_pwd.py)\[\033[m\]\[$MAGENTA\]$(__git_ps1)\[$MAGENTA\]$(__trfrm_ps1)\[$WHITE\]$(kube_ps1)\$ '
