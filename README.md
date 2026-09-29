# EndeavourOS / CachyOS Rice & Dotfiles

Ricing **Caelestia + Hyprland** oleh **naidrahiqa**.

## 📁 Struktur

| Folder | Isi |
|--------|-----|
| `hypr/` | Config Hyprland (keybinds, animations, rules, scheme Material You) |
| `caelestia/` | Config Caelestia shell (shell.json, hypr-vars, monitors) |
| `quickshell/` | Full Caelestia QuickShell (lock screen, notif, bar, launcher, dll) |
| `kitty/` | Kitty terminal theme (Material You) |
| `foot/` | Foot terminal theme (Material You) |
| `grub/` | GRUB theme (JetBrains Mono font, Material You colors) |
| `wofi/` | Clipboard picker style (SUPER+V) |
| `fuzzel/` | Fuzzel launcher style |
| `gtk/` | GTK icon/cursor settings |
| `scripts/` | Screenshot, clipboard, profile switcher scripts |

## 🚀 Install

```bash
# Clone
git clone https://github.com/naidrahiqa/endeavouros-rice.git
cd endeavouros-rice

# Copy configs
cp -r hypr/* ~/.config/hypr/
cp -r caelestia/* ~/.config/caelestia/
cp -r quickshell/* ~/.config/quickshell/caelestia/
cp kitty/kitty.conf ~/.config/kitty/
cp foot/foot.ini ~/.config/foot/
cp wofi/style.css ~/.config/wofi/
cp fuzzel/fuzzel.ini ~/.config/fuzzel/

# Copy scripts
sudo cp scripts/screenshot-* scripts/clipmenu /usr/local/bin/
sudo cp scripts/hyprland-caelestia.desktop /usr/share/wayland-sessions/

# GRUB theme
sudo cp grub/theme.txt /usr/share/grub/themes/SleekTheme-Dark/sleek/theme.txt
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## 🖥️ Specs

- **OS**: CachyOS (Arch-based)
- **WM**: Hyprland
- **Shell**: Caelestia (QuickShell)
- **Theme**: Material You (dynamic from wallpaper)
- **Terminal**: Kitty + Foot
- **Font**: JetBrains Mono Nerd Font
- **Cursor**: Bibata-Modern-Ice
- **Icons**: Papirus-Dark

## 📸 Preview

Ricing includes:
- **Lock screen** — Material You clock, profile pic, password input
- **Notifications** — Material You cards, swipe to dismiss
- **GRUB** — custom theme + JetBrains Mono font + anime wallpaper
- **Terminal** — Material You colors (kitty + foot)
- **Clipboard** — SUPER+V picker with image paste support
- **Screenshot** — auto-save + auto-copy to clipboard
- **Profile switcher** — Hyprland (CachyOS) vs Caelestia at login

## ⌨️ Keybinds Penting

| Key | Action |
|-----|--------|
| `SUPER + V` | Clipboard picker (wofi) |
| `SUPER + ALT + V` | Delete clipboard entry |
| `SUPER + SHIFT + S` | Screenshot (full, auto-copy) |
| `SUPER + SHIFT + P` | Toggle performance mode |
| `SUPER + L` | Lock screen |
| `SUPER + V` | Clipboard |
| `SUPER + Period` | Emoji picker |
