# Build and Push Docker image
docker_bush() {
  if [[ $1 == "bush" ]]; then
    docker build -t $2 .
    docker push $2
  else
    docker "$@"
  fi
}
# Battery status
battery-status() {
  # get percents
  percents=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  if [ "$percents" -gt "40" ]; then
    output="$(tput setaf 12)(${percents}%"
  else
    output="$(tput setaf 1)(${percents}%"
  fi
  # get charge status
  if [[ $(pmset -g batt | grep -c discharging) == 1 ]]; then
    output="$(tput sgr 0 1)${output})"
  elif [[ $(pmset -g batt | grep -c charged) == 1 ]]; then
    output=""
  else
    output="$(tput bold)⚡${output})"
  fi
  echo "$output$(tput sgr 0)"
}

# Ping speed
ping-speed() {
  if [[ ${SKIP_NETWORK_CHECK} ]]; then
    return 0
  fi
  if [[ $(ifconfig en0 | grep status | grep inactive) ]]; then
    echo "(N.A.)"
    return 0
  fi
  speed=$(ping -qc1 -t 1 8.8.8.8 2>&1 | awk -F/ '/^round-trip/ { printf "%.2f\n", $5; ok = 1 } END { if (!ok) print "0" }')
  speed_int=$(echo $speed | cut -d'.' -f1)
  if [ "$speed_int" -gt "100" ]; then
    echo "$(tput setaf 1)(${speed}ms)$(tput sgr 0)"
  elif [ "$speed" == "0" ]; then
    echo "$(tput sgr 0 1)$(tput setaf 1)(FAIL)$(tput sgr 0)"
  else
    echo ""
  fi
}

# Some shortcuts
alias ll='ls -lah'
alias ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@'
alias docker='docker_bush'
alias cat='bat'  # https://github.com/sharkdp/bat
alias preview="fzf --preview 'bat --color \"always\" {}'"  # https://github.com/junegunn/fzf
alias top='sudo htop'
alias ping8='ping 8.8.8.8'
alias ping1='ping 1.1.1.1'
alias cerebro='docker run --rm -p 9000:9000 lmenezes/cerebro'

# Work envs
alias py-endor='source /Users/davidg/virtualenvs/endor/bin/activate'
alias ssh-u='ssh -l ubuntu -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-a='ssh -l ec2-user -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-r='ssh -l root -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-h='ssh -l hadoop -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-ov='ssh -l openvpnas -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-ba='ssh -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM} -l ec2-user -o "proxycommand ssh -W %h:%p -i ${SSH_PEM_PATH}/${AWS_BASTION_PEM} -l ${AWS_BASTION_USER} ${AWS_BASTION_ADDRESS}"'
alias ssh-bu='ssh -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM} -l ubuntu -o "proxycommand ssh -W %h:%p -i ${SSH_PEM_PATH}/${AWS_BASTION_PEM} -l ${AWS_BASTION_USER} ${AWS_BASTION_ADDRESS}"'
#alias cd-dev-heili='cd /Users/davidg/Development/heili'
#alias cd-dev-forthscale='cd /Users/davidg/Development/forthscale'
#alias cd-dev-feedvisor='cd /Users/davidg/Development/feedvisor'

# Load in the git branch prompt script.
source ~/.git-prompt.sh
