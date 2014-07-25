alias vi="vim"
if [ $(uname) == 'Darwin' ]; then
    alias ls="ls -G"
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
