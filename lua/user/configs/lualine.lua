local M = {}

function M.config(cfg)
  local left = cfg.sections.lualine_c
  left[1], left[2] = left[2], left[1]
  table.insert(left, 1, {
    "filename",
    file_status = true,
    path = 0,
    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  })
  return cfg
end

return M
