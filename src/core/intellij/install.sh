#!/bin/bash

# ===== CONFIG =====
source ./src/dependices.sh
export VERSION_IIU BASE_URL_JAVA DOWNLOAD_URL_INTELLIJ

VERSION=$VERSION_IIU
DOWNLOAD_URL=$DOWNLOAD_URL_INTELLIJ

echo "Installing IntelliJ IDEA version: $VERSION"

# ===== DOWNLOAD =====
echo "Downloading: $DOWNLOAD_URL_INTELLIJ"
mkdir -p temp
cd temp
curl -L -O "$DOWNLOAD_URL_INTELLIJ" || { echo "Download failed"; exit 1; }

# ===== EXTRACT =====
tar -xvzf "ideaIU-${VERSION}.tar.gz" || { echo "Extraction failed"; exit 1; }
mv idea-* idea

# ===== INSTALL =====
sudo rm -rf /opt/intellij-idea
sudo mv idea /opt/intellij-idea

cd ..
rm -rf temp

# Create symbolic link for native launcher
sudo ln -sf /opt/intellij-idea/bin/idea /usr/local/bin/idea
sudo chmod +x /usr/local/bin/idea

# ===== CREATE .desktop FILE =====
sudo bash -c 'cat > /usr/share/applications/intellij-idea.desktop <<EOF
[Desktop Entry]
Name=IntelliJ IDEA
Comment=JetBrains IntelliJ IDEA Ultimate
Exec=/opt/intellij-idea/bin/idea %f
Icon=intellij-idea
Terminal=false
Type=Application
Categories=Development;IDE;
StartupWMClass=jetbrains-idea
EOF'

sudo update-desktop-database

# ===== DYNAMIC ICON =====
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")

# Copy to current theme
mkdir -p ~/.local/share/icons/$THEME/scalable/apps
cp /opt/intellij-idea/bin/idea.svg ~/.local/share/icons/$THEME/scalable/apps/intellij-idea.svg 2>/dev/null || true
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true

# Copy to fallback hicolor theme
sudo mkdir -p /usr/share/icons/hicolor/scalable/apps
sudo cp /opt/intellij-idea/bin/idea.svg /usr/share/icons/hicolor/scalable/apps/intellij-idea.svg
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# ===== CLEANUP =====
rm "ideaIU-${VERSION}.tar.gz"

echo "Installation completed!"
echo "→ Icon integrated into current theme ($THEME)"
echo "→ Fallback icon configured in 'hicolor' theme"
