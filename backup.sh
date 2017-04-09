#!/usr/bin/env bash

# If abort error, exit shell script
set -e

# Display some informations
echo "Author: myyerrol"
echo "Date: 2017-01-13"
echo "Desc: This repository contains some software configurations that are used commonly under Linux, such as vim, tmux, zsh, bash, atom, etc."
echo ""

# Copy configurations to back cp
cp -puv ~/.zshrc            ./zsh
cp -puv ~/.bashrc           ./bash
cp -puv ~/.vimrc            ./vim
cp -puv ~/.tmux.conf        ./tmux
cp -puv ~/.atom/styles.less ./atom

# Copy directories to back up
cp -pruv ~/.atom/packages/  ./atom

# Display some informations
echo "Everything is ok! All configurations have been backed up!"
