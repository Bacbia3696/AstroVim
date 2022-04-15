local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

local config = {

  -- Set colorscheme
  colorscheme = "default_theme",

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = require "user.colors",
    -- Modify the highlight groups
    highlights = function(highlights)
      local C = require "default_theme.colors"

      highlights.NonText = { fg = C.grey_2, bg = C.none }

      highlights.IndentBlanklineContextStart = { sp = C.blue_1, style = "underline" }
      highlights.IndentBlanklineContextChar = { fg = C.blue_1, style = "nocombine" }

      -- highlights.NeoTreeNormal = { bg = C.none }
      -- highlights.NeoTreeNormalNC = { bg = C.none }
      highlights.NvimTreeNormal = { bg = C.none }
      highlights.NvimTreeNormalNC = { bg = C.none }
      highlights.NvimTreeSpecialFile = { fg = C.yellow, style = "bold,underline" }

      highlights.WinSeparator = { bg = C.none }
      highlights.CursorLineNr = { fg = C.gold, bg = C.none }
      highlights.LineNr = { fg = C.grey, bg = C.none }

      highlights.LspReferenceText = { fg = C.none, bg = C.grey_7, style = "italic" }
      highlights.LspReferenceRead = { fg = C.none, bg = C.grey_7 }
      highlights.LspReferenceWrite = { fg = C.none, bg = C.grey_7 }

      highlights.Visual = { fg = C.none, bg = C.grey_1 }
      highlights.VisualNOS = { fg = C.grey_1, bg = C.none }

      highlights.TSStrong = { fg = C.fg, style = "bold" }
      highlights.TSEmphasis = { fg = C.fg, style = "italic" }
      highlights.TSUnderline = { fg = C.blue_2, style = "underline" }
      highlights.TSTitle = { fg = C.orange, style = "bold,italic" }
      highlights.TSPunctDelimiter = { fg = C.gold }
      highlights.TSPunctSpecial = { fg = C.purple }
      highlights.TSPunctBracket = { fg = C.blue }

      highlights.GitSignsCurrentLineBlame = { fg = C.cyan, style = "italic" }

      highlights.MatchParen = { style = "bold,italic,strikethrough" }
      return highlights
    end,
  },

  -- Disable default plugins
  enabled = {
    neo_tree = false,
    lualine = true,
    gitsigns = true,
    colorizer = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
    bufferline = false,
    toggle_term = true,
    dashboard = false,
    which_key = false,
  },

  -- Configure plugins
  plugins = require "user.plugins",

  -- Add paths for including more VS Code style snippets in luasnip
  luasnip = {
    vscode_snippet_paths = {},
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings to the normal mode <leader> mappings
    register_n_leader = {
      -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,
    ---@diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
      if client.name == "gopls" then
        client.resolved_capabilities.document_formatting = false
      end

      vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
      lsp_highlight_document(client)
    end,

    -- override the lsp installer server-registration function
    server_registration = function(server, server_opts)
      -- Special code for rust.tools.nvim!
      if server.name == "rust_analyzer" then
        local extension_path = vim.fn.stdpath "data" .. "/dapinstall/codelldb/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

        require("rust-tools").setup {
          server = server_opts,
          dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
          },
        }
      else
        server:setup(server_opts)
      end
    end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      ["emmet_ls"] = {
        filetypes = { "typescriptreact", "javascriptreact", "html", "css" },
      },
      ["tsserver"] = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "non-relative",
          },
        },
      },
      -- ["sqls"] = {
      --   cmd = {
      --     "/Users/dat.nguyen1/.local/share/nvim/lsp_servers/sqls/sqls",
      --     "-config",
      --     "/Users/dat.nguyen1/.config/sqls/config.yaml",
      --   },
      --   setup = {
      --     on_attach = function(client, bufnr)
      --       require("sqls").on_attach(client, bufnr)
      --     end,
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- null-ls configuration
  ["null-ls"] = function()
    -- Formatting and linting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
      return
    end

    -- Check supported formatters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    -- Check supported linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      debug = false,
      sources = {
        -- action from gitsigns
        null_ls.builtins.code_actions.gitsigns,
        -- Set a formatter
        formatting.prettier,
        formatting.black,
        formatting.goimports,
        formatting.shfmt.with {
          filetypes = { "sh", "zsh", "bash", "dockerfile" },
        },
        formatting.sqlfluff,
        -- formatting.gofumpt,
        -- formatting.golines,
        -- formatting.stylua,
        -- Set a linter
        diagnostics.golangci_lint,
        diagnostics.sqlfluff,
      },
      -- NOTE: You can remove this on attach function to disable format on save
      ---@diagnostic disable-next-line: unused-local
      on_attach = function(client)
        -- if client.resolved_capabilities.document_formatting then
        --   vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
        -- end
      end,
    }
  end,

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    require "user.options"
    require "user.mappings"
    require "user.autocmds"
    require "user.dap_configs"
  end,
}

return config
