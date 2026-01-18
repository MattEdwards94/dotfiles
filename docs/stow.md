# GNU Stow Guide

## What is Stow? (User Perspective)

GNU Stow is a symlink farm manager that makes managing dotfiles easy. Instead
of manually linking configuration files from your dotfiles repository to your
home directory (like `ln -s ~/dotfiles/nvim ~/.config/nvim`), Stow does this
automatically for you.

It allows you to keep your configuration files organized in separate
directories (packages) within your dotfiles repository, while making them
appear to be installed in their standard locations in your home directory.

**Example:**
If you have a folder structure like this:
```
~/dotfiles/
    nvim/
        .config/
            nvim/
                init.lua
```

Running `stow nvim` inside `~/dotfiles` will create a symlink at
`~/.config/nvim/init.lua` pointing to your file in `~/dotfiles`.

## How it Works

Stow works by "folding" the filesystem hierarchy of a package directory into a target directory
(usually your home directory).

1.  **Packages**: Each top-level directory in your dotfiles repo (like `nvim`, `fish`, `tmux`)
    is considered a "package".
2.  **Target**: The directory where symlinks should be created (default is the parent directory,
    e.g., `../` or `~/`).
3.  **Folding**: Stow walks the directory tree of the package. If a directory
    exists in the target, it descends into it. If a file exists in the package
    but not the target, it creates a symlink in the target pointing to the
    package file.

If you delete a package or use `stow -D package_name`, it removes the symlinks,
effectively "uninstalling" the configuration without deleting the source files.

## Handling Existing Configuration

If you try to stow a package but a configuration file already exists in the
target location (e.g., `~/.config/nvim/init.lua` exists and is a real file,
not a symlink), Stow will **refuse to run** and will print an error message.
It **will not** overwrite your existing files.

You have two main options:

1.  **Back up (Preserve)**:
    If you want to keep the existing file but not use it with Stow right now, rename it:
    ```bash
    mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
    stow nvim
    ```

2.  **Adopt (Import)**:
    If the existing file is the one you want to keep and manage with Stow, move it into your
    dotfiles repository:
    ```bash
    # Move the file to your dotfiles repo (maintaining the directory structure)
    mv ~/.config/nvim/init.lua ~/dotfiles/nvim/.config/nvim/init.lua

    # Run stow to create the link
    cd ~/dotfiles
    stow nvim
    ```
    *(Note: GNU Stow 2.2.4+ has an `--adopt` flag that does this automatically.
    However, use it with caution: `--adopt` will overwrite the file in your
    **dotfiles repo** with the one from your home directory. If you intended
    to push your repo version to your home directory, `--adopt` will do the
    opposite and you will lose your repo changes.)*

## Common Questions

**Q: Can I symlink "over" an existing file?**
No. A file system location can only hold one thing: a file OR a symlink. It
cannot hold both.
*   If a file exists, Stow will refuse to create a symlink (conflict).
*   If you force a symlink (e.g. `ln -sf`), the original file is **deleted**
    and replaced by the link. It is not "hidden" or "masked".

**Q: What happens when I unstow (`stow -D`)?**
Stow removes the symlinks it created. It does **not** restore the original
files (because they weren't hidden, they were either moved or deleted before
Stow could run).
