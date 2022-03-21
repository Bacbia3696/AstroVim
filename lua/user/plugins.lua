local plugins = {
  -- Add plugins, the packer syntax without the "use"
  init = function(plugins)
    -- add your new plugins to this table
    local my_plugins = {
      "tpope/vim-repeat", -- repeat command
      "tpope/vim-unimpaired", -- cool hotkey
      "tpope/vim-surround", -- select surround
      "tpope/vim-fugitive", -- git intergration
      "metakirby5/codi.vim", -- interactive environment for coding
      "jpalardy/vim-slime", -- send command to external program!!
      {
        "tami5/sqlite.lua",
        otp = false,
      },

      -- NOTE: for debug
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",

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
          vim.g.tokyonight_italic_functions = true
          vim.g.tokyonight_transparent = true
          vim.g.tokyonight_transparent_sidebar = true
          vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
        end,
      },

      -- Zen mode
      {
        "Pocco81/TrueZen.nvim",
        config = function()
          require("user.configs.true-zen").config()
        end,
      },

      -- highlight text
      "Pocco81/HighStr.nvim",
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
          -- "john-cena/cool-neorg-plugin",
        },
      },

      -- treesitter
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",

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

    -- remove unused plugins
    plugins["max397574/better-escape.nvim"] = nil

    -- add the my_plugins table to the plugin table
    return vim.tbl_deep_extend("force", plugins, my_plugins)
  end,

  -- All other entries override the setup() call for default plugins
  symbols_outline = {
    width = 25,
  },
  treesitter = function(cfg)
    return require("user.configs.treesitter").config(cfg)
  end,
  packer = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
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

return plugins
