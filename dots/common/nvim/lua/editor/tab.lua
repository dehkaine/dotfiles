-- ==================== Tab Management ====================
local map = vim.keymap.set
local ns  = { noremap = true, silent = true }

-- New tab
map("n", "ta", ":tabe<CR>",      ns)
map("n", "tA", ":tab split<CR>", ns)

-- Switch tab
map("n", "th", ":-tabnext<CR>", ns)
map("n", "tl", ":+tabnext<CR>", ns)

-- Move tab
map("n", "tmh", ":-tabmove<CR>", ns)
map("n", "tml", ":+tabmove<CR>", ns)
