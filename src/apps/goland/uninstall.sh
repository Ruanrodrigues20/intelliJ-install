#!/usr/bin/env bash
set -euo pipefail

export APP_NAME="GoLand"
export APP_ID="goland"
export INSTALL_DIR="/opt/goland"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/../utils/uninstall_common.sh"
