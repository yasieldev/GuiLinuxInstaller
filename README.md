# GUI Installer for Debian & Derivatives

A simple Bash script that lets you choose and install one of dozens of popular desktop environments or window managers on Debian, Ubuntu and related distributions.

## Supported Environments

| No. | Name                         | Package                      |
|-----|------------------------------|------------------------------|
|  1  | GNOME                        | `task-gnome-desktop`         |
|  2  | KDE Plasma                   | `task-kde-desktop`           |
|  3  | Xfce                         | `task-xfce-desktop`          |
|  4  | LXDE                         | `task-lxde-desktop`          |
|  5  | LXQt                         | `task-lxqt-desktop`          |
|  6  | MATE                         | `task-mate-desktop`          |
|  7  | Cinnamon                     | `cinnamon`                   |
|  8  | Budgie                       | `budgie-desktop`             |
|  9  | Deepin                       | `deepin-desktop-environment` |
| 10  | Enlightenment                | `enlightenment`              |
| 11  | Trinity                      | `task-trinity-desktop`       |
| 12  | i3 (tiling WM)               | `i3`                         |
| 13  | Awesome (tiling WM)          | `awesome`                    |
| 14  | BSPWM (tiling WM)            | `bspwm`                      |
| 15  | Openbox (stacking WM)        | `openbox`                    |
| 16  | Fluxbox (stacking WM)        | `fluxbox`                    |
| 17  | IceWM                        | `icewm`                      |
| 18  | WindowMaker                  | `windowmaker`                |
| 19  | Blackbox                     | `blackbox`                   |
| 20  | JWM                          | `jwm`                        |
| 21  | Sugar Desktop                | `sugar`                      |

## Prerequisites

- A Debian-based system (Debian, Ubuntu, Mint, etc.)  
- Root (or sudo) privileges  
- Internet connection to fetch packages  

## Installation & Usage

1. Copy or download the script:

    ```bash
    wget https://example.com/install-gui.sh -O install-gui.sh
    chmod +x install-gui.sh
    ```

2. Run the script as root:

    ```bash
    sudo ./install-gui.sh
    ```

3. Select the number corresponding to the desktop environment or window manager you want to install.  
4. Wait for the script to update apt and install the chosen meta-package.  
5. When complete, log out and choose your new session at the login screen.
