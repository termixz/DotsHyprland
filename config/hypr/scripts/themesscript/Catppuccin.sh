#!/bin/zsh

CONFIG_FILE="$HOME/.config/hypr/pathtonotes.conf"

if [ -f "$CONFIG_FILE" ]; then
    OBSIDIAN_VAULT=$(cat "$CONFIG_FILE")
else
    echo "Enter full path to your Obsidian vault (example: ~/.config/obsidian/notes/ MANDATORY / at the end):"
    read -r OBSIDIAN_VAULT
    echo "$OBSIDIAN_VAULT" > "$CONFIG_FILE"
fi

COLOR_HEX="#8aadf4"
COLOR_ANSI="4"
gsettings set org.gnome.desktop.interface cursor-theme 'catppuccin-macchiato-dark-cursors'
gsettings set org.gnome.desktop.interface cursor-size 24
hyprctl setcursor catppuccin-macchiato-dark-cursors 24
CURSOR_LUA="$HOME/.config/hypr/lua/Startup_Apps.lua"
sed -E -i 's|hyprctl setcursor [A-Za-z0-9-]+ 24|hyprctl setcursor catppuccin-macchiato-dark-cursors 24|' "$CURSOR_LUA"
mv $HOME/.config/gtk-3.0/gtk.css* $HOME/.config/gtk-3.0/gtk.css.disabled
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin"
gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-SE"

DECOR_LUA="$HOME/.config/hypr/lua/Decorations.lua"
sed -E -i 's/active_border = "rgb\([0-9a-fA-F,]*\)"/active_border = "rgb(89b4fa)"/' "$DECOR_LUA"
sed -E -i 's/inactive_border = "rgb\([0-9a-fA-F,]*\)"/inactive_border = "rgb(6e738d)"/' "$DECOR_LUA"
hyprctl reload 2>/dev/null || true

