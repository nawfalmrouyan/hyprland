# Arch with Hyprland

![Screenshot_2022-11-24-18-27-54_19051](https://user-images.githubusercontent.com/10271030/203763303-5fa66fa9-4921-4095-b970-25446d6d7c9e.png)

![Screenshot_2022-11-24-18-25-48_2385](https://user-images.githubusercontent.com/10271030/203763318-d1ad8a5a-b845-4fa1-aa1a-5a99343fa06d.png)

<br />

# Overview

Hyprland is a dynamic tiling Wayland compositor based on wlroots that doesn't sacrifice on its looks.

 | Label | Application | 
 | -- | -- |
 | Operating System  | Arco Linux |
 | Window Manager    | Hyprland |
 | Status Bar        | Waybar-hyprland-git |
 | Launcher          | Wofi |
 | Session Manager   | Wlogout |
 | Notifications     | Mako |
 | Terminal          | Kitty |
 | Web Browser       | Firefox |

<br />

# Installation

If you want to install this setup on ARCH Linux or on any other distro, follow the points below:

1. Install the following programs on your computer: 
  - hyprland
  - swaybg
  - swayidle
  - swaylock
  - wlroots
  - wl-clipboard
  - waybar-hyprland-git
  - wofi
  - kitty
  - mako
  - grim
  - slurp
  - wf-recorder
  - yad
  - polkit-gnome
  - xorg-xwayland
  - guake
2. After installing programs above,
1. Copy hypr directory to ~/.config/ (`cp -r hypr ~/.config`)
1. Start a Hyprland session (https://wiki.hyprland.org/Getting-Started/Quick-start/)

<br />

# Keybinds

<br />

## General

| Keybind | Command |
|-|-|
| SUPER + SHIFT + Return | Open Kitty terminal |
| SUPER + W | Open firefox in workspace 2 |
| SUPER + SHIFT + W | Open WhatsApp in workspace 9 silently |
| SUPER + Q | Kill focused window |
| SUPER + A | Open Microsoft Edge (Default Profile) |
| SUPER + SHIFT + A | Open Microsoft Edge (Profile 1) |
| SUPER + F | Toggle fullscreen of focused window |
| SUPER + E | Open Nautilus |
| SUPER + V | Toggle floating of focused window |
| SUPER + R | Open application using wofi |
| SUPER + C | Open application using bemenu |
| SUPER + P | Set focused window to pseudo | |
| SUPER + J | Focus to next window |
| SUPER + K | Focus to previous window |
| SUPER + Return | Swap current focused window with Master window |
| SUPER + I | Add focused window to Master |
| SUPER + D | Remove focused window from Master |
| SUPER + Backspace | Toggle scratch terminal |
| SUPER + L | Toggle between Master and Dwindle layout |
| SUPER + M | Set split ratio to 0.3 |
| SUPER + SHIFT + M | Set split ratio to -0.3 |
| SUPER + Escape | Toggle Wlogout |

<br />

## Special Keys

| Keybind | Command |
|-|-|
| xf86audioraisevolume | Increase volume by 5% |
| xf86audiolowervolume | Decrease volume by 5% |
| xf86audiomute | Toggle mute |
| xf86monbrightnessup | Increase brightness by 5% |
| xf86monbrightnessdown | Decrease brightness by 5% |

<br />

## Backlight control

| Keybind | Command |
|-|-|
| SUPER + SHIFT + equal | Enter backlight mode |
| equal | Increase backlight by 5% |
| minus | Decrease backlight by 5% |
| escape | Exit backlight mode |

<br />

## Volume control

| Keybind | Command |
|-|-|
| SUPER + equal | Enter volume mode |
| equal | Increase volume by 5% |
| minus | Decrease volume by 5% 
| 0 | Toggle mute |
| 9 | Toggle Microphone |
| escape | Exit volume mode |

<br />

## Resize windows

| Keybind | Command |
|-|-|
| SUPER + SHIFT + h | Resize left |
| SUPER + SHIFT + l | Resize right |
| SUPER + SHIFT + k | Resize up  |
| SUPER + SHIFT + j | Resize down |

<br />

## Move focused window

| Keybind | Command |
|-|-|
| SUPER + CTRL + h | Move focused window left |
| SUPER + CTRL + l | Move focused window right |
| SUPER + CTRL + k | Move focused window up |
| SUPER + CTRL + j | Move focused window down |

<br />

## Focus

| Keybind | Command |
|-|-|
| SUPER + left | Focus left |
| SUPER + right |Focus right |
| SUPER + up | Focus up |
| SUPER + down | Focus down |

<br />

## Special workspace

| Keybind | Command |
|-|-|
| SUPER + SHIFT + U | Move focused window to special workspace |
| SUPER + U | Toggle special workspace |

<br />

## Switch workspaces

| Keybind | Command |
|-|-|
| SUPER + 1 | Move to workspace 1 |
| SUPER + 2 | Move to workspace 2 |
| SUPER + 3 | Move to workspace 3 |
| SUPER + 4 | Move to workspace 4 |
| SUPER + 5 | Move to workspace 5 |
| SUPER + 6 | Move to workspace 6 |
| SUPER + 7 | Move to workspace 7 |
| SUPER + 8 | Move to workspace 8 |
| SUPER + 9 | Move to workspace 9 |
| SUPER + 0 | Move to workspace 10 |
| SUPER + Grave | Move to first empty workspace |

<br />

## Move active window to a workspace

| Keybind | Command |
|-|-|
| SUPER + SHIFT + 1 | Move focused window to workspace 1 |
| SUPER + SHIFT + 2 | Move focused window to workspace 2 |
| SUPER + SHIFT + 3 | Move focused window to workspace 3 |
| SUPER + SHIFT + 4 | Move focused window to workspace 4 |
| SUPER + SHIFT + 5 | Move focused window to workspace 5 |
| SUPER + SHIFT + 6 | Move focused window to workspace 6 |
| SUPER + SHIFT + 7 | Move focused window to workspace 7 |
| SUPER + SHIFT + 8 | Move focused window to workspace 8 |
| SUPER + SHIFT + 9 | Move focused window to workspace 9 |
| SUPER + SHIFT + 0 | Move focused window to workspace 10 |
| SUPER + SHIFT + Grave | Move focused window to empty workspace |

* Use `movetoworkspace` if you do not want to silently move focused window

<br />

## Scroll through existing workspaces

| Keybind | Command |
|-|-|
| SUPER + Mouse wheel down | Move to previous workspace |
| SUPER + Mouse wheel up | Move to next workspace |
| SUPER + period | Move to previous workspace |
| SUPER + comma | Move to next workspace |

<br />

## Move/resize windows with using mouse

| Keybind | Command |
|-|-|
| SUPER + LMB | Move window |
| SUPER + RMB | Resize window |

<br />

## Group - only available in Dwindle layout

| Keybind | Command |
|-|-|
| SUPER + G | Toggle group |
| SUPER + tab | Change to next window in group |

<br />

## Script binds

| Keybind | Command |
|-|-|
| SUPER + CTRL + S | Listen to Lofi music stream |
| SUPER + Print | Take screenshot now |
| SUPER + Print | Take screenshot in 5 seconds |
| SUPER + SHIFT + Print | Take screenshot in 10 seconds |
| SUPER + CTRL + Print | Take screenshot of current focused window |
| SUPER + CTRL + Print | Select area for a screenshot |

<br />

# Special thanks

* https://github.com/hyprwm/Hyprland - For an amazing WM
* https://github.com/eldermf/bspwm-hyprland - For the inspiration
