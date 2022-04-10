-- Set options
local set = vim.opt
set.list = true
-- ↵,→,~,↷,↶,·,¬,⇨⋄,‸,⇥,➜,⟫,➪,➭,⚬,⮐
set.listchars = { tab = "➪➤", trail = "⚬", eol = "¬", nbsp = "+", extends = "→", precedes = "←" }
set.fillchars = { eob = " " }
set.relativenumber = false
set.confirm = true

-- wrap line
set.wrap = true
set.showbreak = "↪ "
set.cpo:append { n = true }

set.winblend = 10
set.pumblend = 10
set.timeoutlen = 10000
-- set.smartindent=true
set.cindent = true

vim.g["slime_target"] = "kitty"
vim.g.indent_blankline_char = "▏"

vim.cmd "cnoreabbrev t Telescope"
vim.cmd "cnoreabbrev n Neorg"
vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
-- HACK: remove this hotfix latter
vim.cmd [[ command! R execute ('lua vim.lsp.stop_client(vim.lsp.get_active_clients())') | sleep 100m | e ]]

vim.cmd [[
" print synstack group name
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]]
