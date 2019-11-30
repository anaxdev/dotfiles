#!/bin/bash
############################
# reset.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

olddir=~/dotfiles_old             # old dotfiles backup directory
files="zshrc bashrc vimrc tmux.conf dircolors gitignore_global gitconfig"

##########

# Remove symlink and reset to old directory
for file in $files; do
    echo "Removing symlink to $file in home directory"
    rm ~/.$file
    echo "Reseting to old $file"
    mv ~/dotfiles_old/.$file ~/
done
exit 0
