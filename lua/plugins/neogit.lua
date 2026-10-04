-- Neogit: UI git ala Magit (tampilan default: tab layar penuh)
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- wajib
    "nvim-telescope/telescope.nvim", -- opsional: menu pilihan lewat telescope
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
  opts = {
    integrations = { telescope = true },
  },
}
