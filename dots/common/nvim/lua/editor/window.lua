-- ==================== Window Management ====================
local map = vim.keymap.set
local ns  = { noremap = true, silent = true }

-- Focus switching
map("n", "<leader><Tab>",     "<C-w>w", ns)
map("n", "<leader>s<Tab>",    "<C-w>x", ns)
map("n", "<leader><leader>k", "<C-w>k", ns)
map("n", "<leader><leader>j", "<C-w>j", ns)
map("n", "<leader><leader>h", "<C-w>h", ns)
map("n", "<leader><leader>l", "<C-w>l", ns)
map("n", "qs",                "<C-w>o", ns)

-- Split: Up/Down/Left/Right
map("n", "<leader><leader>sj", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", ns)
map("n", "<leader>sj",          ":set splitbelow<CR>:split<CR>", ns)
map("n", "<leader><leader>sl", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", ns)
map("n", "<leader>sl",          ":set splitright<CR>:vsplit<CR>", ns)

-- Resize (arrow keys)
map("n", "<Up>",    ":res +5<CR>",              ns)
map("n", "<Down>",  ":res -5<CR>",              ns)
map("n", "<Left>",  ":vertical resize-5<CR>",   ns)
map("n", "<Right>", ":vertical resize+5<CR>",   ns)

-- Rotate layout
map("n", "<leader>rwv", "<C-w>b<C-w>K", ns)
map("n", "<leader>rwh", "<C-w>b<C-w>H", ns)

-- Close adjacent windows
map("n", "<leader><leader>qh", "<C-w>h:q<CR>", ns)
map("n", "<leader><leader>qj", "<C-w>j:q<CR>", ns)
map("n", "<leader><leader>qk", "<C-w>k:q<CR>", ns)
map("n", "<leader><leader>ql", "<C-w>l:q<CR>", ns)
