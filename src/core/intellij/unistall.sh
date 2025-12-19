#!/bin/bash

echo "Removing IntelliJ IDEA..."

# Check if the installation directory exists
if [ -d "/opt/intellij-idea" ]; then
    # Remove the installation directory
    sudo rm -rf /opt/intellij-idea
    echo "Directory /opt/intellij-idea removed."
else
    echo "IntelliJ IDEA not found in /opt/intellij-idea."
fi

# Remove the symbolic link for the 'idea' command
if [ -L "/usr/local/bin/idea" ]; then
    sudo rm /usr/local/bin/idea
    echo "Symbolic link /usr/local/bin/idea removed."
else
    echo "Symbolic link /usr/local/bin/idea not found."
fi

# Remove the .desktop application menu file
if [ -f "/usr/share/applications/intellij-idea.desktop" ]; then
    sudo rm /usr/share/applications/intellij-idea.desktop
    echo "Application menu file removed."
else
    echo "Application menu file not found."
fi

# Update the desktop database
echo "Updating application menu database..."
sudo update-desktop-database

echo "IntelliJ IDEA has been successfully removed!"
