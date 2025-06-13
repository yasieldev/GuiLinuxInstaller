#!/usr/bin/env bash
#
# install-gui.sh — Debian/Ubuntu GUI & Pentest Distro Installer (30 options)
# Divided into small, medium, high resource categories
#

set -euo pipefail
IFS=$'\n\t'

# ─── Colors ───────────────────────────────────────────────────────────────
RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; BLUE="\e[34m"; RESET="\e[0m"

# ─── Pre‐checks ───────────────────────────────────────────────────────────
pre_checks() {
    [ "$EUID" -ne 0 ] && { echo -e "${RED}ERROR:${RESET} run as root"; exit 1; }
    ping -c1 8.8.8.8 &>/dev/null || { echo -e "${RED}ERROR:${RESET} no network"; exit 1; }
}

# ─── System Update / Upgrade ─────────────────────────────────────────────
update_system() {
    echo -e "${BLUE}Updating package lists...${RESET}"
    apt-get update -qq
    echo -e "${BLUE}Upgrading installed packages...${RESET}"
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
}

# ─── Add External Repos ──────────────────────────────────────────────────
add_kali_repo() {
    if ! grep -q "kali-rolling" /etc/apt/sources.list.d/kali.list 2>/dev/null; then
        echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" \
            > /etc/apt/sources.list.d/kali.list
        wget -qO - https://archive.kali.org/archive-key.asc | apt-key add -
    fi
    apt-get update -qq
}

add_parrot_repo() {
    if ! grep -q "parrot stable" /etc/apt/sources.list.d/parrot.list 2>/dev/null; then
        echo "deb https://deb.parrot.sh/parrot stable main contrib non-free" \
            > /etc/apt/sources.list.d/parrot.list
        wget -qO - https://deb.parrot.sh/parrot-key.asc | apt-key add -
    fi
    apt-get update -qq
}

# ─── Installation ────────────────────────────────────────────────────────
install_gui() {
    local pkg="$1"
    case "$pkg" in
        kali-desktop-xfce|kali-linux-full) add_kali_repo ;;
        parrot-desktop)                    add_parrot_repo ;;
    esac
    echo -e "${GREEN}Installing ${pkg}...${RESET}"
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "$pkg"
    echo -e "${GREEN}Done installing ${pkg}.${RESET}"
}

# ─── Menu Definitions ────────────────────────────────────────────────────
# Format: Name|Package|Description|Requirements
GUIS=(
  # small (<512 MB)
  " i3               |i3                      |Tiling, keyboard-driven      |≥256 MB RAM, minimal CPU"
  " Awesome          |awesome                 |Highly configurable tiling   |≥256 MB RAM, minimal CPU"
  " BSPWM            |bspwm                   |Scriptable BSP tiling        |≥256 MB RAM, minimal CPU"
  " Openbox          |openbox                 |Fast stacking WM             |≥256 MB RAM, minimal CPU"
  " Fluxbox          |fluxbox                 |Light stacking WM            |≥256 MB RAM, minimal CPU"
  " IceWM            |icewm                   |Classic X11 WM               |≥256 MB RAM, minimal CPU"
  " WindowMaker      |windowmaker             |NeXTSTEP-style WM            |≥256 MB RAM, minimal CPU"
  " Blackbox         |blackbox                |Minimal C++ WM               |≥256 MB RAM, minimal CPU"
  " JWM              |jwm                     |Joe’s lightweight WM         |≥256 MB RAM, minimal CPU"
  # medium (512 MB–2 GB)
  " Xfce             |task-xfce-desktop       |Lightweight GTK2/3 desktop   |≥1 GB RAM, single-core CPU"
  " LXDE             |task-lxde-desktop       |Ultra-light GTK2 desktop     |≥512 MB RAM, single-core CPU"
  " LXQt             |task-lxqt-desktop       |Lightweight Qt5 desktop      |≥1 GB RAM, single-core CPU"
  " MATE             |task-mate-desktop       |GNOME2-style desktop         |≥1.5 GB RAM, single-core CPU"
  " GNOME Flashback  |gnome-session-flashback |Fallback GNOME3 session      |≥1 GB RAM, dual-core CPU"
  " Pantheon         |pantheon-shell          |elementary OS UI             |≥2 GB RAM, dual-core CPU"
  " Unity            |ubuntu-unity-desktop    |Classic Unity7 desktop       |≥2 GB RAM, dual-core CPU"
  " Sway             |sway                    |Wayland tiling WM            |≥1 GB RAM, minimal CPU"
  " River            |river                   |Minimal Wayland tiling WM    |≥512 MB RAM, minimal CPU"
  " Lumina           |lumina-desktop          |Qt-based modular UI          |≥512 MB RAM, minimal CPU"
  " UKUI             |ukui-desktop-environment|Ubuntu Kylin UI              |≥1 GB RAM, single-core CPU"
  # high (>2 GB)
  " GNOME            |task-gnome-desktop      |Full-featured modern desktop |≥4 GB RAM, dual-core CPU"
  " KDE Plasma       |task-kde-desktop        |Customizable Qt desktop      |≥3 GB RAM, dual-core CPU"
  " Cinnamon         |cinnamon                |Modern GNOME fork            |≥2 GB RAM, dual-core CPU"
  " Budgie           |budgie-desktop          |Elegant Solus-based UI       |≥2 GB RAM, dual-core CPU"
  " Deepin           |deepin-desktop-environment|Eye-candy polished DE     |≥3 GB RAM, dual-core CPU"
  " Enlightenment    |enlightenment           |Eye-candy lightweight WM     |≥1 GB RAM, single-core CPU"
  " Kali XFCE        |kali-desktop-xfce       |Official pentest distro DE   |≥2 GB RAM, dual-core CPU"
  " Kali Full        |kali-linux-full         |Complete Kali suite          |≥4 GB RAM, dual-core CPU"
  " Parrot Security  |parrot-desktop          |Debian-based security DE     |≥2 GB RAM, dual-core CPU"
  " BackBox Linux    |backbox-desktop         |Ubuntu-based pentest DE      |≥2 GB RAM, dual-core CPU"
)

print_menu() {
    echo
    echo -e "${YELLOW}Choose a GUI or pentest distro:${RESET}"
    for i in "${!GUIS[@]}"; do
        IFS='|' read -r name pkg desc req <<<"${GUIS[i]}"
        printf "  %2d) %-18s — %s (%s)\n" "$((i+1))" "$name" "$desc" "$req"
    done
    echo "   0) Exit"
    echo
}

# ─── Main ────────────────────────────────────────────────────────────────
main() {
    pre_checks

    echo -e "${BLUE}Perform system update & upgrade first?${RESET}"
    select ans in "Yes" "No"; do
        [[ $ans == "Yes" ]] && update_system
        break
    done

    while true; do
        print_menu
        read -rp "Enter choice [0-${#GUIS[@]}]: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice>=0 && choice<=${#GUIS[@]} )); then
            (( choice == 0 )) && { echo "Goodbye."; exit 0; }
            IFS='|' read -r name pkg desc req <<<"${GUIS[choice-1]}"
            install_gui "$pkg"
            echo -e "${BLUE}Done! Select '${name}' at login.${RESET}"
            exit 0
        else
            echo -e "${RED}Invalid choice, try again.${RESET}"
        fi
    done
}

main "$@"
