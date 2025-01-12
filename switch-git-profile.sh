#!/bin/bash

CONFIG_FILE="$HOME/.git-profiles"

# Function to read profile configuration
read_profile() {
    local profile=$1
    local key=$2
    grep -A4 "^\[$profile\]" "$CONFIG_FILE" | grep "^$key=" | cut -d'=' -f2
}

# Function to validate config file
validate_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Error: Configuration file not found at $CONFIG_FILE"
        echo "Please create the file with your profile configurations"
        exit 1
    fi
    
    # Check file permissions
    if [ "$(stat -f %Lp $CONFIG_FILE)" != "600" ]; then
        echo "Warning: Configuration file has loose permissions. Fixing..."
        chmod 600 "$CONFIG_FILE"
    fi
}

# Function to switch Git profile
switch_profile() {
    local profile=$1
    
    # Validate profile exists in config
    if ! grep -q "^\[$profile\]" "$CONFIG_FILE"; then
        echo "Error: Profile '$profile' not found in $CONFIG_FILE"
        echo "Available profiles:"
        grep '^\[.*\]' "$CONFIG_FILE" | tr -d '[]'
        exit 1
    fi
    
    # Read profile configuration
    local name=$(read_profile $profile "name")
    local email=$(read_profile $profile "email")
    local username=$(read_profile $profile "username")
    local token=$(read_profile $profile "token")
    
    # Update git configuration
    echo "Switching to $profile profile..."
    git config --global user.name "$name"
    git config --global user.email "$email"
    git config --global credential.helper store
    echo "https://$username:$token@github.com" > ~/.git-credentials
    
    # Display current Git configuration
    echo -e "\nCurrent Git Configuration:"
    echo "Profile: $profile"
    echo "User name: $(git config --global user.name)"
    echo "User email: $(git config --global user.email)"
    echo "Using credentials for: $username"
}

# Validate config file exists and has proper permissions
validate_config

# Check if profile argument is provided
if [ $# -eq 0 ]; then
    echo "Please specify a profile"
    echo "Available profiles:"
    grep '^\[.*\]' "$CONFIG_FILE" | tr -d '[]'
    exit 1
fi

# Switch to specified profile
switch_profile $1