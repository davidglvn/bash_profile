# Define colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BRIGHT_BLUE=$(tput setaf 12)
MAGENTA=$(tput setaf 5)
WHITE=$(tput setaf 7)
RESET=$(tput setaf 0)

# The cli
export PS1='\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u$(battery-status)$(ping-speed)\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\[$YELLOW\]$(~/bash_profile/scripts/short_pwd.py)\[\033[m\]\[$MAGENTA\]$(__git_ps1)\[$WHITE\]\$ '
#export PS1='\[$GREEN\]\t\[$RED\]-\[$BLUE\]\u$(battery-status)$(ping-speed)\[$RED\]-\[$BRIGHT_BLUE\]$WORKING_ENVIRONMENT\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]$(__git_ps1)\[$WHITE\]\$ '
