# GUI Installer for Debian & Derivatives
#### Author: Bocaletto Luca

A simple Bash script that lets you choose and install one of dozens of popular desktop environments or window managers on Debian, Ubuntu and related distributions.

## Supported Environments

| No | Name                | Package                    | Description                               | System Requirements            |
|----|---------------------|----------------------------|-------------------------------------------|--------------------------------|
|  1 | i3                  | i3                         | Tiling window manager, keyboard‐driven    | ≥256 MB RAM, minimal CPU       |
|  2 | Awesome             | awesome                    | Highly configurable tiling WM             | ≥256 MB RAM, minimal CPU       |
|  3 | BSPWM               | bspwm                      | Scriptable BSP tiling WM                  | ≥256 MB RAM, minimal CPU       |
|  4 | Openbox             | openbox                    | Fast stacking window manager              | ≥256 MB RAM, minimal CPU       |
|  5 | Fluxbox             | fluxbox                    | Lightweight stacking window manager       | ≥256 MB RAM, minimal CPU       |
|  6 | IceWM               | icewm                      | Classic X11 window manager                | ≥256 MB RAM, minimal CPU       |
|  7 | WindowMaker         | windowmaker                | NeXTSTEP‐style window manager             | ≥256 MB RAM, minimal CPU       |
|  8 | Blackbox            | blackbox                   | Minimalistic C++ window manager           | ≥256 MB RAM, minimal CPU       |
|  9 | JWM                 | jwm                        | Joe’s lightweight window manager          | ≥256 MB RAM, minimal CPU       |
| 10 | Xfce                | task-xfce-desktop          | Lightweight GTK2/3 desktop                | ≥1 GB RAM, single‐core CPU     |
| 11 | LXDE                | task-lxde-desktop          | Ultra‐light GTK2 desktop                  | ≥512 MB RAM, single‐core CPU   |
| 12 | LXQt                | task-lxqt-desktop          | Lightweight Qt5 desktop                   | ≥1 GB RAM, single‐core CPU     |
| 13 | MATE                | task-mate-desktop          | Traditional GNOME2‐style desktop          | ≥1.5 GB RAM, single‐core CPU   |
| 14 | GNOME Flashback     | gnome-session-flashback    | Fallback GNOME3 session                   | ≥1 GB RAM, dual‐core CPU       |
| 15 | Pantheon            | pantheon-shell             | elementary OS UI                          | ≥2 GB RAM, dual‐core CPU       |
| 16 | Unity               | ubuntu-unity-desktop       | Classic Unity 7 desktop                   | ≥2 GB RAM, dual‐core CPU       |
| 17 | Sway                | sway                       | Wayland tiling window manager             | ≥1 GB RAM, minimal CPU         |
| 18 | River               | river                      | Minimal Wayland tiling WM                 | ≥512 MB RAM, minimal CPU       |
| 19 | Lumina              | lumina-desktop             | Qt‐based modular UI                       | ≥512 MB RAM, minimal CPU       |
| 20 | UKUI                | ukui-desktop-environment   | Ubuntu Kylin UI                           | ≥1 GB RAM, single‐core CPU     |
| 21 | GNOME               | task-gnome-desktop         | Full-featured modern GTK3/4 desktop       | ≥4 GB RAM, dual‐core CPU       |
| 22 | KDE Plasma          | task-kde-desktop           | Highly customizable Qt desktop            | ≥3 GB RAM, dual‐core CPU       |
| 23 | Cinnamon            | cinnamon                   | Modern GNOME fork with effects            | ≥2 GB RAM, dual‐core CPU       |
| 24 | Budgie              | budgie-desktop             | Elegant, Solus-based desktop              | ≥2 GB RAM, dual‐core CPU       |
| 25 | Deepin              | deepin-desktop-environment | Slick, eye-candy desktop                  | ≥3 GB RAM, dual‐core CPU       |
| 26 | Enlightenment       | enlightenment              | Eye-candy lightweight window manager      | ≥1 GB RAM, single‐core CPU     |
| 27 | Kali XFCE           | kali-desktop-xfce          | Official pen-test distro (XFCE)           | ≥2 GB RAM, dual‐core CPU       |
| 28 | Kali Full           | kali-linux-full            | Complete Kali penetration testing suite   | ≥4 GB RAM, dual‐core CPU       |
| 29 | Parrot Security     | parrot-desktop             | Debian-based security & pen-test desktop  | ≥2 GB RAM, dual‐core CPU       |
| 30 | BackBox Linux       | backbox-desktop            | Ubuntu-based penetration testing desktop  | ≥2 GB RAM, dual‐core CPU       |


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
