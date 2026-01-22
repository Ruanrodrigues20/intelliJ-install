#!/usr/bin/env bash
# install-deps.sh - Install dependencies for JetBrains IDE Manager

set -euo pipefail

# ===============================
# Colors
# ===============================
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${GREEN}📦 Installing dependencies for JetBrains IDE Manager...${RESET}"

# ===============================
# Detect package manager
# ===============================
if command -v apt >/dev/null 2>&1; then
    PM="apt"
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
elif command -v pacman >/dev/null 2>&1; then
    PM="pacman"
else
    echo -e "${RED}✖ No supported package manager found (apt, dnf, pacman).${RESET}"
    exit 1
fi

echo -e "${YELLOW}→ Detected package manager: $PM${RESET}"

# ===============================
# Install deps
# ===============================
case "$PM" in
    apt)
        sudo apt update
        sudo apt install -y \
            curl \
            tar \
            gzip \
        ;;

    dnf)
        sudo dnf install -y \
            curl \
            tar \
            gzip \
        ;;

    pacman)
        sudo pacman -Sy --noconfirm \
            curl \
            tar \
            gzip \
        ;;
esac

echo -e "${GREEN}✔ All dependencies installed successfully!${RESET}"
