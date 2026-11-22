# Hyprland Configuration Reference

Sources: `hyprland.lua` (main), `modules/binds.lua`, `modules/config.lua`, `modules/rules.lua`, `scrolling.lua`, `split-monitor-workspaces.lua`, `scrolloverview.lua`, `wl-kbptr.lua`.

`SUPER` is the main mod. All keybinds below use `SUPER` unless noted otherwise.

---

## Keybinds

### Apps & Launch

| Keybind | Action / Command | Description |
|---|---|---|
| `SUPER + SHIFT + Return` | `kitty -1 -e sesh connect stuff` | Open Terminal (tmux session: stuff) |
| `SUPER + SHIFT + T` | `kitty -1 --class=kittyterminal -T Projects -e sesh connect Projects` | Open Terminal (tmux session: Projects) |
| `SUPER + SHIFT + S` | `kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell` | Open Terminal (tmux session: PowerShell) |
| `SUPER + SHIFT + W` | `zen-browser -new-window` | Open new Zen Browser window |
| `SUPER + N` | `nvim-hypr-anywhere.sh` | Open quick text editor (nvim-hypr-anywhere) |
| `SUPER + SHIFT + N` | `kitty -1 -T btop -e nvtop` | Open GPU task monitor (nvtop in Kitty) |
| `SUPER + 0` | `rofi-pass` | Open password manager (rofi-pass) |
| `SUPER + Grave` | `vicinae vicinae://launch/wm/switch-windows` | Switch windows (Vicinae) |
| `SUPER + Y` | `vicinae vicinae://launch/clipboard/history` | Open clipboard history (Vicinae) |
| `SUPER + SHIFT + P` | `powerprofiles.sh` | Select power profile (Rofi) |
| `SUPER + SHIFT + C` | `pkill bemenu \|\| bemenu_input 6` | Open quick input menu (bemenu, *release*) |
| `SUPER + CTRL + Grave` | `kitten quick-access-terminal` | Toggle Kitty quick-access drop-down terminal (*locked*) |
| `Print` | `quickshell -c QuickSnip -n` | Take interactive screenshot (QuickSnip) |
| `Print` (no mod) | `quickshell -c HyprQuickFrame -n` | Screen OCR and visual search (HyprQuickFrame) |
| `SUPER + X` | `dms ipc call bar toggle index 0` | Toggle DMS top bar |
| `SUPER + CTRL + P` | `dms ipc wallpaperCarousel toggle` | Toggle DMS wallpaper carousel |
| `SUPER + CTRL + T` | `dms ipc typingSounds toggle` | Toggle DMS typing sound effects |
| `SUPER + Escape` | `dms ipc powermenu open` | Open DMS power menu |

> `*` Note: `SUPER + CTRL + Grave` (`quick-access-terminal`) is marked `locked=true`.

### Cycle Focus by Class / Title (MRU)

Fallback launches the app if none is open; otherwise cycles between existing windows.

| Keybind | Target (class / title) | Launch command | Description |
|---|---|---|---|
| `SUPER + W` | `zen` (class) | `zen-browser` | Focus or launch Zen Browser |
| `SUPER + T` | `kittyterminal` (class) | `kitty -1 --class=kittyterminal -e sesh connect stuff` | Focus or launch Terminal (tmux: stuff) |
| `SUPER + R` | `teams-for-linux` (class) | `teams-for-linux-electron --ozone-platform-hint=auto` | Focus or launch Teams for Linux |
| `SUPER + A` | `Prospect Mail` (class) | `prospect-mail ...` | Focus or launch Prospect Mail (Outlook) |
| `SUPER + Z` | `Apache Directory Studio` (class) | `/opt/ApacheDirectoryStudio/ApacheDirectoryStudio` | Focus or launch Apache Directory Studio |
| `SUPER + SHIFT + A` | `brave-browser` (class) | `brave -enable-features=UseOzonePlatform -ozone-platform=wayland` | Focus or launch Brave Browser |
| `SUPER + 8` | `toipe` (class) | `kitty --class=toipe -o font_size=17 -e toofan` | Focus or launch Toipe typing practice |
| `SUPER + CTRL + W` | `microsoft-edge` (class) | `microsoft-edge-stable` | Focus or launch Microsoft Edge |
| `SUPER + E` | `explorer` (class) | `kitty -1 --class=explorer -T explorer -e yazi` | Focus or launch Yazi file manager |
| `SUPER + SHIFT + E` | `dfiles` (class) | `dfiles` | Focus or launch Dfiles file manager |
| `SUPER + S` | `PowerShell` (title) | `kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell` | Focus or launch PowerShell terminal |
| `SUPER + B` | `btop` (title) | `kitty -1 -T btop -e btop` | Focus or launch btop system monitor |
| `SUPER + Tab` | active window's class | — | Cycle focus among windows of active application (same class, *repeating*) |

