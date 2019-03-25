# Build and Push Docker image
docker_bush() {
  if [[ $1 == "bush" ]]; then
    docker build -t $2 .
    docker push $2
  else
    docker "$@"
  fi
}

# Some shortcuts
alias ll='ls -lah'
alias ssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@'
alias docker='docker_bush'
alias cat='bat'  # https://github.com/sharkdp/bat
alias preview="fzf --preview 'bat --color \"always\" {}'"  # https://github.com/junegunn/fzf
alias top="sudo htop"

# Work envs
alias cd-dev-heili='cd /Users/davidg/Development/heili'
alias cd-dev-forthscale='cd /Users/davidg/Development/forthscale'
alias cd-dev-feedvisor='cd /Users/davidg/Development/feedvisor'
alias batter-status='pmset -g batt | grep -Eo "\d+%" | cut -d% -f1'

# Load in the git branch prompt script.
source ~/.git-prompt.sh
