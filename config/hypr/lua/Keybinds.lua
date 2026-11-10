local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"
local UserScripts = os.getenv("HOME") .. "/.config/hypr/UserScripts"

local terminal = "kitty"
local fileManager = "thunar"

local kbdBrightnessDown = hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --dec")
local kbdBrightnessUp   = hl.dsp.exec_cmd(scriptsDir .. "/BrightnessKbd.sh --inc")

hl.bind("SUPER + T",                             hl.dsp.exec_cmd(scriptsDir .. "/rofi-theme-launcher.sh"))
hl.bind("SUPER + ALT + CTRL + S",                hl.dsp.exec_cmd("spotify-launcher"))
hl.bind("SUPER + ALT + CTRL + C",                hl.dsp.exec_cmd('kitty -e zsh -i -c "tty-clock"'))
hl.bind("SUPER + ALT + CTRL + A",                hl.dsp.exec_cmd("kitty -e cava"))
hl.bind("SUPER + ALT + CTRL + P",                hl.dsp.exec_cmd('kitty -e zsh -i -c "pipes.sh"'))

hl.bind("CTRL + ALT + Delete",                   hl.dsp.exit())
hl.bind("SUPER + Q",                             hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q",                     hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"))
hl.bind("CTRL + ALT + L",                        hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"))
hl.bind("CTRL + ALT + P",                        hl.dsp.exec_cmd(scriptsDir .. "/Wlogout.sh"))
hl.bind("SUPER + SHIFT + N",                     hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("SUPER + SHIFT + E",                     hl.dsp.exec_cmd(scriptsDir .. "/Kool_Quick_Settings.sh"))

hl.bind("SUPER + CTRL + D",                      hl.dsp.layout("removemaster"))
hl.bind("SUPER + I",                             hl.dsp.layout("addmaster"))
hl.bind("SUPER + J",                             hl.dsp.layout("cyclenext"))
hl.bind("SUPER + K",                             hl.dsp.layout("cycleprev"))
hl.bind("SUPER + CTRL + Return",                 hl.dsp.layout("swapwithmaster"))

hl.bind("SUPER + SHIFT + I",                     hl.dsp.layout("togglesplit"))
hl.bind("SUPER + P",                             hl.dsp.window.pseudo())
hl.bind("SUPER + M",                             hl.dsp.exec_cmd("hyprctl dispatch splitratio 0.3"))

hl.bind("SUPER + G",                             hl.dsp.group.toggle())
hl.bind("SUPER + CTRL + tab",                    hl.dsp.group.next())

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind("XF86AudioRaiseVolume",                  hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"),          { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",                  hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"),          { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",                      hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"),   { locked = true })
hl.bind("XF86AudioMute",                         hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"),       { locked = true })
hl.bind("XF86Sleep",                             hl.dsp.exec_cmd("systemctl suspend"),                       { locked = true })
hl.bind("XF86Rfkill",                            hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"),          { locked = true })

hl.bind("XF86AudioPause",                        hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"),     { locked = true })
hl.bind("XF86AudioPlay",                         hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"),     { locked = true })
hl.bind("XF86AudioNext",                         hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"),       { locked = true })
hl.bind("XF86AudioPrev",                         hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"),       { locked = true })
hl.bind("XF86AudioStop",                         hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --stop"),      { locked = true })

hl.bind("SUPER + Print",                         hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
hl.bind("SUPER + SHIFT + Print",                 hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind("SUPER + CTRL + Print",                  hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind("SUPER + CTRL + SHIFT + Print",          hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"))
hl.bind("ALT + Print",                           hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"))
hl.bind("SUPER + SHIFT + S",                     hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))

hl.bind("SUPER + SHIFT + left",                  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + right",                 hl.dsp.window.resize({ x = 50, y = 0, relative = true }),  { repeating = true })
hl.bind("SUPER + SHIFT + up",                    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + down",                  hl.dsp.window.resize({ x = 0, y = 50, relative = true }),  { repeating = true })

hl.bind("SUPER + CTRL + left",                   hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + right",                  hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + up",                     hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + down",                   hl.dsp.window.move({ direction = "d" }))

hl.bind("SUPER + ALT + left",                   hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + ALT + right",                  hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + ALT + up",                     hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + ALT + down",                   hl.dsp.window.swap({ direction = "d" }))

hl.bind("SUPER + left",                          hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right",                         hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up",                            hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down",                          hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + tab",                           hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + SHIFT + tab",                   hl.dsp.focus({ workspace = "m-1" }))

hl.bind("SUPER + SHIFT + U",                     hl.dsp.window.move({ workspace = "special" }))
hl.bind("SUPER + U",                             hl.dsp.workspace.toggle_special(""))

for i = 1, 10 do
    local code = i + 9
    local workspace = tostring(i % 10 == 0 and 10 or i)

    hl.bind("SUPER + code:" .. code,             hl.dsp.focus({ workspace = workspace }))
    hl.bind("SUPER + SHIFT + code:" .. code,     hl.dsp.window.move({ workspace = workspace }))
    hl.bind("SUPER + CTRL + code:" .. code,      hl.dsp.window.move({ workspace = workspace, follow = false }))
end

hl.bind("SUPER + SHIFT + bracketleft",           hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + bracketright",          hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + CTRL + bracketleft",            hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind("SUPER + CTRL + bracketright",           hl.dsp.window.move({ workspace = "+1", follow = false }))

hl.bind("SUPER + mouse_down",                    hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",                      hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + period",                        hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + comma",                         hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + mouse:272",                     hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273",                     hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + D",                             hl.dsp.exec_cmd("pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window"))
hl.bind("SUPER + B",                             hl.dsp.exec_cmd('xdg-open "https://"'))
hl.bind("SUPER + Return",                        hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E",                             hl.dsp.exec_cmd(fileManager))

hl.bind("SUPER + S",                             hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"))
hl.bind("SUPER + ALT + O",                       hl.dsp.exec_cmd(scriptsDir .. "/ChangeBlur.sh"))
hl.bind("SUPER + SHIFT + G",                     hl.dsp.exec_cmd(scriptsDir .. "/GameMode.sh"))
hl.bind("SUPER + ALT + L",                       hl.dsp.exec_cmd(scriptsDir .. "/ChangeLayout.sh"))
hl.bind("SUPER + ALT + V",                       hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"))

hl.bind("SUPER + SHIFT + F",                     hl.dsp.window.fullscreen())
hl.bind("SUPER + SPACE",                         hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + ALT + SPACE",                   hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))
hl.bind("SUPER + SHIFT + Return",                hl.dsp.exec_cmd(scriptsDir .. "/Dropterminal.sh " .. terminal))

local function zoom(multiply)
    local current = hl.get_config("cursor.zoom_factor")
    if type(current) ~= "number" or current < 1 then
        current = 1
    end
    current = current * multiply
    if current < 1 then
        current = 1
    end
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + ALT + mouse_down", function()
    zoom(2.0)
end)
hl.bind("SUPER + ALT + mouse_up", function()
    zoom(0.5)
end)

hl.bind("SUPER + V",                             hl.dsp.exec_cmd(scriptsDir .. "/VpnToggle.sh"))
hl.bind("SUPER + ALT + W",                       hl.dsp.exec_cmd(scriptsDir .. "/WaybarSwitcher.sh"))
hl.bind("SUPER + ALT + D",                       hl.dsp.exec_cmd(scriptsDir .. "/DNSToggleScript.sh"))

hl.bind("SUPER + CTRL + ALT + B",                hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

hl.bind("SUPER + W",                             hl.dsp.exec_cmd(scriptsDir .. "/theme-wallpaper-picker.sh"))
hl.bind("SUPER + SHIFT + W",                     hl.dsp.exec_cmd(UserScripts .. "/WallpaperEffects.sh"))
hl.bind("SUPER + CTRL + O",                      hl.dsp.exec_cmd("hyprctl setprop active opaque toggle"))
hl.bind("SUPER + SHIFT + A",                     hl.dsp.exec_cmd(scriptsDir .. "/Animations.sh"))
hl.bind("SUPER + SHIFT + O",                     hl.dsp.exec_cmd(UserScripts .. "/ZshChangeTheme.sh"))

hl.bind("XF86KbdBrightnessDown",                 kbdBrightnessDown, { repeating = true })
hl.bind("XF86KbdBrightnessUp",                   kbdBrightnessUp, { repeating = true })
hl.bind("XF86Launch1",                           hl.dsp.exec_cmd("rog-control-center"))
hl.bind("XF86Launch3",                           hl.dsp.exec_cmd("asusctl led-mode -n"))
hl.bind("XF86Launch4",                           hl.dsp.exec_cmd("asusctl profile -n"))
hl.bind("XF86MonBrightnessDown",                 hl.dsp.exec_cmd(scriptsDir .. "/Brightness.sh --dec"), { repeating = true })
hl.bind("XF86MonBrightnessUp",                   hl.dsp.exec_cmd(scriptsDir .. "/Brightness.sh --inc"), { repeating = true })
hl.bind("XF86TouchpadToggle",                    hl.dsp.exec_cmd(scriptsDir .. "/TouchPad.sh"))

hl.bind("SUPER + F6",                            hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
hl.bind("SUPER + SHIFT + F6",                    hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind("SUPER + CTRL + F6",                     hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind("SUPER + ALT + F6",                      hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"))
hl.bind("ALT + F6",                              hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"))

hl.device({
    name = "asue1209:00-04f3:319f-touchpad",
    enabled = true,
})
