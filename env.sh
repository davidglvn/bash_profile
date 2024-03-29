# Bash history
export HISTFILESIZE=10000
export HISTSIZE=10000

# Make terminal colorful
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
#export PATH
# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
#export PATH
# Enbale PyhtonEnv
eval "$(pyenv init -)"

# Go
export PATH=$PATH:/Users/davidg/go/bin/

# Some Java things
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export M2_HOME=/Users/davidg/apache-maven-3.6.0
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm	

# Forthscale
export FSSH_DEBUG=true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/davidg/google-cloud-sdk/path.bash.inc' ]; then source '/Users/davidg/google-cloud-sdk/path.bash.inc'; fi

# Configure kubectl
for config_file in $(ls $HOME/.kube/ | grep -e "^config"); do
  KUBECONFIG=$KUBECONFIG:$HOME/.kube/$config_file
done
export KUBECONFIG=$KUBECONFIG


# https://github.com/junegunn/fzf - add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# General stuff
SSH_PEM_PATH="/Users/davidg/.ssh"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

# GNU sed
PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:${PATH}"

# MySQL Client
#export PATH="/usr/local/opt/mysql-client/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/mysql-client/lib"
#export CPPFLAGS="-I/usr/local/opt/mysql-client/include"
