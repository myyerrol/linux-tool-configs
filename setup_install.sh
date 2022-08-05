#!/usr/bin/env bash

set -e
[ -n "$LTC_DEBUG" ] && set -x

PATH_HOME=${HOME}
PATH_EXEC=${PWD}

setDisplayedColors() {
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

setSoftwaresDirectory() {
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
        if [ ! -f "./master.zip" ]; then
            wget https://github.com/powerline/fonts/archive/master.zip
        fi
        unzip -n master.zip
        rm -rf master.zip
        mv fonts-master fonts-powerline
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
        git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
        cd ${TERMINAL_COLOR}
        ./install.sh
        cd - > /dev/null 2>&1
        cp -pruv ./dir_colors/ ${PATH_HOME}/.dir_colors/
        echo "${GREEN}Setting the terminal's colors successfully!${NORMAL}"
    else
        echo "${GREEN}The terminal's colors have been set successfully!${NORMAL}"
    fi
}

setXterm() {
    if command -v xterm > /dev/null 2>&1; then
        echo "${GREEN}The xterm has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The xterm has not been installed!${NORMAL}"
        echo "${BLUE}Installing the xterm...${NORMAL}"
        sudo apt-get install xterm
        echo "${GREEN}Installing the xterm successfully!${NORMAL}"
    fi

    if [ -f /usr/share/fonts/truetype/wqy/wqy-microhei.ttc ]; then
        echo "${GREEN}The wqy-microhei font has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The wqy-microhei font has not been installed!${NORMAL}"
        echo "${BLUE}Installing the wqy-microhei font...${NORMAL}"
        sudo apt-get install ttf-wqy-microhei
        echo "${GREEN}Installing the wqy-microhei font successfully!${NORMAL}"
    fi

    cp -puv ${PATH_EXEC}/xterm/.Xresources ${PATH_HOME}/
    xrdb -load ${PATH_HOME}/.Xresources
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
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "${GREEN}Setting the oh-my-zsh successfully!${NORMAL}"
    else
        echo "${GREEN}The oh-my-zsh has been set successfully!${NORMAL}"
    fi

    cp -ipv ${PATH_EXEC}/zsh/.zshrc ${PATH_HOME}/
}

displayCompletedInfo() {
    echo ""
    echo "${GREEN}Everything is ok! Start to enjoy it!${NORMAL}"
}

main() {
    setDisplayedColors
    setSoftwaresDirectory

    # setPownlineFonts
    # setTerminalColor
    # setXterm
    setTmux
    # setGit
    # setVim
    # setZsh

    displayCompletedInfo
}

# Run script
RUNNING=$(basename $0)
[ "$RUNNING" = "setup_install.sh" ] && main
