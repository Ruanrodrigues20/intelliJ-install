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
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../lib/uninstall_common.sh"
