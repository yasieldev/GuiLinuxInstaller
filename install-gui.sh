#!/usr/bin/env bash
# Author: Bocaletto Luca
# install-gui.sh
# Debian/Ubuntu derivative script to choose & install
# popular desktop environments and window managers.
#

set -e

# Ensure running as root
if [ "$EUID" -ne 0 ]; then
        echo "Please run as root: sudo $0"
        exit 1
fi

# name|package pairs
GUIS=(
    "GNOME|task-gnome-desktop"
    "KDE Plasma|task-kde-desktop"
    "Xfce|task-xfce-desktop"
    "LXDE|task-lxde-desktop"
    "LXQt|task-lxqt-desktop"
    "MATE|task-mate-desktop"
    "Cinnamon|cinnamon"
    "Budgie|budgie-desktop"
    "Deepin|deepin-desktop-environment"
    "Enlightenment|enlightenment"
    "Trinity|task-trinity-desktop"
    "i3 (tiling WM)|i3"
    "Awesome (tiling WM)|awesome"
    "BSPWM (tiling WM)|bspwm"
    "Openbox (stacking WM)|openbox"
    "Fluxbox (stacking WM)|fluxbox"
    "IceWM|icewm"
    "WindowMaker|windowmaker"
    "Blackbox|blackbox"
    "JWM|jwm"
    "Sugar Desktop|sugar"
)

print_menu() {
        echo
        echo "Select a desktop or window manager to install:"
        for i in "${!GUIS[@]}"; do
                name="${GUIS[i]%%|*}"
                printf "  %2d) %s\n" "$((i+1))" "$name"
        done
        echo "   0) Exit"
        echo
}

read_choice() {
        read -rp "Enter choice [0-${#GUIS[@]}]: " choice
        echo "$choice"
}

install_gui() {
        local pkg="$1"
        echo
        echo "Updating package lists…"
        apt-get update -qq
        echo "Installing $pkg…"
        apt-get install -y "$pkg"
        echo "Done installing $pkg."
}

# Main loop
while true; do
        print_menu
        CHOICE=$(read_choice)
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 0 ] && [ "$CHOICE" -le "${#GUIS[@]}" ]; then
                if [ "$CHOICE" -eq 0 ]; then
                        echo "Exiting."
                        exit 0
                fi
                entry="${GUIS[$((CHOICE-1))]}"
                pkg="${entry##*|}"
                install_gui "$pkg"
                echo "Installation complete. Log out and select your new session."
                exit 0
        else
                echo "Invalid choice. Please enter 0–${#GUIS[@]}."
        fi
done
