# Build and Push Docker image
docker_bush() {
  if [[ $1 == "bush" ]]; then
    docker build -t $2 .
    docker push $2
  else
    docker "$@"
  fi
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
    #echo "$(tput setaf 1)(${speed}ms)$(tput sgr 0)"
    #echo "$(tput setaf 1)(${speed}ms)"
    echo "(⚠ ${speed}ms)"
  elif [ "$speed" == "0" ]; then
    #echo "$(tput sgr 0 1)$(tput setaf 1)(FAIL)$(tput sgr 0)"
    #echo "$(tput sgr 0 1)$(tput setaf 1)(FAIL)"
    echo "(FAIL)"
  else
    echo ""
  fi
}

# Flush DNS
flush-dns() {
  echo "Flushing DNS cache"
  dscacheutil -flushcache
  echo "Kulling DNS daemons [Password required]"
  sudo killall -HUP mDNSResponder
}

# Super `cd`
super-cd() {
  cd "$@"
  cdnvm
}

# SSH Tunnel
ssh-tunnel() {
  local_port=$1
  tunnel_remote=$2
  ssh -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM} ${AWS_BASTION_USER}@${AWS_BASTION_ADDRESS} -CNL localhost:${local_port}:${tunnel_remote}
}
# Postgres Tunnel
pg-tunnel() {
  db=$1
  echo "Opening tunnel to ${db}"
  ssh-tunnel 5432 "${db}.${ENDOR_PG_ADDRESS_SUFFIX}:5432"
}
# MongoDB Tunnel
mdb-tunnel() {
  db=$1
  echo "Opening tunnel to ${db} mongo"
  ssh-tunnel 27017 "mdb.${db}.${ENDOR_DEV_DOMAIN}:27017"
}

# Some shortcuts
alias ll='ls -lah'
alias ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@'
alias docker='docker_bush'
alias cat='bat'  # https://github.com/sharkdp/bat
alias cd='super-cd'
alias preview="fzf --preview 'bat --color \"always\" {}'"  # https://github.com/junegunn/fzf
alias top='sudo htop'
alias kube='kubectl'
alias ping8='ping 8.8.8.8'
alias ping1='ping 1.1.1.1'
alias flushdns='flush-dns'
alias vimhosts='sudo vim /etc/hosts'
alias cerebro='docker run -p 9000:9000 --rm lmenezes/cerebro:0.9.4 '
#alias cerebro='docker run --network host --rm lmenezes/cerebro:0.9.2 -Dhttp.address=0.0.0.0 -Dhttp.port=9000'

# Work envs
#alias py-endor='source /Users/davidg/virtualenvs/endor/bin/activate'
#alias py-errbot='source /Users/davidg/virtualenvs/errbot/bin/activate'
alias ssh-dev='ssh -l ubuntu -i ${SSH_PEM_PATH}/dev.pem'
alias ssh-dev-task='ssh -l ec2-user -i ${SSH_PEM_PATH}/devTaskRunner.pem'
alias ssh-stage='ssh -l ubuntu -i ${SSH_PEM_PATH/stage.pem'
alias ssh-stage-task='ssh -l ec2-user -i ${SSH_PEM_PATH}/stageTaskRunner.pem'
alias ssh-r='ssh -l root -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-h='ssh -l hadoop -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-ov='ssh -l openvpnas -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM}'
alias ssh-ba='ssh -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM} -l ec2-user -o "proxycommand ssh -W %h:%p -i ${SSH_PEM_PATH}/${AWS_BASTION_PEM} -l ${AWS_BASTION_USER} ${AWS_BASTION_ADDRESS}"'
alias ssh-bu='ssh -i ${SSH_PEM_PATH}/${ENDOR_MAIN_PEM} -l ubuntu -o "proxycommand ssh -W %h:%p -i ${SSH_PEM_PATH}/${AWS_BASTION_PEM} -l ${AWS_BASTION_USER} ${AWS_BASTION_ADDRESS}"'
alias ssh-bov='ssh -i ${SSH_PEM_PATH}/vpn.pem -l openvpnas -o "proxycommand ssh -W %h:%p -i ${SSH_PEM_PATH}/${AWS_BASTION_PEM} -l ${AWS_BASTION_USER} ${AWS_BASTION_ADDRESS}"'
alias pg-tun='pg-tunnel'
alias mdb-tun='mdb-tunnel'
#alias cd-dev-heili='cd /Users/davidg/Development/heili'
#alias cd-dev-forthscale='cd /Users/davidg/Development/forthscale'
#alias cd-dev-feedvisor='cd /Users/davidg/Development/feedvisor'

# Load in the git branch prompt script.
source ~/.git-prompt.sh
