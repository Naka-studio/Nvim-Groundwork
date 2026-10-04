-- Tanda perubahan git di gutter
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    preview_config = { border = "rounded" }, -- popup preview rounded
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(keys, fn, desc)
        vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
      end
      map("]h", function() gs.nav_hunk("next") end, "Hunk berikutnya")
      map("[h", function() gs.nav_hunk("prev") end, "Hunk sebelumnya")
      map("<leader>hp", gs.preview_hunk, "Preview hunk")
      map("<leader>hs", gs.stage_hunk, "Stage hunk")
      map("<leader>hr", gs.reset_hunk, "Reset hunk")
      map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame baris")
    end,
  },
}
