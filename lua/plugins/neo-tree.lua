-- File explorer: neo-tree
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  opts = {
    -- Ikon status git (range Font Awesome, aman di Cascadia NF)
    default_component_configs = {
      git_status = {
        symbols = {
          added = vim.fn.nr2char(0xf067),     -- +
          modified = vim.fn.nr2char(0xf040),  -- pensil
          deleted = vim.fn.nr2char(0xf1f8),   -- tempat sampah
          renamed = vim.fn.nr2char(0xf061),   -- panah
          untracked = vim.fn.nr2char(0xf111), -- bulat (file baru)
          ignored = vim.fn.nr2char(0xf070),   -- mata dicoret
          unstaged = vim.fn.nr2char(0xf096),  -- kotak kosong
          staged = vim.fn.nr2char(0xf046),    -- kotak centang
          conflict = vim.fn.nr2char(0xf071),  -- segitiga peringatan
        },
      },
    },
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
