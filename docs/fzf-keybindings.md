# fzf Key Bindings

fzf provides three interactive key bindings for bash and fish. Two use a
shared `fd` command configured via environment variables.

## Bindings

| Key       | Action                                                      |
|-----------|-------------------------------------------------------------|
| `Ctrl+T`  | Paste a selected **file or directory** path onto the command line |
| `Ctrl+G`  | **Change directory** to a selected directory (bash: alias for `Alt+C`) |
| `Ctrl+R`  | Search command **history** and paste selected entry         |

## How They Work

### Bash

`~/.bashrc` sets the search commands, then sources fzf's official key-bindings
script which registers all three bindings:

```bash
export FZF_CTRL_T_COMMAND="fd --hidden ... . $HOME"
export FZF_ALT_C_COMMAND="fd --type d --hidden ... . $HOME"
source /usr/share/doc/fzf/examples/key-bindings.bash
bind '"\C-g": "\ec"'   # alias Ctrl+G to Alt+C (the cd binding)
```

### Fish

`config.fish` exports the same variables. `Ctrl+T` and `Ctrl+R` are handled
by fzf's fish key-bindings (sourced separately if enabled). `Ctrl+G` calls
the custom `fzf_cd` function defined in `functions/fzf_cd.fish`, which runs
`$FZF_ALT_C_COMMAND`, pipes output to fzf, and `cd`s to the selection.

## Modifying the Search

Both `FZF_CTRL_T_COMMAND` and `FZF_ALT_C_COMMAND` are defined in:

- `home/.bashrc`
- `fish/.config/fish/config.fish`

Key `fd` flags to adjust:

| Flag                  | Purpose                              |
|-----------------------|--------------------------------------|
| `--max-depth 6`       | How deep to recurse                  |
| `. $HOME`             | Search root (`$HOME` = entire home)  |
| `--exclude <dir>`     | Add more directories to skip         |
| `--type d`            | Restrict to directories only (ALT-C) |
| `--follow`            | Follow symlinks                      |

**Example** — also search a second root (e.g. `/mnt`):

```bash
export FZF_CTRL_T_COMMAND="fd --hidden --exclude .git --max-depth 6 . $HOME /mnt"
```
