#!/usr/bin/env bash
set -euo pipefail

# ===============================
# IntelliJ IDEA config
# ===============================
export APP_NAME="IntelliJ IDEA"
export APP_ID="intellij-idea"
export INSTALL_DIR="/opt/intellij-idea"
export BIN_NAME="idea"
export ICON_NAME="intellij-idea"
export STARTUP_WMCLASS="jetbrains-idea"
export DOWNLOAD_URL="$(python ../../utils/py/get_latest_version.py IIU)"

# ===============================
# Run generic installer
# ===============================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../lib/install_common.sh"
