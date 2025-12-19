#!/bin/bash

# ===== CONFIG =====
source ./src/dependices.sh
export VERSION_GO BASE_URL_GOLAND DOWNLOAD_URL_GOLAND

echo "Installing GoLand version: $VERSION"
VERSION=$VERSION_GO
DOWNLOAD_URL=$DOWNLOAD_URL_GOLAND

# ===== DOWNLOAD =====
echo "Downloading: $DOWNLOAD_URL"
mkdir -p temp
cd temp
curl -L -o "goland-${VERSION}.tar.gz" "$DOWNLOAD" || { echo "Download failed"; exit 1; }

# ===== EXTRACT =====
tar -xvzf "goland-${VERSION}.tar.gz" || { echo "Extraction failed"; exit 1; }
mv GoLand-* goland

# ===== INSTALL =====
sudo rm -rf /opt/goland
sudo mv goland /opt/goland

cd ..
rm -rf temp
# Create symbolic link for native launcher
sudo ln -sf /opt/goland/bin/goland.sh /usr/local/bin/goland
sudo chmod +x /usr/local/bin/goland

# ===== CREATE .desktop FILE =====
sudo bash -c 'cat > /usr/share/applications/goland.desktop <<EOF
[Desktop Entry]
Name=GoLand
Comment=JetBrains GoLand IDE
Exec=/opt/goland/bin/goland.sh %f
Icon=goland
Terminal=false
Type=Application
Categories=Development;IDE;
StartupWMClass=jetbrains-goland
EOF'

sudo update-desktop-database

# ===== DYNAMIC ICON =====
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")

# Copy to current theme
mkdir -p ~/.local/share/icons/$THEME/scalable/apps
cp /opt/goland/bin/goland.svg ~/.local/share/icons/$THEME/scalable/apps/goland.svg 2>/dev/null || true
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true

# Copy to fallback hicolor theme
sudo mkdir -p /usr/share/icons/hicolor/scalable/apps
sudo cp /opt/goland/bin/goland.svg /usr/share/icons/hicolor/scalable/apps/goland.svg
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# ===== CLEANUP =====
rm "goland-${VERSION}.tar.gz"

echo "Installation completed!"
echo "→ Icon integrated into current theme ($THEME)"
echo "→ Fallback icon configured in 'hicolor' theme"
