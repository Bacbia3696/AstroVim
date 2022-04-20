local plugins = {
  -- Add plugins, the packer syntax without the "use"
  init = function(plugins)
    -- add your new plugins to this table
    local my_plugins = {
      "tpope/vim-repeat", -- repeat command
      "tpope/vim-unimpaired", -- cool hotkey
      "tpope/vim-surround", -- select surround
      "metakirby5/codi.vim", -- interactive environment for coding
      {
        "jpalardy/vim-slime", -- send command to external program!!
        -- run = 'g ss pop',
      },
      {
        "tami5/sqlite.lua",
        otp = false,
      },

      {
        "folke/zen-mode.nvim",
        config = function()
          require("user.configs.zen-mode").config()
        end,
      },

      {
        'windwp/nvim-spectre',
        config = function()
          require('spectre').setup()
          vim.cmd [[
              nnoremap <leader>S <cmd>lua require('spectre').open()<CR>

              "search current word
              nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
              vnoremap <leader>s <cmd>lua require('spectre').open_visual()<CR>
              "  search in current file
              nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
          ]]
        end,
        requires = "nvim-lua/plenary.nvim",
      },

      -- code coverage for go
      {
        'rafaelsq/nvim-goc.lua',
        config = function()
          -- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
          vim.opt.switchbuf = 'useopen'

          local goc = require 'nvim-goc'
          goc.setup({ verticalSplit = false })


          vim.keymap.set('n', '<space>gcr', goc.Coverage, { silent = true })
          vim.keymap.set('n', '<space>gcc', goc.ClearCoverage, { silent = true })
          vim.keymap.set('n', '<space>gct', goc.CoverageFunc, { silent = true })
          vim.keymap.set('n', ']a', goc.Alternate, { silent = true })
          vim.keymap.set('n', '[a', goc.AlternateSplit, { silent = true })

          local cf = function(testCurrentFunction)
            local cb = function(path)
              if path then
                vim.cmd(":silent exec \"!xdg-open " .. path .. "\"")
              end
            end

            if testCurrentFunction then
              goc.CoverageFunc(nil, cb, 0)
            else
              goc.Coverage(nil, cb)
            end
          end

          vim.keymap.set('n', '<space>gca', cf, { silent = true })
          vim.keymap.set('n', '<space>gcb', function() cf(true) end, { silent = true })

          -- default colors
          -- vim.highlight.link('GocNormal', 'Comment')
          -- vim.highlight.link('GocCovered', 'String')
          -- vim.highlight.link('GocUncovered', 'Error')
        end
      },

      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          }
        end
      },

      -- scrollbar for neovim
      -- {
      --   'petertriho/nvim-scrollbar',
      --   config = function()
      --     require("scrollbar").setup({
      --       handle = {
      --         text = " ",
      --         color = nil,
      --         cterm = nil,
      --         highlight = "CursorColumn",
      --         hide_if_all_visible = true, -- Hides handle if all lines are visible
      --       },
      --     })
      --   end
      -- },
      -- Config lsp as json file like coc.nvim
      {
        'tamago324/nlsp-settings.nvim',
        config = function()
          local nlspsettings = require("nlspsettings")
          nlspsettings.setup({
            config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
            local_settings_dir = ".nlsp-settings",
            local_settings_root_markers = { '.git' },
            append_default_schemas = true,
            loader = 'json'
          })
        end
      },

      {
        "Pocco81/HighStr.nvim"
      },

      -- NOTE: show breachcrume like vs code
      {
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
          require('nvim-gps').setup({})
        end
      },

      -- NOTE: lua lsp
      {
        "folke/lua-dev.nvim",
        config = function()
          local luadev = require("lua-dev").setup {
            -- add any options here, or leave empty to use the default settings
            lspconfig = {
              library = {
                vimruntime = true, -- runtime path
                types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
              },
              runtime_path = false, -- enable this to get completion in require strings. Slow!
              -- pass any additional options that will be merged in the final lsp config
              lspconfig = {
                -- cmd = {"lua-language-server"},
                on_attach = function(client, bufnr)
                  client.resolved_capabilities.document_formatting = false
                end
              },
            },
          }

          local lspconfig = require "lspconfig"
          lspconfig.sumneko_lua.setup(luadev)
        end,
      },

      -- NOTE: for debug
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",

      -- "ellisonleao/glow.nvim",

      -- NOTE: LSP for sql
      {
        "nanotee/sqls.nvim",
        config = function()
          require("lspconfig").sqls.setup {
            on_attach = function(client, bufnr)
              client.resolved_capabilities.document_formatting = false
              require("sqls").on_attach(client, bufnr)
            end,
          }
        end,
      },

      -- NOTE: better NEOVIM UI
      {
        "stevearc/dressing.nvim",
        config = function()
          require("user.configs.dressing").config()
        end,
      },
      -- NOTE: for Rust programming language
      {
        "simrat39/rust-tools.nvim",
        requires = { "nvim-lspconfig", "nvim-lsp-installer", "nvim-dap", "Comment.nvim" },
        -- Is configured via the server_registration_override installed below!
      },

      -- tree
      {
        "kyazdani42/nvim-tree.lua",
        requires = {
          "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
          require("user.configs.nvim-tree").config()
        end,
      },
      -- NOTE: highlight
      {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
          require("todo-comments").setup {}
        end,
      },

      -- theme
      {
        "folke/tokyonight.nvim",
        config = function()
          local g = vim.g
          g.tokyonight_italic_functions = true
          g.tokyonight_transparent = true
          g.tokyonight_transparent_sidebar = true
          g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
        end,
      },

      -- show lightbulb when have code actions
      {
        "kosayoda/nvim-lightbulb",
        config = function()
          vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
        end,
      },
      -- note taking in neovim
      {
        "nvim-neorg/neorg",
        config = function()
          require("user.configs.neorg").config()
        end,
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-neorg/neorg-telescope",
          "Pocco81/TrueZen.nvim",
        },
      },

      -- treesitter
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "mfussenegger/nvim-ts-hint-textobject",
        config = function()
          vim.cmd [[
            omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
            vnoremap <silent> m :lua require('tsht').nodes()<CR>
          ]]
        end
      },

      -- telescope extensions
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "jvgrootveld/telescope-zoxide",
      "benfowler/telescope-luasnip.nvim",
      "nvim-neorg/neorg-telescope",
      {
        "AckslD/nvim-neoclip.lua",
        requires = {
          { "tami5/sqlite.lua", module = "sqlite" },
          { "nvim-telescope/telescope.nvim" },
        },
        config = function()
          require("user.configs.neoclip").config()
        end,
      },
      {
        "phaazon/hop.nvim",
        branch = "v1", -- optional but strongly recommended
        config = function()
          require("hop").setup {}
        end,
      },
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          require("lsp_signature").setup()
        end,
      },
    }

    -- change default config options
    plugins["max397574/better-escape.nvim"] = nil

    plugins["nvim-telescope/telescope.nvim"].cmd = nil
    plugins["nvim-telescope/telescope.nvim"].module = nil
    plugins["neovim/nvim-lspconfig"].event = nil

    -- add the my_plugins table to the plugin table
    return vim.tbl_deep_extend("force", plugins, my_plugins)
  end,

  -- All other entries override the setup() call for default plugins
  symbols_outline = {
    width = 20,
    auto_preview = false,
  },
  treesitter = function(cfg)
    return require("user.configs.treesitter").config(cfg)
  end,
  packer = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    git = {
      subcommands = {
        update = "pull --progress --rebase=true",
      },
    },
  },
  indent_blankline = {
    show_current_context_start = true,
    space_char_blankline = " ",
  },
  gitsigns = require("user.configs.gitsigns").config,
  telescope = require("user.configs.telescope").config,
  autopairs = {
    fast_wrap = nil,
  },
  notify = {
    background_colour = "#46244C",
    stages = "fade_in_slide_out",
  },
  cmp = function(cfg)
    return require("user.configs.cmp").config(cfg)
  end,
  lualine = function(cfg)
    return require("user.configs.lualine").config(cfg)
  end,
}

-- NOTE: for telescope extensions
require("telescope").load_extension "neoclip"
require("telescope").load_extension "dap"
require("telescope").load_extension "zoxide"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "luasnip"
require('telescope').load_extension('projects')

return plugins
