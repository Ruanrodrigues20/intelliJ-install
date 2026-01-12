#!/usr/bin/env bash
set -euo pipefail

# ===============================
# VALIDATION
# ===============================
REQUIRED_VARS=(
  APP_NAME
  APP_ID
  INSTALL_DIR
)

for var in "${REQUIRED_VARS[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    echo "❌ Missing env var: $var"
    exit 1
  fi
done

echo "🗑️  Uninstalling $APP_NAME"

# ===============================
# REMOVE INSTALL DIR
# ===============================
if [[ -d "$INSTALL_DIR" ]]; then
  echo "📂 Removing install dir: $INSTALL_DIR"
  sudo rm -rf "$INSTALL_DIR"
else
  echo "⚠️  Install dir not found: $INSTALL_DIR"
fi

# ===============================
# REMOVE SYMLINK
# ===============================
if [[ -L "/usr/local/bin/$APP_ID" ]]; then
  echo "🔗 Removing symlink: /usr/local/bin/$APP_ID"
  sudo rm -f "/usr/local/bin/$APP_ID"
else
  echo "⚠️  Symlink not found: /usr/local/bin/$APP_ID"
fi

# ===============================
# REMOVE DESKTOP ENTRY
# ===============================
if [[ -f "/usr/share/applications/${APP_ID}.desktop" ]]; then
  echo "🖥️  Removing desktop entry"
  sudo rm -f "/usr/share/applications/${APP_ID}.desktop"
else
  echo "⚠️  Desktop entry not found"
fi


gtk-update-icon-cache -f -t "$HOME/.local/share/icons/$THEME" 2>/dev/null || true
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor 2>/dev/null || true

echo "✅ $APP_NAME uninstalled successfully!"
