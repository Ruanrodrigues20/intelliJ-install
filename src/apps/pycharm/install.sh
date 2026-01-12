#!/usr/bin/env bash
set -euo pipefail

# ===============================
# PyCharm config for uninstallation
# ===============================
export APP_NAME="PyCharm Professional"
export APP_ID="pycharm"
export INSTALL_DIR="/opt/pycharm"

# Caminho absoluto do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Rodar desinstalador genérico
bash "$SCRIPT_DIR/../lib/uninstall_common.sh"
