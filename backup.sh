#!/usr/bin/env bash

# Copy configurations to backcp
cp -puv ~/.bashrc    ./
cp -puv ~/.zshrc     ./
cp -puv ~/.tmux.conf ./

# Copy directories to backup
cp -pruv ~/.dir_colors     ./
cp -pruv ~/.atom/packages  ./.atom

