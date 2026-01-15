local wezterm = require("wezterm")
local colors = require("config.colors.tokyonight_night")
local keys = require("config.keys")
local status_line = require("config.status_line")
local startup = require("config.startup")
local domains_ok, domains = pcall(require, "config.domains")
local workspacinator =
  wezterm.plugin.require("https://github.com/eldyl/workspacinator.wezterm")

local config = wezterm.config_builder() -- Holds our wezterm config

-- Appearance
config.font = wezterm.font("Zed Plex Mono")
config.underline_position = -2.5
config.underline_thickness = 3
config.font_size = 17
config.window_background_opacity = 0.97
config.scrollback_lines = 11000

if wezterm.target_triple == "aarch64-apple-darwin" then
  config.window_decorations = "RESIZE" -- Remove the window bar
end

-- Apply config modules
colors.apply_to_config(config)

keys.apply_to_config(config)

status_line.apply_to_config(config)

startup.apply_to_config(config)

if domains_ok and domains then
  domains.apply_to_config(config)
end

workspacinator.apply_to_config(config, {
  directories = {
    "/", -- Equivelaent to "~/" in this instance
    "/.config",
    "/Projects",
    "/Projects/FORKS",
    "/scripts",
    "/Documents/School",
  },
  ssh_domains = config.ssh_domains,
})

return config
