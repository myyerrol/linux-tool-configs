#!/usr/bin/env bash

set -e
[ -n "$LTC_DEBUG" ] && set -x

setDisplayedColors()
{
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
}

backupConfigurationFiles()
{
    cp -puv ~/.zshrc            ./zsh
    cp -puv ~/.bashrc           ./bash
    cp -puv ~/.vimrc            ./vim
    cp -puv ~/.tmux.conf        ./tmux
    cp -puv ~/.gitconfig        ./git
    cp -puv ~/.atom/styles.less ./atom
    cp -puv ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings ./sublime
}

displayCompletedInfo()
{
    echo ""
    echo "${GREEN}Everything is ok! All configurations have been backed up!${NORMAL}"
}

main()
{
    setDisplayedColors

    backupConfigurationFiles

    displayCompletedInfo
}

# Run script
RUNNING=$(basename $0)
[ "$RUNNING" = "setup_backup.sh" ] && main
