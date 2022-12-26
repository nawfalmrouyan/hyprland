<h1 align="center">Hyprland on ArcoLinux</h1>

<div align="center">
<img src="https://img.shields.io/github/last-commit/nawfalmrouyan/hyprland?style=for-the-badge&logo=github&color=a6da95&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/repo-size/nawfalmrouyan/hyprland?style=for-the-badge&logo=dropbox&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/license/nawfalmrouyan/hyprland?style=for-the-badge&logo=powerpages&color=cba6f7&logoColor=D9E0EE&labelColor=302D41"/>
</div>

## 🌟 Preview ([Video](https://youtu.be/MXOsmXXafS8))

![Screenshot_2022-12-19-13-13-42_31139](https://user-images.githubusercontent.com/10271030/208352714-e2b22e9f-2760-48e5-976f-6d6305cb3051.png)

![Screenshot_2022-12-19-13-27-10_8731](https://user-images.githubusercontent.com/10271030/208354086-d6aaf941-2108-421f-b56a-3128f7f0bfae.png)

<br />

## Overview

Hyprland is a dynamic tiling Wayland compositor based on wlroots that doesn't sacrifice on its looks.

|      Label       |        Application        |
| :--------------: | :-----------------------: |
| Operating System |         ArcoLinux         |
|  Window Manager  |         Hyprland          |
|    Status Bar    |    Waybar-hyprland-git    |
|     Launcher     |           Wofi            |
| Session Manager  |     archlinux-logout      |
|  Notifications   |           Mako            |
|     Terminal     |           Kitty           |
|   Web Browser    |          Firefox          |
|      Fonts       |    Fira Sans Condensed    |
|                  |     Symbols Nerd Font     |
|                  | IosevkaLyteTerm Nerd Font |

<br />

## 🛠 Installation

If you want to install this setup on ARCH Linux or on any other distro, follow the points below:

1. Install the following programs on your computer:

- bemenu
- grim
- hyprland-nvidia-git
- hyprpicker
- kitty
- lf
- mako
- pamixer
- polkit-gnome
- slurp
- swaybg
- swayidle
- swaylock-effects
- waybar-hyprland-git
- wf-recorder
- wl-clipboard
- wlroots
- wofi
- xbacklight
- xdg-desktop-portal-hyprland-git
- xorg-xwayland
- yad

2. Clone the repo
3. Assuming you do not have Hyprland configured before, copy/move all the files in the repo to `~/.config/hypr`.

```bash
git clone <this repository>
cd hyprland
mkdir -p ~/.config/hypr
cp -r * ~/.config/hypr
```

4. You can start Hyprland using a simple launcher script below:

```sh
#!/bin/sh

cd ~

export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

exec Hyprland
```

5. You can refer [here](https://wiki.hyprland.org/Getting-Started/Quick-start/) for more info.

<br />

## Keybinds

<br />

### General

| Keybind                                            | Description                                        |
| -------------------------------------------------- | -------------------------------------------------- |
| <kbd>SUPER</kbd> + <kbd>Return</kbd>               | Open Kitty terminal                                |
| <kbd>SUPER</kbd> + <kbd>W</kbd>                    | Open firefox in workspace 2                        |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>W</kbd> | Open WhatsApp in workspace 9 silently              |
| <kbd>SUPER</kbd> + <kbd>Q</kbd>                    | Kill focused window                                |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>Q</kbd> | Exit Hyprland                                      |
| <kbd>SUPER</kbd> + <kbd>A</kbd>                    | Open Microsoft Edge (Default Profile)              |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>A</kbd> | Open Microsoft Edge (Profile 1)                    |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>F</kbd> | Toggle fullscreen of focused window                |
| <kbd>SUPER</kbd> + <kbd>E</kbd>                    | Open lf - Terminal based file manager              |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>E</kbd> | Open Nautilus                                      |
| <kbd>SUPER</kbd> + <kbd>V</kbd>                    | Toggle floating of focused window                  |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>V</kbd> | Toggle floating on all windows                     |
| <kbd>SUPER</kbd> + <kbd>C</kbd>                    | Open application using wofi                        |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>C</kbd> | Open application using bemenu                      |
| <kbd>SUPER</kbd> + <kbd>L</kbd>                    | Toggle between Master and Dwindle layout           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>L</kbd> | Lock screen                                        |
| <kbd>SUPER</kbd> + <kbd>M</kbd>                    | Set split ratio to 0.3                             |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>M</kbd> | Set split ratio to -0.3                            |
| <kbd>SUPER</kbd> + <kbd>Escape</kbd>               | Toggle power menu (archlinux-logout)               |
| <kbd>SUPER</kbd> + <kbd>Y</kbd>                    | Set night mode on (flux)                           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>Y</kbd> | Set night mode off                                 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>O</kbd> | Color picker in RGB format                         |

<br />

### Master Layout

| Keybind                                                 | Description                                    |
| ------------------------------------------------------- | ---------------------------------------------- |
| <kbd>SUPER</kbd> + <kbd>J</kbd>                         | Cycle to next window                           |
| <kbd>SUPER</kbd> + <kbd>K</kbd>                         | Cycle to previous window                       |
| <kbd>SUPER</kbd> + <kbd>I</kbd>                         | Add focused window to Master                   |
| <kbd>SUPER</kbd> + <kbd>D</kbd>                         | Remove focused window from Master              |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>Return</kbd> | Swap current focused window with Master window |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>period</kbd> | Cycle to next master layout orientation        |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>comma</kbd>  | Cycle to previous master layout orientation    |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>Return</kbd>  | Focus master window                            |

<br />

### Dwindle Layout

| Keybind                                            | Description                     |
| -------------------------------------------------- | ------------------------------- |
| <kbd>SUPER</kbd> + <kbd>J</kbd>                    | Cycle to next window            |
| <kbd>SUPER</kbd> + <kbd>K</kbd>                    | Cycle to previous window        |
| <kbd>SUPER</kbd> + <kbd>P</kbd>                    | Toggle pseudo on focused window |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>P</kbd> | Toggle pseudo on all windows    |
| <kbd>SUPER</kbd> + <kbd>O</kbd>                    | Toggle split window             |

<br />

### Special Keys

| Keybind                    | Description                 |
| -------------------------- | --------------------------- |
| <kbd>Volume Up</kbd>       | Increase volume by 5%       |
| <kbd>Volume Down</kbd>     | Decrease volume by 5%       |
| <kbd>Mute</kbd>            | Toggle mute                 |
| <kbd>Brightness Up</kbd>   | Increase brightness by 5%   |
| <kbd>Brightness Down</kbd> | Decrease brightness by 5%   |
| <kbd>Play</kbd>            | Play/Pause media            |
| <kbd>Next</kbd>            | Play next media in list     |
| <kbd>Previous</kbd>        | Play previous media in list |

<br />

### Backlight control

| Keybind                                            | Description              |
| -------------------------------------------------- | ------------------------ |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>=</kbd> | Enter backlight mode     |
| <kbd>=</kbd>                                       | Increase backlight by 5% |
| <kbd>-</kbd>                                       | Decrease backlight by 5% |
| <kbd>Esc</kbd>                                     | Exit backlight mode      |

<br />

### Volume control

| Keybind                         | Description           |
| ------------------------------- | --------------------- |
| <kbd>SUPER</kbd> + <kbd>=</kbd> | Enter volume mode     |
| <kbd>=</kbd>                    | Increase volume by 5% |
| <kbd>-</kbd>                    | Decrease volume by 5% |
| <kbd>0</kbd>                    | Toggle mute           |
| <kbd>9</kbd>                    | Toggle Microphone     |
| <kbd>Esc</kbd>                  | Exit volume mode      |

<br />

### Resize windows

| Keybind                         | Description       |
| ------------------------------- | ----------------- |
| <kbd>SUPER</kbd> + <kbd>R</kbd> | Enter resize mode |
| <kbd>Left</kbd> / <kbd>H</kbd>  | Resize left       |
| <kbd>Right</kbd> / <kbd>L</kbd> | Resize right      |
| <kbd>Up</kbd> / <kbd>K</kbd>    | Resize up         |
| <kbd>Down</kbd> / <kbd>J</kbd>  | Resize down       |
| <kbd>Esc</kbd>                  | Exit resize mode  |

<br />

### Move focused window

| Keybind                         | Description      |
| ------------------------------- | ---------------- |
| <kbd>SUPER</kbd> + <kbd>M</kbd> | Enter move mode |
| <kbd>Left</kbd> / <kbd>H</kbd>  | Move left       |
| <kbd>Right</kbd> / <kbd>L</kbd> | Move right      |
| <kbd>Up</kbd> / <kbd>K</kbd>    | Move up         |
| <kbd>Down</kbd> / <kbd>J</kbd>  | Move down       |
| <kbd>Esc</kbd>                  | Exit move mode  |

<br />

### Focus

| Keybind                         | Description      |
| ------------------------------- | ---------------- |
| <kbd>SUPER</kbd> + <kbd>F</kbd> | Enter focus mode |
| <kbd>Left</kbd> / <kbd>H</kbd>  | Focus left       |
| <kbd>Right</kbd> / <kbd>L</kbd> | Focus right      |
| <kbd>Up</kbd> / <kbd>K</kbd>    | Focus up         |
| <kbd>Down</kbd> / <kbd>J</kbd>  | Focus down       |
| <kbd>Esc</kbd>                  | Exit focus mode  |

<br />

### Special workspace

| Keybind                                            | Description                              |
| -------------------------------------------------- | ---------------------------------------- |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>U</kbd> | Move focused window to special workspace |
| <kbd>SUPER</kbd> + <kbd>U</kbd>                    | Toggle special workspace                 |

<br />

### Switch workspaces

| Keybind                         | Description                   |
| ------------------------------- | ----------------------------- |
| <kbd>SUPER</kbd> + <kbd>1</kbd> | Move to workspace 1           |
| <kbd>SUPER</kbd> + <kbd>2</kbd> | Move to workspace 2           |
| <kbd>SUPER</kbd> + <kbd>3</kbd> | Move to workspace 3           |
| <kbd>SUPER</kbd> + <kbd>4</kbd> | Move to workspace 4           |
| <kbd>SUPER</kbd> + <kbd>5</kbd> | Move to workspace 5           |
| <kbd>SUPER</kbd> + <kbd>6</kbd> | Move to workspace 6           |
| <kbd>SUPER</kbd> + <kbd>7</kbd> | Move to workspace 7           |
| <kbd>SUPER</kbd> + <kbd>8</kbd> | Move to workspace 8           |
| <kbd>SUPER</kbd> + <kbd>9</kbd> | Move to workspace 9           |
| <kbd>SUPER</kbd> + <kbd>0</kbd> | Move to workspace 10          |
| <kbd>SUPER</kbd> + <kbd>`</kbd> | Move to first empty workspace |

<br />

### Move active window to a workspace

| Keybind                                           | Description                                  |
| ------------------------------------------------- | -------------------------------------------- |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>1</kbd> | Move focused window to workspace 1           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>2</kbd> | Move focused window to workspace 2           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>3</kbd> | Move focused window to workspace 3           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>4</kbd> | Move focused window to workspace 4           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>5</kbd> | Move focused window to workspace 5           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>6</kbd> | Move focused window to workspace 6           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>7</kbd> | Move focused window to workspace 7           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>8</kbd> | Move focused window to workspace 8           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>9</kbd> | Move focused window to workspace 9           |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>0</kbd> | Move focused window to workspace 10          |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>`</kbd> | Move focused window to first empty workspace |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>[</kbd> | Move focused window to previous workspace    |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>]</kbd> | Move focused window to next workspace        |

<br />

### Silently move active window to a workspace

| Keybind                                            | Description                                  |
| -------------------------------------------------- | -------------------------------------------- |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>1</kbd> | Move focused window to workspace 1           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>2</kbd> | Move focused window to workspace 2           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>3</kbd> | Move focused window to workspace 3           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>4</kbd> | Move focused window to workspace 4           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>5</kbd> | Move focused window to workspace 5           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>6</kbd> | Move focused window to workspace 6           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>7</kbd> | Move focused window to workspace 7           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>8</kbd> | Move focused window to workspace 8           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>9</kbd> | Move focused window to workspace 9           |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>0</kbd> | Move focused window to workspace 10          |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>`</kbd> | Move focused window to first empty workspace |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>[</kbd> | Move focused window to previous workspace    |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>]</kbd> | Move focused window to next workspace        |

<br />

### Scroll through existing workspaces

| Keybind                             | Description                |
| ----------------------------------- | -------------------------- |
| <kbd>SUPER</kbd> + Mouse wheel down | Move to previous workspace |
| <kbd>SUPER</kbd> + Mouse wheel up   | Move to next workspace     |
| <kbd>SUPER</kbd> + <kbd>.</kbd>     | Move to previous workspace |
| <kbd>SUPER</kbd> + <kbd>,</kbd>     | Move to next workspace     |

<br />

### Move/resize windows with using mouse

| Keybind                | Description   |
| ---------------------- | ------------- |
| <kbd>SUPER</kbd> + LMB | Move window   |
| <kbd>SUPER</kbd> + RMB | Resize window |

<br />

### Group - only available in Dwindle layout

| Keybind                           | Description                    |
| --------------------------------- | ------------------------------ |
| <kbd>SUPER</kbd> + <kbd>G</kbd>   | Toggle group                   |
| <kbd>SUPER</kbd> + <kbd>Tab</kbd> | Change to next window in group |

<br />

### Script binds

| Keybind                                               | Description                               |
| ----------------------------------------------------- | ----------------------------------------- |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>S</kbd>     | Listen to Lofi music stream               |
| <kbd>Print</kbd>                                      | Take screenshot now                       |
| <kbd>SUPER</kbd> + <kbd>Print</kbd>                   | Take screenshot in 5 seconds              |
| <kbd>SHIFT</kbd> + <kbd>Print</kbd>                   | Take screenshot in 10 seconds             |
| <kbd>CTRL</kbd> + <kbd>Print</kbd>                    | Take screenshot of current focused window |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>Print</kbd> | Select area for a screenshot              |

<br />

### Two Monitors

- When there are to monitors connected, workspaces 1-5 bind to monitor id 0 and workspaces 6-10 bind to monitor id 1

| Keybind                                                                  | Description                      |
| ------------------------------------------------------------------------ | -------------------------------- |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>CTRL</kbd> + <kbd>comma</kbd> | Swap workspaces between monitors |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>CTRL</kbd> + <kbd>comma</kbd> | Swap workspaces between monitors |
| <kbd>SUPER</kbd> + <kbd>comma</kbd>                                      | Focus on monitor id 0            |
| <kbd>SUPER</kbd> + <kbd>period</kbd>                                     | Focus on monitor id 1            |

<br />

### Waybar

|   Module   | Mouse Click | Description                                            |
| :--------: | :---------: | ------------------------------------------------------ |
|  Battery   |    Right    | Toggle glassy blur                                     |
|            |   Middle    | Toggle swallow                                         |
|  Updater   |    Left     | Spawn kitty terminal and execute yay                   |
|   Volume   |    Left     | Mute                                                   |
|            |  Wheel Up   | Increase volume by 5%                                  |
|            | Wheel Down  | Decrease volume by 5%                                  |
| Brightness |  Wheel Up   | Increase brightness by 5%                              |
|            | Wheel Down  | Decrease brightness by 5%                              |
|  Network   |    Right    | Execute script to connect to VPN (script not included) |
|   Clock    |    Right    | Random wallpaper change                                |

<br />

## Special thanks

- https://github.com/hyprwm/Hyprland - For an amazing WM
- https://github.com/eldermf/bspwm-hyprland - For the inspiration
- https://github.com/Ruixi-rebirth/nixos-config - Pretty neofetch config
- https://github.com/iamverysimp1e/dots - Glassmorphism effect
- https://github.com/rxyhn/dotfiles
