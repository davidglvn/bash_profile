# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BRIGHT_BLUE=$(tput setaf 12)
MAGENTA=$(tput setaf 5)
WHITE=$(tput setaf 7)
RESET=$(tput setaf 0)

# Workspace path length
export PROMPT_DIRTRIM=3

# Battery status
battery-status() {
  # get percents
  percents=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  if [ "$percents" -gt "40" ]; then
    main_color=12
    output="${percents}%"
  else
    main_color=1
    output="⚠${percents}%"
  fi
  # get charge status
  if [[ $(pmset -g batt | grep -c discharging) == 1 ]]; then
      #output="$(tput smul)$(tput setaf ${main_color})(${output})$(tput rmul)"
      #output="$(tput setaf ${main_color})(${output})"
      output="(${output})"
  elif [[ $(pmset -g batt | grep -c charged) == 1 ]]; then
    output=""
  else
    #output="$(tput bold)$(tput setaf ${main_color})(⚡${output})"
    output="(⚡${output})"
  fi
  #echo "${output}"; tput sgr 0
  echo "${output}"
}

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

# python
__pyenv_ps1() {
    local version=$(pyenv version-name)
    if [ $version == "system" ]; then
        version=$(python --version 2>&1 | awk '{print $2}')
    fi
    echo "[py${version}]"
}

# nvm code
__nvm_ps1() {
    if [[ -f package.json || -f package-lock.json || -d node_modules ]]; then
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
    export PS1='\[$GREEN\]\t\[$BRIGHT_BLUE\]$(battery-status)$(ping-speed)\[$BLUE\]$(__pyenv_ps1)$(__nvm_ps1)\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]$(__git_ps1_custom)\[$MAGENTA\]$(__trfrm_ps1)\[$WHITE\]$(kube_ps1)\$ '
else
    export PS1='\s-\v\$ '
    #export PS1='\[$GREEN\]\t$(battery-status)\[$BLUE\]$(__pyenv_ps1)$(__nvm_ps1)\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\w\[\033[m\]$(__trfrm_ps1)\[$WHITE\]\$ '
fi
if [ $(tput cols) -lt "120" ]; then
    export PS1='\s-\v\$ '
fi
