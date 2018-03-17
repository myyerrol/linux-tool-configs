#!/usr/bin/env bash

set -e
[ -n "$LUC_DEBUG" ] && set -x

PATH_HOME=${HOME}
PATH_EXEC=${PWD}

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

setSoftwaresDirectory()
{
    if [ ! -d ${PATH_HOME}/Softwares ]; then
        mkdir ${PATH_HOME}/Softwares
        echo "${GREEN}Creating the directory of softwares successfully!${NORMAL}"
    else
        echo "${GREEN}The directory of softwares has been created successfully!${NORMAL}"
    fi
}

setPownlineFonts()
{
    if [ ! -d ${PATH_HOME}/Softwares/fonts ]; then
        echo "${BLUE}Downloading the fonts of powerline...${NORMAL}"
        cd ${PATH_HOME}/Softwares
        wget https://github.com/powerline/fonts/archive/master.zip
        unzip -n master.zip
        rm -rf master.zip
        mv fonts-master fonts
        cd fonts
        ./install.sh
        cd - /dev/null 2>&1
        echo "${GREEN}Setting the powerline's fonts successfully!${NORMAL}"
    else
        echo "${GREEN}The powerline's fonts have been set successfully!${NORMAL}"
    fi
}

setTerminalColor()
{
    TERMINAL_COLOR="gnome-terminal-colors-solarized"

    if [ ! -d ${PATH_HOME}/Softwares/${TERMINAL_COLOR} ]; then
        echo "${BLUE}Downloading the ${TERMINAL_COLOR}...${NORMAL}"
        cd ${PATH_HOME}/Softwares
        sudo apt-get install dconf-cli
        git clone https://github.com/Anthony25/${TERMINAL_COLOR}.git
        cd ${TERMINAL_COLOR}
        ./install.sh
        cd - /dev/null 2>&1
        cp -pruv ./dir_colors/ ${PATH_HOME}/.dir_colors/
        echo "${GREEN}Setting the terminal's colors successfully!${NORMAL}"
    else
        echo "${GREEN}The terminal's colors have been set successfully!${NORMAL}"
    fi
}

setXterm()
{
    if command -v xterm > /dev/null 2>&1; then
        echo "${GREEN}Xterm has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}Xterm has not been installed!${NORMAL}"
        echo "${BLUE}Installing the xterm...${NORMAL}"
        sudo apt-get install xterm
        echo "${GREEN}Installing the xterm successfully!${NORMAL}"
    fi

    if [ -f /usr/share/fonts/truetype/wqy/wqy-microhei.ttc ]; then
        echo "${GREEN}The wqy-microhei font has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}The wqy-microhei font has not been installed!${NORMAL}"
        echo "${BLUE}install the wqy-microhei font...${NORMAL}"
        sudo apt-get install ttf-wqy-microhei
        echo "${GREEN}Installing the wqy-microhei font successfully!${NORMAL}"
    fi

    cp -puv ${PATH_EXEC}/xterm/.Xresources ${PATH_HOME}/
    xrdb -load ${PATH_HOME}/.Xresources
}

setTmux()
{
    if command -v tmux > /dev/null 2>&1; then
        echo "${GREEN}Tmux has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}Tmux has not been installed!${NORMAL}"
        echo "${BLUE}Installing the tmux...${NORMAL}"
        sudo apt-get install tmux
        echo "${GREEN}Installing the tmux successfully!${NORMAL}"
    fi

    cp -puv ${PATH_EXEC}/tmux/.tmux.conf ${PATH_HOME}/
}

setVimAndVundle()
{
    if command -v vim > /dev/null 2>&1; then
        echo "${GREEN}Vim has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}Vim has not been installed!${NORMAL}"
        echo "${BLUE}Installing the vim...${NORMAL}"
        sudo apt-get install vim
        echo "${GREEN}Installing the vim successfully!${NORMAL}"
    fi

    if comman -v ctags > /dev/null 2>&1; then
        echo "${GREEN}Ctags has been installed successfully!${NORMAL}"
        echo "${YELLOW}Ctags has not been installed!${NORMAL}"
        echo "${BLUE}Installing the ctags...${NORMAL}"
        sudo apt-get install exuberant-ctags
        echo "${GREEN}Installing the Ctags successfully!${NORMAL}"
    fi

    if [ ! -d ${PATH_HOME}/.vim/bundle/Vundle.vim ]; then
        echo "${BLUE}Downloading the vundle...${NORMAL}"
        git clone https://github.com/VundleVim/Vundle.vim.git ${PATH_HOME}/.vim/bundle/Vundle.vim
        echo "${GREEN}Setting the vundle successfully!${NORMAL}"
    else
        echo "${GREEN}The vundle has been set successfully! Updating...${NORMAL}"
        cd ${PATH_HOME}/.vim/bundle/Vundle.vim
        git pull
        cd - /dev/null 2>&1
    fi

    cp -puv ${PATH_EXEC}/vim/.vimrc ${PATH_HOME}/

    echo "${BLUE}Installing vim plugins...${BLUE}"
    vim +PluginInstall +qall
}

setZSH()
{
    if command -v zsh > /dev/null 2>&1; then
        echo "${GREEN}ZSH has been installed successfully!${NORMAL}"
    else
        echo "${YELLOW}ZSH has not been installed!${NORMAL}"
        echo "${BLUE}Installing the zsh...${NORMAL}"
        sudo apt-get install zsh
        echo "${GREEN}Installing the zsh successfully!${NORMAL}"
    fi

    chsh -s /bin/zsh

    cp -ipv ${PATH_EXEC}/zsh/.zshrc ${PATH_HOME}/

    if [ ! -d ${PATH_HOME}/.oh-my-zsh ]; then
        echo "${BLUE}Downloading the oh-my-zsh...${NORMAL}"
        sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        echo "${GREEN}Setting the oh-my-zsh successfully!${NORMAL}"
    else
        echo "${GREEN}The oh-my-zsh has been set successfully!${NORMAL}"
    fi
}

displayCompletedInfo()
{
    echo ""
    echo "${GREEN}Everything is ok! Start to enjoy it!${NORMAL}"
}

main()
{
    setDisplayedColors
    setSoftwaresDirectory

    setPownlineFonts
    setTerminalColor
    setXterm
    setTmux
    setVimAndVundle
    setZSH

    displayCompletedInfo
}

# Run script
RUNNING=$(basename $0)
[ "$RUNNING" = "setup_install.sh" ] && main
