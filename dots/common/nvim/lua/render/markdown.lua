return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx", "rmd" },  -- 只在这些文件类型加载
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- 二选一装一个图标提供者
      -- "echasnovski/mini.icons",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      preset = "none",
      file_types = { "markdown" },   -- 插件内部也有 file_types，保持默认即可
      -- 需要时可改：render_modes = { "n", "i" },
      heading = {
        enabled = true,
        width = "full",
        border = true,               -- 标题上下加分隔
        border_virtual = true,       -- 总是用虚拟行画边框，避免改动真实缓冲区
        above = "▄",
        below = "▀",
        left_margin = 0,
        left_pad = 0,
        -- 背景/前景走高亮组（见下方 config 里统一设色）
        -- backgrounds/foregrounds 默认就是 RenderMarkdownH1(H1Bg) ~ H6(H6Bg)
      },
      code = {
        enabled = true,
        width = "full",
        border = "hide",             -- 顶/底边界由虚拟字符绘制，且尽量隐藏空行
        language = true,
        language_icon = true,
        language_name = true,
        inline = true,
      },
      bullet = { icons = { "●", "○", "◆", "◇" } },
      checkbox = {
        enabled = true,
        bullet = false,
        unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
        checked   = { icon = "󰱒 ", highlight = "RenderMarkdownChecked"  },
      },
      quote = { icon = "▋" },
      dash  = { icon = "─", width = "full" },
      pipe_table = { preset = "none" },
      anti_conceal = {
        enabled = true,
        ignore = { code_background = true, indent = true, sign = true, virtual_lines = true },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- 🔧 颜色与主题衔接：
      -- heading 的底色由 RenderMarkdownH1Bg~H6Bg 决定；
      -- 如果你想“无底色”，把 bg 设为 "NONE" 即可。
      local set = vim.api.nvim_set_hl
      local ok, _ = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
      -- 示例：去掉标题底色，并给标题字色一些层级差
      set(0, "RenderMarkdownH1Bg", { bg = "NONE" })
      set(0, "RenderMarkdownH2Bg", { bg = "NONE" })
      set(0, "RenderMarkdownH3Bg", { bg = "NONE" })
      set(0, "RenderMarkdownH4Bg", { bg = "NONE" })
      set(0, "RenderMarkdownH5Bg", { bg = "NONE" })
      set(0, "RenderMarkdownH6Bg", { bg = "NONE" })

      -- 这里按需给标题前景色做微调（示例色号，后续你可以换成更贴合 gruvbox/deus 的色）
      set(0, "RenderMarkdownH1", { fg = "#ebdbb2", bold = true })
      set(0, "RenderMarkdownH2", { fg = "#d5c4a1", bold = true })
      set(0, "RenderMarkdownH3", { fg = "#bdae93", bold = true })
      set(0, "RenderMarkdownH4", { fg = "#a89984", bold = true })
      set(0, "RenderMarkdownH5", { fg = "#928374", bold = true })
      set(0, "RenderMarkdownH6", { fg = "#7c6f64", bold = true })

      -- 可选：把边框颜色调淡一些（沿用代码边框风格）
      set(0, "RenderMarkdownCodeBorder", { fg = "#504945" })
    end,
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "render-markdown: Toggle" },
      { "<leader>mR", "<cmd>RenderMarkdown restart<CR>", desc = "render-markdown: Restart" },
    },
  },
}