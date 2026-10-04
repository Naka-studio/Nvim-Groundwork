-- Statusline: lualine (theme ayu, separator default)
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- icon file
  event = "VeryLazy",
  opts = {
    options = {
      theme = "ayu",
      globalstatus = true, -- 1 statusline buat semua window
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } }, -- path relatif
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
