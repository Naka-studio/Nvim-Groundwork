-- Render markdown di buffer (heading, tabel, checkbox, code block)
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown", -- load saat buka file markdown
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- ikon bahasa di code block
  },
  opts = {},
}
