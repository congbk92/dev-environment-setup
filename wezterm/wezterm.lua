-- WezTerm config — managed in the dev-environment-setup repo (the source of truth).
-- Loaded by Windows WezTerm via a bootstrap file that install.sh writes to
-- %USERPROFILE%\.config\wezterm\wezterm.lua; that bootstrap dofile()s THIS file
-- over the WSL UNC path (no admin / symlink needed).
-- After editing, reload with Ctrl+Shift+R (or restart WezTerm).
-- Docs: https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Open new windows/tabs directly in the WSL distro (not PowerShell/cmd).
config.default_domain = "WSL:Ubuntu-24.04"

-- Sensible basic defaults. Personalize here later, e.g.:
config.font = wezterm.font_with_fallback({ "MesloLGS NF", "Cascadia Code" })
config.color_scheme = "Tokyo Night"
config.font_size = 11.0
config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.adjust_window_size_when_changing_font_size = false

return config
