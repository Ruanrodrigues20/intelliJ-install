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
export DOWNLOAD_URL="$(python3 src/utils/py/get_latest_version.py IIU)"

# ===============================
# Run generic installer
# ===============================
bash "src/lib/install_common.sh"

sudo cp /opt/pycharm/bin/pycharm.svg \
  /usr/share/icons/hicolor/scalable/apps/pycharm.svg

sudo gtk-update-icon-cache -f /usr/share/icons/hicolor

