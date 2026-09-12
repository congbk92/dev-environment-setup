-- WezTerm config — managed in the dev-environment-setup repo (the source of truth).
-- Loaded by Windows WezTerm via a bootstrap file that install.sh writes to
-- %USERPROFILE%\.config\wezterm\wezterm.lua; that bootstrap dofile()s THIS file
-- over the WSL UNC path (no admin / symlink needed).
-- After editing, reload with Ctrl+Shift+R (or restart WezTerm).
-- Docs: https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Open new windows/tabs directly in the WSL distro (not PowerShell/cmd).
-- WSL domains only exist in the Windows build; on native Linux/macOS the
-- default local domain is already correct, so don't override it there.
if wezterm.target_triple:find("windows", 1, true) then
  -- Follow the WSL default distro instead of hardcoding a name:
  -- default_wsl_domains() parses `wsl -l -v`, which lists the default (*-marked) first.
  local wsl_domains = wezterm.default_wsl_domains()
  if #wsl_domains > 0 then
    config.default_domain = wsl_domains[1].name
  end
end

-- Sensible basic defaults. Personalize here later, e.g.:
config.font = wezterm.font_with_fallback({ "MesloLGS NF", "Cascadia Code" })
config.color_scheme = "Tokyo Night Storm"
config.font_size = 11.0
config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.adjust_window_size_when_changing_font_size = false

-- Distro dropdown à la Windows Terminal: fuzzy-searchable list of every
-- domain (WSL distros are auto-discovered — nothing hardcoded).
-- Note this shadows QuickSelect's default Ctrl+Shift+Space binding.
config.keys = {
  { key = "Space", mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|DOMAINS" } },
}

return config
