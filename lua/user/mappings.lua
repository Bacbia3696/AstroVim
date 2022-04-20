local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map("", ":", ";")
map("", ";", ":")

-- lsp
map("n", "gr", "<cmd>Telescope lsp_references theme=ivy<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations theme=dropdown<cr>")
map("n", "gt", "<cmd>Telescope lsp_type_definitions theme=dropdown<cr>")
map("n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<cr>")
-- map("n", "ga", "<cmd>Telescope lsp_code_actions theme=cursor<cr>")
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<C-k>", vim.lsp.buf.signature_help)
map("n", "K", vim.lsp.buf.hover)
-- map("n", "go", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>li", "<cmd>LspInfo<cr>")
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>")

-- use built-in
-- map("n", "gr", vim.lsp.buf.references)
-- map("n", "gi", vim.lsp.buf.implementation)
-- map("n", "gd", vim.lsp.buf.definition)
-- map("n", "gt", vim.lsp.buf.type_definition)
map("n", "ga", vim.lsp.buf.code_action)

-- format onsave
map({ "i", "n" }, "<C-s>", "<esc><cmd>lua vim.lsp.buf.formatting_sync()<cr><cmd>up<CR>", { silent = true })
map("", "<leader>q", "<cmd>qa<CR>")
map("", "<C-q>", "<cmd>q<cr>")

-- mapping in insert/command mode
map("!", "<C-a>", "<Home>")
map("!", "<C-e>", "<End>")
map("!", "<C-p>", "<Up>")
map("!", "<C-n>", "<Down>")
map("!", "<C-b>", "<Left>")
map("!", "<C-f>", "<Right>")
map("!", "<M-b>", "<S-Left>")
map("!", "<M-f>", "<S-Right>")

-- navigate vim tab
map("", "<M-k>", "<cmd>tabn<cr>")
map("", "<M-t>", "<cmd>tabnew<cr>")
map("", "<M-j>", "<cmd>tabp<cr>")
map("", "<M-k>", "<cmd>tabn<cr>")
-- navigate window
for i = 1, 9, 1 do
  map({ "n", "i" }, "<M-" .. i .. ">", "<cmd>" .. i .. "wincmd w<cr>")
end

map("n", "<M-a>", "ggVG")
map("n", "<C-w>>", "5<C-w>>")
map("n", "<C-w><", "5<C-w><")

map("n", "*", "<cmd>keepjumps normal! mi*`i<CR>")
map("n", ",p", [["0p]])
map("n", ",P", [["0P]])

-- undo breakpoint
map("i", ",", ",<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")

-- plugin mapping
map("n", "<leader><leader>", "<cmd>Telescope builtin<cr>")
map("n", "<leader>y", "<cmd>Telescope neoclip<cr>")
map("n", "<leader>da", "<cmd>Telescope diagnostics<cr>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- hop
vim.keymap.set({ "n", "o", "x" }, "f", "<CMD>HopChar1MW<CR>")
vim.keymap.set({ "n", "o", "x" }, "F", "<CMD>HopChar1<CR>")

-- telescope

map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end)
-- map("n", "<leader>gt", function()
--   require("telescope.builtin").git_status()
-- end)
-- map("n", "<leader>gb", function()
--   require("telescope.builtin").git_branches()
-- end)
-- map("n", "<leader>gc", function()
--   require("telescope.builtin").git_commits()
-- end)
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end)
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end)
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end)
map("n", "<leader>fm", function()
  require("telescope.builtin").marks()
end)
map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end)
-- map("n", "<leader>sb", function()
--   require("telescope.builtin").git_branches()
-- end)
-- map("n", "<leader>sh", function()
--   require("telescope.builtin").help_tags()
-- end)
map("n", "<leader>sm", function()
  require("telescope.builtin").man_pages()
end)
map("n", "<leader>sn", function()
  require("telescope").extensions.notify.notify()
end)
map("n", "<leader>sr", function()
  require("telescope.builtin").registers()
end)
map("n", "<leader>sk", function()
  require("telescope.builtin").keymaps()
end)
map("n", "<leader>sc", function()
  require("telescope.builtin").commands()
end)
map("n", "<leader>ls", function()
  require("telescope.builtin").lsp_document_symbols()
end)
map("n", "<leader>lR", function()
  require("telescope.builtin").lsp_references()
end)
map("n", "<leader>lD", function()
  require("telescope.builtin").diagnostics()
end)

-- toggleterm

local _user_terminals = {}
local function toggle_term_cmd(cmd)
  if _user_terminals[cmd] == nil then
    _user_terminals[cmd] = require("toggleterm.terminal").Terminal:new { cmd = cmd, hidden = true }
  end
  _user_terminals[cmd]:toggle()
end

map("n", "<leader>gg", function()
  toggle_term_cmd("NVIM_LISTEN_ADDRESS=" .. vim.v.servername .. " lazygit")
end)
map("n", "<leader>tn", function()
  toggle_term_cmd "node"
end)
map("n", "<leader>tu", function()
  toggle_term_cmd "ncdu"
end)
map("n", "<leader>tt", function()
  toggle_term_cmd "htop"
end)
map("n", "<leader>tp", function()
  toggle_term_cmd "python"
end)
map("n", "<leader>tl", function()
  toggle_term_cmd("NVIM_LISTEN_ADDRESS=" .. vim.v.servername .. " lazygit")
end)
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>")
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")
map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>")

-- packer
map("n", "<leader>pc", "<cmd>PackerCompile<cr>")
map("n", "<leader>pi", "<cmd>PackerInstall<cr>")
map("n", "<leader>ps", "<cmd>PackerSync<cr>")
map("n", "<leader>pS", "<cmd>PackerStatus<cr>")
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>")
map("n", "<leader>6", "<C-6>")

map('t', '<C-q>', [[<C-\><C-n>]])
map('t', '<M-1>', [[<cmd>1wincmd w<cr>]])
map('t', '<M-2>', [[<cmd>2wincmd w<cr>]])
map('t', '<M-3>', [[<cmd>3wincmd w<cr>]])
-- pbpaste > /tmp/file.html && htmltojsx /tmp/file.html | pbcopy
map("n", "ss", [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])
map("n", "st", [[yat :silent execute '!pbpaste > /tmp/file.html && htmltojsx /tmp/file.html | pbcopy'<CR>]])
