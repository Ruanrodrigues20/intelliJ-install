#!/bin/bash

# Remove GoLand installation
sudo rm -rf /opt/goland
sudo rm -f /usr/local/bin/goland

# Remove desktop entry
sudo rm -f /usr/share/applications/goland.desktop

# Remove theme icons
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
rm -f ~/.local/share/icons/$THEME/scalable/apps/goland.svg
sudo rm -f /usr/share/icons/hicolor/scalable/apps/goland.svg
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

echo "GoLand has been completely uninstalled!"
