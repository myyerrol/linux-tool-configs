#!/usr/bin/env bash

TERMINAL_COLOR="gnome-terminal-colors-solarized"

DIRECTORY=$(pwd)

cd ~/Documents

if [ ! -d ${TERMINAL_COLOR} ]; then
    echo "Installing the ${TERMINAL_COLOR} ..."
    sudo apt-get install dconf-cli
    git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
    cd ${TERMINAL_COLOR}
    ./install.sh
else
    echo "Finish the installation of ${TERMINAL_COLOR}!"
fi

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing the oh-my-zsh ..." 
    sudo apt-get install zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "Finish the installation of oh-my-zsh!"
fi

if [ ! -d fonts ]; then
    echo "Installing the fonts of powerline ..."
    wget https://github.com/powerline/fonts/archive/master.zip
    unzip -n master.zip
    mv fonts-master fonts 
    cd fonts
    ./install.sh
else
    echo "Finish the installation of fonts!"
fi

cd ${DIRECTORY}

# Copy configurations to user's home
#cp -puv .bashrc    ~/
#cp -puv .zshrc     ~/
#cp -puv .tmux.conf ~/

# Copy directories to user's home
#cp -pruv ./.dir_colors    ~/
#cp -pruv ./.atom/packages ~/.atom
#cp -pruv ./vim            ~/.vim

