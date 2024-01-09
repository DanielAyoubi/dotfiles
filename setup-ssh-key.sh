#!/bin/bash

# SSH key setup script

# Define the SSH key file path
ssh_key_file="$HOME/.ssh/id_rsa"

# Check if SSH key already exists
if [ -f "$ssh_key_file" ]; then
    echo "SSH key already exists at $ssh_key_file"
    exit 0
fi

# Generate a new SSH key
read -p "Enter your email for the SSH key: " email
ssh-keygen -t rsa -b 4096 -C "$email" -f "$ssh_key_file" -N ""

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add the SSH key to the ssh-agent
ssh-add "$ssh_key_file"

# Optionally, upload the public key to GitHub
read -p "Do you want to upload the SSH key to GitHub? (y/n): " upload_answer
if [[ "$upload_answer" == "y" ]]; then
    read -p "Enter your GitHub username: " github_username

    # Requires the GitHub CLI to be installed and authenticated
    gh ssh-key add "${ssh_key_file}.pub" -t "${github_username}@$(hostname)"
fi

echo "SSH key setup complete."

