-- Theme utama: ayu dark (comment gk italic)
return {
  "Shatur/neovim-ayu",
  lazy = false,    -- load di awal, bukan lazy
  priority = 1000, -- harus load sebelum plugin UI lain
  config = function()
    local colors = require("ayu.colors")
    require("ayu").setup({
      mirage = false, -- varian dark murni, bukan mirage
      overrides = function()
        -- Comment cuma set warna, tanpa italic
        return { Comment = { fg = colors.comment, italic = false } }
      end,
    })
    vim.cmd.colorscheme("ayu-dark")
  end,
}
