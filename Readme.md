# 📋 Instalação e Remoção do IntelliJ IDEA Ultimate

Este repositório contém dois scripts Bash para **instalar** e **remover** o IntelliJ IDEA Ultimate no sistema Linux.

---

## 🛠️ Scripts

1. **install.sh**: Baixa, instala e configura o IntelliJ IDEA Ultimate.
2. **uninstall.sh**: Remove completamente o IntelliJ IDEA Ultimate do sistema.

---

## 📥 Instalação

### Requisitos

- Sistema operacional Linux (Ubuntu/Debian recomendado).
- Permissões de superusuário (`sudo`).
- Conexão com a internet.

### Novidades

- **Escolha de versão**: Agora, é possível escolher a versão específica do IntelliJ IDEA a ser instalada. Ao rodar o script de instalação, você pode passar um parâmetro com a versão desejada. Caso contrário, o script instalará a versão mais recente disponível.

### Uso do Script de Instalação

1. Baixe o script `install.sh` ou copie o conteúdo para um arquivo no seu sistema.

2. Dê permissão de execução ao script:
   ```bash
   chmod +x install.sh
   ```

3. Execute o script para instalar a versão padrão (a mais recente):
   ```bash
   ./install.sh
   ```

   Ou, se você deseja instalar uma versão específica, execute o script passando o número da versão como parâmetro:
   ```bash
   ./install.sh 2024.3.1
   ```

   Pronto! O IntelliJ IDEA será instalado em `/opt/intellij-idea`. Você pode iniciá-lo:
   - Pelo terminal, com o comando: `idea`
   - Pelo menu de aplicativos, buscando IntelliJ IDEA.

---

## 🗑️ Remoção

### Uso do Script de Remoção

1. Baixe o script `uninstall.sh` ou copie o conteúdo para um arquivo no seu sistema.

2. Dê permissão de execução ao script:
   ```bash
   chmod +x uninstall.sh
   ```

3. Execute o script:
   ```bash
   ./uninstall.sh
   ```

   Pronto! O IntelliJ IDEA será removido completamente, incluindo:
   - Diretório de instalação (`/opt/intellij-idea`).
   - Link simbólico em `/usr/local/bin/idea`.
   - Arquivo do menu de aplicativos (.desktop).

---

## ⚙️ Detalhes dos Scripts

### Script de Instalação (install.sh)

- Baixa a última versão do IntelliJ IDEA Ultimate ou uma versão específica (caso seja passada como parâmetro).
- Extrai o arquivo `.tar.gz` e move o conteúdo para `/opt/intellij-idea`.
- Cria um link simbólico em `/usr/local/bin/idea` para facilitar a execução.
- Adiciona uma entrada ao menu de aplicativos (arquivo .desktop).
- Atualiza o banco de dados do menu.
- Remove o arquivo baixado após a instalação.

### Script de Remoção (uninstall.sh)

- Remove o diretório de instalação em `/opt/intellij-idea`.
- Apaga o link simbólico em `/usr/local/bin/idea`.
- Remove o arquivo .desktop do menu de aplicativos.
- Atualiza o banco de dados do menu.

---

## 🚀 Comandos Úteis

- Iniciar o IntelliJ IDEA:
  ```bash
  idea
  ```

- Verificar se o IntelliJ IDEA está instalado:
  ```bash
  ls /opt/intellij-idea
  ```

---

## 🧑‍💻 Contribuição

Sinta-se à vontade para abrir issues ou pull requests para melhorias nos scripts.

---

## 📄 Licença

Este projeto está licenciado sob a MIT License.

Desenvolvido para facilitar a instalação e remoção do IntelliJ IDEA em sistemas Linux! 🚀
