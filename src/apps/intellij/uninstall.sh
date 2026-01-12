#!/usr/bin/env bash
set -euo pipefail

export APP_NAME="IntelliJ IDEA Ultimate"
export APP_ID="intellij-idea"
export INSTALL_DIR="/opt/intellij-idea"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../utils/uninstall_common.sh"