WALL_DIR="$HOME/Pictures/wallpapers/Dynamic-Wallpapers/Catppuccin/"
CURRENTWALL="$HOME/Pictures/wallpapers/current"
WALL=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
mkdir -p "$CURRENTWALL"
rm -f "$CURRENTWALL"/*
cp "$WALL" "$CURRENTWALL/"
if command -v awww &> /dev/null; then
    pgrep -x awww-daemon > /dev/null || awww-daemon &
    sleep 0.5
    awww img "$WALL" --transition-type any --transition-fps 60 --transition-duration 1
fi

HYPRLOCK_CONFIG="$HOME/.config/hypr/hyprlockthemes/Catppuchine.conf"
[ -f "$HYPRLOCK_CONFIG" ] && cp "$HYPRLOCK_CONFIG" "$HOME/.config/hypr/hyprlock.conf"

sudo sed -i 's/ConfigFile=Themes\/.*/ConfigFile=Themes\/Catppuccin.conf/' /usr/share/sddm/themes/simple_sddm_2/metadata.desktop
sudo sed -i 's/^Inherits=.*/Inherits=catppuccin-macchiato-dark-cursors/' /usr/share/icons/default/index.theme
sudo cp "$HOME"/Pictures/wallpapers/current/* /usr/share/sddm/themes/simple_sddm_2/Backgrounds/default

WALLALLDIREC="$HOME/Pictures/fastfetch/catppuchine"
WALLFASTDIREC="$HOME/Pictures/fastfetch/curent"
mkdir -p "$WALLFASTDIREC"
WALLFAST=$(find "$WALLALLDIREC" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
rm -f "$WALLFASTDIREC"/*
cp "$WALLFAST" "$WALLFASTDIREC/"

kitten themes --reload-in=all Catppuccin-Macchiato

OPENCODE_CLI="$HOME/.config/opencode/cli.json"
if [ -f "$OPENCODE_CLI" ]; then
    jq '.theme.name = "catppuccin-macchiato" | .theme.mode = "dark"' "$OPENCODE_CLI" > "$OPENCODE_CLI.tmp" && mv "$OPENCODE_CLI.tmp" "$OPENCODE_CLI"
else
    echo '{"$schema": "https://opencode.ai/v2/cli.json", "theme": {"name": "catppuccin-macchiato", "mode": "dark"}}' > "$OPENCODE_CLI"
fi
python3 "$HOME/.config/opencode/bin/opencode-desktop-theme.py" catppuccin-macchiato dark "$HOME/.config/opencode/themes-desktop/catppuccin-macchiato-dark.css"

CAVA_CONFIG="$HOME/.config/cava/config"
sed -i "s|^background *=.*|background = default|" "$CAVA_CONFIG"
sed -i "s|^foreground *=.*|foreground = '$COLOR_HEX'|" "$CAVA_CONFIG"
sed -i "s|^gradient *=.*|gradient = 0|" "$CAVA_CONFIG"

PIPES="pipes.sh -c $COLOR_ANSI -f 60"
sed -i "s|^alias pipes\.sh=.*|alias pipes.sh='$PIPES'|" "$HOME/.zshrc"
CLOCK="tty-clock -c -C $COLOR_ANSI -D"
sed -i "s|^alias tty-clock=.*|alias tty-clock='$CLOCK'|" "$HOME/.zshrc"
case "$COLOR_ANSI" in
    0) COLOR_NAME="black" ;;
    1) COLOR_NAME="red" ;;
    2) COLOR_NAME="green" ;;
    3) COLOR_NAME="yellow" ;;
    4) COLOR_NAME="blue" ;;
    5) COLOR_NAME="magenta" ;;
    6) COLOR_NAME="cyan" ;;
    *) COLOR_NAME="white" ;;
esac
LAVAT="lavat -c $COLOR_NAME"
if rg -q '^alias lavat=' "$HOME/.zshrc"; then
    sed -i "s|^alias lavat=.*|alias lavat='$LAVAT'|" "$HOME/.zshrc"
else
    echo "alias lavat='$LAVAT'" >> "$HOME/.zshrc"
fi

if pgrep -x "lavat" > /dev/null; then
    pkill -x "lavat"
    kitty -e zsh -ic "lavat" & disown
fi
if pgrep -x "tty-clock" > /dev/null; then
    pkill -x "tty-clock"
    kitty -e zsh -ic "tty-clock" & disown
fi

NVIM_CONFIG="$HOME/.config/nvim/init.vim"
if [ -f "$NVIM_CONFIG" ]; then
    sed -i "s/theme = '.*'/theme = 'catppuccin-macchiato'/" "$NVIM_CONFIG"
    sed -i "s/flavour = '.*'/flavour = 'macchiato'/" "$NVIM_CONFIG"
    sed -i "s/^colorscheme .*$/colorscheme catppuccin-macchiato/" "$NVIM_CONFIG"
    pkill -x nvim
fi

OBSIDIAN_CONFIG="$OBSIDIAN_VAULT.obsidian/appearance.json"
if [ -f "$OBSIDIAN_CONFIG" ]; then
    sed -i 's/"cssTheme": *".*"/"cssTheme": "Catppuccin"/' "$OBSIDIAN_CONFIG"
    sed -i 's/"theme": *".*"/"theme": "obsidian"/' "$OBSIDIAN_CONFIG"
    if pgrep -f "obsidian" > /dev/null; then
        pkill -f "obsidian"
        obsidian "$OBSIDIAN_VAULT" & disown
    fi
fi

VSCODE_SETTINGS="$HOME/.config/Code - OSS/User/settings.json"
if [ -f "$VSCODE_SETTINGS" ]; then
    sed -i 's/"workbench.colorTheme": *".*"/"workbench.colorTheme": "Catppuccin Macchiato"/' "$VSCODE_SETTINGS"
fi

ROFI_CONFIG="$HOME/.config/rofi/style.rasi"
sed -i 's|^@theme.*|@theme "~/.config/rofi/wallust/Cattpuchine.rasi"|' "$ROFI_CONFIG"

PROFILE_DIR=$(find "$HOME/.mozilla/firefox" -maxdepth 1 -type d -name "*.default-release" | head -n 1)
if [ -d "$PROFILE_DIR" ]; then
    cp -f "$HOME/.config/firefox-themes/cattpuchin/userChrome.css" "$PROFILE_DIR/chrome/"
    cp -f "$HOME/.config/firefox-themes/cattpuchin/index.html" "$HOME/.config/firefox-custom-addons/index.html"
    pkill -x firefox && nohup firefox &> /dev/null &
fi

pkill swaync
cp "$HOME/.config/swaync/Themes/Catppuccin.css" "$HOME/.config/swaync/style.css"
swaync & disown

spicetify config color_scheme catppuccin-macchiato
if pgrep -x "spotify" > /dev/null; then
    spicetify apply -n
    pkill -x spotify
    spotify & disown
else
    spicetify apply -n
fi

cp "$HOME/.config/millennium/colors/catppuccin-macchiato.css" "$HOME/.config/millennium/quick.css"

cp "$HOME/.config/waybar/style/Catppuchin.css" "$HOME/.config/waybar/style.css"
killall waybar && waybar & disown

CAVALIER_CONF="$HOME/.var/app/org.nickvision.cavalier/config/Nickvision Cavalier/config.json"
if [ -f "$CAVALIER_CONF" ]; then
    sed -i -E 's/"ActiveProfile": [0-9]+/"ActiveProfile": 2/' "$CAVALIER_CONF"
fi

THEMEFOLDER="/usr/share/grub/themes/"
THEME="catppuccin-macchiato-grub-theme"
GRUBCONF="/etc/default/grub"
if grep -q "^GRUB_THEME=" "$GRUBCONF"; then
   sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"${THEMEFOLDER}${THEME}/theme.txt\"|" "$GRUBCONF"
else
    echo "GRUB_THEME=\"${THEMEFOLDER}${THEME}/theme.txt\"" | sudo tee -a "$GRUBCONF" > /dev/null
fi
sudo grub-mkconfig -o /boot/grub/grub.cfg
