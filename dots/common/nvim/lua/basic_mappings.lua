-- ==================== Basic Mappings ====================

local map = vim.keymap.set
local ns  = { noremap = true, silent = true }
local rs  = { remap   = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = vim.api.nvim_replace_termcodes("<BS>", true, true, true)
-- vim.g.maplocalleader = "-"

-- LazyNvim
map("n", "<leader>lz", ":Lazy<CR>", ns)

-- Save and quit
map("n", "Q", ":q<CR>", ns)
map("n", "<leader>qq", ":q<CR>", ns)
map("n", "<leader>fq", ":q!<CR>", ns)
map("n", "<leader>W", ":wq<CR>", ns)
map("n", "<leader>w" , ":w<CR>", ns)

-- Quick edit nvim config
map("n", "<leader>rc", ":e " .. vim.fn.expand("$HOME/.config/nvim/init.lua") .. "<CR>", ns)
map("n", "<leader>rv", ":e .nvimrc<CR>", ns)

-- source .nvimrc on save
do
  local grp = vim.api.nvim_create_augroup("NVIMRC", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = grp, pattern = "*.nvimrc",
    callback = function() vim.cmd("source %") end,
  })
end

-- System clipboard
map("n", "<leader>Y", '"+yy', ns)
map("v", "Y", '"+y', { noremap = true })

-- Better indenting
map("n", ",.", "%", { noremap = true })
map("v", "ki", "$%", { noremap = true })

-- Clear search highlight
map("n", "<leader><CR>", ":nohlsearch<CR>", ns)

-- Search for the word under the cursor and highlight all occurrences
map("n", "<leader>sdw", [[/\(\<\w\+\>\)\_s*\1]], { noremap = true })

-- Switch spaces and tabs
map("n", "<leader>tt", [[:%s/    /\t/g<CR>]], { noremap = true })
map("x", "<leader>tt", [[:s/    /\t/g<CR>]],  { noremap = true })

-- Fold toggle
map("n", "<leader>z", "za", ns)

-- Insert a new line below and switch to insert mode
map("n", "<leader>o", "o<Esc>", ns)

-- Insert: Insert {} at the end of the line and switch to the previous line to continue editing (preserve original macro sequence)
map("i", "<C-b>", "<ESC>A {}<ESC>i<CR><ESC>ko", { noremap = true })

-- Insert: Quickly start a new line in insert mode
map("i", "<C-CR>", "<Esc>o", { noremap = true })

-- black hole register for delete and change
map("n", "<leader>dd", [["_dd]], ns)
map("n", "<leader>cc", [["_cc]], ns)

-- Move current line
map("n", "<A-i>", ":m .-2<CR>==", ns)  -- Up
map("n", "<A-k>", ":m .+1<CR>==", ns)  -- Down

-- Comment
map("n", "co", "gcc", rs)
map("v", "co", "gc", rs)

