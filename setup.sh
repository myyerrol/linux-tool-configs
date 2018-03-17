#!/usr/bin/env bash

set -e

displayVersion()
{
    echo "Version:"
    echo "1.0.0"
}

displayUsage()
{
    echo "Usage:"
    echo "./setup.sh [--install | --uninstall | --backup]"
}

displayInfo()
{
    echo "Author:"
    echo "myyerrol"
    echo ""
    echo "Created on: "
    echo "2017-01-13"
}

displayHelp()
{
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
    echo "--install       Install configuration files"
    echo "--uninstall     Uninstall configuration files"
    echo "--backup        Backup configuration files"
    echo "--version       Display Version"
    echo ""
    echo "For more information, see https://github.com/myyerrol/linux_user_configuration"
    echo ""
}

if [ "$1" = "--debug" ]; then
    export LUC_DEBUG=1
    shift
fi

[ -n "${LUC_DEBUG}" ] && set -x
    
case "$1" in
    "--version")
        displayVersion
        ;;
    "--usage")
        displayUsage
        ;;
    "--help")
        displayHelp
        ;;
    "--install")
        bash ./setup_install.sh
        ;;
    "--uninstall")
        bash ./setup_uninstall.sh
        ;;
    "--backup")
        bash ./setup_backup.sh
        ;;
    *)
        echo "Unknown parameter: "$1"" >&2
        displayUsage >&2
        exit 1
        ;;
esac

unset LUC_DEBUG