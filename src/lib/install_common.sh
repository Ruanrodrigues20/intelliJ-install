#!/usr/bin/env bash
set -euo pipefail

# ===============================
# VALIDATION
# ===============================
REQUIRED_VARS=(
  APP_NAME
  APP_ID
  INSTALL_DIR
  BIN_NAME
  ICON_NAME
  STARTUP_WMCLASS
  DOWNLOAD_URL
)

for var in "${REQUIRED_VARS[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    echo "❌ Missing env var: $var"
    exit 1
  fi
done

TMP_DIR="$(mktemp -d)"

echo "🚀 Installing $APP_NAME"
echo "→ Install dir: $INSTALL_DIR"
echo "→ Download: $DOWNLOAD_URL"

# ===============================
# DOWNLOAD
# ===============================
cd "$TMP_DIR"
echo "⬇️  Downloading..."
curl -L --progress-bar -o "${APP_ID}.tar.gz" "$DOWNLOAD_URL"

# ===============================
# EXTRACT
# ===============================
echo "📦 Extracting..."
tar -xzf "${APP_ID}.tar.gz"

EXTRACTED_DIR="$(find . -maxdepth 1 -type d -name '*' | tail -n +2 | head -n 1)"
if [[ -z "$EXTRACTED_DIR" ]]; then
  echo "❌ Could not detect extracted directory"
  exit 1
fi

# ===============================
# INSTALL
# ===============================
echo "📂 Installing to $INSTALL_DIR"
sudo rm -rf "$INSTALL_DIR"
sudo mv "$EXTRACTED_DIR" "$INSTALL_DIR"

# ===============================
# SYMLINK
# ===============================
echo "🔗 Creating symlink"
sudo ln -sf "$INSTALL_DIR/bin/$BIN_NAME" "/usr/local/bin/$APP_ID"
sudo chmod +x "/usr/local/bin/$APP_ID"

# ===============================
# DESKTOP ENTRY
# ===============================
echo "🖥️  Creating .desktop entry"
sudo bash -c "cat > /usr/share/applications/${APP_ID}.desktop <<EOF
[Desktop Entry]
Name=$APP_NAME
Comment=JetBrains $APP_NAME Ultimate
Exec=$INSTALL_DIR/bin/$BIN_NAME %f
Icon=$ICON_NAME
Terminal=false
Type=Application
Categories=Development;IDE;
StartupWMClass=$STARTUP_WMCLASS
EOF"

sudo update-desktop-database

# ===============================
# ICON
# ===============================
ICON_SRC="$(find "$INSTALL_DIR/bin" -name '*.svg' | head -n1)"
THEME="$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")"

echo "🎨 Installing icon ($THEME)"

mkdir -p "$HOME/.local/share/icons/$THEME/scalable/apps"
cp "$ICON_SRC" "$HOME/.local/share/icons/$THEME/scalable/apps/$ICON_NAME.svg" 2>/dev/null || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/$THEME" 2>/dev/null || true

sudo mkdir -p /usr/share/icons/hicolor/scalable/apps
sudo cp "$ICON_SRC" "/usr/share/icons/hicolor/scalable/apps/$ICON_NAME.svg"
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# ===============================
# CLEANUP
# ===============================
rm -rf "$TMP_DIR"

echo "✅ $APP_NAME installed successfully!"
echo "→ Binary: /usr/local/bin/$APP_ID"
