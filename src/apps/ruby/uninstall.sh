#!/usr/bin/env bash
set -euo pipefail

# ===============================
# RubyMine config for uninstallation
# ===============================
export APP_NAME="RubyMine"
export APP_ID="rubymine"
export INSTALL_DIR="/opt/rubymine"

# Caminho absoluto do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Rodar desinstalador genérico
bash "$SCRIPT_DIR/../lib/uninstall_common.sh"
