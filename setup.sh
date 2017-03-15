#!/usr/bin/env bash

TERMINAL_COLOR="gnome-terminal-colors-solarized"

DIRECTORY=$(pwd)

cd ~/Documents

if [ ! -d ${TERMINAL_COLOR} ]; then
    echo "Installing ${TERMINAL_COLOR} ..."
    sudo apt-get install dconf-cli
    git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
    cd ${TERMINAL_COLOR}
    ./install.sh
else
    echo "${TERMINAL_COLOR} has been installed!"
fi

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh ..." 
    sudo apt-get install zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "oh-my-zsh has been installed!"
fi


cd ${DIRECTORY}

# Copy configurations to user's home
#cp -puv .bashrc ~/
#cp -puv .zshrc  ~/

# Copy directories to user's home
#cp -pruv ./.dir_colors    ~/
#cp -pruv ./.atom/packages ~/.atom

