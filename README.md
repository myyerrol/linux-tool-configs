# linux_user_configuration

![linux_user_configuration](.images/linux_user_configuration.png)

## Description

This repository contains some software configurations that are used commonly under Linux, such as vim, tmux, zsh, bash, atom, etc.

## Installation

- Clone the repository to your Desktop:

  ```bash
  $> cd Desktop
  $> git clone https://github.com/myyerrol/linux_user_configuration.git
  ```

- Execute the following shell scrpit:

  ```bash
  $> cd linux_user_configuration
  $> ./setup.sh
  ```

- **Because the installation of ZSH will cause the current script to exit, you can copy the `.zshrc` file to `HOME` manually:**

  ```bash
  $> cp -puv .zshrc ~/
  ```

  or execute `setup.sh` once again:

  ```bash
  $> ./setup.sh
  ```

## Configuration

### Terminal

- Open the **Profile Preferences** in the current terminal.

- Choose the **Gerenal** option and adjust the font with the name of **Powerline**.

### Vim

- Open the `.vimrc` by using vim:

  ```bash
  $> vim ~/.vimrc
  ```

- In command mode, enter **:PluginInstall** to install plugins.
