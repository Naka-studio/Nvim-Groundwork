-- Garis indent (indent-blankline v3)
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = { char = "│" },
    scope = { enabled = false }, -- highlight blok aktif dimatiin dulu
  },
}
