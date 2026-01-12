#!/usr/bin/env bash
set -euo pipefail

# ===============================
# GoLand config
# ===============================
export APP_NAME="GoLand"
export APP_ID="goland"
export INSTALL_DIR="/opt/goland"
export BIN_NAME="goland.sh"
export ICON_NAME="goland"
export STARTUP_WMCLASS="jetbrains-goland"
export DOWNLOAD_URL="$(python ../../utils/py/get_latest_version.py GO)"

# ===============================
# Run generic installer
# ===============================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../lib/install_common.sh"
