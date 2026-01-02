# AGENTS.md

## Overview
This repository contains dotfiles for configuring a development environment, managed using GNU Stow. It includes configurations for Neovim, Tmux, Fish shell, and Bash.

## Directory Structure
The repository is organized into "packages" compatible with GNU Stow:

- **`fish/`**: Configuration for the Fish shell. Contains `.config/` structure.
- **`home/`**: General home directory configurations, specifically `.bashrc`.
- **`nvim/`**: Neovim configuration files, structured under `.config/`.
- **`tmux/`**: Tmux configuration, including `.tmux.conf` and related `.config/` and `.local/` directories.

## Usage

### 1. Bootstrap Dependencies
Run the `install_deps.sh` script to install necessary packages and tools:
```bash
./install_deps.sh
```
This script installs:
- Core tools: `git`, `curl`, `fzf`, `ripgrep`, `jq`, `tree`, `unzip`, `wget`.
- Editors/Shells: `neovim`, `tmux`, `zsh`.
- Extra tools: `uv` (Python package manager), `nvm` (Node version manager), GitHub Copilot CLI.

### 2. Install Dotfiles
Use `stow` to symlink configurations into the home directory.

**Install all configurations:**
```bash
cd ~/dotfiles
stow */
source ~/.bashrc
```

**Install a specific configuration (e.g., nvim):**
```bash
cd ~/dotfiles
stow nvim
```

### 3. Handling Conflicts
If target files already exist, `stow` might fail. To adopt existing files into the repo (and then reset them to the repo's version):
```bash
stow --adopt <package>
git reset --hard
```

## Key Files
- **`install_deps.sh`**: Bash script to automate the installation of system packages and tools. Detects package manager (apt, dnf, yum, pacman).
- **`README.md`**: Contains detailed human-readable instructions and examples for using `stow` with alternative target directories.
