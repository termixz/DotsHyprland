local tagRules = {
    { tag = "browser",          class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" },
    { tag = "browser",          class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" },
    { tag = "browser",          class = "^(chrome-.+-Default)$" },
    { tag = "browser",          class = "^([Cc]hromium)$" },
    { tag = "browser",          class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" },
    { tag = "browser",          class = "^(Brave-browser(-beta|-dev|-unstable)?)$" },
    { tag = "browser",          class = "^([Tt]horium-browser|[Cc]achy-browser)$" },
    { tag = "browser",          class = "^(zen-alpha|zen)$" },
    { tag = "notif",            class = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$" },
    { tag = "KooL_Cheat",       title = "^(KooL Quick Cheat Sheet)$" },
    { tag = "KooL_Settings",    title = "^(KooL Hyprland Settings)$" },
    { tag = "KooL-Settings",    class = "^(nwg-displays|nwg-look)$" },
    { tag = "terminal",         class = "^(Alacritty|kitty|kitty-dropterm)$" },
    { tag = "email",            class = "^([Tt]hunderbird|org.mozilla.Thunderbird)$" },
    { tag = "email",            class = "^(eu.betterbird.Betterbird)$" },
    { tag = "email",            class = "^(org.gnome.Evolution)$" },
    { tag = "projects",         class = "^(codium|codium-url-handler|VSCodium)$" },
    { tag = "projects",         class = "^(VSCode|code|code-url-handler)$" },
    { tag = "projects",         class = "^(jetbrains-.+)$" },
    { tag = "projects",         class = "^(dev.zed.Zed|antigravity)$" },
    { tag = "screenshare",      class = "^(com.obsproject.Studio)$" },
    { tag = "im",               class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" },
    { tag = "im",               class = "^([Ff]erdium)$" },
    { tag = "im",               class = "^([Ww]hatsapp-for-linux)$" },
    { tag = "im",               class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" },
    { tag = "im",               class = "^(teams-for-linux)$" },
    { tag = "im",               class = "^(im.riot.Riot|Element)$" },
    { tag = "games",            class = "^(gamescope)$" },
    { tag = "games",            class = "^(steam_app_\\d+)$" },
    { tag = "gamestore",        class = "^([Ss]team)$" },
    { tag = "gamestore",        title = "^([Ll]utris)$" },
    { tag = "gamestore",        class = "^(com.heroicgameslauncher.hgl)$" },
    { tag = "file-manager",     class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" },
    { tag = "file-manager",     class = "^(app.drey.Warp)$" },
    { tag = "wallpaper",        class = "^([Ww]aytrogen)$" },
    { tag = "multimedia",       class = "^([Aa]udacious)$" },
    { tag = "multimedia_video", class = "^([Mm]pv|vlc)$" },
    { tag = "settings",         title = "^(ROG Control)$" },
    { tag = "settings",         class = "^(wihotspot(-gui)?)$" },
    { tag = "settings",         class = "^([Bb]aobab|org.gnome.[Bb]aobab)$" },
    { tag = "settings",         class = "^(gnome-disks|wihotspot(-gui)?)$" },
    { tag = "settings",         title = "(Kvantum Manager)" },
    { tag = "settings",         class = "^(file-roller|org.gnome.FileRoller)$" },
    { tag = "settings",         class = "^(nm-applet|nm-connection-editor|blueman-manager)$" },
    { tag = "settings",         class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" },
    { tag = "settings",         class = "^(qt5ct|qt6ct)$" },
    { tag = "settings",         class = "(xdg-desktop-portal-gtk)" },
    { tag = "settings",         class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
    { tag = "settings",         class = "^([Rr]ofi)$" },
    { tag = "settings",         class = "^(btrfs-assistant)$" },
    { tag = "settings",         class = "^(timeshift-gtk)$" },
    { tag = "viewer",           class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$" },
    { tag = "viewer",           class = "^(evince)$" },
    { tag = "viewer",           class = "^(eog|org.gnome.Loupe)$" },
}

for _, t in ipairs(tagRules) do
    local rule = { match = { class = t.class }, tag = "+" .. t.tag }
    if t.title then
        rule.match = { title = t.title }
    end
    hl.window_rule(rule)
end

hl.window_rule({ match = { tag = "multimedia_video" }, no_blur = true, opacity = "1.0" })
hl.window_rule({ match = { tag = "multimedia" },       no_blur = true, opacity = "1.0" })

hl.window_rule({ match = { tag = "KooL_Cheat" },    center = true })
hl.window_rule({ match = { tag = "KooL-Settings" }, center = true })
hl.window_rule({ match = { title = "^(ROG Control)$" }, center = true })
hl.window_rule({ match = { title = "^(Keybindings)$" }, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, center = true })

hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

hl.window_rule({ match = { tag = "KooL_Cheat" },    float = true })
hl.window_rule({ match = { tag = "wallpaper" },     float = true, center = true })
hl.window_rule({ match = { tag = "settings" },      float = true, center = true })
hl.window_rule({ match = { tag = "viewer" },        float = true, center = true })
hl.window_rule({ match = { tag = "KooL-Settings" }, float = true, center = true })
hl.window_rule({ match = { class = "^([Zz]oom|onedriver|onedriver-launcher)$" }, float = true })
hl.window_rule({ match = { class = "^(org.gnome.Calculator|qalculate-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" }, float = true })
hl.window_rule({ match = { class = "^([Qq]alculate-gtk)$" }, float = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, float = true, center = true })

hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })

hl.window_rule({ match = { title = "^(Add Folder to Workspace)$" }, float = true, center = true, size = { "monitor_w*0.7", "monitor_h*0.6" } })
hl.window_rule({ match = { title = "^(Save As)$" }, float = true, center = true, size = { "monitor_w*0.7", "monitor_h*0.6" } })
hl.window_rule({ match = { initial_title = "^(Open Files)$" }, float = true, size = { "monitor_w*0.7", "monitor_h*0.6" } })
hl.window_rule({ match = { title = "^(SDDM Background)$" }, float = true, center = true, size = { "monitor_w*0.16", "monitor_h*0.12" } })
hl.window_rule({ match = { class = "^(yad)$" },     float = true, center = true, size = { "monitor_w*0.2", "monitor_h*0.2" } })
hl.window_rule({ match = { class = "^(hyprland-donate-screen)$" }, float = true, center = true })

hl.window_rule({ match = { tag = "browser" },       opacity = "1.0 1.0" })
hl.window_rule({ match = { tag = "im" },            opacity = "1.0 1.0" })
hl.window_rule({ match = { tag = "multimedia" },    opacity = "1.0 1.0" })
hl.window_rule({ match = { tag = "viewer" },        opacity = "1.0 1.0" })
hl.window_rule({ match = { tag = "wallpaper" },     opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^(deluge)$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^(seahorse)$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, opacity = "1.0 1.0" })

hl.window_rule({ match = { tag = "KooL_Cheat" }, size = { "monitor_w*0.65", "monitor_h*0.9" } })
hl.window_rule({ match = { tag = "wallpaper" },  size = { "monitor_w*0.7", "monitor_h*0.7" } })
hl.window_rule({ match = { tag = "settings" },   size = { "monitor_w*0.7", "monitor_h*0.7" } })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, size = { "monitor_w*0.6", "monitor_h*0.7" } })

hl.window_rule({ match = { tag = "games" }, no_blur = true, fullscreen = false })
hl.window_rule({ match = { tag = "games" }, fullscreen = false })

hl.window_rule({ match = { class = "^(jetbrains-*)" }, no_initial_focus = true })
hl.window_rule({ match = { title = "^(wind.*)$" },     no_initial_focus = true })

hl.layer_rule({ match = { namespace = "rofi" },                 blur = true })
hl.layer_rule({ match = { namespace = "notifications" },        blur = true })
hl.layer_rule({ match = { namespace = "quickshell:overview" },  blur = true, ignore_alpha = 0.5 })

hl.window_rule({
    name  = "Whatsapp-zapzap",
    match = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" },
    size  = { "monitor_w*0.6", "monitor_h*0.7" },
    center = true,
})

hl.window_rule({
    name  = "Picture-in-Picture",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    move = "72% 7%",
    opacity = "0.95 0.75",
    pin = true,
    keep_aspect_ratio = true,
    size = { "monitor_w*0.3", "monitor_h*0.3" },
})

hl.window_rule({
    name  = "Thunar-Progress-bar",
    match = { class = "^(thunar)$", title = "^(File Operation Progress)$" },
    float = true,
    center = true,
    size = { "monitor_w*0.26", "monitor_h*0.18" },
})

hl.on("window.open", function(w)
    if w == nil then
        return
    end

    local cls = w.class or ""
    local shouldFloat = false

    if cls:match("^([Cc]odium|codium-url-handler|VSCodium)$") then
        shouldFloat = (w.title or ""):match("codium") == nil and (w.title or ""):match("VSCodium") == nil
    elseif cls == "com.heroicgameslauncher.hgl" then
        shouldFloat = (w.title or ""):match("Heroic Games Launcher") == nil
    elseif cls:match("^[Ss]team$") then
        shouldFloat = (w.title or ""):match("^[Ss]team$") == nil
    end

    if shouldFloat then
        hl.dispatch(hl.dsp.window.float({ action = "set", window = w }))
    end
end)
