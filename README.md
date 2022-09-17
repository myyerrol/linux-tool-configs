# linux_tool_configs

![linux_tool_configs](.images/linux_tool_configs.png)

## Description

Install, uninstall or backup config files that are used commonly under Linux, such as powerline, terminal, xterm, tmux, vim, zsh, etc.

## Usage

### Installation

- Clone the repository to your Desktop:

  ```bash
  $> cd Desktop
  $> git clone https://github.com/myyerrol/linux_tool_configs.git
  ```

- Execute the following shell scrpit:

  ```bash
  $> cd linux_tool_configs
  $> ./setup.sh --install
  ```

- **Because the installation of ZSH will cause the current script to exit, you should copy the `.zshrc` file to `HOME` manually to solve this problem:**

  ```bash
  $> cp -ipv ./zsh/.zshrc ${HOME}
  ```

### Uninstall

- Execute the following shell scrpit:

  ```bash
  $> ./setup.sh --uninstall
  ```

### Backup

- Execute the following shell scrpit:

  ```bash
  $> ./setup.sh --backup
  ```

## Configuration

### Terminal

- Open the **Profile Preferences** in the current terminal.

- Choose the **Gerenal** option and choose the font with the name of **Powerline**.