### Window Management

| Keybind | Action | Description |
|---|---|---|
| `SUPER + F` | `window.fullscreen` | Toggle fullscreen mode |
| `SUPER + SHIFT + F` | `window.fullscreen_state` toggle (internal=1, client=2) | Toggle fake fullscreen / maximize active window |
| `SUPER + Q` | `window.close` | Close active window |
| `SUPER + SHIFT + Q` | `window.kill` | Force kill active window process |
| `SUPER + V` | `window.float` toggle | Toggle floating mode for active window |
| `SUPER + CTRL + G` | `window.move out_of_group` | Move active window out of group (right) |
| `SUPER + G` | group toggle / lock | Toggle window group or lock active group |
| `SUPER + M` | `window.tag +movetag` | Toggle movetag on active window (batch move tag) |
| `SUPER + SHIFT + Apostrophe` | `window.tag +mark1` | Tag active window as mark1 |
| `SUPER + CTRL + Apostrophe` | `window.tag -mark1` | Remove mark1 tag from active window |
| `SUPER + Apostrophe` | `focus tag:mark1` | Focus window tagged mark1 |
| `SUPER + SHIFT + Semicolon` | `window.tag +mark2` | Tag active window as mark2 |
| `SUPER + CTRL + Semicolon` | `window.tag -mark2` | Remove mark2 tag from active window |
| `SUPER + Semicolon` | `focus tag:mark2` | Focus window tagged mark2 |
| `SUPER + SHIFT + Comma` | `window.move monitor -1` | Move active window to left monitor |
| `SUPER + SHIFT + Period` | `window.move monitor +1` | Move active window to right monitor |
| `SUPER + CTRL + M` | app shortcut | Toggle microphone in active meeting (Teams / Google Meet) |
| `SUPER + SHIFT + B` | toggle runtime config | Toggle Game Mode (disable animations, shadows, blur, and gaps) |

### Scrolling Layout (plugin)

Layout focus (4 directions, matching Vim keys):

| Keybind | Action | Description |
|---|---|---|
| `SUPER + H` | `focus l` | Focus window left |
| `SUPER + J` | `focus d` | Focus window down |
| `SUPER + K` | `focus u` | Focus window up |
| `SUPER + L` | `focus r` | Focus window right |
| `SUPER + CTRL + H/J/K/L` | `swapcol <dir>` | Swap column left/down/up/right |
| `SUPER + SHIFT + H/J/K/L` | `window.move <dir>` | Move window left/down/up/right |
| `SUPER + ALT + H/J/K/L` | `into_or_create_group <dir>` | Move window into or create group left/down/up/right |
| `SUPER + SHIFT + ALT + H/J/K/L` | `out_of_group <dir>` | Move window out of group left/down/up/right |

Layout commands:

| Keybind | Command | Description |
|---|---|---|
| `SUPER + Home` | `fit tobeg` | Scroll layout to beginning (first column) |
| `SUPER + End` | `fit toend` | Scroll layout to end (last column) |
| `SUPER + Equal` | `colresize +conf` | Increase column width preset |
| `SUPER + Minus` | `colresize -conf` | Decrease column width preset |
| `SUPER + Slash` | `expel r` | Expel window to new column on the right |
| `SUPER + SHIFT + Slash` | `expel l` | Expel window to new column on the left |
| `SUPER + BracketLeft` | `consume r` | Consume window from right into current column |
| `SUPER + BracketRight` | `consume l` | Consume window from left into current column |
| `SUPER + D` | `fit visible` | Fit all columns onto visible screen |
| `SUPER + C` | `fit active` | Fit active column to screen center |
| `SUPER + SHIFT + D` | `inhibit_scroll` | Toggle scroll inhibition (lock layout scrolling) |

> Note: `SUPER + Comma` and `SUPER + Period` are reserved for focusing monitors (`modules/binds.lua`). Column scrolling is mapped to `SUPER + CTRL + mouse_up` and `SUPER + CTRL + mouse_down`.

### Workspaces

Split-monitor setup: **5 workspaces per monitor** (`modules/workspace_names.lua`), `eDP-1` gets base 0 (workspaces `1-5`), and the second monitor gets base 5 (workspaces `6-10`). Workspaces are named with Japanese/Kanji numerals (`一`, `二`, `三`, `四`, `五`) per monitor.

