
set -Ua PATH /opt/nvim-linux-x86_64/bin
set -Ua PATH $HOME/.local/bin
set -Ua PATH $HOME/tmux-sessionizer

if test -f $HOME/.envrc
    source $HOME/.envrc
end

# tmux-sessionizer function
function tmux_sess
    $HOME/.local/bin/tmux-sessionizer
end

# Bind Ctrl-f to tmux_sess (fish syntax)
bind \cf tmux_sess

# Aliases
alias ll='ls -latr'
alias nv='nvim'
alias svenv='source venv/bin/activate'
alias gs='git status'
alias gd='git diff'
alias glo='git log --oneline -n'

# SSH agent
eval (ssh-agent -c)
if test -f $HOME/.ssh-agent-keys
    source $HOME/.ssh-agent-keys
end


