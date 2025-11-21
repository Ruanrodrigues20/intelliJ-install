#!/bin/bash

echo "Removendo PyCharm Pro..."

# Verifica se o diretório de instalação existe
if [ -d "/opt/pycharm" ]; then
    # Remove o diretório de instalação
    sudo rm -rf /opt/pycharm
    echo "Diretório /opt/pycharm removido."
else
    echo "O PyCharm Pro não foi encontrado em /opt/pycharm."
fi

# Remove o link simbólico do comando 'pycharm'
if [ -L "/usr/local/bin/pycharm" ]; then
    sudo rm /usr/local/bin/pycharm
    echo "Link simbólico /usr/local/bin/pycharm removido."
else
    echo "Link simbólico /usr/local/bin/pycharm não encontrado."
fi

# Remove o arquivo do menu de aplicativos .desktop
if [ -f "/usr/share/applications/pycharm-pro.desktop" ]; then
    sudo rm /usr/share/applications/pycharm-pro.desktop
    echo "Arquivo do menu de aplicativos removido."
else
    echo "Arquivo do menu de aplicativos não encontrado."
fi

# Remove ícones locais (tema do usuário)
THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
USER_ICON_DIR="$HOME/.local/share/icons/$THEME/scalable/apps/pycharm-pro.svg"

if [ -f "$USER_ICON_DIR" ]; then
    rm "$USER_ICON_DIR"
    echo "Ícone do tema local removido."
fi

# Remove fallback do hicolor
if [ -f "/usr/share/icons/hicolor/scalable/apps/pycharm-pro.svg" ]; then
    sudo rm /usr/share/icons/hicolor/scalable/apps/pycharm-pro.svg
    echo "Ícone fallback (hicolor) removido."
fi

# Atualiza cache de ícones e menu
echo "Atualizando cache de ícones e banco de dados do menu..."
gtk-update-icon-cache -f -t ~/.local/share/icons/$THEME 2>/dev/null || true
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor 2>/dev/null || true
sudo update-desktop-database

echo "PyCharm Pro foi removido com sucesso!"
