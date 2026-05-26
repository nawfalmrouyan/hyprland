# Hyprland Configuration Reference

Sources: `hyprland.lua` (main), `scrolling.lua`, `split-monitor-workspaces.lua`, `scrolloverview.lua`, `localAMD.lua`, `localNvidia.lua`, `wl-kbptr.conf`.

`SUPER` is the main mod. All keybinds below use `SUPER` unless noted otherwise.

---

## Keybinds

### Apps & Launch

| Keybind | Action / Command | Description |
|---|---|---|
| `SUPER + Return` | `kitty -1 -e sesh connect stuff` | Open terminal (TMUX session: stuff) |
| `SUPER + SHIFT + Return` | `kitty -1 -e sesh connect stuff` | Open terminal (same as above) |
| `SUPER + SHIFT + T` | `kitty -1 --class=kittyterminal -T Projects -e sesh connect Projects` | Open terminal (TMUX session: Projects) |
| `SUPER + SHIFT + S` | `kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell` | Open terminal (TMUX session: PowerShell) |
| `SUPER + SHIFT + W` | `zen-browser -new-window` | Open new Zen window |
| `SUPER + N` | `nvim-hypr-anywhere.sh` | Open nvim-hypr-anywhere |
| `SUPER + SHIFT + N` | `kitty -1 -T btop -e nvtop` | Open nvtop |
| `SUPER + 0` | `rofi-pass` | Open rofi-pass |
| `SUPER + Grave` | `vicinae vicinae://launch/wm/switch-windows` | Vicinae switch windows |
| `SUPER + Y` | `vicinae vicinae://launch/clipboard/history` | Vicinae clipboard history |
| `SUPER + SHIFT + P` | `powerprofiles.sh` | Power profiles (rofi) |
| `SUPER + SHIFT + C` | `pkill bemenu \|\| bemenu_input 6` | Bemenu input (*release*) |
| `SUPER + CTRL + Grave` | `kitten quick-access-terminal` | Kitty quick access terminal (*locked*) |
| `Print` | `quickshell -c QuickSnip -n` | Screenshot |
| `Print` | `quickshell -c HyprQuickFrame -n` | OCR / Google Lens |
| `SUPER + X` | `dms ipc call bar toggle index 0` | Toggle dank bar |
| `SUPER + CTRL + P` | `dms ipc wallpaperCarousel toggle` | Toggle wallpaper carousel |
| `SUPER + CTRL + T` | `dms ipc typingSounds toggle` | Toggle typing sounds |
| `SUPER + Escape` | `dms ipc powermenu open` | Open powermenu |

> `*` Note: the quick-access-terminal bind is marked `locked=true`.

### Cycle Focus by Class / Title (MRU)

Fallback launches the app if none is open; otherwise cycles between existing windows.

| Keybind | Target (class) | Launch command |
|---|---|---|
| `SUPER + W` | `zen` | `zen-browser` |
| `SUPER + T` | `kittyterminal` | `kitty -1 --class=kittyterminal -e sesh connect stuff` |
| `SUPER + R` | `teams-for-linux` | `teams-for-linux-electron --ozone-platform-hint=auto` |
| `SUPER + A` | `Prospect Mail` | `prospect-mail` |
| `SUPER + Z` | `Apache Directory Studio` | `/opt/ApacheDirectoryStudio/ApacheDirectoryStudio` |
| `SUPER + SHIFT + A` | `brave-browser` | `brave -enable-features=UseOzonePlatform -ozone-platform=wayland` |
| `SUPER + 8` | `toipe` | `kitty --class=toipe -o font_size=17 -e toofan` |
| `SUPER + CTRL + W` | `microsoft-edge` | `microsoft-edge-stable` |
| `SUPER + E` | `explorer` | `kitty -1 --class=explorer -T explorer -e yazi` |
| `SUPER + S` (title) | `PowerShell` | `kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell` |
| `SUPER + B` (title) | `btop` | `kitty -1 -T btop -e btop` |
| `SUPER + Tab` | active window's class | Cycle focus by current window’s class (*repeating*) |

### Window Management

