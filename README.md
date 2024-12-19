<h1 align="center">Hyprland on ArcoLinux</h1>

<div align="center">
<img src="https://img.shields.io/github/last-commit/nawfalmrouyan/hyprland?style=for-the-badge&logo=github&color=a6da95&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/repo-size/nawfalmrouyan/hyprland?style=for-the-badge&logo=dropbox&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/license/nawfalmrouyan/hyprland?style=for-the-badge&logo=powerpages&color=cba6f7&logoColor=D9E0EE&labelColor=302D41"/>
</div>

## 🌟 Preview

![image](https://github.com/user-attachments/assets/b9a82e1a-5756-4f1e-98b0-509d0df3a890)

![image](https://github.com/user-attachments/assets/c4718ab5-9108-44c2-b326-26c3154091f2)

![image](https://github.com/user-attachments/assets/e0435737-88ed-4f20-acb2-88708c67c460)

![image](https://github.com/user-attachments/assets/1899348c-fdda-4baa-a4d0-d7e72fa8b0ab)

## Videos (old)

- https://www.youtube.com/watch?v=Ojfbjth-c84
- https://www.youtube.com/watch?v=MXOsmXXafS8

## Overview

Hyprland is a dynamic tiling Wayland compositor based on wlroots that doesn't sacrifice on its looks.

|      Label       |     Application     |
| :--------------: | :-----------------: |
| Operating System |      ArcoLinux      |
|  Window Manager  |      Hyprland       |
|    Status Bar    | hyprpanel |
|     Launcher     |        fuzzel        |
| Session Manager  |  wlogout   |
|  Notifications   |        ags         |
|     Terminal     |        Kitty        |
|   Web Browser    |       Zen       |
|      Fonts       | Fira Sans Condensed |
|                  |  Symbols Nerd Font  |
|                  |   Pragmasevka Nerd Font    |

## 🛠 Installation

If you want to install this setup on ARCH Linux or on any other distro, follow the points below:

1. Install the following programs on your computer:

- hyprland-git
- hyprcursor-git
- hypridle-git
- hyprlock-git
- xdg-desktop-hyprland-portal-git
- hyprutils-git
- hyprgraphics-git
- hyprwayland-scanner-git
- hyprland-protocols-git
- hyprpicker-git
- hyprland-qtutils-git
- hyprpaper-git
- aylurs-gtk-shell
- hyprpanel (astal branch)
- kitty
- zen-browser-avx2-bin
- grim
- slurp
- fuzzel
- rofi-wayland
- rofi-emoji-git
- rofi-calc-git
- rofi-pass
- wtype
- wl-clipboard
- catppuccin-cursors-mocha
- catppuccin-gtk-theme-mocha
- noto-fonts
- noto-fonts-cjk
- ttf-nerd-fonts-symbols
- ttf-nerd-fonts-symbols-mono
- ttf-nerd-fonts-symbols-common
- imagemagick
- hyprsunset-git
- brightnessctl
- wlogout
- playerctl
- pamixer
- libqalculate
- clipse
- uwsm
- kanata-bin
- libinput-gestures
- polkit-gnome
- socat

2. Clone the repo. Assuming you do not have Hyprland configured before, copy/move all the files in the repo to `~/.config/hypr`.

```bash
git clone --depth=1 https://github.com/nawfalmrouyan/hyprland.git ~/.config/hypr
```

3. You can start Hyprland using the command below:

```sh
uwsm start hyprland.desktop
```
Note: You can refer [here](https://wiki.hyprland.org/Useful-Utilities/Systemd-start/) for more info.

## Special thanks

- https://github.com/hyprwm/Hyprland - For an amazing WM
- https://github.com/eldermf/bspwm-hyprland - For the inspiration
- https://github.com/Ruixi-rebirth/nixos-config - Pretty neofetch config
- https://github.com/iamverysimp1e/dots - Glassmorphism effect
- https://github.com/rxyhn/dotfiles
