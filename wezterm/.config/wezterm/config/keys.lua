local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.apply_to_config(config)
  local HOME_ICON = utf8.char(0x1f3e0)
  local MAIL_ICON = utf8.char(0x1f4eb)
  local MUSIC_ICON = utf8.char(0x1f3b5)
  local STOCK_ICON = utf8.char(0x1f4c8)

  -- Set leader key to allow more shortcut options
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

  config.keys = {
    --
    -- Disable default spawn new window
    --
    {
      key = "n",
      mods = "SHIFT|CTRL",
      action = act.DisableDefaultAssignment,
    },

    ---------------------
    ---    Domains    ---
    ---------------------

    --
    -- List ssh domains --
    --
    {
      key = "c",
      mods = "CTRL|ALT",
      action = act.ShowLauncherArgs({
        flags = "FUZZY|DOMAINS",
      }),
    },

    ---------------------
    ---   Workspaces  ---
    ---------------------

    --
    -- Create new named workspace
    --
    {
      key = "W",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = wezterm.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "New workspace name:" },
        }),
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:perform_action(
              act.SwitchToWorkspace({
                name = line,
              }),
              pane
            )
          end
        end),
      }),
    },

    --
    -- Start new project and open in workspace
    --
    {
      key = "p",
      mods = "CTRL|ALT",
      action = act.PromptInputLine({
        description = wezterm.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "New project name:" },
        }),
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          --
          local home = wezterm.home_dir -- Home directory according to wezterm
          local project_path = home .. "/Projects/" .. line

          local success, stdout, stderr =
            wezterm.run_child_process({ "mkdir", "-p", project_path })

          if success then
            if line then
              window:perform_action(
                act.SwitchToWorkspace({
                  name = line,
                  spawn = {
                    label = "Workspace: " .. line,
                    cwd = project_path,
                    domain = "DefaultDomain",
                  },
                }),
                pane
              )
            end
          elseif stderr then
            wezterm.log_info(stderr)
          end
        end),
      }),
    },

    --
    -- Launch Home workspace
    --
    {
      key = "h",
      mods = "CTRL|ALT",
      action = act.SwitchToWorkspace({
        name = HOME_ICON,
        spawn = {
          domain = "DefaultDomain",
        },
      }),
    },

    --
    -- Launch workspace running cmus
    --
    {
      key = "j",
      mods = "CTRL|ALT",
      action = act.SwitchToWorkspace({
        name = MUSIC_ICON,
        spawn = {
          args = { "cmus" },
        },
      }),
    },

    --
    -- Launch workspace running neomutt
    --
    {
      key = "m",
      mods = "CTRL|ALT",
      action = act.SwitchToWorkspace({
        name = MAIL_ICON,
        spawn = {
          args = { "neomutt" },
        },
      }),
    },

    --
    -- Launch workspace running newsboat
    --
    {
      key = "r",
      mods = "CTRL|ALT",
      action = act.SwitchToWorkspace({
        name = "News",
        spawn = {
          args = { "newsboat" },
        },
      }),
    },

    --
    -- Launch workspace running ticker
    --
    {
      key = "s",
      mods = "CTRL|ALT",
      action = act.SwitchToWorkspace({
        name = STOCK_ICON,
        spawn = {
          args = { "ticker" },
        },
      }),
    },

    --
    -- Switch to relative workspaces
    --
    {
      key = "LeftArrow",
      mods = "ALT",
      action = act.SwitchWorkspaceRelative(-1),
    },

    {
      key = "RightArrow",
      mods = "ALT",
      action = act.SwitchWorkspaceRelative(1),
    },

    ---------------------
    ------  Tabs   ------
    ---------------------

    --
    -- Change tab title --
    --
    {
      key = "t",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = wezterm.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "Rename tab to:" },
        }),
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }),
    },

    --
    -- Switch to relative tabs -- these are wezterm defaults
    --
    {
      key = "Tab",
      mods = "CTRL",
      action = act.ActivateTabRelative(1),
    },

    {
      key = "Tab",
      mods = "CTRL|SHIFT",
      action = act.ActivateTabRelative(-1),
    },

    ------------------------
    ------   Panes    ------
    ------------------------

    --
    -- Navigate panes
    --
    {
      key = "LeftArrow",
      mods = "SHIFT",
      action = act.ActivatePaneDirection("Left"),
    },

    {
      key = "RightArrow",
      mods = "SHIFT",
      action = act.ActivatePaneDirection("Right"),
    },

    {
      key = "UpArrow",
      mods = "SHIFT",
      action = act.ActivatePaneDirection("Up"),
    },

    {
      key = "DownArrow",
      mods = "SHIFT",
      action = act.ActivatePaneDirection("Down"),
    },

    --
    -- Adjust pane size
    --
    {
      key = "LeftArrow",
      mods = "CTRL|ALT|SHIFT",
      action = act.AdjustPaneSize({ "Left", 1 }),
    },

    {
      key = "DownArrow",
      mods = "CTRL|ALT|SHIFT",
      action = act.AdjustPaneSize({ "Down", 1 }),
    },

    {
      key = "UpArrow",
      mods = "CTRL|ALT|SHIFT",
      action = act.AdjustPaneSize({ "Up", 1 }),
    },

    {
      key = "RightArrow",
      mods = "CTRL|ALT|SHIFT",
      action = act.AdjustPaneSize({ "Right", 1 }),
    },

    --
    -- Split panes
    --
    {
      key = "v",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },

    {
      key = "s",
      mods = "LEADER",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },

    --
    -- Cycle panes
    --
    { key = "r", mods = "CTRL|ALT", action = act.RotatePanes("Clockwise") },

    --
    -- Split pane to use as build terminal - Bottom
    --
    {
      key = "b",
      mods = "CTRL|ALT",
      action = act.SplitPane({
        direction = "Down",
        size = { Percent = 10 },
      }),
    },

    --
    -- Split pane to use as build terminal - Left
    --
    {
      key = "l",
      mods = "CTRL|ALT",
      action = act.SplitPane({
        direction = "Left",
        size = { Percent = 40 },
      }),
    },

    --
    -- Split pane to use as build terminal - Right
    --
    {
      key = "r",
      mods = "CTRL|ALT",
      action = act.SplitPane({
        direction = "Right",
        size = { Percent = 40 },
      }),
    },

    --
    -- Zoom pane
    --
    {
      key = "z",
      mods = "CTRL|ALT",
      action = act.TogglePaneZoomState,
    },

    ------------------------
    ------   Utils    ------
    ------------------------

    --
    -- Open editor in current pane
    --
    {
      key = "e",
      mods = "CTRL|ALT",
      action = wezterm.action_callback(function(window, pane, line)
        pane:send_text("$EDITOR ." .. "\0\x0D")
      end),
    },
  }
end

return M
