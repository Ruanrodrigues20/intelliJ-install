#!/usr/bin/env bash
set -euo pipefail

# ===============================
# RubyMine config
# ===============================
export APP_NAME="RubyMine"
export APP_ID="rubymine"
export INSTALL_DIR="/opt/rubymine"
export BIN_NAME="rubymine.sh"
export ICON_NAME="rubymine"
export STARTUP_WMCLASS="jetbrains-rubymine"

# Caminho absoluto do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_PY="$SCRIPT_DIR/../utils/py/get_latest_version.py"

# Gerar a URL mais recente
export DOWNLOAD_URL="$(python3 "$UTILS_PY" RM)"

# ===============================
# Run generic installer
# ===============================
bash "$SCRIPT_DIR/../lib/install_common.sh"
