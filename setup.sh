#!/usr/bin/env bash

set -e

displayVersion() {
    echo "Version:"
    echo "1.0.0"
}

displayUsage() {
    echo "Usage:"
    echo "./setup.sh [-i | -u | -b]"
}

displayInfo() {
    echo "Author:"
    echo "myyerrol"
    echo ""
    echo "Created on: "
    echo "2017-01-13"
}

displayHelp() {
    echo ""
    displayInfo
    echo ""
    displayVersion
    echo ""
    displayUsage
    echo ""
    echo "Description:"
    echo "Install, uninstall or backup configuration files that are used commonly under Linux, such as powerline, terminal, xterm, tmux, vim, zsh, etc."
    echo
    echo "-i     Install configuration files"
    echo "-u     Uninstall configuration files"
    echo "-b     Backup configuration files"
    echo "-v     Display Version"
    echo ""
    echo "For more information, see https://github.com/myyerrol/linux-tool-configs"
    echo ""
}

if [ "$1" = "--debug" ]; then
    export LTC_DEBUG=1
    shift
fi

[ -n "${LTC_DEBUG}" ] && set -x

case "$1" in
    "-v")
        displayVersion
        ;;
    "-u")
        displayUsage
        ;;
    "-h")
        displayHelp
        ;;
    "-i")
        bash ./setup_install.sh
        ;;
    "-u")
        bash ./setup_uninstall.sh
        ;;
    "-b")
        bash ./setup_backup.sh
        ;;
    *)
        echo "Unknown parameter: "$1"" >&2
        displayUsage >&2
        exit 1
        ;;
esac

unset LTC_DEBUG
