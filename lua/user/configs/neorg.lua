local M = {}

function M.config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.journal"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = "~/notes/work",
            home = "~/notes/home",
            example_gtd = "/Users/dat.nguyen1/playground/example_workspaces/gtd",
          },
        },
      },
      ["core.gtd.base"] = {
        config = { -- Note that this table is optional and doesn't need to be provided
          workspace = "example_gtd",
        }
      },
      ["core.norg.manoeuvre"] = {
        config = { -- Note that this table is optional and doesn't need to be provided
          -- Configuration here
        }
      },
      ["core.presenter"] = {
        config = {
          zen_mode = "zen-mode",
        },
      },
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
    },
  }
end

return M
