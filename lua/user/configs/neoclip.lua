local M = {}

function M.config()
  require("neoclip").setup {
    history = 200,
    enable_persistent_history = true,
    continious_sync = false,
    db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
    filter = nil,
    preview = true,
    default_register = '"',
    default_register_macros = "q",
    enable_macro_history = true,
    content_spec_column = false,
    on_paste = {
      set_reg = false,
    },
    on_replay = {
      set_reg = false,
    },
    keys = {
      telescope = {
        i = {
          select = "<cr>",
          paste = "<c-y>",
          paste_behind = "<c-e>",
          replay = "<c-q>", -- replay a macro
          delete = "<c-d>", -- delete an entry
          custom = {},
        },
        n = {
          select = "<cr>",
          paste = "p",
          paste_behind = "P",
          replay = "q",
          delete = "d",
          custom = {},
        },
      },
    },
  }
end

return M
