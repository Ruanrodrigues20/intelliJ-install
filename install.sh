#!/bin/bash


# Baixar a última versão do IntelliJ IDEA Ultimate
curl -L -O https://download-cdn.jetbrains.com/idea/ideaIU-2024.3.1.tar.gz

# Verificar se o download foi concluído
if [ ! -f ideaIU-2024.3.1.tar.gz ]; then
    echo "Erro: Download falhou. Verifique sua conexão ou o link."
    exit 1
fi

# Extrair o arquivo tar.gz
tar -xvzf ideaIU-*

# Renomear a pasta extraída para 'idea'
mv idea-* idea

# Mover a pasta para o diretório /opt
sudo mv idea /opt/intellij-idea

# Criar link simbólico para o comando 'idea'
sudo ln -s /opt/intellij-idea/bin/idea.sh /usr/local/bin/idea

# Garantir que o arquivo tenha permissões executáveis
sudo chmod +x /usr/local/bin/idea

# Criar arquivo .desktop para menu de aplicações
sudo bash -c 'cat > /usr/share/applications/intellij-idea.desktop <<EOF
[Desktop Entry]
Name=IntelliJ IDEA
Comment=Edição Comunitária do IntelliJ IDEA
Exec=/opt/intellij-idea/bin/idea.sh %f
Icon=/opt/intellij-idea/bin/idea.png
Terminal=false
Type=Application
Categories=Desenvolvimento;IDE;
StartupWMClass=jetbrains-idea
EOF'

# Atualizar banco de dados do menu de aplicativos
sudo update-desktop-database

# Limpeza do arquivo baixado
echo "Limpando arquivos temporários..."
rm ideaIU-*.tar.gz

echo "Instalação concluída! Você pode iniciar o IntelliJ IDEA com o comando 'idea' ou pelo menu de aplicativos."
