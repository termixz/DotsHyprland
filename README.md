# 💫 Hyprland Custom Rice - Multi-Theme
#### Based on JaKooLit's Hyprland dots

A highly customized Hyprland (Wayland) environment on Arch Linux with multi-theme support
(Catppuccin, Dracula, Gruvbox, Rose Pine, Tokyo Night, Nordic, Kanagawa) driven by a set
of one-click theme scripts that restyle the whole desktop — including GRUB, SDDM,
terminals, GTK/QT apps and Waybar — plus a quickshell desktop overview panel.

---

## 🧩 What's Inside

| Component | Description |
|---|---|
| 🪟 Hyprland | Main compositor with modular config (`hypr/`) — Lua animation presets, wallust integration, monitor profiles |
| 📊 Waybar | Layouts & modules (`config`, `configs/`, `Modules/`, `ModulesCustom/`, `ModulesGroups/`, `ModulesVertical/`) switchable on the fly |
| ✨ Quickshell | Desktop overview panel (`qs`), autostarted (`config/quickshell/`) |
| 📋 SwayNC | Notification center with themed panels |
| 🔭 Rofi | Main launcher, theme picker, search scripts |
| 🎨 themesscript | Theme switcher (`Super + T`) — applies cursors/GTK/icons/wallpaper/waybar/rofi/swaync/kitty/sddm/grub/apps per theme |
| 🖼️ Wallpapers | pickers & helpers (`theme-wallpaper-picker.sh`, `hypr/UserScripts/Wallpaper*.sh`) |
| 🖥️ Kitty | Terminal (Dracula + Catppuccin variants, url hints, tabs) |
| ✢️ Neovim | Editor config (`config/nvim/`) |
| 🎵 Spicetify | Themed Spotify (`config/spicetify/`) |
| 🔮 Obsidian | Vault `.obsidian` config — plugins, themes, appearance (`obsidian/`) |
| 🎨 VS Code (Code - OSS) | `config/Code - OSS/User/` + `vscode-oss/` (argv.json + installed extensions) |
| 🐚 zsh | oh-my-zsh (git, archlinux, syntax-highlighting, autosuggestions) + **Powerlevel10k** (`~/.p10k.zsh`) + custom aliases |
| 🚀 fastfetch | Compact fetch (`config/fastfetch/`) |
| 📷 Others | cava, swappy, btop, gtk-3/4, qt5ct/qt6ct, Thunar, wlogout, xarchiver, yay |

---

## 📂 Repository Structure

```text
Dots/
├── config/           # configs copied into ~/.config/
├── firefox/          # Firefox themes & extensions (chrome, user.js)
├── grub/             # GRUB themes (Catppuccin, Dracula, Gruvbox, Nord, RosePine, TokyoNight, starfield...)
├── icons/            # cursor & icon themes (Dracula, Papirus, Catppuccin cursors...)
├── obsidian/         # Obsidian app.json, plugins, themes
├── Pictures/         # wallpapers + fastfetch assets
├── sddm/             # SDDM theme (simple_sddm_2) + sddm.conf
├── spicetify/        # legacy top-level Spicetify copy — see config/spicetify
├── spotifyPKG/       # packaging helper
├── themes/           # GTK 2/3/4, Cinnamon, GNOME Shell themes
├── vscode-oss/       # VS Code: argv.json + installed extensions
└── zsh/              # oh-my-zsh custom dirs
```

> Most things live in `config/` and get deployed with one `cp -r`.

---

## 🚀 Manual Installation

### 1. AUR helper (yay)
```bash
sudo pacman -Syu --needed base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin && makepkg -si
```

### 2. Core Dependencies
```bash
# Hyprland stack
yay -S --needed hyprland waybar quickshell swaync rofi-wayland awww hyprlock hypridle \
  wlogout nwg-look wallust kitty pywal-16-colors pavucontrol grimblast-git slurp swappy

# Fonts & Icons
yay -S --needed ttf-firacode-nerd ttf-font-awesome noto-fonts-emoji papirus-icon-theme

# Utilities & CLI
yay -S --needed fastfetch cava zsh neovim tty-clock pipes.sh thunar xarchiver btop \
  oh-my-zsh powerlevel10k
```

### 3. Deploy configs
```bash
# .config dirs (maps each folder in config/ into ~/.config/)
cp -r config/* ~/.config/

# Wallpapers
mkdir -p ~/Pictures/wallpapers
cp -r Pictures/wallpapers/* ~/Pictures/wallpapers/
```

