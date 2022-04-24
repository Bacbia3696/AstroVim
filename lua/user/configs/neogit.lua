local M = {}

function M.config()
  local neogit = require "neogit"

  neogit.setup {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = true,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    commit_popup = {
      kind = "replace",
    },
    -- Change the default way of opening neogit
    kind = "split",
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { "🔥", "👀" },
      item = { ">", "v" },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
    },
    sections = {
      untracked = { folded = true },
      unstaged = { folded = true },
      staged = { folded = true },
      stashes = { folded = true },
      unpulled = { folded = true },
      unmerged = { folded = true },
      recent = { folded = true },
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {},
    },
  }

  vim.keymap.set("n", "<leader>n", "<cmd>Neogit<cr>")
end

return M
