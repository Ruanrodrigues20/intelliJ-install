#!/bin/bash
# main.sh - Main menu for installing or uninstalling JetBrains IDEs

# Ask for sudo password upfront
echo "Please enter your password to continue:"
if ! sudo -v; then
    echo "Sudo authentication failed."
    exit 1
fi
echo "Authentication successful."

# Load variables from dependencies.sh
source ./src/dependices.sh

clear
echo "==============================="
echo "   JetBrains IDE Manager"
echo "==============================="

# First menu: install, uninstall, or exit
echo "Choose an action:"
echo "1) Install"
echo "2) Uninstall"
echo "3) Exit"
read -rp "Enter the number of the action: " ACTION

case $ACTION in
    1) ACTION_TYPE="install" ;;
    2) ACTION_TYPE="uninstall" ;;
    3) exit 0 ;;
    *)
        echo "Invalid option. Exiting..."
        exit 1
        ;;
esac

# Second menu: which IDE
echo "Which IDE do you want to process?"
echo "1) IntelliJ Ultimate"
echo "2) PyCharm Pro"
echo "3) GoLand"
echo "4) All"
read -rp "Enter the number of the IDE: " IDE_CHOICE

case $IDE_CHOICE in
    1) IDES=("intellij") ;;
    2) IDES=("pycharm") ;;
    3) IDES=("goland") ;;
    4) IDES=("intellij" "pycharm" "goland") ;;
    *)
        echo "Invalid option. Exiting..."
        exit 1
        ;;
esac

# Run the corresponding scripts
for IDE in "${IDES[@]}"; do
    case $ACTION_TYPE in
        install)
            echo "Installing $IDE..."
            if [[ $IDE == "intellij" ]]; then
                ./src/core/intellij/install.sh
            elif [[ $IDE == "pycharm" ]]; then
                ./src/core/pycharm/install.sh
            else
                ./src/core/goland/install.sh
            fi
            ;;
        uninstall)
            echo "Uninstalling $IDE..."
            if [[ $IDE == "intellij" ]]; then
                ./src/core/intellij/unistall.sh
            elif [[ $IDE == "pycharm" ]]; then
                ./src/core/pycharm/unistall.sh
            else
                ./src/core/goland/unistall.sh
            fi
            ;;
    esac
done

echo "==============================="
echo "Operation completed!"
