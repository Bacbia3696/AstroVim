local M = {}

function M.config(cfg)
  local gps = require("nvim-gps")
  local colors = require "default_theme.colors"

  local left = cfg.sections.lualine_c
  left[1], left[2] = left[2], left[1]
  table.insert(left, 1, {
    "filename",
    file_status = true,
    path = 0,
    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  })
  table.insert(left, {
    gps.get_location,
    color = { fg = colors.cyan },
    cond = gps.is_available,
  })

  cfg.sections.lualine_x[1].color = { fg = colors.orange }
  return cfg
end

return M
