#!/usr/bin/env bash
#
# install-gui.sh — Debian/Ubuntu GUI & Pentest Distro Installer (30 options)
#
# Adds ability to install standard DEs/WMs plus Kali & Parrot desktops by adding their repos.

set -euo pipefail
IFS=$'\n\t'

# Color codes
RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; BLUE="\e[34m"; RESET="\e[0m"

# List: Name|Package|Description|System Requirements
GUIS=(
    "GNOME              |task-gnome-desktop          |Full GTK3/4 desktop        |≥4 GB RAM, dual-core CPU"
    "KDE Plasma         |task-kde-desktop           |Customizable Qt desktop     |≥3 GB RAM, dual-core CPU"
    "Xfce               |task-xfce-desktop          |Lightweight GTK2/3 desktop  |≥1 GB RAM, single-core CPU"
    "LXDE               |task-lxde-desktop          |Ultra-light GTK2 desktop    |≥512 MB RAM, single-core CPU"
    "LXQt               |task-lxqt-desktop          |Lightweight Qt5 desktop     |≥1 GB RAM, single-core CPU"
    "MATE               |task-mate-desktop          |GNOME2-style desktop        |≥1.5 GB RAM, single-core CPU"
    "Cinnamon           |cinnamon                   |Modern GNOME fork           |≥2 GB RAM, dual-core CPU"
    "Budgie             |budgie-desktop             |Elegant Solus-based UI      |≥2 GB RAM, dual-core CPU"
    "Deepin             |deepin-desktop-environment  |Eye-candy, polished DE      |≥3 GB RAM, dual-core CPU"
    "Enlightenment      |enlightenment              |Eye-candy lightweight WM    |≥1 GB RAM, single-core CPU"
    "i3 (tiling WM)     |i3                         |Keyboard-driven tiling WM   |≥256 MB RAM, minimal CPU"
    "Awesome (tiling WM)|awesome                    |Highly configurable tiling  |≥256 MB RAM, minimal CPU"
    "BSPWM (tiling WM)  |bspwm                      |Scriptable BSP tiling WM    |≥256 MB RAM, minimal CPU"
    "Openbox (stacking) |openbox                    |Fast stacking WM            |≥256 MB RAM, minimal CPU"
    "Fluxbox (stacking) |fluxbox                    |Light stacking WM           |≥256 MB RAM, minimal CPU"
    "IceWM              |icewm                      |Classic X11 window manager  |≥256 MB RAM, minimal CPU"
    "WindowMaker        |windowmaker                |NeXTSTEP-style WM           |≥256 MB RAM, minimal CPU"
    "Blackbox           |blackbox                   |Minimalistic C++ WM         |≥256 MB RAM, minimal CPU"
    "JWM                |jwm                        |Joe’s lightweight WM        |≥256 MB RAM, minimal CPU"
    "Sugar Desktop      |sugar                      |Education-focused GNOME fork|≥1 GB RAM, single-core CPU"
    "GNOME Flashback    |gnome-session-flashback    |Fallback GNOME3 session     |≥1 GB RAM, dual-core CPU"
    "Pantheon           |pantheon-shell             |elementary OS UI            |≥2 GB RAM, dual-core CPU"
    "Ubuntu Unity       |ubuntu-unity-desktop       |Classic Unity7 desktop      |≥2 GB RAM, dual-core CPU"
    "Sway (Wayland WM)  |sway                       |Modern Wayland tiling WM    |≥1 GB RAM, minimal CPU"
    "River (Wayland WM) |river                      |Minimal Wayland tiling WM   |≥512 MB RAM, minimal CPU"
    "Wayfire (Wayland)  |wayfire                    |3D Wayland compositor       |≥2 GB RAM, dual-core CPU"
    "Lumina             |lumina-desktop             |Qt-based modular UI         |≥512 MB RAM, minimal CPU"
    "Kali Linux         |kali-desktop-xfce          |Official pentest distro DE  |≥2 GB RAM, dual-core CPU"
    "Parrot OS          |parrot-desktop             |Security Debian-based DE    |≥2 GB RAM, dual-core CPU"
)

print_menu() {
    echo
    echo -e "${YELLOW}Select a desktop environment, WM or pentest distro to install:${RESET}"
    for i in "${!GUIS[@]}"; do
        IFS='|' read -r name pkg desc req <<<"${GUIS[i]}"
        printf "  %2d) %-18s — %s (%s)\n" "$((i+1))" "$name" "$desc" "$req"
    done
    echo "   0) Exit"
    echo
}

read_choice() {
    read -rp "Enter choice [0-${#GUIS[@]}]: " choice
    echo "$choice"
}

pre_checks() {
    [ "$EUID" -ne 0 ] && { echo -e "${RED}Error:${RESET} run as root"; exit 1; }
    ping -c1 1.1.1.1 &>/dev/null || { echo -e "${RED}Error:${RESET} no network"; exit 1; }
}

update_system() {
    echo -e "${BLUE}Updating & upgrading system...${RESET}"
    apt-get update -qq
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
}

add_kali_repo() {
    if [ ! -f /etc/apt/sources.list.d/kali.list ]; then
        echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" \
            > /etc/apt/sources.list.d/kali.list
        wget -qO - https://archive.kali.org/archive-key.asc | apt-key add -
    fi
    apt-get update -qq
}

add_parrot_repo() {
    if [ ! -f /etc/apt/sources.list.d/parrot.list ]; then
        echo "deb https://deb.parrot.sh/parrot stable main contrib non-free" \
            > /etc/apt/sources.list.d/parrot.list
        wget -qO - https://deb.parrot.sh/parrot-key.asc | apt-key add -
    fi
    apt-get update -qq
}

install_gui() {
    local pkg="$1"
    case "$pkg" in
        kali-desktop-xfce) add_kali_repo ;;
        parrot-desktop)    add_parrot_repo ;;
    esac
    echo -e "${GREEN}Installing${RESET} ${pkg}..."
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "$pkg"
    echo -e "${GREEN}Finished installing${RESET} ${pkg}."
}

main() {
    pre_checks

    echo -e "${BLUE}Perform system update & upgrade?${RESET}"
    select yn in "Yes" "No"; do
        [[ $yn == "Yes" ]] && update_system
        break
    done

    while true; do
        print_menu
        CHOICE=$(read_choice)
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && ((CHOICE>=0 && CHOICE<=${#GUIS[@]})); then
            ((CHOICE==0)) && { echo "Goodbye."; exit 0; }
            IFS='|' read -r name pkg desc req <<<"${GUIS[CHOICE-1]}"
            install_gui "$pkg"
            echo -e "${BLUE}All done!${RESET} Log out or reboot and select '${name}'."
            exit 0
        else
            echo -e "${RED}Invalid choice, try again.${RESET}"
        fi
    done
}

main "$@"
