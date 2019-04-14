# GitHub shell command completion
if [ -f ~/.git-completion.bash ]; then source ~/.git-completion.bash; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/davidg/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/davidg/google-cloud-sdk/completion.bash.inc'; fi

# Brew completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# fuzzy completion
# $(brew --prefix)/opt/fzf/install