| Keybind | Action | Description |
|---|---|---|
| `SUPER + 1..5` | `switch_workspace(ws)` | Switch to workspace N on active monitor |
| `SUPER + SHIFT + 1..5` | `move_workspace(ws)` | Move active window to workspace N and follow |
| `SUPER + CTRL + 1..5` | `move_workspace(ws, false)` | Move active window to workspace N (silent / no follow) |
| `SUPER + ALT + 1..5` | move tagged windows | Move all movetag windows to workspace N on active monitor |
| `SUPER + 9` | `toggle_mirror` | Toggle second monitor mirroring (mirror/extend primary display) |
| `SUPER + SHIFT + CTRL + Comma` | `ws_swap.swap()` | Swap active workspaces between monitors |
| `SUPER + SHIFT + CTRL + Period` | `ws_swap.swap()` | Swap active workspaces between monitors |
| `SUPER + Comma` | `focus monitor: l` | Focus left monitor |
| `SUPER + Period` | `focus monitor: r` | Focus right monitor |

Special workspaces — `SUPER + <key>` toggles, `SUPER + SHIFT + <key>` moves the focused window into it:

| Key | Special workspace | Target App / Purpose |
|---|---|---|
| `U` | `special:terminal` | Terminal scratchpad (`kitty -e sesh connect WORK`) |
| `Backspace` | `special:steam` | Steam |
| `Delete` | `special:trash` | Music player (`sung` / YouTube Music) |
| `O` | `special:whatsapp` | WhatsApp Web |
| `6` | `special:pulsesecure` | Pulse Secure VPN UI |
| `7` | `special:forticlient` | FortiClient VPN UI |
| `I` | `special:rmpc` | Music client (`rmpc` in Kitty) |

### Media Keys (no mod, global)

All media binds are `locked`, `repeating` and active across submaps.

| Key | Action / Command | Description |
|---|---|---|
| `XF86AudioRaiseVolume` | `dms ipc call audio increment 5` | Increase audio volume by 5% |
| `XF86AudioLowerVolume` | `dms ipc call audio decrement 5` | Decrease audio volume by 5% |
| `XF86AudioMute` | `dms ipc call audio mute` | Toggle audio mute |
| `XF86AudioMicMute` | `dms ipc call audio micmute` | Toggle microphone mute |
| `XF86AudioPlay` | `playerctl play-pause` | Toggle media playback (play/pause) |
| `XF86AudioNext` | `playerctl next` | Skip to next media track |
| `XF86AudioPrev` | `playerctl previous` | Return to previous media track |

### Other

| Keybind | Action | Description |
|---|---|---|
| `SUPER + SHIFT + I` | `plugin.scrolloverview.overview("toggle")` | Toggle scroll workspace overview (plugin) |
| `SUPER + SHIFT + O` | toggle `screen_share_rule` | Toggle screen share privacy filter (`noscreenshare` rule) |
| `switch:on:[Lid Switch]` | enable output `eDP-1` | Enable internal display on lid open |
| `switch:off:[Lid Switch]` | disable output `eDP-1` | Disable internal display on lid close |

### Mouse

| Binding | Action | Description |
|---|---|---|
| `SUPER + LMB (272)` | `window.drag()` | Move window by dragging |
| `SUPER + RMB (273)` | `window.resize()` | Resize window by dragging |
| `SUPER + MMB (274)` | `window.float()` toggle | Toggle floating for active window via middle click |
| `MMB (274)` | `window.drag()` | Drag Picture-in-Picture window with middle mouse button (without modifier) |
| `SUPER + mouse_up` | `cursor.zoom_factor + 0.5` | Zoom in desktop (increase zoom factor, throttled) |
| `SUPER + mouse_down` | `cursor.zoom_factor - 0.5` | Zoom out desktop (decrease zoom factor, throttled) |
| `SUPER + SHIFT + mouse_up` | `cursor.zoom_factor = 5` | Set zoom factor preset to 5x |
| `SUPER + SHIFT + mouse_down` | `cursor.zoom_factor = 1` | Reset zoom factor to 1x |
| `SUPER + CTRL + mouse_up` | `layout("move -col")` | Scroll layout column left (move -col, throttled) |
| `SUPER + CTRL + mouse_down` | `layout("move +col")` | Scroll layout column right (move +col, throttled) |

Gestures:
- 2-finger pinch $\rightarrow$ `cursorZoom` (live)
- 4-finger horizontal $\rightarrow$ `scroll_move`

### Cursor Submap (`wl-kbptr.lua`)

Enter with `SUPER + CTRL + C` (`Enter keyboard-driven cursor mode`).

