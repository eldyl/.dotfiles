local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

function M.apply_to_config(config)
  local HOME_ICON = utf8.char(0x1f3e0)

  local hostname = wezterm.hostname()

  local dot = hostname:find("[.]")
  if dot then
    hostname = hostname:sub(1, dot - 1)
  end

  local default_workspace_name = HOME_ICON .. hostname

  config.default_workspace = default_workspace_name

  config.unix_domains = {
    {
      name = hostname,
    },
  }

  config.default_gui_startup_args = { "connect", hostname }

  -- GUI startup
  wezterm.on("gui-startup", function(cmd)
    local args = {}
    if cmd then
      args = cmd.args
    end

    local home = wezterm.home_dir -- Get our home directory
    local tab, build_pane, window = mux.spawn_window({
      workspace = default_workspace_name,
      cwd = home,
      args = args,
    })

    mux.set_active_workspace(default_workspace_name)
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
end

return M
