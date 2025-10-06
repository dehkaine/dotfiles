-- ==================== Editor Options ====================

-- interface
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.list           = true
vim.opt.listchars      = { tab = "| ", trail = "▫" }
vim.opt.wrap           = true
vim.opt.textwidth      = 0
vim.opt.colorcolumn    = "+1"
vim.opt.visualbell     = true
vim.opt.showmode       = false
vim.opt.scrolloff      = 4
vim.opt.inccommand     = "split"
vim.opt.shortmess:append("c")
vim.opt.virtualedit    = "block"

vim.opt.selection      = "exclusive"

-- directory & file
vim.opt.autochdir      = true
vim.opt.viewoptions    = { "cursor", "folds", "slash", "unix" }

-- secure 
vim.opt.exrc   = true
vim.opt.secure = true

-- indent & tab 
vim.opt.expandtab   = false
vim.opt.tabstop     = 2
vim.opt.shiftwidth  = 2
vim.opt.softtabstop = 2
vim.opt.autoindent  = true
vim.opt.indentexpr  = ""      -- 只用 autoindent
vim.opt.formatoptions:remove({ "t", "c" })

-- fold
vim.opt.foldmethod = "indent"
vim.opt.foldlevel  = 99
vim.opt.foldenable = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- timeout & performance
vim.opt.ttimeoutlen = 0
vim.opt.timeout     = false
vim.opt.lazyredraw  = true
vim.opt.updatetime  = 100

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- completion
vim.opt.completeopt = { "longest", "noinsert", "menuone", "noselect", "preview" }

-- backup & undo & swap
local data = vim.fn.expand("$HOME/.config/nvim/tmp")
vim.fn.mkdir(data .. "/backup", "p")
vim.fn.mkdir(data .. "/undo",   "p")
vim.opt.backupdir = { data .. "/backup", "." }
vim.opt.directory = { data .. "/backup", "." }
if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undofile = true
  vim.opt.undodir  = { data .. "/undo", "." }
end

-- BufReadPost
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd([[normal! g'"]])
    end
  end,
})
