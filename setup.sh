#!/usr/bin/env bash

set -e

PATH_HOME=${HOME}
PATH_EXEC=${PWD}

displayHelp() {
    echo "Author:"
    echo "myyerrol"
    echo ""
    echo "Created on: "
    echo "2017-01-13"
    echo ""
    echo "Version:"
    echo "1.0.0"
    echo ""
    echo "Usage:"
    echo "./setup.sh [-h | -i | -b | -d]"
    echo ""
    echo "Description:"
    echo "Install, backup or delete configs that are used commonly under Linux."
    echo
    echo "-i   install configs"
    echo "-b   backup  configs"
    echo "-d   delete  configs"
    echo ""
    echo "For more information, see https://github.com/myyerrol/linux-tool-configs"
}

setDisplayColor() {
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

setSoftwaresDir() {
    if [ ! -d ${PATH_HOME}/Softwares ]; then
        mkdir ${PATH_HOME}/Softwares
        echo "${GREEN}Creating the directory of softwares successfully!${NORMAL}"
    else
        echo "${GREEN}The directory of softwares has been created successfully!${NORMAL}"
    fi
}

setPownlineFonts() {
    if [ ! -d ${PATH_HOME}/Softwares/fonts-powerline ]; then
        echo "${BLUE}Downloading the fonts of powerline...${NORMAL}"
        cd ${PATH_HOME}/Softwares
        git clone https://github.com/powerline/fonts.git --depth=1 fonts-powerline
        ./fonts-powerline/install.sh
        cd - > /dev/null 2>&1
        echo "${GREEN}Setting the powerline's fonts successfully!${NORMAL}"
    else
        echo "${GREEN}The powerline's fonts have been set successfully!${NORMAL}"
    fi
}

setTerminalColor() {
    TERMINAL_COLOR="gnome-terminal-colors-solarized"

    if [ ! -d ${PATH_HOME}/Softwares/${TERMINAL_COLOR} ]; then
        echo "${BLUE}Downloading the ${TERMINAL_COLOR}...${NORMAL}"
        cd ${PATH_HOME}/Softwares
        sudo apt-get install dconf-cli
        git clone https://github.com/aruhier/${TERMINAL_COLOR}.git
        cd ${TERMINAL_COLOR}
        ./install.sh
        cd - > /dev/null 2>&1
        echo "${GREEN}Setting the terminal's colors successfully!${NORMAL}"
    else
        echo "${GREEN}The terminal's colors have been set successfully!${NORMAL}"
    fi
}

setTmux() {
    if command -v tmux > /dev/null 2>&1; then
        echo "${GREEN}The tmux has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The tmux has not been installed!${NORMAL}"
        echo "${BLUE}Installing the tmux...${NORMAL}"
        sudo apt-get install tmux
        echo "${GREEN}Installing the tmux successfully!${NORMAL}"
    fi

    if [ ! -d ${PATH_HOME}/.tmux/plugins/tpm ]; then
        echo "${BLUE}Downloading the tpm...${NORMAL}"
        git clone https://github.com/tmux-plugins/tpm.git ${PATH_HOME}/.tmux/plugins/tpm
        echo "${GREEN}Setting the tpm successfully!${NORMAL}"
    else
        echo "${GREEN}The tpm has been set successfully! Updating...${NORMAL}"
        cd ${PATH_HOME}/.tmux/plugins/tpm
        git pull
        cd - > /dev/null 2>&1
        echo "${YELLOW}Install the tmux plugins using the command: <prefix>+<shift><i>${NORMAL}"
    fi

    cp -puv ${PATH_EXEC}/tmux/.tmux.conf ${PATH_HOME}/
}

setGit() {
    if command -v git > /dev/null 2>&1; then
        echo "${GREEN}The git has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The git has not been installed!${NORMAL}"
        echo "${BLUE}Installing the git...${NORMAL}"
        sudo apt-get install git
        echo "${GREEN}Installing the git successfully!${NORMAL}"
    fi

    cp -puv ${PATH_EXEC}/git/.gitconfig ${PATH_HOME}/
}

setVim() {
    if command -v vim > /dev/null 2>&1; then
        echo "${GREEN}The vim has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The vim has not been installed!${NORMAL}"
        echo "${BLUE}Installing the vim...${NORMAL}"
        sudo apt-get install vim
        echo "${GREEN}Installing the vim successfully!${NORMAL}"
    fi

    if comman -v ctags > /dev/null 2>&1; then
        echo "${GREEN}The ctags has been installed successfully!${NORMAL}"
        echo "${YELLOW}The ctags has not been installed!${NORMAL}"
        echo "${BLUE}Installing the ctags...${NORMAL}"
        sudo apt-get install exuberant-ctags
        echo "${GREEN}Installing the ctags successfully!${NORMAL}"
    fi

    if [ ! -d ${PATH_HOME}/.vim/bundle/Vundle.vim ]; then
        echo "${BLUE}Downloading the vundle...${NORMAL}"
        git clone https://github.com/VundleVim/Vundle.vim.git ${PATH_HOME}/.vim/bundle/Vundle.vim
        echo "${GREEN}Setting the vundle successfully!${NORMAL}"
    else
        echo "${GREEN}The vundle has been set successfully! Updating...${NORMAL}"
        cd ${PATH_HOME}/.vim/bundle/Vundle.vim
        git pull
        cd - > /dev/null 2>&1
    fi

    cp -puv ${PATH_EXEC}/vim/.vimrc ${PATH_HOME}/

    echo "${BLUE}Installing vim plugins...${BLUE}"
    vim +PluginInstall +qall
}

setZsh() {
    if command -v zsh > /dev/null 2>&1; then
        echo "${GREEN}The zsh has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The zsh has not been installed!${NORMAL}"
        echo "${BLUE}Installing the zsh...${NORMAL}"
        sudo apt-get install zsh
        echo "${GREEN}Installing the zsh successfully!${NORMAL}"
    fi

    chsh -s /bin/zsh

    if [ ! -d ${PATH_HOME}/.oh-my-zsh ]; then
        echo "${BLUE}Downloading the oh-my-zsh...${NORMAL}"
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        echo "${GREEN}Setting the oh-my-zsh successfully!${NORMAL}"
    else
        echo "${GREEN}The oh-my-zsh has been set successfully!${NORMAL}"
    fi

    if [ ! -d ${PATH_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        echo "${BLUE}Downloading the zsh-autosuggestions...${NORMAL}"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${PATH_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        echo "${GREEN}Setting the zsh-autosuggestions successfully!${NORMAL}"
    else
        echo "${GREEN}The zsh-autosuggestions has been set successfully!${NORMAL}"
    fi

    cp -ipv ${PATH_EXEC}/zsh/.zshrc ${PATH_HOME}/
}

installConfigsToUser() {
    setDisplayColor
    setSoftwaresDir
    setPownlineFonts
    setTerminalColor

    setTmux
    setGit
    setVim
    setZsh

    echo "${GREEN}Everything is ok! Start to enjoy it!${NORMAL}"
}

installConfigsToServer() {
    setDisplayColor
}

backupConfigs() {
    setDisplayColor
    cp -puv ~/.tmux.conf           ./tmux
    cp -puv ~/.gitconfig           ./git
    cp -puv ~/.vimrc               ./vim
    cp -puv ~/.zshrc               ./zsh
    cp -puv ~/.config/nix/nix.conf ./nix
    echo "${GREEN}Everything is ok! All Configs have been backup!${NORMAL}"
}

deleteConfigs() {
    setDisplayColor
    rm -ri ~/.tmux.conf
    rm -ri ~/.gitconfig
    rm -ri ~/.vimrc
    rm -ri ~/.zshrc
    echo "${GREEN}Everything is ok! All Configs have been deleted!${NORMAL}"
}

if [ "$1" = "--debug" ]; then
    export LTC_DEBUG=1
    shift
fi

[ -n "${LTC_DEBUG}" ] && set -x

case "$1" in
    "-h")
        displayHelp
        ;;
    "-i")
        installConfigsToUser
        ;;
    "-b")
        backupConfigs
        ;;
    "-d")
        deleteConfigs
        ;;
    *)
        echo "Unknown parameter: "$1"" >&2
        displayHelp >&2
        exit 1
        ;;
esac

unset LTC_DEBUG
