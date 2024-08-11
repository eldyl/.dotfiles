local wezterm = require("wezterm")
local mux = wezterm.mux
local format = require("config.utils.format")

local M = {}

function M.apply_to_config(config)
  config.use_fancy_tab_bar = false -- Let's make our own
  config.tab_bar_at_bottom = true -- Put the tab bar on bottom
  config.show_new_tab_button_in_tab_bar = false -- Hide new tab button

  config.colors.tab_bar = {
    background = "#16161d",
    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = "#16161d",
      -- The color of the text for the tab
      fg_color = "#00afaf",

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = "Normal",
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = "#16161d",
      fg_color = "#808080",

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },
  }

  wezterm.on("update-right-status", function(window, pane)
    -- Symbols
    local utf8 = utf8
    local COMPUTER_ICON = utf8.char(0xf0379)
    local BRIEF_CASE = utf8.char(0xf0814)
    local TABS_ICON = utf8.char(0xf0a8f)
    local DIRECTORY = utf8.char(0xf4d4)
    local CLOCK = utf8.char(0xf017)
    local BATTERY = utf8.char(0xf240)

    -- Tables to hold our different status line components
    local cells_left = {}
    local cells_right = {}
    -- We will use this more than once
    local active_workspace

    -- Host
    local function get_host_el()
      local cwd_uri = pane:get_current_working_dir()
      if cwd_uri then
        local cwd = ""
        local hostname = ""

        if type(cwd_uri) == "userdata" then
          -- Running on a newer version of wezterm and we have
          -- a URL object here, making this simple!

          cwd = cwd_uri.file_path
          hostname = cwd_uri.host or wezterm.hostname()
        else
          -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
          -- which doesn't have the Url object
          cwd_uri = cwd_uri:sub(8)
          local slash = cwd_uri:find("/")
          if slash then
            hostname = cwd_uri:sub(1, slash - 1)
            -- and extract the cwd from the uri, decoding %-encoding
            cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
              return string.char(tonumber(hex, 16))
            end)
          end
        end

        -- Remove the domain name portion of the hostname
        local dot = hostname:find("[.]")
        if dot then
          hostname = hostname:sub(1, dot - 1)
        end
        if hostname == "" then
          hostname = wezterm.hostname()
        end

        local el_host = format.status_host(COMPUTER_ICON .. "  " .. hostname)
        table.insert(cells_left, el_host)
      end
    end

    -- Active workspace
    local function get_active_workspace_el()
      active_workspace = window:active_workspace()
      local el_active_workspace =
        format.status_workspace(BRIEF_CASE .. "  " .. active_workspace)
      table.insert(cells_left, el_active_workspace)
    end

    -- Tab icon
    local function get_tab_icon_el()
      local el_tabs = format.status_tabs(TABS_ICON)
      table.insert(cells_left, el_tabs)
    end

    -- Known workspaces
    local function get_known_workspaces_el()
      local known_workspaces = mux.get_workspace_names()
      local parsed_workspaces = {}
      for _, workspace in ipairs(known_workspaces) do
        if workspace == active_workspace then
          table.insert(
            parsed_workspaces,
            wezterm.format({
              { Attribute = { Intensity = "Bold" } },
              { Foreground = { Color = "#d75f87" } },
              { Text = workspace .. "*" },
            })
          )
        else
          table.insert(parsed_workspaces, workspace)
        end
      end

      local el_workspaces = "" .. table.concat(parsed_workspaces, " ") .. " "
      table.insert(cells_right, el_workspaces)
    end

    -- Date/time
    local function get_date_time()
      local el_date = CLOCK .. " " .. wezterm.strftime("%a %b %-d %H:%M")
      table.insert(cells_right, format.status_date(el_date))
    end

    -- Battery info
    local function get_battery_info()
      for _, b in ipairs(wezterm.battery_info()) do
        local battery = string.format("%.0f%%", b.state_of_charge * 100)
        if battery then
          local el_battery = format.status_battery(BATTERY .. "  " .. battery)
          table.insert(cells_right, el_battery)
        end
      end
    end

    get_host_el()
    get_active_workspace_el()
    get_tab_icon_el()
    get_known_workspaces_el()

    get_date_time()
    get_battery_info()

    -- Finally set our status elements
    window:set_left_status(table.concat(cells_left))
    window:set_right_status(table.concat(cells_right))
  end)
end

return M