### 4. zsh
```bash
# plugins must be present under $ZSH_CUSTOM/plugins:
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

cp zsh/.zshrc ~/ && cp zsh/.p10k.zsh ~/
```

> `swww` is aliased to `awww` (a fork with image-name support) in `zsh/.zshrc`, so only `awww` needs installing.

---

## 🔧 Component Setup

### 🎵 Spotify (Spicetify)
```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify backup apply
```

### 🖥️ SDDM & GRUB
```bash
# SDDM
sudo cp -r sddm/simple_sddm_2 /usr/share/sddm/themes/
sudo cp sddm/sddm.conf /etc/sddm.conf

# GRUB (pick any theme dir)
sudo cp -r grub/<theme-name> /usr/share/grub/themes/
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 📝 Sudoers (for theme scripts)
```text
# visudo — add at the end:
YourUser ALL=(ALL) NOPASSWD: /usr/bin/sed *, /etc/default/grub
YourUser ALL=(ALL) NOPASSWD: /usr/bin/sed *, /usr/share/sddm/themes/simple_sddm_2/metadata.desktop
YourUser ALL=(ALL) NOPASSWD: /usr/bin/grub-mkconfig *
YourUser ALL=(ALL) NOPASSWD: /bin/cp
```

---

## ⌨️ Keybindings

| Bind | Action |
|---|---|
| `Super + Q` | Close window |
| `Super + Return` | Terminal (kitty) |
| `Super + D` | App launcher (rofi drun) |
| `Super + W` / `Super + Shift + W` | Theme & wallpaper picker / wallpaper effects |
| `Super + T` | rofi theme switcher |
| `Ctrl + Alt + L` | Lock screen (hyprlock) |
| `Ctrl + Alt + P` | Power menu (wlogout) |
| `Super + Shift + N` | SwayNC notification panel |
| `Super + Shift + E` | KooL settings menu |
| `Super + S` | Rofi web search |
| `Super + Alt + V` | Clipboard manager |
| `Super + Alt + W` | Waybar layout switcher |
| `Super + Shift + F` | Fullscreen |
| `Super + Space` | Toggle floating |
| `Super + Shift + Return` | Drop-down terminal |
| `Super + Print / Shift + Print` | Screenshot / area screenshot |
| `Super + Alt + L` | Toggle Master / Dwindle layout |
| `Super + Shift + G` | Game mode (toggle animations) |

Full list: `hypr/configs/Keybinds.conf` + `hypr/UserConfigs/UserKeybinds.conf`.

---

## 🎨 Theme Switching

The main driver is `Super + T` → `rofi-theme-launcher.sh` → one script per theme in
`hypr/scripts/themesscript/` (Dracula, Catppuccin, GruvBox, Nord, RosePine, RosePineDawn,
TokyoNight…). Each script applies its theme everywhere at once:

| Layer | How it's applied |
|---|---|
| Cursors | `gsettings` + `hyprctl setcursor` (+ patch `hypr/lua/Startup_Apps.lua`) |
| GTK theme & icons | `gsettings` (dconf is the source of truth; `gtk/*/settings.ini` is fallback) |
| Wallpaper | random pick from `Pictures/wallpapers/Dynamic-Wallpapers/<Theme>/` → `awww img` |
| Hyprlock | `hypr/hyprlockthemes/<Theme>.conf` → `hyprlock.conf` |
| SDDM | `sed` config in `metadata.desktop` + copy wallpaper to `Backgrounds/` |
| GRUB | `sed` `GRUB_THEME=` in `/etc/default/grub` + `grub-mkconfig` |
| Terminal stack | `kitten themes` for kitty, color aliases for `cava`/`pipes.sh`/`tty-clock`/`lavat` written into `~/.zshrc` |
| Apps | nvim, Obsidian, VS Code, Firefox `userChrome`, spicetify, Steam (millennium), cavalier, fastfetch wallpaper, opencode theme |

Wallpapers also have their own pickers: `Super + W` → `theme-wallpaper-picker.sh` (rofi
selection), and `hypr/UserScripts/Wallpaper*.sh` helpers (AutoChange / Random / Select /
Effects) used by lockscreen & fastfetch pipelines.

> The repository mirrors the whole `hypr/scripts/` and `hypr/UserScripts/` set even if
> some helpers (e.g. `DarkLight.sh`, parts of `initial-boot.sh`) are not actively called
> at the moment — they are kept for completeness. wallust still produces the color files
> the rofi themes are picked from (`config/rofi/wallust/`).
