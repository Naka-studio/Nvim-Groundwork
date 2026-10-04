-- Cmdline (:) & search (/ ?) jadi popup melayang, rounded
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- pesan dikirim ke notify (rounded + wrap)
  },
  opts = {
    cmdline = { view = "cmdline_popup" },
    presets = {
      command_palette = true, -- cmdline + menu completion jadi satu blok di atas
    },
    views = {
      cmdline_popup = {
        border = { style = "rounded", padding = { 0, 1 } },
      },
      cmdline_popupmenu = {
        border = { style = "rounded", padding = { 0, 1 } },
      },
    },
    -- Hover & signature pakai bawaan nvim (udah rounded)
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false },
    },
  },
}
