#!/usr/bin/env bash
# src/main.sh - JetBrains IDE Manager

set -euo pipefail




# ===============================
# Colors & icons
# ===============================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

ICON_OK="✔"
ICON_ERR="✖"
ICON_WARN="⚠"
ICON_LOCK="🔐"
ICON_BOX="📦"
ICON_RUN="🚀"
ICON_IDE="💡"


# ===============================
# Bootstrap dependencies
# ===============================
DEPS_SCRIPT="src/utils/dependencies/install_dependencies.sh"

if [[ -x "$DEPS_SCRIPT" ]]; then
    echo -e "${CYAN}${ICON_BOX}${RESET} Checking and installing dependencies..."
    bash "$DEPS_SCRIPT"
else
    echo -e "${YELLOW}${ICON_WARN}${RESET} Dependency installer not found: $DEPS_SCRIPT"
fi



# ===============================
# Sudo auth (safe + keep alive)
# ===============================
if sudo -n true 2>/dev/null; then
    echo -e "${GREEN}${ICON_OK}${RESET} Sudo already authenticated."
else
    echo -e "${YELLOW}${ICON_LOCK}${RESET} Sudo authentication required."
    sudo -v || {
        echo -e "${RED}${ICON_ERR}${RESET} Sudo authentication failed."
        exit 1
    }
fi

# Keep sudo alive
while true; do
    sudo -n true
    sleep 60
done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID' EXIT

# ===============================
# Spinner
# ===============================
spinner() {
    local pid=$1
    local msg="$2"
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0

    tput civis 2>/dev/null || true
    printf "${CYAN}%s${RESET} " "$msg"

    while kill -0 "$pid" 2>/dev/null; do
        printf "\b${PURPLE}%c${RESET}" "${spin:i++%${#spin}:1}"
        sleep 0.08
    done

    printf "\b${GREEN}${ICON_OK}${RESET}\n"
    tput cnorm 2>/dev/null || true
}

# ===============================
# Paths
# ===============================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPS_DIR="$SCRIPT_DIR/apps"


# ===============================
# UI Header
# ===============================
clear
echo -e "${BOLD}${CYAN}"
echo "╔══════════════════════════════╗"
echo "║    JetBrains IDE Manager     ║"
echo "╚══════════════════════════════╝"
echo -e "${RESET}"

# ===============================
# Action menu
# ===============================
echo -e "${ICON_RUN} ${BOLD}Choose an action:${RESET}"
select ACTION_TYPE in "Install" "Uninstall" "Exit"; do
    case $REPLY in
        1) ACTION_TYPE="install"; break ;;
        2) ACTION_TYPE="unistall"; break ;; # typo mantido
        3) echo -e "${YELLOW}Bye 👋${RESET}"; exit 0 ;;
        *) echo -e "${RED}${ICON_WARN} Invalid option.${RESET}" ;;
    esac
done

# ===============================
# IDE menu
# ===============================
echo
echo -e "${ICON_IDE} ${BOLD}Which IDE do you want to process?${RESET}"
select IDE_OPTION in \
    "IntelliJ Ultimate" \
    "PyCharm Pro" \
    "GoLand" \
    "RubyMine" \
    "PyCharm + IntelliJ" \
    "All"; do

    case $REPLY in
        1) IDES=(intellij) ;;
        2) IDES=(pycharm) ;;
        3) IDES=(goland) ;;
        4) IDES=(ruby) ;;
        5) IDES=(pycharm intellij) ;;
        6) IDES=(intellij pycharm goland ruby) ;;
        *) echo -e "${RED}${ICON_WARN} Invalid option.${RESET}"; continue ;;
    esac
    break
done

# ===============================
# Runner
# ===============================
run_ide_action() {
    local ide="$1"
    local action="$2"
    local script="$APPS_DIR/$ide/${action}.sh"

    if [[ ! -f "$script" ]]; then
        echo -e "${RED}${ICON_ERR}${RESET} Script not found: ${BOLD}$script${RESET}"
        return 1
    fi

    echo -e "${CYAN}${ICON_RUN}${RESET} ${BOLD}${action^}ing${RESET} ${PURPLE}$ide${RESET}..."
    bash "$script"
}

# ===============================
# Execute
# ===============================
echo
for ide in "${IDES[@]}"; do
    run_ide_action "$ide" "$ACTION_TYPE"
done

# ===============================
# Done
# ===============================
echo
echo -e "${GREEN}${BOLD}${ICON_OK} Operation completed successfully!${RESET}"
