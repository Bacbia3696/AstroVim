-- Set options
local set = vim.opt
set.list = true
-- ↵,→,~,↷,↶,·,¬,⇨⋄,‸,⇥,➜,⟫,➪,➭,⚬,⮐
set.listchars = { tab = "➪➤", trail = "⚬", eol = "¬", nbsp = "+", extends = "→", precedes = "←" }
set.relativenumber = false
set.confirm = true
set.history = 1000 -- Number of commands to remember in a history table

-- wrap line
set.wrap = true
set.showbreak = "↪ "
set.cpo:append { n = true }
set.foldmethod = "indent"
set.foldlevelstart = 10
set.linebreak = true

set.winblend = 0
set.pumblend = 0
set.timeoutlen = 10000
-- set.smartindent=true
set.cindent = true

vim.g["slime_target"] = "kitty"

vim.g.indent_blankline_char = "▏"

vim.api.nvim_create_user_command("Format", "execute 'lua vim.lsp.buf.formatting()'", {})

vim.cmd "cnoreabbrev t Telescope"
vim.cmd "cnoreabbrev n Neorg"

vim.cmd [[
" print synstack group name
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]]

-- DiffWithSaved
vim.cmd [[
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" auto insert mode
autocmd TermOpen * startinsert
autocmd BufWinEnter,WinEnter term://* startinsert
com OR lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
]]

vim.cmd [[
function CenterPane()
  lefta vnew
  wincmd w
  exec 'vertical resize '. string(&columns * 0.75)
endfunction

"https://stackoverflow.com/questions/2295410/how-to-prevent-the-cursor-from-moving-back-one-character-on-leaving-insert-mode
autocmd InsertLeave * :normal! `^
" set virtualedit=onemore
]]
