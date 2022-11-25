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
  - wlogout
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
  - lf
2. Clone the repo
1. Copy all the files in the repo to ~/.config/ (`cd hyprland && cp -r * ~/.config`)
1. Start a Hyprland session (https://wiki.hyprland.org/Getting-Started/Quick-start/)

<br />

# Keybinds

<br />

## General

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>Return</kbd> | Open Kitty terminal |
| <kbd>SUPER</kbd> + <kbd>W</kbd> | Open firefox in workspace 2 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>W</kbd> | Open WhatsApp in workspace 9 silently |
| <kbd>SUPER</kbd> + <kbd>Q</kbd> | Kill focused window |
| <kbd>SUPER</kbd> + <kbd>A</kbd> | Open Microsoft Edge (Default Profile) |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>A</kbd> | Open Microsoft Edge (Profile 1) |
| <kbd>SUPER</kbd> + <kbd>F</kbd> | Toggle fullscreen of focused window |
| <kbd>SUPER</kbd> + <kbd>E</kbd> | Open lf - Terminal based file manager |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>E</kbd> | Open Nautilus |
| <kbd>SUPER</kbd> + <kbd>V</kbd> | Toggle floating of focused window |
| <kbd>SUPER</kbd> + <kbd>R</kbd> | Open application using wofi |
| <kbd>SUPER</kbd> + <kbd>C</kbd> | Open application using bemenu |
| <kbd>SUPER</kbd> + <kbd>P</kbd> | Set focused window to pseudo | |
| <kbd>SUPER</kbd> + <kbd>J</kbd> | Focus to next window |
| <kbd>SUPER</kbd> + <kbd>K</kbd> | Focus to previous window |
| <kbd>SUPER</kbd> + <kbd>Return | Swap current focused window with Master window |
| <kbd>SUPER</kbd> + <kbd>I</kbd> | Add focused window to Master |
| <kbd>SUPER</kbd> + <kbd>D</kbd> | Remove focused window from Master |
| <kbd>SUPER</kbd> + <kbd>Backspace</kbd> | Toggle scratch terminal |
| <kbd>SUPER</kbd> + <kbd>L</kbd> | Toggle between Master and Dwindle layout |
| <kbd>SUPER</kbd> + <kbd>M</kbd> | Set split ratio to 0.3 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>M</kbd> | Set split ratio to -0.3 |
| <kbd>SUPER</kbd> + <kbd>Escape</kbd> | Toggle Wlogout |

<br />

## Special Keys

| Keybind | Command |
|-|-|
| <kbd>Volume Up</kbd> | Increase volume by 5% |
| <kbd>Volume Down</kbd> | Decrease volume by 5% |
| <kbd>Mute</kbd> | Toggle mute |
| <kbd>Brightness Up</kbd> | Increase brightness by 5% |
| <kbd>Brightness Down</kbd> | Decrease brightness by 5% |

<br />

## Backlight control

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>=</kbd> | Enter backlight mode |
| <kbd>=</kbd> | Increase backlight by 5% |
| <kbd>-</kbd> | Decrease backlight by 5% |
| <kbd>Esc</kbd> | Exit backlight mode |

<br />

## Volume control

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>=</kbd> | Enter volume mode |
| <kbd>=</kbd> | Increase volume by 5% |
| <kbd>-</kbd> | Decrease volume by 5% 
| <kbd>0</kbd> | Toggle mute |
| <kbd>9</kbd>| Toggle Microphone |
| <kbd>Esc</kbd> | Exit volume mode |

<br />

## Resize windows

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>H</kbd> | Resize left |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>L</kbd> | Resize right |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>K</kbd> | Resize up  |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>J</kbd> | Resize down |

<br />

## Move focused window

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>H</kbd> | Move focused window left |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>L</kbd> | Move focused window right |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>K</kbd> | Move focused window up |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>J</kbd> | Move focused window down |

<br />

## Focus

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>Left</kbd> | Focus left |
| <kbd>SUPER</kbd> + <kbd>Right</kbd> | Focus right |
| <kbd>SUPER</kbd> + <kbd>Up</kbd> | Focus up |
| <kbd>SUPER</kbd> + <kbd>Down</kbd> | Focus down |

<br />

## Special workspace

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>U</kbd> | Move focused window to special workspace |
| <kbd>SUPER</kbd> + <kbd>U</kbd> | Toggle special workspace |

<br />

## Switch workspaces

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>1</kbd> | Move to workspace 1 |
| <kbd>SUPER</kbd> + <kbd>2</kbd> | Move to workspace 2 |
| <kbd>SUPER</kbd> + <kbd>3</kbd> | Move to workspace 3 |
| <kbd>SUPER</kbd> + <kbd>4</kbd> | Move to workspace 4 |
| <kbd>SUPER</kbd> + <kbd>5</kbd> | Move to workspace 5 |
| <kbd>SUPER</kbd> + <kbd>6</kbd> | Move to workspace 6 |
| <kbd>SUPER</kbd> + <kbd>7</kbd> | Move to workspace 7 |
| <kbd>SUPER</kbd> + <kbd>8</kbd> | Move to workspace 8 |
| <kbd>SUPER</kbd> + <kbd>9</kbd> | Move to workspace 9 |
| <kbd>SUPER</kbd> + <kbd>0</kbd> | Move to workspace 10 |
| <kbd>SUPER</kbd> + <kbd>`</kbd> | Move to first empty workspace |

<br />

## Move active window to a workspace

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>1</kbd> | Move focused window to workspace 1 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>2</kbd> | Move focused window to workspace 2 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>3</kbd> | Move focused window to workspace 3 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>4</kbd> | Move focused window to workspace 4 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>5</kbd> | Move focused window to workspace 5 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>6</kbd> | Move focused window to workspace 6 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>7</kbd> | Move focused window to workspace 7 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>8</kbd> | Move focused window to workspace 8 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>9</kbd> | Move focused window to workspace 9 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>0</kbd> | Move focused window to workspace 10 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>`</kbd> | Move focused window to first empty workspace |

* Use `movetoworkspace` if you do not want to silently move focused window

<br />

## Scroll through existing workspaces

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + Mouse wheel down | Move to previous workspace |
| <kbd>SUPER</kbd> + Mouse wheel up | Move to next workspace |
| <kbd>SUPER</kbd> + <kbd>.</kbd> | Move to previous workspace |
| <kbd>SUPER</kbd> + <kbd>,</kbd> | Move to next workspace |

<br />

## Move/resize windows with using mouse

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + LMB | Move window |
| <kbd>SUPER</kbd> + RMB | Resize window |

<br />

## Group - only available in Dwindle layout

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>G</kbd> | Toggle group |
| <kbd>SUPER</kbd> + <kbd>Tab</kbd> | Change to next window in group |

<br />

## Script binds

| Keybind | Command |
|-|-|
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>S</kbd> | Listen to Lofi music stream |
| <kbd>SUPER</kbd> + <kbd>Print</kbd> | Take screenshot now |
| <kbd>SUPER</kbd> + <kbd>Print</kbd> | Take screenshot in 5 seconds |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>Print</kbd> | Take screenshot in 10 seconds |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>Print</kbd> | Take screenshot of current focused window |
| <kbd>SUPER</kbd> + <kbd>CTRL</kbd> + <kbd>Print</kbd> | Select area for a screenshot |

<br />

# Special thanks

* https://github.com/hyprwm/Hyprland - For an amazing WM
* https://github.com/eldermf/bspwm-hyprland - For the inspiration
