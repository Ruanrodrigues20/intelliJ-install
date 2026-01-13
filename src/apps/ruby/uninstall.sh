#!/usr/bin/env bash
set -euo pipefail

# ===============================
# RubyMine config for uninstallation
# ===============================
export APP_NAME="RubyMine"
export APP_ID="rubymine"
export INSTALL_DIR="/opt/rubymine"


# Rodar desinstalador genérico
bash "src/lib/uninstall_common.sh"
