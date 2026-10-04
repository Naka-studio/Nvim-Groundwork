-- Popup bantuan keymap
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Keymap buffer ini",
    },
  },
  opts = {
    preset = "classic",
    win = { border = "rounded" }, -- popup rounded
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>h", group = "git hunk" },
      { "<leader>c", group = "code" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
    },
  },
}
