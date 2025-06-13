#!/usr/bin/env bash
#
# install-gui.sh — Debian/Ubuntu GUI Installer with Descriptions & Requirements (30 options)
#

set -euo pipefail
IFS=$'\n\t'

# Color codes
RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; BLUE="\e[34m"; RESET="\e[0m"

# List: Name|Package|Description|System Requirements
GUIS=(
    "GNOME|task-gnome-desktop|Full-featured modern GTK3/4 UI|≥4 GB RAM, dual-core CPU"
    "KDE Plasma|task-kde-desktop|Customizable Qt-based desktop|≥3 GB RAM, dual-core CPU"
    "Xfce|task-xfce-desktop|Lightweight GTK2/3 desktop|≥1 GB RAM, single-core CPU"
    "LXDE|task-lxde-desktop|Very lightweight GTK2 desktop|≥512 MB RAM, single-core CPU"
    "LXQt|task-lxqt-desktop|Lightweight Qt5 desktop|≥1 GB RAM, single-core CPU"
    "MATE|task-mate-desktop|Traditional GNOME2-style desktop|≥1.5 GB RAM, single-core CPU"
    "Cinnamon|cinnamon|Modern GNOME fork with effects|≥2 GB RAM, dual-core CPU"
    "Budgie|budgie-desktop|Elegant Solus-based desktop|≥2 GB RAM, dual-core CPU"
    "Deepin|deepin-desktop-environment|Slick, eye-candy desktop|≥3 GB RAM, dual-core CPU"
    "Enlightenment|enlightenment|Eye-candy lightweight WM|≥1 GB RAM, single-core CPU"
    "Trinity|task-trinity-desktop|KDE3 legacy desktop|≥1 GB RAM, single-core CPU"
    "i3|i3|Tiling window manager, keyboard-driven|≥256 MB RAM, minimal CPU"
    "Awesome|awesome|Highly configurable tiling WM|≥256 MB RAM, minimal CPU"
    "BSPWM|bspwm|Scriptable BSP tiling WM|≥256 MB RAM, minimal CPU"
    "Openbox|openbox|Fast stacking WM|≥256 MB RAM, minimal CPU"
    "Fluxbox|fluxbox|Light stacking WM|≥256 MB RAM, minimal CPU"
    "IceWM|icewm|Classic X11 WM|≥256 MB RAM, minimal CPU"
    "WindowMaker|windowmaker|NeXTSTEP-style WM|≥256 MB RAM, minimal CPU"
    "Blackbox|blackbox|Minimalistic C++ WM|≥256 MB RAM, minimal CPU"
    "JWM|jwm|Joe's lightweight WM|≥256 MB RAM, minimal CPU"
    "Sugar|sugar|Education-focused GNOME fork|≥1 GB RAM, single-core CPU"
    "GNOME Flashback|gnome-session-flashback|GNOME fallback session on GTK3|≥1 GB RAM, dual-core CPU"
    "Pantheon|pantheon-shell|elementary OS UI, GTK3|≥2 GB RAM, dual-core CPU"
    "Ubuntu Unity|ubuntu-unity-desktop|Classic Unity 7 desktop|≥2 GB RAM, dual-core CPU"
    "Sway|sway|Wayland tiling WM|≥1 GB RAM, minimal CPU"
    "River|river|Minimal Wayland tiling WM|≥512 MB RAM, minimal CPU"
    "Wayfire|wayfire|3D Wayland compositor|≥2 GB RAM, dual-core CPU"
    "Lumina|lumina-desktop|Qt-based modular UI|≥512 MB RAM, minimal CPU"
    "UKUI|ukui-desktop-environment|Ubuntu Kylin UI|≥1 GB RAM, single-core CPU"
)

print_menu() {
    echo
    echo -e "${YELLOW}Select a desktop environment or window manager to install:${RESET}"
    for i in "${!GUIS[@]}"; do
        IFS='|' read -r name pkg desc req <<<"${GUIS[i]}"
        printf "  %2d) %-18s — %s (%s)\n" "$((i+1))" "$name" "$desc" "$req"
    done
    echo "   0) Exit"
    echo
}

read_choice() {
    local choice
    read -rp "Enter choice [0-${#GUIS[@]}]: " choice
    echo "$choice"
}

pre_checks() {
    [ "$EUID" -ne 0 ] && { echo -e "${RED}Error:${RESET} run as root"; exit 1; }
    ping -c1 8.8.8.8 &>/dev/null || { echo -e "${RED}Error:${RESET} no network"; exit 1; }
}

update_system() {
    echo -e "${BLUE}Updating package lists...${RESET}"
    apt-get update -qq
    echo -e "${BLUE}Upgrading packages...${RESET}"
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
}

install_gui() {
    local pkg="$1"
    echo -e "${GREEN}Installing ${pkg}...${RESET}"
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "$pkg"
    echo -e "${GREEN}Done installing ${pkg}.${RESET}"
}

main() {
    pre_checks

    echo -e "${BLUE}Perform system update & upgrade first?${RESET}"
    select yn in "Yes" "No"; do
        [[ $yn == "Yes" ]] && update_system
        break
    done

    while true; do
        print_menu
        CHOICE=$(read_choice)
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && ((CHOICE>=0 && CHOICE<=${#GUIS[@]})); then
            ((CHOICE==0)) && { echo "Exiting."; exit 0; }
            IFS='|' read -r name pkg desc req <<<"${GUIS[CHOICE-1]}"
            install_gui "$pkg"
            echo -e "${BLUE}Installation complete!${RESET} Log out and select '${name}' session."
            exit 0
        else
            echo -e "${RED}Invalid choice, try again.${RESET}"
        fi
    done
}

main "$@"
