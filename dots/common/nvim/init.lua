-- ===================
-- lua config
-- ===================

require("basic_mappings")
require("snippets.common")

-- editor
require("editor.options")
require("editor.cursor")
require("editor.tab")
require("editor.window")

-- set terminal color
require("themes.terminal_colors")

-- plugins
require("plug_libs")

-- vim.api.nvim_create_autocmd({"BufReadPost","BufNewFile"}, {
--   callback = function()
--     vim.cmd("TSBufEnable highlight")
--   end,
-- })
