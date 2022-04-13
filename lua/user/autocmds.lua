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
vim.api.nvim_create_autocmd("ColorScheme *", {
  command = [[highlight LineNr guifg=grey ]]
})

-- sql
vim.api.nvim_create_autocmd("FileType sql", {
  command = [[set ts=4 | set sw=4]]
})