| Key | Action / Command | Description |
|---|---|---|
| `A` | `wl-kbptr -o modes=tile,click` | Jump cursor to tiled window via wl-kbptr |
| `W` | `wl-kbptr -o modes=floating,click` | Jump cursor to floating window via wl-kbptr |
| `H / J / K / L` | `wlrctl pointer move` | Move cursor left / down / up / right 25px (*repeating*) |
| `F` | `wlrctl pointer click left` | Left mouse click |
| `D` | `wlrctl pointer click middle` | Middle mouse click |
| `S` | `wlrctl pointer click right` | Right mouse click |
| `G` | `wlrctl pointer scroll 30 0` | Scroll cursor down (*repeating*) |
| `T` | `wlrctl pointer scroll -30 0` | Scroll cursor up (*repeating*) |
| `E` | `wlrctl pointer scroll 0 -30` | Scroll cursor left (*repeating*) |
| `R` | `wlrctl pointer scroll 0 30` | Scroll cursor right (*repeating*) |
| `Escape` | `submap("reset")` | Exit cursor submap + restore cursor autohide |

### Hardware-Specific (`modules/binds.lua`)

AMD (`hostname == "opalMMU"`):

| Key | Action / Command | Description |
|---|---|---|
| `XF86Calculator` | `vicinae vicinae://launch/calculator/history` | Open calculator history (Vicinae) |
| `XF86MonBrightnessUp` | `dms ipc call brightness increment 5 ...` | Increase display brightness by 5% (internal + external) |
| `XF86MonBrightnessDown` | `dms ipc call brightness decrement 5 ...` | Decrease display brightness by 5% (internal + external) |
| `SHIFT + XF86MonBrightnessDown` | `dms ipc call brightness toggleExponential ...` | Toggle exponential brightness curve (internal + external) |

NVIDIA (other hostnames):

| Key | Action / Command | Description |
|---|---|---|
| `XF86MonBrightnessUp` | `dms ipc call brightness increment 5 ...` | Increase display brightness by 5% (internal backlight) |
| `XF86MonBrightnessDown` | `dms ipc call brightness decrement 5 ...` | Decrease display brightness by 5% (internal backlight) |
| `SHIFT + XF86MonBrightnessDown` | `dms ipc call brightness toggleExponential ...` | Toggle exponential brightness curve (internal backlight) |

---

## Window Rules

### Border / Visual

| Match | Rules |
|---|---|
| `focus` + workspace `w[t1]` | `border_size 0` (no border for single tiled window) |
| tag `movetag` | `border_size 3`, `border_color red` (Catppuccin Mocha) |
| `float` (any) | `border_color mauve` |
| `fullscreen` | `border_size 0`, `rounding 0` |
| `fullscreen_state_internal = 1`, `fullscreen_state_client = 2` | `border_size 0`, `rounding 0` |
| `pin` | opacity `0.8 0.8` |

### Size / Layout

| Match class/title | Rules |
|---|---|
| `^(explorer\|kitty\|kittyterminal\|footclient)$` | `scrolling_width 0.5` |
| `org.remmina.Remmina` + title `Remmina Remote Desktop Client` | `scrolling_width 0.5` |
| `sioyek` | `scrolling_width 0.5` |
| title `^(Peek preview)$` | `no_focus`, `scrolling_width 0.5` |
| `ONLYOFFICE` | `tile` |
| `steam_app_.*` | `immediate` (allow tearing) |
| `.*` (all) | `suppress_event maximize` |

### Float / Center / Fixed Size

