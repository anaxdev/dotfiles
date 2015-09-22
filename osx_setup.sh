l!/bin/bash

# Install homebrew
echo 'Installing homebrew'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Tmux
echo 'Installing tmux'
brew install tmux

# Set up Vim
echo 'Setting up vim'
vim +PluginInstall +qall

# Python
#echo 'Installing python modules'
#brew install pip
#sudo pip install nose
#brew install numpy
#brew install pandas
#brew install opencv
#brew install scipy

echo 'done'
