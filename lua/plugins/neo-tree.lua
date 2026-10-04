-- File explorer: neo-tree
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
  },
  opts = {
    popup_border_style = "rounded", -- popup input/konfirmasi rounded
    close_if_last_window = true,    -- tutup nvim kalau cuma sisa explorer
    window = {
      position = "left",
      width = 30,
    },
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight file yg lagi dibuka
      use_libuv_file_watcher = true,            -- auto-refresh kalau file berubah
      filtered_items = {
        hide_dotfiles = false, -- dotfile (.env, .gitignore) tetep keliatan
        hide_gitignored = false,
      },
    },
  },
}
