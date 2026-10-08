-- Tanda perubahan git di gutter (keymap ada di config/keymaps.lua)
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    preview_config = { border = "rounded" }, -- popup preview rounded
  },
}
