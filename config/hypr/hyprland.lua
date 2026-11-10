package.path = package.path
    .. ";" .. os.getenv("HOME") .. "/.config/hypr/lua/?.lua"
    .. ";" .. os.getenv("HOME") .. "/.config/hypr/?.lua"

require("monitors")
require("ENVariables")
require("Settings")
require("Decorations")
require("Animations")

do
    local f = io.open(os.getenv("HOME") .. "/.config/hypr/lua/UserAnimations.lua")
    if f then
        f:close()
        require("UserAnimations")
    end
end

require("WindowRules")
require("Keybinds")
require("Startup_Apps")

hl.on("hyprland.start", function()
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/initial-boot.sh")
end)
