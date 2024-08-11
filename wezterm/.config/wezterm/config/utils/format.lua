local wezterm = require("wezterm")

local M = {}

function M.status_host(text)
  local formatted = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = "#7fb4ca" } },
    { Text = " " .. text .. " " },
  })
  return formatted
end

function M.status_workspace(text)
  local formatted = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = "#d75f87" } },
    { Text = " " .. text .. " " },
  })
  return formatted
end

function M.status_tabs(text)
  local formatted = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = "#00afaf" } },
    { Text = " " .. text .. " " },
  })
  return formatted
end

function M.status_cwd(text)
  local formatted = wezterm.format({
    { Foreground = { Color = "#dcd7ba" } },
    { Text = " " .. text .. "" },
  })
  return formatted
end

function M.status_date(text)
  local formatted = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = "#16161d" } },
    { Background = { Color = "#a9b1d6" } },
    { Text = " " .. text .. " " },
  })
  return formatted
end

function M.status_battery(text)
  local formatted = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { AnsiColor = "Blue" } },
    { Text = " " .. text .. " " },
  })
  return formatted
end

return M