| Match class/title | Rules |
|---|---|
| `pulseUI` (class) | `float`, `center`, `900×750` $\rightarrow$ `special:pulsesecure` |
| `FortiClient` (initial class) | `float`, `center`, `900×750` $\rightarrow$ `special:forticlient` |
| `com.rtosta.zapzap\|whatsappweb-nativefier-d40211\|org.telegram.desktop` (initial) | `float`, `center`, `1600×960` $\rightarrow$ `special:whatsapp silent` |
| `com.github.th_ch.youtube_music\|spotube\|(YouTube Music for Desktop\|sung)` | `float`, `center`, `1600×960` $\rightarrow$ `special:trash silent` |
| `DesktopEditors` (onlyoffice popups) | `center` |
| `toipe\|jamesdsp\|hyprland-share-picker\|nm-connection-editor\|pavucontrol\|Gimp\|org.quickshell` | `float`, `center`, `1200×750` |
| `qt5ct\|qt6ct\|FortiClient\|yad` | `float`, `center` |
| title `Settings\|Hyprshot\|Open\|(Publish as PDF or XPS\|^Settings - .*\|^Warning:.*)` | `float`, `center`, `900×750` |
| title `LibreOffice` | `center` |
| title `.*Network Manager.*` | `float` |
| `waypaper\|qt6ct\|qt5ct` | `float`, `center`, `900×750` |
| initial title `(All files)\|([Ff]ile Upload.*)\|(Enter name of file to save to.*)\|(blob.*)\|(Open [Ff]iles)\|(Open folder.*)` | `float`, `center`, `1345×720` |
| `(soffice\|Save Image\|Save As\|xdg-desktop-portal-gtk)` | `float`, `center`, `1345×720` |
| `(blueman-manager)\|(com.network.manager)` (initial) | `float`, `1280×700`, `move (380,35)`, `animation slide`, `stay_focused` |
| `steam` (class) | `float` |
| `^(steam_app_.*)$` + initial title `^(..+)$` | `float` |
| `steam` + title `Steam\|(Sign in to Steam)` | `float`, `center`, `1600×960` $\rightarrow$ `special:steam silent` |
| `zen` + title `Picture-in-Picture` | `float`, `max 800×800` |
| `xwaylandvideobridge` | `float` (opacity `0.0 override`), `no_anim`, `no_focus`, `no_initial_focus` $\rightarrow$ `special:junks silent` |
| `update` + title `update` | `float`, `1280×700`, `move (380,43)`, `animation slide` $\rightarrow$ `special:update` |
| `nvim-hypr-anywhere` | `float`, `pin`, `center`, `1280×700`, `animation slide` |
| initial title `btop` | `float`, `pin`, `center`, `1280×700`, `animation popin` |
| initial title `ytm` | `float`, `center`, `1280×700`, `animation popin` |
| `scratch` + title `scratch` | `float`, `1440×700`, `move (240,377)`, `animation slide` |
| `^(cable-uhid-bridge)$` | `float`, `center` |
| title `^(Sung · Mini player)$` | `float`, `pin` |

### Grouping

| Match class | Rule |
|---|---|
| `whatsappweb-nativefier-d40211\|org.telegram.desktop\|spotube\|com.github.th_ch.youtube_music\|com.rtosta.zapzap\|FortiClient\|pulseUI` | `group set` (can be grouped into tabs) |
| `foot\|zen\|xdg-desktop-portal-gtk` | `group override barred` (cannot be tabbed) |

### Misc

| Match | Rules |
|---|---|
| `teams-for-linux` | `idle_inhibit focus` |
| title `noscreenshare` | `no_screen_share` |
| `whatsappweb-nativefier-d40211\|org.telegram.desktop\|spotube\|com.github.th_ch.youtube_music\|steam\|com.rtosta.zapzap` | `no_screen_share` — **dynamic rule**, toggle with `SUPER + SHIFT + O` |
| `^$` class + `^$` title + xwayland + float + not fullscreen + not pin | `no_focus` (fix XWayland drags) |

---

## Workspace Rules

### Special workspaces — commands run when opened empty (`on_created_empty`)

| Workspace | Command |
|---|---|
| `special:terminal` | `kitty --class=scratch -T scratch -e sesh connect WORK` |
| `special:trash` | `sung` (music player) |
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
| `w[tv1]` | `no_border`, `no_rounding`, `gaps_out 0`, `gaps_in 0` (full-screen slideshow) |
| `1, 2, 3, 4, 5` | pinned to primary monitor (`eDP-1`, base 0) |
| `6, 7, 8, 9, 10` | pinned to secondary monitor (base 5) |

Workspaces are assigned **5 per monitor** with names `一`, `二`, `三`, `四`, `五` applied dynamically per monitor. On monitor hotplug, windows are saved by workspace ID, moved onto `eDP-1`, and restored when reconnected.

`SUPER + 9` toggles the connected second monitor between extending the desktop and mirroring `eDP-1`. While mirroring, its windows are moved onto `eDP-1` and restored when toggled back. If no second monitor is connected, the chosen mode is remembered and applied to the next monitor that connects.

---

## Layer Rules (popups / OSD / overlays)

| Namespace | Rules |
|---|---|
| `rofi\|logout_dialog\|vicinae` | `dim_around`, `blur`, `animation popin` |
| `vicinae\|ghostty-quick-terminal\|kitty-quick-access` | `blur`, `above_lock 2`, `no_screen_share` |
| `swaync.*\|dms.*` | `no_screen_share` |
| `dms.bar` | `no_screen_share false` (screen share allowed) |
| `hyprhalt` | `blur`, `ignore_alpha 0` |
