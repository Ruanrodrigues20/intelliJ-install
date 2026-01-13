#!/usr/bin/env bash
set -euo pipefail

export APP_NAME="GoLand"
export APP_ID="goland"
export INSTALL_DIR="/opt/goland"

bash "src/utils/uninstall_common.sh"
