#!/usr/bin/env bash

# Copy configurations to backcp
cp -puv ~/.zshrc     ./
cp -puv ~/.bashrc    ./
cp -puv ~/.vimrc     ./
cp -puv ~/.tmux.conf ./

# Copy directories to backup
cp -pruv ~/.atom/packages/ ./.atom
