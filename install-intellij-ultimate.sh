#!/bin/bash

# ===== CONFIG =====
DEFAULT_VERSION="2025.3"
BASE_URL="https://download-cdn.jetbrains.com/idea/"

# ===== DETECTAR VERSÃO =====
if [ -z "$1" ]; then
    echo "Nenhuma versão fornecida. Usando versão padrão: $DEFAULT_VERSION"
    VERSION="$DEFAULT_VERSION"
else
    VERSION="$1"
fi

echo "Instalando IntelliJ IDEA versão: $VERSION"

# ===== BAIXAR =====
DOWNLOAD_URL="${BASE_URL}ideaIU-${VERSION}.tar.gz"
echo "Baixando: $DOWNLOAD_URL"
curl -L -O "$DOWNLOAD_URL" || { echo "Erro no download"; exit 1; }

# ===== EXTRAIR =====
tar -xvzf "ideaIU-${VERSION}.tar.gz" || { echo "Erro ao extrair"; exit 1; }
mv idea-* idea

# ===== INSTALAR =====
sudo rm -rf /opt/intellij-idea
sudo mv idea /opt/intellij-idea

# Cria link simbólico usando o launcher nativo
sudo ln -sf /opt/intellij-idea/bin/idea /usr/local/bin/idea
sudo chmod +x /usr/local/bin/idea

# ===== CRIAR .desktop =====
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

# ===== ÍCONE DINÂMICO =====
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")

# Copiar para o tema atual
mkdir -p ~/.local/share/icons/$THEME/scalable/apps
cp /opt/intellij-idea/bin/idea.svg ~/.local/share/icons/$THEME/scalable/apps/intellij-idea.svg 2>/dev/null || true
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true

# Copiar para fallback hicolor
sudo mkdir -p /usr/share/icons/hicolor/scalable/apps
sudo cp /opt/intellij-idea/bin/idea.svg /usr/share/icons/hicolor/scalable/apps/intellij-idea.svg
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# ===== LIMPEZA =====
rm "ideaIU-${VERSION}.tar.gz"

echo "Instalação concluída!"
echo "→ Ícone integrado ao tema atual ($THEME)"
echo "→ Fallback configurado no tema 'hicolor'"
