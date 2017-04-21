# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
# git-prompt
source ~/.git-prompt.sh
source ~/.git-completion.bash

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    export GIT_PS1_SHOWDIRTYSTATE=1
    #PS1='\u:[\w]$(__git_ps1 " (%s)")\n🐳  '
    PS1='\u:[\w]$(__git_ps1 " (%s)")🐳  '
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ $(uname) == 'Darwin' ]; then
    alias ls="ls -G"
fi

# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1
#
# # Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

#vim
alias vi="vim"
alias vim="mvim -v"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias dirs
alias dirs='dirs -v'

# Navigation
cd_pushd() {
    if [ $# -eq 0 ]; then
        DIR="${HOME}"
    else
        DIR="$1"
    fi
    builtin pushd "${DIR}" > /dev/null
}

pushd_builtin() {
    builtin pushd > /dev/null
}

cd_popd() {
    builtin popd > /dev/null
}

clear_dirs() {
    builtin dirs -c > /dev/null
}

alias cd='cd_pushd'
alias bd='cd_popd'
alias fd='pushd_builtin'
alias xd='clear_dirs'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias tmux="TERM=screen-256color-bce tmux"
alias love="/Applications/love.app/Contents/MacOS/love"

SCALA_HOME="/usr/local/bin/scala"
export PATH=/usr/local/bin:$PATH

#GUROBI_HOME="/Library/gurobi650/mac64"
#PATH="${PATH}:${GUROBI_HOME}/bin"
#DYLD_LIBRARY_PATH="${DYLD_LIBRARY_PATH}:${GUROBI_HOME}/lib"
#GUROBI_LICENCE="/Users/dawu/gurobi.lic"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi


export GOPATH=$HOME/dev/go/
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Docker work stuff

export GITHUB_TOKEN="af4a6d9ab57e11c5034e9afdb1fea75f37da657d"

function rmdtr {
    docker ps -a | grep dtr | grep -v enzi | awk '{print $1}' | xargs docker rm -f; docker volume ls | grep dtr | awk '{print $2}' | xargs docker volume rm
}

# GPG agent
GPG_AGENT_FILE="$HOME/.gpg-agent-info"
function start_gpg_agent {
  gpg-agent --daemon --write-env-file $GPG_AGENT_FILE
}
if which gpg-agent > /dev/null; then
  # start agent if there's no agent file
  if [ ! -f $GPG_AGENT_FILE ]; then
    eval $( start_gpg_agent )
  else
    # check agent works
    source $GPG_AGENT_FILE
    SOCKET=$(echo "${GPG_AGENT_INFO}"  | cut -d : -f 1)
    # check agent connection
    if ( ! nc -U $SOCKET < /dev/null | grep -q "OK Pleased to meet you" ); then
      eval $( start_gpg_agent )
    fi
  fi
  export GPG_TTY=$(tty)
fi
## AWS
#export DOCKER_TLS_VERIFY=0
#alias docker="docker --tlsverify=false"
#export DOCKER_CERT_PATH=~/.docker/

# Infra
alias aws_vpn_infra='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=infra-us-east-1*" "Name=tag:role,Values=docker" "Name=tag:secondary-role,Values=vpn" "Name=instance-state-name,Values=running" --output=json'
alias aws_saltmaster_infra='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=infra-us-east-1*" "Name=tag:role,Values=saltmaster" "Name=instance-state-name,Values=running" --output=json'

# Production
alias aws_dist_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=distribution" "Name=instance-state-name,Values=running" --output=json'
alias aws_docker_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=docker" "Name=instance-state-name,Values=running" --output=json'
alias aws_dtr_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=dtr" "Name=instance-state-name,Values=running" --output=json'
alias aws_es_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=elasticsearch" "Name=instance-state-name,Values=running" --output=json'
alias aws_es2_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=elasticsearch2" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_ext_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=external" "Name=tag:role,Values=haproxy" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_ext_reg_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=external" "Name=tag:role,Values=haproxy" "Name=tag:haproxy-group,Values=registry" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_int_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=internal" "Name=tag:role,Values=haproxy" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=haproxy" "Name=instance-state-name,Values=running" --output=json'
alias aws_hub_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=hub" "Name=instance-state-name,Values=running" --output=json'
alias aws_infra_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=docker" "Name=tag:secondary-role,Values=infra" "Name=instance-state-name,Values=running" --output=json'
alias aws_nautilus_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=nautilus" "Name=instance-state-name,Values=running" --output=json'
alias aws_nautilus_singleton_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=nautilus-singleton" "Name=instance-state-name,Values=running" --output=json'
alias aws_nautilus_signer_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=nautilus-signer" "Name=instance-state-name,Values=running" --output=json'
alias aws_notary_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=notary" "Name=instance-state-name,Values=running" --output=json'
alias aws_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=instance-state-name,Values=running" --output=json'
alias aws_prometheus_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=prometheus" "Name=instance-state-name,Values=running" --output=json'
alias aws_store_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=store" "Name=instance-state-name,Values=running" --output=json'
alias aws_swarm_dis_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:secondary-role,Values=swarm-discovery" "Name=instance-state-name,Values=running" --output=json'
alias aws_s3_es_logs_prod='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=us-east-1*" "Name=tag:role,Values=docker" "Name=tag:secondary-role,Values=s3-es-logs" "Name=instance-state-name,Values=running" --output=json'

# Staging
alias aws_dist_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=distribution" "Name=instance-state-name,Values=running" --output=json'
alias aws_docker_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=docker" "Name=instance-state-name,Values=running" --output=json'
alias aws_dtr_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=dtr" "Name=instance-state-name,Values=running" --output=json'
alias aws_es_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=elasticsearch" "Name=instance-state-name,Values=running" --output=json'
alias aws_es2_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=elasticsearch2" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_ext_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=external" "Name=tag:role,Values=haproxy" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_ext_reg_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=external" "Name=tag:role,Values=haproxy" "Name=tag:haproxy-group,Values=registry" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_int_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=internal" "Name=tag:role,Values=haproxy" "Name=instance-state-name,Values=running" --output=json'
alias aws_haproxy_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=haproxy" "Name=instance-state-name,Values=running" --output=json'
alias aws_hub_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=hub" "Name=instance-state-name,Values=running" --output=json'
alias aws_infra_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=docker" "Name=tag:secondary-role,Values=infra" "Name=instance-state-name,Values=running" --output=json'
alias aws_nautilus_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=nautilus" "Name=instance-state-name,Values=running" --output=json'
alias aws_nautilus_singleton_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=nautilus-singleton" "Name=instance-state-name,Values=running" --output=json'
alias aws_nautilus_signer_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=nautilus-signer" "Name=instance-state-name,Values=running" --output=json'
alias aws_notary_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=notary" "Name=instance-state-name,Values=running" --output=json'
alias aws_prometheus_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=prometheus" "Name=instance-state-name,Values=running" --output=json'
alias aws_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=instance-state-name,Values=running" --output=json'
alias aws_store_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=store" "Name=instance-state-name,Values=running" --output=json'
alias aws_swarm_dis_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:secondary-role,Values=swarm-discovery" "Name=instance-state-name,Values=running" --output=json'
alias aws_s3_es_logs_stage='aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=stage-us-east-1*" "Name=tag:role,Values=docker" "Name=tag:secondary-role,Values=s3-es-logs" "Name=instance-state-name,Values=running" --output=json'

alias aws_ip="jq -r '.Reservations[].Instances[].PrivateIpAddress'"

alias fig="docker-compose"

function ndocker () {
    server=$1;
    shift;
    /usr/local/bin/docker --tlsverify=false --tlscacert=$HOME/.docker/ca.pem --tlscert=$HOME/.docker/cert.pem \
        --tlskey=$HOME/.docker/nautilus-certs/nautilus-docker-key.pem \
        -H tcp://$server:2376 $@
}

function ndocker-compose () {
    f=$1;
    shift;
    server=$1;
    shift;
    docker-compose -f $f --skip-hostname-check --tlsverify --tlscacert=$HOME/.docker/ca.pem --tlscert=$HOME/.docker/cert.pem \
        --tlskey=$HOME/.docker/nautilus-certs/nautilus-docker-key.pem \
        -H tcp://$server:2376 $@
}

alias gtv='set oldLevel=$LOG_LEVEL; export LOG_LEVEL=INFO; go test `go list ./...  | grep -v vendor/` | grep -v "no test files"; export LOG_LEVEL=$oldLevel'

function list_nautilus () {
    ENVIRONMENT=$1
    if [[ $ENVIRONMENT == "prod" ]]; then
        IPS=$(aws_nautilus_prod | aws_ip)
    else
        IPS=$(aws_nautilus_stage | aws_ip)
    fi
    for IP in $IPS; do
        line=$(ndocker $IP ps | grep "nautilus-scanner")
        echo -e "$IP: \t$line"
    done
}

function kdtr () {
    docker ps -a | grep dtr | grep -v enzi | awk '{print $1}' | xargs docker rm -f; docker volume ls | grep dtr | awk '{print $2}' | xargs docker volume rm
}

function idtr () {
    docker run -it --rm dtr-internal.caas.docker.io/caas/dtr install --ucp-url `docker-machine ip dtr-vm`:444 --ucp-username admin --ucp-password password --ucp-insecure-tls --dtr-external-url `docker-machine ip dtr-vm`
}

function kdtrv () {
    docker ps -a | grep dtr | grep -v enzi | awk '{print $1}' | xargs docker rm -f; docker volume ls | grep dtr | awk '{print $2}' | xargs docker volume rm
}

function idtrv () {
    docker run -it --rm dtr-internal.caas.docker.io/caas/dtr install --ucp-url 192.168.33.10:444 --ucp-username admin --ucp-password password --ucp-insecure-tls --dtr-external-url 192.168.33.10
}


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
eval "$(direnv hook bash)"

# android stuff
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools/adb
