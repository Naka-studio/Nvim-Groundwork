-- Auto tutup + rename tag HTML/JSX (berbasis treesitter)
return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
}
