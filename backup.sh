#!/usr/bin/env bash

# If abort error, exit shell script
set -e

# Display some informations
echo "Author: myyerrol"
echo "Date: 2017-01-13"
echo "Desc: This repository contains some software configurations that are used commonly under Linux, such as vim, tmux, zsh, bash, atom, xterm, etc."
echo ""

# Copy configurations to back up
cp -puv ~/.zshrc             ./zsh
cp -puv ~/.bashrc            ./bash
cp -puv ~/.vimrc             ./vim
cp -puv ~/.tmux.conf         ./tmux
cp -puv ~/.atom/styles.less  ./atom
cp -puv ~/.Xresources        ./xterm
cp -puv ~/.ycm_extra_conf.py ./ycm

# Copy directories to back up
cp -pruv ~/.atom/packages/  ./atom

# Display some informations
echo ""
echo "Everything is ok! All configurations have been backed up!"
