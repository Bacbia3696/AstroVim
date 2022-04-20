-- Set autocommands
-- vim.cmd [[
--   augroup packer_conf
--     autocmd!
--     autocmd bufwritepost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

local group = vim.api.nvim_create_augroup("utils", { clear = true })
-- disable auto add comment new line
vim.api.nvim_create_autocmd("BufEnter *", { command = "set formatoptions-=cro", group = group })
-- highlight yanked text
vim.api.nvim_create_autocmd(
  "TextYankPost",
  { command = "silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }", group = group }
)

-- open last leave position
vim.api.nvim_create_autocmd("BufReadPost", {
  command = [[ if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
  group = group,
})


-- colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "*" },
  command = [[highlight LineNr guifg=grey
  highlight TSTag guifg=#40d9ff
  highlight TSInclude guifg=#ff9640
  highlight TSString guifg=#7bc99c
  highlight TSVariable guifg=#d47d85
  ]]
})

-- sql
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  command = [[set ts=4 | set sw=4]]
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "tsconfig.json" },
  command = "set ft=jsonc",
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "lib*.d.ts" },
  command = "ed ++ff=dos %",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "neorg" },
  command = "set concealcursor=nc | set conceallevel=2",
})
