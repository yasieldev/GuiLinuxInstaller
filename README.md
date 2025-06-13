# GUI Installer for Debian & Derivatives

A simple Bash script that lets you choose and install one of dozens of popular desktop environments or window managers on Debian, Ubuntu and related distributions.

## Supported Environments

| No. | Name        | Package                  | Description                              | System Requirements         |
|----:|-------------|--------------------------|------------------------------------------|-----------------------------|
|  1  | GNOME       | `task-gnome-desktop`     | Full-featured, modern UI with GTK3/4     | ≥ 4 GB RAM, dual-core CPU   |
|  2  | KDE Plasma  | `task-kde-desktop`       | Highly customizable Qt-based desktop     | ≥ 3 GB RAM, dual-core CPU   |
|  3  | Xfce        | `task-xfce-desktop`      | Lightweight GTK2/3 desktop, snappy       | ≥ 1 GB RAM, single-core CPU |
|  4  | LXDE        | `task-lxde-desktop`      | Very lightweight GTK2 desktop            | ≥ 512 MB RAM, single-core   |
|  5  | LXQt        | `task-lxqt-desktop`      | Lightweight Qt5 desktop                  | ≥ 1 GB RAM, single-core     |
|  6  | MATE        | `task-mate-desktop`      | Traditional GNOME2-style desktop         | ≥ 1.5 GB RAM, single-core   |
|  7  | Cinnamon    | `cinnamon`               | Modern GNOME-fork with effects           | ≥ 2 GB RAM, dual-core CPU   |
|  8  | Budgie      | `budgie-desktop`         | Elegant, GNOME-based desktop by Solus    | ≥ 2 GB RAM, dual-core CPU   |
|  9  | Deepin      | `deepin-desktop-environment` | Slick, eye-candy desktop from Deepin     | ≥ 3 GB RAM, dual-core CPU   |
| 10  | Enlightenment | `enlightenment`        | Eye-candy, lightweight window manager    | ≥ 1 GB RAM, single-core CPU |
| 11  | Trinity     | `task-trinity-desktop`   | KDE3-based legacy desktop                | ≥ 1 GB RAM, single-core CPU |
| 12  | i3          | `i3`                     | Tiling window manager, keyboard-driven   | ≥ 256 MB RAM, minimal CPU   |
| 13  | Awesome     | `awesome`                | Highly configurable tiling WM            | ≥ 256 MB RAM, minimal CPU   |
| 14  | BSPWM       | `bspwm`                  | Scriptable BSP tiling window manager     | ≥ 256 MB RAM, minimal CPU   |
| 15  | Openbox     | `openbox`                | Fast, stacking window manager            | ≥ 256 MB RAM, minimal CPU   |
| 16  | Fluxbox     | `fluxbox`                | Lightweight stacking window manager      | ≥ 256 MB RAM, minimal CPU   |
| 17  | IceWM       | `icewm`                  | Classic X11 window manager               | ≥ 256 MB RAM, minimal CPU   |
| 18  | WindowMaker | `windowmaker`            | NeXTSTEP-style window manager            | ≥ 256 MB RAM, minimal CPU   |
| 19  | Blackbox    | `blackbox`               | Minimalistic C++-based WM                | ≥ 256 MB RAM, minimal CPU   |
| 20  | JWM         | `jwm`                    | Joe’s Window Manager: lightweight C-based| ≥ 256 MB RAM, minimal CPU   |
| 21  | Sugar       | `sugar`                  | Education-focused GNOME-fork             | ≥ 1 GB RAM, single-core CPU |


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
