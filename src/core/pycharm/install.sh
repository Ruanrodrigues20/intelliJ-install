#!/bin/bash

# ===== CONFIG =====
VERSION=$(python3 ./src/bin/get_version.py PCP)
DOWNLOAD_URL="https://download-cdn.jetbrains.com/python/pycharm-professional-${VERSION}.tar.gz"

echo "Installing PyCharm Professional version: $VERSION"

# ===== DOWNLOAD =====
mkdir -p temp
cd temp
echo "Downloading: $DOWNLOAD_URL"
curl -L -O "$DOWNLOAD_URL" || { echo "Download failed"; exit 1; }

# ===== EXTRACT =====
echo "Extracting..."
tar -xvzf "pycharm-professional-${VERSION}.tar.gz" || { echo "Extraction failed"; exit 1; }

EXTRACTED_DIR=$(find . -maxdepth 1 -type d -name "pycharm-*" | head -n 1)
mv "$EXTRACTED_DIR" pycharm

# ===== INSTALL =====
sudo rm -rf /opt/pycharm
sudo mv pycharm /opt/pycharm
cd ..
rm -rf temp

# Create symbolic link
sudo ln -sf /opt/pycharm/bin/pycharm.sh /usr/local/bin/pycharm
sudo chmod +x /usr/local/bin/pycharm

# ===== CREATE .desktop FILE =====
sudo bash -c 'cat > /usr/share/applications/pycharm-pro.desktop <<EOF
[Desktop Entry]
Name=PyCharm Pro
Comment=JetBrains PyCharm Professional
Exec=/opt/pycharm/bin/pycharm.sh %f
Icon=pycharm-pro
Terminal=false
Type=Application
Categories=Development;IDE;
StartupWMClass=jetbrains-pycharm
EOF'

sudo update-desktop-database

# ===== DYNAMIC ICON =====
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
mkdir -p ~/.local/share/icons/$THEME/scalable/apps
cp /opt/pycharm/bin/pycharm.svg ~/.local/share/icons/$THEME/scalable/apps/pycharm-pro.svg 2>/dev/null || true
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true

sudo mkdir -p /usr/share/icons/hicolor/scalable/apps
sudo cp /opt/pycharm/bin/pycharm.svg /usr/share/icons/hicolor/scalable/apps/pycharm-pro.svg
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# ===== CLEANUP =====
rm -f "pycharm-professional-${VERSION}.tar.gz"

echo "Installation completed!"
echo "→ Display name: PyCharm Pro"
echo "→ Icon integrated into current theme ($THEME)"
echo "→ Fallback icon configured in 'hicolor' theme"
