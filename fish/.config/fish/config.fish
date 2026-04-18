set -Ua PATH /opt/nvim-linux-x86_64/bin
set -Ua PATH $HOME/.local/bin
set -Ua PATH $HOME/tmux-sessionizer
set -Ua PATH $HOME/.opencode/bin
set -Ua PATH /usr/local/go/bin

if test -f $HOME/.envrc
    source $HOME/.envrc
end

set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude __pycache__ --exclude venv --exclude .venv --max-depth 6 . $HOME"
set -gx FZF_CTRL_T_COMMAND "fd --hidden --follow --exclude .git --exclude node_modules --exclude __pycache__ --exclude venv --exclude .venv --max-depth 6 . $HOME"

# tmux-sessionizer function
function tmux_sess
    $HOME/.local/bin/tmux-sessionizer
end

# Bind Ctrl-f to tmux_sess (fish syntax)
bind \cf tmux_sess

# Bind Ctrl-g to fzf directory picker
bind \cg fzf_cd

# Aliases
alias ll='ls -latr'
alias nv='nvim'
alias svenv='source venv/bin/activate.fish'
alias gs='git status'
alias gd='git diff'
alias glo='git log --oneline -n'
alias caat='copilot --allow-all-tools'

# SSH agent
eval (ssh-agent -c)
if test -f $HOME/.ssh-agent-keys
    source $HOME/.ssh-agent-keys
end


if test -f "/home/edwardsm/corporate-ca.pem"
    set -x NODE_EXTRA_CA_CERTS "/home/edwardsm/corporate-ca.pem"
end

if test -f $HOME/.config/fish/work_functions.fish
    source $HOME/.config/fish/work_functions.fish
end

