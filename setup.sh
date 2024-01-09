#!/bin/bash

# Define the source directory for your dotfiles
dotfiles_dir=~/.dotfiles

# List of dotfiles in the home directory
home_dotfiles=(.bashrc .vimrc .zshrc)

# List of directories/files in the ~/.config directory
config_dotfiles=(scripts LazyVim)

# Function to create a symbolic link
create_link() {
    local src=$1
    local dst=$2

    # Check if the source file/directory exists
    if [ ! -e "$src" ]; then
        echo "Source file/directory not found: $src"
        return
    fi

    # Remove the destination if it's an existing symlink, or back it up if it's not a symlink
    if [ -L "$dst" ]; then
        echo "Removing existing symlink: $dst"
        rm "$dst"
    elif [ -e "$dst" ]; then
        echo "Backing up existing file/directory: $dst"
        mv "$dst" "${dst}.backup"
    fi

    # Create the symlink
    ln -s "$src" "$dst"
    echo "Created symlink: $dst -> $src"
}

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Link dotfiles in the home directory
for dotfile in "${home_dotfiles[@]}"; do
    create_link "$dotfiles_dir/$dotfile" "$HOME/$dotfile"
done

# Link dotfiles/directories in the ~/.config directory
for config_dotfile in "${config_dotfiles[@]}"; do
    create_link "$dotfiles_dir/$config_dotfile" "$HOME/.config/$config_dotfile"
done

echo "Dotfiles setup complete."

