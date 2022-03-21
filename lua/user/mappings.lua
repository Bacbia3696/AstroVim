local map = vim.keymap.set
local function clear(a, b)
  return pcall(vim.keymap.del, a, b)
end
-- Del
-- clear("n", "<C-w>")
clear("n", "<C-q>")

clear("n", "<C-h>")
clear("n", "<C-j>")
clear("n", "<C-k>")
clear("n", "<C-l>")
clear("n", "<C-Up>")
clear("n", "<C-Down>")
clear("n", "<C-Left>")
clear("n", "<C-Right>")

clear({ "n", "v" }, "<A-k>")
clear({ "n", "v" }, "<A-j>")
clear("v", "<")
clear("v", ">")
clear("v", "p")

clear("n", "<leader>w")
clear("n", "<leader>q")
clear("n", "<leader>c")
clear("n", "<leader>h")
clear("n", "<leader>/")
clear("v", "<leader>/")
clear("v", "<leader>o")

clear("n", "<S-l>")
clear("n", "<S-h>")

clear("x", "J")
clear("x", "K")

clear("n", "ca")
clear("n", "gj")
clear("n", "gk")

-- lsp and Telescope
map("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations theme=dropdown<cr>")
map("n", "gt", "<cmd>Telescope lsp_type_definitions theme=dropdown<cr>")
map("n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<cr>")
map("n", "ga", "<cmd>Telescope lsp_code_actions theme=cursor<cr>")

map("n", "<leader>y", "<cmd>Telescope neoclip<cr>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

map({ "i", "n" }, "<C-s>", "<esc><cmd>lua vim.lsp.buf.formatting_sync()<cr><cmd>up<CR>", { silent = true })
map("", "<leader>q", "<cmd>qa<CR>")
map("", "<C-q>", "<cmd>q<cr>")
-- map("", "<C-e>", "3<C-e>")
-- map("", "<C-y>", "3<C-y>")

map("!", "<C-a>", "<Home>")
map("!", "<C-e>", "<End>")
map("!", "<C-p>", "<Up>")
map("!", "<C-n>", "<Down>")
map("!", "<C-b>", "<Left>")
map("!", "<C-f>", "<Right>")
map("!", "<M-b>", "<S-Left>")
map("!", "<M-f>", "<S-Right>")

map("n", "<M-a>", "ggVG")
map("n", "<C-w>>", "5<C-w>>")
map("n", "<C-w><", "5<C-w><")

-- tab hotkey
map("", "<M-k>", "<cmd>tabn<cr>")
map("", "<M-t>", "<cmd>tabnew<cr>")
map("", "<M-j>", "<cmd>tabp<cr>")
map("", "<M-k>", "<cmd>tabn<cr>")

-- map("", ":", ";")
map("", ";", ":")
map("n", "<C-l>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>")

map("n", "<leader><leader>", "<cmd>Telescope<cr>")

-- navigate window
for i = 1, 9, 1 do
  map({ "n", "i" }, "<M-" .. i .. ">", "<cmd>" .. i .. "wincmd w<cr>")
end

map("n", "*", "<cmd>keepjumps normal! mi*`i<CR>")

map("n", "<C-k>", vim.lsp.buf.signature_help)

map("v", "-", "kojV")

map("n", ",p", [["0p]])
map("n", ",P", [["0P]])

-- undo breakpoint
map("i", ",", ",<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")

-- hop
vim.keymap.set({ "n", "o", "x" }, "f", "<CMD>HopChar1MW<CR>")
vim.keymap.set({ "n", "o", "x" }, "F", "<CMD>HopChar1<CR>")
