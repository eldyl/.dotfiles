-- All credit to folke
-- https://github.com/folke/tokyonight.nvim/blob/main/extras/wezterm/tokyonight_night.toml
local M = {}

function M.apply_to_config(config)
  config.colors = {
    foreground = "#c0caf5",

    background = "#101014", -- a bit darker background for better contrast

    cursor_bg = "#c0caf5",
    cursor_fg = "#1a1b26",
    cursor_border = "#c0caf5",

    selection_bg = "#283457",
    selection_fg = "#c0caf5",

    split = "#7aa2f7",
    compose_cursor = "#ff9e64",
    scrollbar_thumb = "#292e42",

    ansi = {
      "#15161e",
      "#f7768e",
      "#9ece6a",
      "#e0af68",
      "#7aa2f7",
      "#bb9af7",
      "#7dcfff",
      "#a9b1d6",
    },

    brights = {
      "#414868",
      "#f7768e",
      "#9ece6a",
      "#e0af68",
      "#7aa2f7",
      "#bb9af7",
      "#7dcfff",
      "#c0caf5",
    },
  }
end

return M
