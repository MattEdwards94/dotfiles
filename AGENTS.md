<<<<<<< HEAD
# AGENTS.md - Dotfiles Repository Guidelines

## Repository Overview

This is a personal dotfiles repository using GNU Stow for managing shell,
Neovim, and Tmux configurations. The primary codebase is Lua (Neovim
configuration) with supporting Bash and Fish shell scripts.

## Code Style Guidelines

### General Formatting

- **Line wrapping**: Wrap at approximately 80-90 characters with a hard
  limit of 100 characters
- **Line endings**: Unix line endings (LF)

### Lua (Neovim Configuration)

- **Formatter**: Stylua with 160-column width (`.stylua.toml`)
- **Indentation**: 4 spaces, Unix line endings
- **Quotes**: Auto-prefer single quotes
- **Naming**: Use snake_case for variables and functions
- **Comments**: Use `--` for single-line, `--[[...]]` for multi-line; use
  `---@` for type annotations
- **Module imports**: Use `require()` at top; prefer explicit local
  assignments: `local map = function(...)`
- **Types**: Use Lua type annotations (`---@param`, `---@return`,
  `---@type`)
- **Error handling**: Use `pcall()` for graceful error handling; avoid
  silent failures
- **Plugin conventions**: Return tables from plugin specs; use
  `dependencies`, `config`, `opts` fields

### Bash/Shell Scripts

- **Style**: Bash with strict mode: `set -e` and `set -o pipefail`
- **Indentation**: Spaces (standard 2-4)
- **Functions**: Use `function_name() { ... }` syntax
- **Variables**: Use UPPER_CASE for constants/exported variables
- **Error messages**: Print to stderr; include context for debugging

### General Patterns

- **File organization**: Group related configs in subdirectories under
  `.config/`
- **Documentation**: Include setup instructions in file headers
- **Cross-platform**: Test on Linux; note SSH clipboard handling for
  WSL/remote sessions

## Build/Lint/Test Commands

**No build/test suite** - This is a configuration repository managed by
Stow.

**Installation**:

```bash
cd ~/dotfiles && stow */           # Install all configs
cd ~/dotfiles && stow nvim         # Install specific config
bash install_deps.sh               # Install system dependencies
```

**Validation**:

```bash
stylua --check nvim/.config/nvim/lua/  # Check Lua formatting
```

**Formatting** (if needed):

```bash
stylua nvim/.config/nvim/lua/      # Auto-format Lua files
```

## Key Configuration Files

- `.stylua.toml` - Lua formatting rules (160-column, 4-space indent)
- `install_deps.sh` - System dependency installer
- Neovim configs use lazy.nvim plugin manager (no lock file rebuilds
  needed)

## Documentation and Notes

**Important**: This repository has an associated notes folder at `~/notes`
containing general documentation that may reference configurations,
workflows, keymaps, and procedures. When making any changes to this
codebase:

1. Search through `~/notes` to identify any documentation that may be
   impacted by your changes
2. Alert the user about potentially affected documentation
3. Ask the user whether the notes should be updated to reflect the
   changes
4. Do not update notes without explicit user approval

This ensures configuration changes stay synchronized with user
documentation and workflows.
=======
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
>>>>>>> master
