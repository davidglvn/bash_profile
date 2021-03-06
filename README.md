# How to use
## Install dependencies
### X-Code
`xcode-select --install`
### Brew
`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
### Bash
Upgrade bash
`brew install bash`
### Bash completition
`brew install bash-completion@2`
### Python 3
`brew install python3`
### Docker
[Follow instructions here](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
### [Bat](https://github.com/sharkdp/bat)
Replace standart `cat` command
`brew install bat`
### [fzf](https://github.com/junegunn/fzf)
Improved recursive search in CLI
```
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```
### htop
Improved `top`
`brew install htop`

### trash
Move files to trash
`brew install trash`

### [kubectx / kubens](https://github.com/ahmetb/kubectx)
Power tools for kubectl
`brew install kubectx`

### [kube-ps1](https://github.com/jonmosco/kube-ps1)
K8s prompt
`brew install kube-ps1`

## Configure
Add to `~/.bash_profile`
```
#!/bin/bash
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

source ~/bash_profile/env.sh
source ~/bash_profile/secrets.sh
source ~/bash_profile/alias.sh
source ~/bash_profile/completion.sh
source ~/bash_profile/cli.sh
```

### Kubernetes configurations
Save additional K8s cluster config file under `~/.kube/` directory with name prefix `config-`.  
For example: `~/.kube/config-devDave`

### Scheduled Jobs
#### Clear downloads directory once a week
Clear script is located at `scripts/clear_dir.sh` and launchctl plist file is `jobs/im.golovan.clear-downloads-dir.plist`
```
ln -sf ~/bash_profile/jobs/im.golovan.clear-downloads-dir.plist ~/Library/LaunchAgents/im.golovan.clear-downloads-dir.plist
launchctl load ~/Library/LaunchAgents/im.golovan.clear-downloads-dir.plist 
launchctl start ~/Library/LaunchAgents/im.golovan.clear-downloads-dir
```
#### Clear Trash every 2 weeks
Clear script is located at `scripts/clear_trash.sh` and launchctl plist file is `jobs/im.golovan.clear-trash.plist`
```
ln -sf ~/bash_profile/jobs/im.golovan.clear-trash.plist ~/Library/LaunchAgents/im.golovan.clear-trash.plist
launchctl load ~/Library/LaunchAgents/im.golovan.clear-trash.plist
launchctl start ~/Library/LaunchAgents/im.golovan.clear-trash
```
