local M = {}

function M.config()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_show_icons = {
    git = 0,
  }

  nvimtree.setup(require("core.utils").user_plugin_opts("plugins.nvim-tree", {
    update_cdw = true,
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
          -- user mappings go here
        },
      },
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
      },
    },
    update_focused_file = {
      enable = true,
    },
  }))
end

return M
