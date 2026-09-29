# Ricing Documentation

Detail ricing yang sudah dilakukan.

## 🎨 Material You / Dynamic Color

Warna otomatis berubah berdasarkan wallpaper. Scheme disimpan di:
- `~/.config/hypr/scheme/current.lua` — warna aktif
- `~/.config/hypr/scheme/default.lua` — warna default
- `~/.local/state/caelestia/scheme.json` — scheme dari wallpaper

Update scheme:
```bash
caelestia wallpaper -f <wallpaper_path>
```

## 🔒 Lock Screen

Config di `~/.config/caelestia/shell.json`:
```json
"lock": {
    "enabled": true,
    "useWallpaper": true,
    "hideNotifs": false,
    "recolourLogo": true
}
```

Lock screen components: `quickshell/modules/lock/`
- Clock — Material You primary/secondary colors
- PasswordInput — surfaceContainer background, full rounded
- ProfilePic — user avatar (~/.face)
- NotifDock — notifications on lock screen

## 🔔 Notifications

Config: `~/.config/caelestia/shell.json`
```json
"notifs": {
    "actionOnClick": false,
    "openExpanded": true
}
```

Components: `quickshell/modules/notifications/Notification.qml`
- Normal: surfaceContainer background
- Critical: secondaryContainer background
- Radius: Tokens.rounding.large
- Swipe right to dismiss, swipe down to expand

## 🖥️ GRUB Theme

File: `/usr/share/grub/themes/SleekTheme-Dark/sleek/`

Changes:
- Font: **JetBrains Mono Nerd Font** (converted via `grub-mkfont`)
- Background: anime wallpaper (1366x768)
- Text: "Welcome Back" + "Choose your system"
- Menu: semi-transparent background (rgba(0,0,0,0.5))
- Colors: Material You (white text on dark)

Config: `/etc/default/grub`
```
GRUB_THEME="/usr/share/grub/themes/SleekTheme-Dark/sleek/theme.txt"
GRUB_TERMINAL_OUTPUT=gfxterm
GRUB_GFXMODE=1366x768
```

Regenerate: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

## 🖥️ Terminal (Kitty + Foot)

Material You colors matching scheme:
- Background: `#0a0f0f`
- Foreground: `#dce8e6`
- Accent: `#9bd0cc` (cyan-ish)
- Selection: `#255b58`
- Font: JetBrains Mono Nerd Font, size 10
- Opacity: 0.75

## 📋 Clipboard

Keybind: `SUPER + V`

Script: `~/.local/bin/clipmenu` (wofi picker)
- Text entries → decode + wl-copy
- Image entries → decode + wl-copy (binary)
- `SUPER + ALT + V` → delete entry

Storage: cliphist
- `wl-paste --type text --watch cliphist store`
- `wl-paste --type image --watch cliphist store`

## 📸 Screenshot

Scripts: `~/.local/bin/screenshot-{full,region,freeze}`
- Save to `~/Pictures/Screenshots/`
- Auto-copy to clipboard (`wl-copy`)
- Notify via `notify-send`

Keybind: `SUPER + SHIFT + S` (full)

## 🔄 Profile Switcher

Script: `~/.local/bin/switch-hypr`

Two profiles:
1. **Hyprland** — CachyOS default config (`~/.config/hypr.cachyos/`)
2. **Caelestia** — Caelestia config (`~/.config/hypr.caelstia/`)

Login sessions:
- `hyprland.desktop` → Hyprland (CachyOS)
- `hyprland-caelestia.desktop` → Caelestia

## 📦 Packages Required

```bash
# Core
hyprland quickshell caelestia-shell caelestia-cli

# Terminal
kitty foot

# Tools
grim slurp wl-clipboard cliphist wofi fuzzel

# Fonts
ttf-jetbrains-mono-nerd ttf-font-awesome

# Theme
papirus-icon-theme bibata-cursor-theme

# Extras
file-roller thunar-archive-plugin swww
```
