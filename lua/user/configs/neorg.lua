local M = {}

function M.config()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.journal"] = {},
      -- ["core.norg.completion"] = {},
      ["core.norg.dirman"] = {},
      ["core.presenter"] = {
        config = {
          zen_mode = "truezen",
        },
      },
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
    },
  }
end

return M
