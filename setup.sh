#!/usr/bin/env bash

TERMINAL_COLOR="gnome-terminal-colors-solarized"

DIRECTORY=$(pwd)

cd ~/Documents

# Set powerline fonts
if [ ! -d fonts ]; then
    echo "Installing the fonts of powerline ..."
    wget https://github.com/powerline/fonts/archive/master.zip
    unzip -n master.zip
    rm -rf master.zip
    mv fonts-master fonts
    cd fonts
    ./install.sh
    cd ../
else
    echo "Finish the installation of fonts!"
fi

# Set terminal color
if [ ! -d ${TERMINAL_COLOR} ]; then
    echo "Installing the ${TERMINAL_COLOR} ..."
    sudo apt-get install dconf-cli
    git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
    cd ${TERMINAL_COLOR}
    ./install.sh
    cd ../
else
    echo "Finish the installation of ${TERMINAL_COLOR}!"
fi

# Set zsh an oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing the oh-my-zsh ..." 
    sudo apt-get install zsh
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
else
    echo "Finish the installation of oh-my-zsh!"
fi

# Set atom and packages
if [ ! -d ~/.atom ]; then
    echo "Installing the atom ..."
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt-get update
    sudo apt-get install atom
else
    echo "Finish the installation of atom!"
fi

# Set tmux
if [ ! -f ~/.tmux.conf ]; then
    echo "Installing the tmux ..."
    sudo apt-get install tmux
else
    echo "Finish the installation of tmux!"
fi

# Set vim
if [! -f ~/.vimrc ]; then
    echo "Installing the vim ..."
    sudo apt-get install vim
else
    echo "Finish the installation of vim!"
fi

cd ${DIRECTORY}

# Copy configurations to user's home
cp -puv .zshrc     ~/
cp -puv .bashrc    ~/
cp -puv .vimrc     ~/
cp -puv .tmux.conf ~/

# Copy directories to user's home
cp -pruv ./.vim/           ~/
cp -pruv ./.dir_colors/    ~/
cp -pruv ./.atom/packages/ ~/.atom