| Keybind | Action | Description |
|---|---|---|
| `SUPER + F` | `window.fullscreen` | Fullscreen focused app |
| `SUPER + SHIFT + F` | `window.fullscreen_state` toggle (internal=1, client=2) | Fake maximize |
| `SUPER + Q` | `window.close` | Close focused app |
| `SUPER + SHIFT + Q` | `window.kill` | Kill focused app |
| `SUPER + V` | `window.float` toggle | Float focused app |
| `SUPER + CTRL + G` | `window.move out_of_group` | Move app out of group |
| `SUPER + G` | group toggle / lock | Toggle group, or lock if group has >1 member |
| `SUPER + M` | `window.tag +movetag` | Toggle movetag on focused window |
| `SUPER + SHIFT + Apostrophe` | `window.tag +mark1` | Tag window mark1 |
| `SUPER + CTRL + Apostrophe` | `window.tag -mark1` | Untag window mark1 |
| `SUPER + Apostrophe` | `focus tag:mark1` | Focus mark1 window |
| `SUPER + SHIFT + Semicolon` | `window.tag +mark2` | Tag window mark2 |
| `SUPER + CTRL + Semicolon` | `window.tag -mark2` | Untag window mark2 |
| `SUPER + Semicolon` | `focus tag:mark2` | Focus mark2 window |
| `SUPER + SHIFT + Comma` | `window.move monitor -1` | Move window to left monitor |
| `SUPER + SHIFT + Period` | `window.move monitor +1` | Move window to right monitor |
| `SUPER + CTRL + M` | app shortcut | Toggle mic (Teams: `CTRL+SHIFT+M`, Google Meet: `CTRL+D`) |
| `SUPER + SHIFT + B` | toggle runtime config | Game mode: disables animations/shadow/blur/gaps |

### Scrolling Layout (plugin)

Layout focus (4-dir), matching Vim keys.

| Keybind | Action |
|---|---|
| `SUPER + H` | focus left (`focus l`) |
| `SUPER + J` | focus down (`focus d`) |
| `SUPER + K` | focus up (`focus u`) |
| `SUPER + L` | focus right (`focus r`) |
| `SUPER + CTRL + H/J/K/L` | swap column in direction |
| `SUPER + SHIFT + H/J/K/L` | move window in direction |
| `SUPER + ALT + H/J/K/L` | move into / create group in direction |
| `SUPER + SHIFT + ALT + H/J/K/L` | move out of group in direction |

Layout commands:

| Keybind | Command |
|---|---|
| `SUPER + Home` | `fit tobeg` |
| `SUPER + End` | `fit toend` |
| `SUPER + Equal` | `colresize +conf` |
| `SUPER + Minus` | `colresize -conf` |
| `SUPER + Comma` | `move -col` |
| `SUPER + Period` | `move +col` |
| `SUPER + Slash` | `expel r` |
| `SUPER + SHIFT + Slash` | `expel l` |
| `SUPER + BracketLeft` | `consume r` |
| `SUPER + BracketRight` | `consume l` |
| `SUPER + D` | `fit visible` |
| `SUPER + C` | `fit active` |
| `SUPER + SHIFT + D` | `inhibit_scroll` |

### Workspaces

Split-monitor setup: **3 workspaces per monitor**, `eDP-1` always gets base 0, so monitor 1 owns workspace `1-3` and monitor 2 owns `4-6`.

| Keybind | Action |
|---|---|
| `SUPER + 1/2/3` | switch to workspace N on active monitor |
| `SUPER + SHIFT + 1/2/3` | move focused window to workspace N |
| `SUPER + CTRL + 1/2/3` | move focused window to workspace N (no follow) |
| `SUPER + ALT + 1/2/3` | move all tagged (`movetag`) windows to workspace N |
| `SUPER + SHIFT + CTRL + Comma` | swap workspaces between monitors |
| `SUPER + SHIFT + CTRL + Period` | swap workspaces between monitors |
| `SUPER + Comma` | focus left monitor |
| `SUPER + Period` | focus right monitor |

Special workspaces — `SUPER + <key>` toggles, `SUPER + SHIFT + <key>` moves the focused window into it:

| Key | Special workspace |
|---|---|
| `U` | `special:terminal` |
| `Backspace` | `special:steam` |
| `Delete` | `special:trash` (YouTube Music) |
| `O` | `special:whatsapp` |
| `6` | `special:pulsesecure` |
| `7` | `special:forticlient` |
| `I` | `special:rmpc` |

