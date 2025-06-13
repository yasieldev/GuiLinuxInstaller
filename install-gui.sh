#!/usr/bin/env bash
# Author: Bocaletto Luca
# install-gui.sh
# Debian/Ubuntu derivative script to choose & install
# popular desktop environments and window managers.
#

set -euo pipefail
IFS=$'\n\t'

LOG_FILE="/var/log/install-gui.log"
DATE_FMT="+%Y-%m-%d %H:%M:%S"

# === Color definitions ===
RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; BLUE="\e[34m"; RESET="\e[0m"

# === Cleanup on exit ===
cleanup() {
    [ -f "$TMP_FILE" ] && rm -f "$TMP_FILE"
}
trap cleanup EXIT

# === Logging function ===
log() {
    local level="$1"; shift
    local msg="$*"
    printf "%s [%s] %s\n" "$(date "$DATE_FMT")" "$level" "$msg" \
        | tee -a "$LOG_FILE"
}

error_exit() {
    log "ERROR" "$*"
    echo -e "${RED}ERROR:${RESET} $*" >&2
    exit 1
}

# === Pre‐checks ===
pre_checks() {
    # ensure root
    [ "$EUID" -ne 0 ] && error_exit "Run with sudo or as root"
    # ensure network
    ping -c1 8.8.8.8 &>/dev/null || error_exit "No network connection"
    # ensure apt unlocked
    if lsof /var/lib/dpkg/lock-frontend &>/dev/null; then
        error_exit "apt is locked by another process"
    fi
}

# === System update & upgrade ===
update_system() {
    echo -e "${BLUE}Updating package lists...${RESET}"
    log "INFO" "apt-get update"
    apt-get update -qq 2>&1 | tee -a "$LOG_FILE"
}

upgrade_system() {
    echo -e "${BLUE}Upgrading installed packages...${RESET}"
    log "INFO" "apt-get upgrade"
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq \
        2>&1 | tee -a "$LOG_FILE"
    echo -e "${BLUE}Performing full distribution upgrade...${RESET}"
    log "INFO" "apt-get dist-upgrade"
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -qq \
        2>&1 | tee -a "$LOG_FILE"
}

cleanup_system() {
    echo -e "${BLUE}Autoremoving unused packages...${RESET}"
    log "INFO" "apt-get autoremove"
    apt-get autoremove -y -qq 2>&1 | tee -a "$LOG_FILE"
    echo -e "${BLUE}Cleaning package cache...${RESET}"
    log "INFO" "apt-get autoclean"
    apt-get autoclean -qq 2>&1 | tee -a "$LOG_FILE"
}

# === Desktop environments & window managers ===
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
    echo -e "${YELLOW}Select a desktop or window manager to install:${RESET}"
    for i in "${!GUIS[@]}"; do
        name="${GUIS[i]%%|*}"
        printf "  %2d) %s\n" "$((i+1))" "$name"
    done
    echo "   0) Exit"
    echo
}

read_choice() {
    local choice
    read -rp "Enter choice [0-${#GUIS[@]}]: " choice
    echo "$choice"
}

install_gui() {
    local pkg="$1"
    echo -e "${GREEN}Installing ${pkg}...${RESET}"
    log "INFO" "apt-get install $pkg"
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "$pkg" \
        2>&1 | tee -a "$LOG_FILE"
    echo -e "${GREEN}${pkg} installation completed.${RESET}"
    log "INFO" "${pkg} installed"
}

# === Main script ===
main() {
    pre_checks

    # prompt for system maintenance
    echo -e "${BLUE}Would you like to update and upgrade your system first?${RESET}"
    select ans in "Yes" "No"; do
        case $ans in
            Yes)
                update_system
                upgrade_system
                cleanup_system
                break
                ;;
            No) break ;;
        esac
    done

    # install chosen GUI
    while :; do
        print_menu
        CHOICE=$(read_choice)
        if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 0 ] && [ "$CHOICE" -le "${#GUIS[@]}" ]; then
            if [ "$CHOICE" -eq 0 ]; then
                echo -e "${BLUE}Exiting.${RESET}"
                exit 0
            fi
            entry="${GUIS[$((CHOICE-1))]}"
            pkg="${entry##*|}"
            install_gui "$pkg"
            echo -e "${BLUE}All done! You can now reboot or log out and select '${entry%%|*}' session.${RESET}"
            exit 0
        else
            echo -e "${RED}Invalid choice! Please enter 0–${#GUIS[@]}.${RESET}"
        fi
    done
}

main "$@"
