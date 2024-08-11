local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

function M.apply_to_config(config)
  local HOME_ICON = utf8.char(0x1f3e0)

  local default_workspace_title = HOME_ICON

  config.default_workspace = default_workspace_title

  config.unix_domains = {
    {
      name = "unix",
    },
  }

  config.default_gui_startup_args = { "connect", "unix" }

  -- GUI startup
  wezterm.on("gui-startup", function(cmd)
    local args = {}
    if cmd then
      args = cmd.args
    end

    local home = wezterm.home_dir -- Get our home directory
    local tab, build_pane, window = mux.spawn_window({
      workspace = default_workspace_title,
      cwd = home,
      args = args,
    })

    mux.set_active_workspace(default_workspace_title)
    window:gui_window():maximize()
  end)

  wezterm.on("gui-attached", function(domain)
    -- maximize all displayed windows on startup
    local workspace = mux.get_active_workspace()
    for _, window in ipairs(mux.all_windows()) do
      if window:get_workspace() == workspace then
        window:gui_window():maximize()
      end
    end
  end)

  wezterm.on("window-config-reloaded", function(window, pane)
    window:toast_notification("wezterm", "configuration reloaded!", nil, 2000)
  end)
end

return M
