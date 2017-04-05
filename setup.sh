#!/usr/bin/env bash

TERMINAL_COLOR="gnome-terminal-colors-solarized"

DIRECTORY=$(pwd)

cd ~/Documents

# Use colors
if command -v tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

# Set powerline fonts
if [ ! -d fonts ]; then
    echo "${BLUE}Installing the fonts of powerline...${NORMAL}"
    wget https://github.com/powerline/fonts/archive/master.zip
    unzip -n master.zip
    rm -rf master.zip
    mv fonts-master fonts
    cd fonts
    ./install.sh
    cd ../
    echo "${GREEN}Finish the installation of powerline's fonts!${NORMAL}"
else
    echo "${GREEN}Finish the installation of powerline's fonts!${NORMAL}"
fi

# Set terminal color
if [ ! -d ${TERMINAL_COLOR} ]; then
    echo "${BLUE}Installing the ${TERMINAL_COLOR}...${NORMAL}"
    sudo apt-get install dconf-cli
    git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
    cd ${TERMINAL_COLOR}
    ./install.sh
    cp -pruv ./.dir_colors/ ~/
    cd ../
    echo "${GREEN}Finish the installation of terminal's colors!${NORMAL}"
else
    echo "${GREEN}Finish the installation of terminal's colors!${NORMAL}"
fi

# Set atom
if command -v atom > /dev/null 2>&1; then
    echo "${GREEN}Atom has been installed!${NORMAL}"
else
    echo "${YELLOW}Atom has not been installed!${NORMAL}"
    echo "${BLUE}Installing the atom...${NORMAL}"
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt-get update
    sudo apt-get install atom
    echo "${GREEN}Finish the installation of atom!${NORMAL}"
fi

cp -pruv ${DIRECTORY}/.atom/packages/ ~/.atom

# Set tmux
if command -v tmux > /dev/null 2>&1; then
    echo "${GREEN}Tmux has been installed!${NORMAL}"
else
    echo "${YELLOW}Tmux has not been installed!${NORMAL}"
    echo "${BLUE}Installing the tmux...${NORMAL}"
    sudo apt-get install tmux
    echo "${GREEN}Finish the installation of tmux!${NORMAL}"
fi

cp -puv ${DIRECTORY}/.tmux.conf ~/

# Set vim
if command -v vim > /dev/null 2>&1; then
    echo "${GREEN}Vim has been installed!${NORMAL}"
else
    echo "${YELLOW}Vim has not been installed!${NORMAL}"
    echo "${BLUE}Installing the vim...${NORMAL}"
    sudo apt-get install vim
    echo "${GREEN}Finish the installation of vim!${NORMAL}"
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "${BLUE}Installing the vundle...${NORMAL}"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "${GREEN}Finish the installation of vundle!${NORMAL}"
else
    echo "${GREEN}Finish the installation of vundle!${NORMAL}"
fi

cp -puv ${DIRECTORY}/.vimrc ~/

# Set zsh and oh-my-zsh
if command -v zsh > /dev/null 2>&1; then
    echo "${GREEN}ZSH has been installed!${NORMAL}"
else
    echo "${YELLOW}ZSH has not been installed!${NORMAL}"
    echo "${BLUE}Installing the zsh...${NORMAL}"
    sudo apt-get install zsh
    echo "${GREEN}Finish the installation of zsh!${NORMAL}"
fi

if [ ! -d ~/.oh-my-zsh ]; then
    echo "${BLUE}Installing the oh-my-zsh...${NORMAL}"
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    echo "${GREEN}Finish the installation of oh-my-zsh!${NORMAL}"
else
    echo "${GREEN}Finish the installation of oh-my-zsh!${NORMAL}"
fi

cp -puv ${DIRECTORY}/.zshrc ~/
