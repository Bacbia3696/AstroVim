local M = {}

function M.config(cfg)
  local cmp = require "cmp"

  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then
    return
  end
  cfg.mapping["<C-f>"] = nil
  cfg.mapping["<C-d>"] = nil
  local config = {
    preselect = cmp.PreselectMode.Item,
    mapping = {
      ["<C-p>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-n>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
  }
  cfg = vim.tbl_deep_extend("force", cfg, config)
  return cfg
end

return M
