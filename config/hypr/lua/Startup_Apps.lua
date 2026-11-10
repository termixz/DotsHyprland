local HOME = os.getenv("HOME")
local scriptsDir = HOME .. "/.config/hypr/scripts"
local UserScripts = HOME .. "/.config/hypr/UserScripts"
local wallDIR = HOME .. "/Pictures/wallpapers"
local lock = scriptsDir .. "/LockScreen.sh"
local AwwwRandom = UserScripts .. "/WallpaperAutoChange.sh"
local livewallpaper = ""

hl.on("hyprland.start", function ()
    hl.exec_cmd("python3 -m http.server 8000 --directory " .. HOME .. "/.config/firefox-custom-addons/")
    hl.exec_cmd("sudo modprobe -r r8169")
    hl.exec_cmd("sudo modprobe r8169")
    hl.exec_cmd("hyprctl setcursor BreezeX-RosePine-Linux 24")
    hl.exec_cmd("awww-daemon --format xrgb")
    hl.exec_cmd("firefox")
    hl.exec_cmd("telegram-desktop")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("swaync")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("qs")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hypridle")
    -- hl.exec_cmd(AwwwRandom .. " " .. wallDIR) -- random wallpaper switcher every 30 minutes
    -- hl.exec_cmd(scriptsDir .. "/Polkit-NixOS.sh")
    -- hl.exec_cmd(scriptsDir .. "/PortalHyprland.sh")
    -- hl.exec_cmd("mpvpaper '*' -o \"load-scripts=no no-audio --loop\" " .. livewallpaper)
end)