### Media Keys (no mod, global)

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` | `dms ipc call audio increment 5` — Raise volume |
| `XF86AudioLowerVolume` | `dms ipc call audio decrement 5` — Lower volume |
| `XF86AudioMute` | `dms ipc call audio mute` — Mute audio |
| `XF86AudioMicMute` | `dms ipc call audio micmute` — Mute microphone |
| `XF86AudioPlay` | `playerctl play-pause` |
| `XF86AudioNext` | `playerctl next` |
| `XF86AudioPrev` | `playerctl previous` |

All media binds are `locked`, `repeating` and active in all submaps.

### Other

| Keybind | Action |
|---|---|
| `SUPER + SHIFT + I` | toggle scroll-overview (plugin) |
| `SUPER + SHIFT + O` | toggle the `no_screen_share` window rule |
| `switch:on:[Lid Switch]` | enable `eDP-1` (locked) |
| `switch:off:[Lid Switch]` | disable `eDP-1` (locked) |

### Mouse

| Binding | Action |
|---|---|
| `SUPER + LMB (272)` | drag/move window |
| `SUPER + RMB (273)` | resize window |
| `SUPER + MMB (274)` | toggle float focused window |
| `MMB (274)` | drag PiP window (`non_consuming`, only when title = `Picture-in-Picture`) |
| `SUPER + mouse_up` | cursor zoom in (+0.5, throttled) |
| `SUPER + mouse_down` | cursor zoom out (−0.5, throttled) |
| `SUPER + SHIFT + mouse_up` | reset cursor zoom to 5 |
| `SUPER + SHIFT + mouse_down` | reset cursor zoom to 1 |
| `SUPER + CTRL + mouse_up` | scroll windows right (`layout move -col`) |
| `SUPER + CTRL + mouse_down` | scroll windows left (`layout move +col`) |

Gestures:
- 2-finger pinch → `cursorZoom` (live)
- 4-finger horizontal → `scroll_move`

### Cursor Submap (`wl-kbptr.conf`)

Enter with `SUPER + P` (or from a submap reset; also `a` re-enters while in submap).

| Key | Action |
|---|---|
| `a` | jump cursor (`wl-kbptr` click mode) |
| `h/j/k/l` | move cursor ↔/↑↓ (`wlrctl pointer move`) |
| `f` | left click |
| `d` | middle click |
| `s` | right click |
| `e` / `r` | scroll up / down |
| `t` / `g` | scroll left / right |
| `Escape` | exit submap + restore cursor timeout/hide |

### Hardware-Specific (hostname `opalMMU` → `localAMD.lua`, else `localNvidia.lua`)

AMD (`opalMMU`):

| Key | Action |
|---|---|
| `XF86Calculator` | vicinae calculator history |
| `SUPER + W` | open Zen (hypr-cycle-focus) — overrides the class-cycle bind on this host |
| `XF86MonBrightnessUp` | brightness +5 (amdgpu + ddc-i2c-4) |
| `XF86MonBrightnessDown` | brightness −5 (amdgpu + ddc-i2c-4) |
| `SHIFT + XF86MonBrightnessDown` | toggle exponential brightness |

NVIDIA (others):

| Key | Action |
|---|---|
| `XF86MonBrightnessUp` | brightness +5 (`intel_backlight`) |
| `XF86MonBrightnessDown` | brightness −5 (`intel_backlight`) |
| `SHIFT + XF86MonBrightnessDown` | toggle exponential brightness |

---

## Window Rules

### Border / Visual

| Match | Rules |
|---|---|
| `focus` + workspace `w[tv2-50]` | border_size 3 |
| `focus` + workspace `s[true]` (special) | border_size 3 |
| tag `movetag` | border_size 3 |
| tag `movetag` | border_color red (Catppuccin Mocha) |
| `float` (any) | border_color mauve |
| `fullscreen` | border_size 0, rounding 0 |
| `fullscreen_state_internal = 1`, `fullscreen_state_client = 2` | border_size 0, rounding 0 |
| `pin` | opacity `0.8 0.8` |

### Size / Layout

| Match class/title | Rules |
|---|---|
| `^(explorer\|kitty\|kittyterminal\|footclient)$` | scrolling_width 0.5 |
| `org.remmina.Remmina` + title `Remmina Remote Desktop Client` | scrolling_width 0.5 |
| `sioyek` | scrolling_width 0.5 |
| title `^(Peek preview)$` | no_focus, scrolling_width 0.5 |
| `ONLYOFFICE` | tile |
| `steam_app_.*` | immediate |
| `.*` (all) | suppress_event `maximize` |

### Float / Center / Fixed Size

| Match class/title | Rules |
|---|---|
| `pulseUI` + title `(Pulse Secure)` | float, center, 900×750 → `special:pulsesecure` |
| `FortiClient` (initial) | float, center, 900×750 → `special:forticlient` |
| `com.rtosta.zapzap\|whatsappweb-nativefier-d40211\|org.telegram.desktop` (initial) | float, center, 1600×960 → `special:whatsapp silent` |
| `com.github.th_ch.youtube_music\|spotube\|(YouTube Music for Desktop)` | float, center, 1600×960 → `special:trash silent` |
| `DesktopEditors` (onlyoffice popups) | center |
| `toipe\|jamesdsp\|hyprland-share-picker\|nm-connection-editor\|pavucontrol\|Gimp\|org.quickshell` | float, center, 1200×750 |
| `qt5ct\|qt6ct\|feh\|FortiClient\|yad` | float, center |
| title `Settings\|Hyprshot\|Open\|(Publish as PDF or XPS\|^Settings - .*\|^Warning:.*)` | float, center, 900×750 |
| title `LibreOffice` | center |
| title `.*Network Manager.*` | float |
| `waypaper\|qt6ct\|qt5ct` | float, center, 900×750 |
| title `([Ff]ile Upload)\|(Enter name of file to save to.*)\|(blob.*)\|(Open [Ff]iles)\|(Open folder.*)` | float, center, 1345×720 |
| `(soffice\|Save Image\|Save As\|xdg-desktop-portal-gtk)` | float, center, 1345×720 |
| `(blueman-manager)\|(com.network.manager)` (initial) | float, 1280×700, move (380,35), animation slide, stay_focused |
| `steam` | float |
| `^(steam_app_.*)$` + initial title `^(..+)$` | float |
| `steam` + title `Steam\|(Sign in to Steam)` | float, center, 1600×960 → `special:steam silent` |
| `zen` + title `Picture-in-Picture` | float, max 800×800 |
| `xwaylandvideobridge` | float (opacity `0.0 override`), no_anim, no_focus, no_initial_focus → `special:junks silent` |
| `update` + title `update` | float, 1280×700, move (380,43), animation slide → `special:update` |
| `nvim-hypr-anywhere` | float, pin, center, 1280×700, animation slide |
| initial title `btop` | float, pin, center, 1280×700, animation popin |
| initial title `ytm` | float, center, 1280×700, animation popin |
| `scratch` + title `scratch` | float, 1440×700, move (240,377), animation slide |

### Grouping

| Match class | Rule |
|---|---|
| `whatsappweb-nativefier-d40211\|org.telegram.desktop\|spotube\|com.github.th_ch.youtube_music\|com.rtosta.zapzap\|FortiClient\|pulseUI` | group `set` (can be grouped into tabs) |
| `foot\|zen\|xdg-desktop-portal-gtk` | group override `barred` (cannot be tabbed) |

### Misc

| Match | Rules |
|---|---|
| `teams-for-linux` | idle_inhibit `focus` |
| title `noscreenshare` | no_screen_share |
| `whatsappweb-nativefier-d40211\|org.telegram.desktop\|spotube\|com.github.th_ch.youtube_music\|steam\|com.rtosta.zapzap` | no_screen_share — **dynamic rule**, toggle with `SUPER + SHIFT + O` |
| `^$` class + `^$` title + xwayland + float + not fullscreen + not pin | no_focus (fix XWayland drags) |

---

## Workspace Rules

### Special workspaces — commands run when opened empty (`on_created_empty`)

| Workspace | Command |
|---|---|
| `special:terminal` | `kitty --class=scratch -T scratch -e sesh connect WORK` |
| `special:trash` | `youtube-music-for-desktop` |
| `special:whatsapp` | `WhatsAppWeb --ozone-platform-hint=auto --enable-features=WebRTCPipeWireCapturer` |
| `special:steam` | `steam` |
| `special:update` | `kitty -1 --class=update -T update -e yay -Syu` |
| `special:pulsemixer` | `kitty -1 --class=update -T update -e pulsemixer` |
| `special:pulsesecure` | `/opt/pulsesecure/bin/pulseUI` |
| `special:forticlient` | `/opt/forticlient/gui/FortiClient` |
| `special:rmpc` | `kitty -1 -T ytm -e rmpc` |

### Monitor split (from `split-monitor-workspaces.lua`)

| Workspace | Rule |
|---|---|
| `w[tv1]` | no_border, no_rounding, gaps_out 0, gaps_in 0 (full-screen slideshow) |
| `1, 2, 3` | pinned to first monitor (eDP-1 base 0) |
| `4, 5, 6` | pinned to second monitor |

Workspaces are assigned per monitor (3 per monitor). On monitor hotplug, windows are moved onto eDP-1 and restored on reconnect.

---

## Layer Rules (popups / OSD / overlays)

| Namespace | Rules |
|---|---|
| `rofi\|logout_dialog\|vicinae` | dim_around, blur, animation popin |
| `vicinae\|ghostty-quick-terminal\|kitty-quick-access` | blur, above_lock 2, no_screen_share |
| `swaync.*\|dms.*` | no_screen_share |
| `dms.bar` | no_screen_share false (screen share allowed) |
| `hyprhalt` | blur, ignore_alpha 0 |