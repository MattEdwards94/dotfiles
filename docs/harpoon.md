# Harpoon Usage

Harpoon is a file navigation plugin for Neovim that lets you mark files and quickly switch between them.

## Add files

Add files to the harpoon list using `<leader>jh`.

You can add as many files as you want, but there's only shortcuts configured for jumping to 
the first four files. To jump to more files, open the harpoon quick menu and select manually

## Harpoon quick menu

Open the quick menu with `<leader>je`.

Files can be selected and opened with j/k and then enter.

Since this is a normal buffer, operations like yank/delete work.
The order can be changed and items deleted, but will need writing, using :w, to persist.

## Harpoon quick navigation keymaps

Go to harpoon file 1 - `<leader>ja`
Go to harpoon file 2 - `<leader>js`
Go to harpoon file 3 - `<leader>jd`
Go to harpoon file 4 - `<leader>jf`

## Notes

- The plugin version installed is `harpoon2`.
- Configuration is located in `lua/plugins/harpoon.lua`.
