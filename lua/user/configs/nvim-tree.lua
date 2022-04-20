local M = {}

function M.config()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_highlight_opened_files = 0
  vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  }

  nvimtree.setup(require("core.utils").user_plugin_opts("plugins.nvim-tree", {
    view = {
      width = 30,
      height = 30,
      side = "left",
      preserve_window_proportions = true,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
        custom_only = false,
        list = {
          { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
          { key = "<C-e>", action = "" },
          { key = "O", action = "edit_in_place" },
          { key = "o", action = "edit_no_picker" },
        },
      },
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = false,
        global = false,
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
      icons = {
        webdev_colors = true,
      },
    },
    diagnostics = {
      enable = true,
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 400,
    },
    update_focused_file = {
      enable = true,
    },
  }))
end

return M
