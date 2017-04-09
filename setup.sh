#!/usr/bin/env bash

# If abort error, exit shell script
set -e

# Display some informations
echo "Author: myyerrol"
echo "Date: 2017-01-13"
echo "Desc: This repository contains some software configurations that are used commonly under Linux, such as vim, tmux, zsh, bash, atom, etc."
echo ""

DIRECTORY=$(pwd)

# Set the colors
if command -v tput > /dev/null 2>&1; then
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

# Set the directory
if [ ! -d ~/Softwares ]; then
    mkdir ~/Softwares
    echo "${GREEN}Creating the directory of softwares successfully!${NORMAL}"
else
    echo "${GREEN}The directory of softwares has been created successfully!${NORMAL}"
cd ~/Softwares
fi

# Set the powerline's fonts
if [ ! -d fonts ]; then
    echo "${BLUE}Downloading the fonts of powerline...${NORMAL}"
    wget https://github.com/powerline/fonts/archive/master.zip
    unzip -n master.zip
    rm -rf master.zip
    mv fonts-master fonts
    cd fonts
    ./install.sh
    cd ../
    echo "${GREEN}Setting the powerline's fonts successfully!${NORMAL}"
else
    echo "${GREEN}The powerline's fonts have been set successfully!${NORMAL}"
fi

# Set the terminal's colors
TERMINAL_COLOR="gnome-terminal-colors-solarized"

if [ ! -d ${TERMINAL_COLOR} ]; then
    echo "${BLUE}Downloading the ${TERMINAL_COLOR}...${NORMAL}"
    sudo apt-get install dconf-cli
    git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
    cd ${TERMINAL_COLOR}
    ./install.sh
    cp -pruv ./dir_colors/ ~/
    # cd ../
    echo "${GREEN}Setting the terminal's colors successfully!${NORMAL}"
else
    echo "${GREEN}The terminal's colors have been set successfully!${NORMAL}"
fi

# Set atom
if command -v atom > /dev/null 2>&1; then
    echo "${GREEN}Atom has been installed successfully!${NORMAL}"
else
    echo "${YELLOW}Atom has not been installed!${NORMAL}"
    echo "${BLUE}Installing the atom...${NORMAL}"
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt-get update
    sudo apt-get install atom
    echo "${GREEN}Installing the atom successfully!${NORMAL}"
fi

cp -pruv ${DIRECTORY}/atom/packages/ ~/.atom

# Set tmux
if command -v tmux > /dev/null 2>&1; then
    echo "${GREEN}Tmux has been installed successfully!${NORMAL}"
else
    echo "${YELLOW}Tmux has not been installed!${NORMAL}"
    echo "${BLUE}Installing the tmux...${NORMAL}"
    sudo apt-get install tmux
    echo "${GREEN}Installing the tmux successfully!${NORMAL}"
fi

cp -puv ${DIRECTORY}/tmux/.tmux.conf ~/

# Set vim and vundle
if command -v vim > /dev/null 2>&1; then
    echo "${GREEN}Vim has been installed successfully!${NORMAL}"
else
    echo "${YELLOW}Vim has not been installed!${NORMAL}"
    echo "${BLUE}Installing the vim...${NORMAL}"
    sudo apt-get install vim
    echo "${GREEN}Installing the vim successfully!${NORMAL}"
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "${BLUE}Downloading the vundle...${NORMAL}"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "${GREEN}Setting the vundle successfully!${NORMAL}"
else
    echo "${GREEN}The vundle has been set successfully!${NORMAL}"
fi

cp -puv ${DIRECTORY}/vim/.vimrc ~/

# Set zsh and oh-my-zsh
if command -v zsh > /dev/null 2>&1; then
    echo "${GREEN}ZSH has been installed successfully!${NORMAL}"
else
    echo "${YELLOW}ZSH has not been installed!${NORMAL}"
    echo "${BLUE}Installing the zsh...${NORMAL}"
    sudo apt-get install zsh
    echo "${GREEN}Installing the zsh successfully!${NORMAL}"
fi

if [ ! -d ~/.oh-my-zsh ]; then
    echo "${BLUE}Downloading the oh-my-zsh...${NORMAL}"
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    echo "${GREEN}Setting the oh-my-zsh successfully!${NORMAL}"
else
    echo "${GREEN}The oh-my-zsh has been set successfully!${NORMAL}"
fi

cp -puv ${DIRECTORY}/zsh/.zshrc ~/

# Display some informations
echo ""
echo "Everything is ok! Start to enjoy it!"
