local wezterm = require("wezterm")
local colors = require("config.colors.tokyonight_night")
local keys = require("config.keys")
local status_line = require("config.status_line")
local startup = require("config.startup")
local domains = require("config.domains")
local workspacinator = wezterm.plugin.require("https://github.com/eldyl/workspacinator.wezterm")

local config = wezterm.config_builder() -- Holds our wezterm config

-- Appearance
config.font = wezterm.font("GeistMono Nerd Font")
config.underline_position = -2.5
config.underline_thickness = 3
config.font_size = 16
config.scrollback_lines = 11000
config.window_decorations = "RESIZE" -- Remove the window bar
config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}

-- Apply config modules
colors.apply_to_config(config)

keys.apply_to_config(config)

status_line.apply_to_config(config)

startup.apply_to_config(config)

if domains then
  domains.apply_to_config(config)
end

workspacinator.apply_to_config(config, {
  directories = {
    "/", -- Equivelaent to "~/" in this instance
    "/.config",
    "/Projects",
    "/Projects/FORKS",
    "/Services",
    "/Source",
    "/scripts",
  },
  ssh_domains = config.ssh_domains,
})

return config