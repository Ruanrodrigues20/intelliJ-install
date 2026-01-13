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

UTILS_PY="src/utils/py/get_latest_version.py"

export DOWNLOAD_URL="$(python3 "$UTILS_PY" RM)"

# ===============================
# Run generic installer
# ===============================
bash "$SCRIPT_DIR/../lib/install_common.sh"
