#!/bin/bash

echo "Removing PyCharm Pro..."

# Check if the installation directory exists
if [ -d "/opt/pycharm" ]; then
    # Remove the installation directory
    sudo rm -rf /opt/pycharm
    echo "Directory /opt/pycharm removed."
else
    echo "PyCharm Pro not found in /opt/pycharm."
fi

# Remove the symbolic link for the 'pycharm' command
if [ -L "/usr/local/bin/pycharm" ]; then
    sudo rm /usr/local/bin/pycharm
    echo "Symbolic link /usr/local/bin/pycharm removed."
else
    echo "Symbolic link /usr/local/bin/pycharm not found."
fi

# Remove the .desktop application menu file
if [ -f "/usr/share/applications/pycharm-pro.desktop" ]; then
    sudo rm /usr/share/applications/pycharm-pro.desktop
    echo "Application menu file removed."
else
    echo "Application menu file not found."
fi

# Remove local user theme icon
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
USER_ICON_DIR="$HOME/.local/share/icons/$THEME/scalable/apps/pycharm-pro.svg"

if [ -f "$USER_ICON_DIR" ]; then
    rm "$USER_ICON_DIR"
    echo "Local theme icon removed."
fi

# Remove fallback hicolor icon
if [ -f "/usr/share/icons/hicolor/scalable/apps/pycharm-pro.svg" ]; then
    sudo rm /usr/share/icons/hicolor/scalable/apps/pycharm-pro.svg
    echo "Fallback (hicolor) icon removed."
fi

# Update icon cache and application menu database
echo "Updating icon cache and application menu database..."
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor 2>/dev/null || true
sudo update-desktop-database

echo "PyCharm Pro has been successfully removed!"
