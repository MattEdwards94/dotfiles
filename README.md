# Dotfiles

## Usage - personal machine/account
These steps will override the system values, assuming that you have full permission/control over
the account.

```bash
sudo apt install stow

git clone git@github.com:MattEdwards94/dotfiles.git ~/dotfiles

cd ~/dotfiles
stow . --adopt --dotfiles
git reset --hard
source ~/.bashrc
```

See `man stow` for the adopt option details. In short, the working version of the dotfile within
the git repo will be changed to reflect any existing file. git reset --hard will then return 
the working version to HEAD

