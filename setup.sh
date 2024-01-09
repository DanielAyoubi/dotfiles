#!/bin/bash

# Define the source directory for your dotfiles
dotfiles_dir=~/dotfiles

# List of dotfiles to link to the home directory
home_dotfiles=(.bashrc .vimrc .zshrc)

# List of directories to link to ~/.config
config_dirs=(nvim kitty) # Add more directories as needed

# Function to create a symbolic link
create_link() {
    local src=$1
    local dst=$2

    # Check if the destination already exists
    if [ -e "$dst" ]; then
        # If it's a symlink, remove it. If it's a regular file/directory, back it up.
        if [ -L "$dst" ]; then
            echo "Removing existing symlink: $dst"
            rm "$dst"
        else
            echo "Backing up existing file/directory: $dst"
            mv "$dst" "${dst}.backup"
        fi
    fi

    # Create the symlink
    ln -s "$src" "$dst"
    echo "Created symlink: $dst -> $src"
}

# Link dotfiles to the home directory
for dotfile in "${home_dotfiles[@]}"; do
    create_link "$dotfiles_dir/$dotfile" "$HOME/$dotfile"
done

# Link directories to ~/.config
for dir in "${config_dirs[@]}"; do
    create_link "$dotfiles_dir/$dir" "$HOME/.config/$dir"
done

echo "Dotfiles setup complete."
