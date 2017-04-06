#!/usr/bin/env bash

set -e

# Copy configurations to backcp
cp -puv ~/.zshrc     ./zsh
cp -puv ~/.bashrc    ./bash
cp -puv ~/.vimrc     ./vim
cp -puv ~/.tmux.conf ./tmux

# Copy directories to backup
cp -pruv ~/.atom/packages/ ./atom
