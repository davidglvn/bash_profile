# GitHub shell command completion
if [ -f ~/.git-completion.bash ]; then source ~/.git-completion.bash; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/davidg/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/davidg/google-cloud-sdk/completion.bash.inc'; fi

# Brew completion
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#. $(brew --prefix)/etc/bash_completion
#fi
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# fuzzy completion
# $(brew --prefix)/opt/fzf/install

# kubectl
source <(kubectl completion bash)
complete -o default -F __start_kubectl kube

# nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
