# logout user
alias luser='pkill -KILL -u'
alias susu='sudo su'

# binaries
#alias python2='/usr/bin/python2'
#alias pip2='/usr/bin/pip2'
#alias python3='/usr/bin/python3'
#alias pip3='/usr/bin/pip3'

# override aliases
alias ls='lsd -A'
alias cat='bat'
alias vi='nvim'

# misspelling
alias car='cat'

# programs
alias nr='npm run'
alias py='python'
alias pip='python3 -m pip'
alias poe='poetry'
alias nf='neofetch'
alias ssh='TERM=screen command ssh'
alias sc='sudo systemctl'
alias scu='systemctl --user'
alias shut='sudo shutdown -h now'
alias power='sudo powertop'
alias loopback='pactl load-module module-loopback latency_msec=1'
alias fb='pcmanfm .'
alias space='ncdu'
alias o='xdg-open'
alias c='cargo'
alias tssh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias ydl='youtube-dl'

# python
alias cvenv='python -m venv .venv'
alias venv='source .venv/bin/activate'

# terraform
alias tf='terraform'
alias tfa='terraform apply -auto-approve'
alias tfd='terraform destroy -auto-approve'

# docker
alias p='podman'
alias d='docker'
alias dke='docker exec -it'
alias dklocal='docker run --rm -it -v {$PWD}:/usr/workdir --workdir=/usr/workdir'
alias ld='lazydocker'

alias dc='docker-compose'
alias pc='podman-compose'

#function dci
    #docker inspect $(docker-compose ps -q $1)
#end

alias dm='docker-machine'

alias mk='minikube'
alias kblocal='kubectl run -it --rm --restart=Never alpine --image=alpine sh'

# files
alias del='rm -rf'
alias sdel='sudo rm -rf'
alias lst='ls --tree -I .git'
alias lsl='ls -l'
alias mkdir='command mkdir -p'
#alias cp='command cp -i' # confirm before overwrite
alias df='command df -h'
alias free='command free -h'
alias du='command du -sh'

# console
alias cl='clear'
alias cs='clear;ls'
alias null='/dev/null'
alias psf='ps -aux | grep'

function watch
    while sleep 1
        clear
        $argv
    end
end

function cd
    builtin cd $argv
    ls
end

function mkd
    mkdir $argv
    builtin cd $argv
end

# tmux
alias tmux='command tmux -u'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias td='tmux kill-session -t'

# git
alias g='git'
# removes all local branches without origin
#alias gclean='git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done'

function lgc
    git commit -m "$argv"
end

function clone
    git clone git@$argv.git
end

function gclone
    clone github.com:$argv
end

function bclone
    gclone breuerfelix/$argv
end

function gsm
    git submodule foreach "$argv || :"
end

function lg
    git add --all
    git commit -a -m "$argv"
    git push
end

function git-del
    git push --delete origin $argv
    git branch -d $argv
end

alias colemak='setxkbmap -option "ctrl:nocaps,altwin:alt_win,grp:shifts_toggle" -layout "us(colemak)"'
alias qwfp='setxkbmap -option "ctrl:nocaps,altwin:alt_win,grp:shifts_toggle" -layout "eu"'

# utils
alias CAPS='xdotool key Caps_Lock'

#export PATH=$PATH:$HOME/bin

#
# PLUGINS
#

# miktex
#export PATH=$PATH:/opt/miktex/bin

# golang
#export GOPATH=$HOME/go
#export PATH=$PATH:$GOPATH/bin

# kubectl
#if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# nnn
#source ~/dotfiles/shell/nnn.sh

# rust
#export PATH=$HOME/.cargo/bin:$PATH
#source $HOME/.cargo/env

# direnv
#eval "$(direnv hook zsh)"

# gpg
#export GPG_TTY=$(tty)

# nomad
#[ -x /usr/local/bin/nomad ] && complete -o nospace -C /usr/local/bin/nomad nomad

# hstr
#export HSTR_CONFIG=hicolor,hide-help
#bindkey -s "\C-e" "\e^ihstr -- \n"

# asdf-vm
#. /opt/asdf-vm/asdf.sh
#. /opt/asdf-vm/completions/asdf.bash

# nvm
#export PATH=$PATH:$HOME/programs/npm/bin
#export NVM_DIR=$HOME/.nvm
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# flutter
#export PATH=$PATH:$HOME/packages/flutter/bin

# import secrets which are not stored in the repo
#[ -f $HOME/.secrets.sh ] && source $HOME/.secrets.sh

# ruby
#export GEM_HOME=$HOME/.gem
#export GEM_PATH=$HOME/.gem
#export PATH=$PATH:$GEM_PATH/bin

#if which ruby >/dev/null && which gem >/dev/null; then
    #PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
#fi

# docker machine
#source /etc/bash_completion.d/docker-machine-prompt.bash

# autojump
#source /usr/share/autojump/autojump.sh

# powerline
#powerline-daemon -q

# esp-idf
#export IDF_PATH=$HOME/inovex/esp-idf
#. $HOME/inovex/esp-idf/export.sh >> /dev/null

# poetry
#export PATH="$HOME/.poetry/bin:$PATH"

# dotnet
# opt out of dotnet telemetry data
#export DOTNET_CLI_TELEMETRY_OPTOUT=true
#export MSBuildSDKsPath="/usr/share/dotnet/sdk/$(dotnet --version)/Sdks"
