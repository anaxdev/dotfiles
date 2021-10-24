# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export PATH="$HOME/.rbenv/bin:$PATH"

ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()


plugins=(
    git
    docker
    pass
    fzf
)

source $ZSH/oh-my-zsh.sh


alias ls="ls -G"
alias vim="nvim"
alias vi="nvim"

### golang
export GOPATH=$HOME/dev/go/
export PATH="${GOPATH}bin":$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.yarn/bin

### gopass
source <(gopass completion bash)
alias pass=gopass

### python
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/david/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/david/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/david/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/david/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<


function vid () {
  ffmpeg -ss 1.0 -t 1.0 -i $1 -filter_complex "[0:v] palettegen" palette.png
  ffmpeg -i $1 -i palette.png -filter_complex "[0:v] fps=12:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" $2
  rm palette.png
}

export VISUAL=nvim
export EDITOR="$VISUAL"
export MANPAGER='nvim +Man!'
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
