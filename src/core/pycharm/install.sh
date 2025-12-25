#!/bin/bash

# ===== CONFIG =====
source ./src/dependices.sh

export VERSION_IIU DOWNLOAD_URL_PYCHARM

VERSION=$VERSION_IIU


echo "Installing PyCharm Professional version: $VERSION"

echo "Baixando: $DOWNLOAD_URL_PYCHARM"
curl -L -O "$DOWNLOAD_URL_PYCHARM" || { echo "Erro no download"; exit 1; }

tar -xvzf "pycharm-professional-${VERSION}.tar.gz" || { echo "Erro ao extrair"; exit 1; }

EXTRACTED_DIR=$(find . -maxdepth 1 -type d -name "pycharm-*" | head -n 1)
mv "$EXTRACTED_DIR" pycharm


# ===== install =====
sudo rm -rf /opt/pycharm
sudo mv pycharm /opt/pycharm

sudo ln -sf /opt/pycharm/bin/pycharm.sh /usr/local/bin/pycharm
sudo chmod +x /usr/local/bin/pycharm

# ===== create .desktop =====
sudo bash -c 'cat > /usr/share/applications/pycharm-pro.desktop <<EOF
[Desktop Entry]
Name=PyCharm Pro
Comment=JetBrains PyCharm Professional
Exec=/opt/pycharm/bin/pycharm.sh %f
Icon=pycharm
Terminal=false
Type=Application
Categories=Development;IDE;
StartupWMClass=jetbrains-pycharm
EOF'

sudo update-desktop-database

THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")

mkdir -p ~/.local/share/icons/$THEME/scalable/apps
cp /opt/pycharm/bin/pycharm.svg ~/.local/share/icons/$THEME/scalable/apps/pycharm-pro.svg 2>/dev/null || true
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true

sudo mkdir -p /usr/share/icons/hicolor/scalable/apps
sudo cp /opt/pycharm/bin/pycharm.svg /usr/share/icons/hicolor/scalable/apps/pycharm-pro.svg
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor


rm pycharm-*

echo "Installation completed!"
