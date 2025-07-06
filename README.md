# Installation

Clone repo and install pre-requisites

```bash
sudo apt install stow

git clone git@github.com:MattEdwards94/dotfiles.git ~/dotfiles
```

## personal machine/account - install all
Install all the dotfiles in the repo, e.g. `bash`, `nvim`, etc.

```bash
cd ~/dotfiles
stow */
source ~/.bashrc
```

Note, if stow fails due to there being existing files in the home directory, you can use the 
following:
```bash 
cd ~/dotfiles
stow --adopt */
git reset --hard
source ~/.bashrc
```

See `man stow` for the adopt option details. In short, the working version of the dotfile within
the git repo will be changed to reflect any existing file. git reset --hard will then return 
the working version to HEAD

## personal machine/account - install specific
To install a specific package, e.g. `nvim`, run:

```bash
cd ~/dotfiles
stow nvim
git reset --hard
source ~/.bashrc
```

# How to stow "alongside" existing config

If there is already a config that you don't want to overwrite, you can use the `-t` option with 
`stow` to specify a target directory

To keep the folder structure the same we need to coerce it a bit. For example, to create a new
nvim config under `~/.config/nvim-alternative`, you can run:

```bash
mkdir ~/.config/nvim-alternative
stow -d nvim/.config/nvim * -t ~/.config/nvim-alternative
```

This could then be launched like so: 
```bash
alias nvim-alt='NVIM_APPNAME="nvim-alternative" nvim'
nvim-alt
```
