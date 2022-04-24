local M = {}

function M.config(cfg)
  -- install parser for norg
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  -- These two are optional and provide syntax highlighting
  -- for Neorg tables and the @document.meta tag
  parser_configs.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  parser_configs.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  local tp = {
    ensure_installed = {},
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "ss",
        scope_incremental = "sk",
        node_incremental = "ss",
        node_decremental = "sj",
      },
    },
    indent = {
      enable = true,
      disable = { "go", "lua", "typescript" },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  }
  return vim.tbl_deep_extend("force", cfg, tp)
end

return M
