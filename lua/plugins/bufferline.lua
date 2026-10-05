-- Tab buffer di atas (bufferline)
return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      diagnostics = "nvim_lsp", -- jumlah error/warning per tab
      -- Tutup buffer tanpa ngerusak layout window
      close_command = function(n) Snacks.bufdelete(n) end,
      -- Geser tab saat neo-tree kebuka
      offsets = {
        { filetype = "neo-tree", text = "Explorer", text_align = "left" },
      },
    },
  },
}
