#!/usr/bin/env bash
set -euo pipefail

# ===============================
# PyCharm config for uninstallation
# ===============================
export APP_NAME="PyCharm Professional"
export APP_ID="pycharm"
export INSTALL_DIR="/opt/pycharm"
export BIN_NAME="pycharm-professional.sh"
export ICON_NAME="pycharm"
export STARTUP_WMCLASS="pycharm-professional"
export DOWNLOAD_URL="$(python3 src/utils/py/get_latest_version.py PCP)"

# ===============================
# Run generic installer
# ===============================
bash "src/lib/install_common.sh"
