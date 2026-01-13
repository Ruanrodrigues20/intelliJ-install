#!/usr/bin/env bash
set -euo pipefail

# ===============================
# PyCharm uninstall config
# ===============================
export APP_NAME="PyCharm Professional"
export APP_ID="pycharm"
export INSTALL_DIR="/opt/pycharm"

# ===============================
# Run generic uninstaller
# ===============================
bash "src/lib/uninstall_common.sh"
