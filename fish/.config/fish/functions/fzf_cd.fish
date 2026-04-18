function fzf_cd
    set -l selected (eval $FZF_ALT_C_COMMAND | fzf --height 40% --reverse)
    if test -n "$selected"
        cd $selected
        commandline -f repaint
    end
end
