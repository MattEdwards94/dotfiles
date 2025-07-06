# Dotfiles

This repository contains my personal configuration files (dotfiles).

## Usage

### Prerequisites

*   `wget`
*   A Unix-like operating system (Linux, macOS, etc.)

### Installation


1.  (optional) Backup Existing Files

    ```bash
    mv ~/.bashrc ~/.bashrc.bak
    mv ~/.tmux.conf ~/.tmux.conf.bak
    ```

2. Either clone the repo or use wget to get the files

    ```bash
    git clone <repository_url> ~/.dotfiles
    ```

    ```bash
    wget https://raw.githubusercontent.com/MattEdwards94/dotfiles/refs/heads/master/.bashrc -O ~/.bashrc.edwardsm
    wget https://raw.githubusercontent.com/MattEdwards94/dotfiles/refs/heads/master/.tmux.conf -O ~/.tmux.conf.edwardsm
    ```

3.  Create symlink

    ```bash
    ln -s ~/.bashrc.edwardsm ~/.bashrc
    ln -s ~/.tmux.conf.edwardsm ~/.tmux.conf
    ```

4. source it

```bash
source ~/.bashrc
```

For Tmux, either restart your Tmux server or start a new session.

```bash
tmux source-file ~/.tmux.conf
```

