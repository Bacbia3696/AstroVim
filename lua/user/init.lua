local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
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

      highlights.WinSeparator = { bg = C.none }
      highlights.CursorLineNr = { fg = C.gold, bg = C.none }
      highlights.LineNr = { fg = C.grey, bg = C.none }

      highlights.LspReferenceText = { fg = C.none, bg = C.grey_7, style = "italic,bold" }
      highlights.LspReferenceRead = { fg = C.none, bg = C.grey_7 }
      highlights.LspReferenceWrite = { fg = C.none, bg = C.grey_7 }

      highlights.Visual = { fg = C.none, bg = C.grey_1 }
      highlights.VisualNOS = { fg = C.grey_1, bg = C.none }

      highlights.TSStrong = { fg = C.fg, style = "bold" }
      highlights.TSEmphasis = { fg = C.fg, style = "italic" }
      highlights.TSUnderline = { fg = C.fg, style = "underline" }

      highlights.MatchParen = { fg = C.red_3, bg = C.white, style = "bold,italic,reverse" }
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
    toggle_term = false,
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
      if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
      elseif client.name == "jsonls" then
        client.resolved_capabilities.document_formatting = false
      elseif client.name == "html" then
        client.resolved_capabilities.document_formatting = false
      elseif client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
      elseif client.name == "gopls" then
        client.resolved_capabilities.document_formatting = false
      end

      vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
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
        -- Set a formatter
        formatting.prettier,
        formatting.black,
        formatting.goimports,
        -- formatting.gofumpt,
        -- formatting.golines,
        formatting.stylua,
        -- Set a linter
        diagnostics.golangci_lint,
      },
      -- NOTE: You can remove this on attach function to disable format on save
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
    require "user.configs"
  end,
}

return config
