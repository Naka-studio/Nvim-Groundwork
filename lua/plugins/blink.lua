-- Completion: blink.cmp (insert mode + cmdline)
return {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    keymap = {
      preset = "enter", -- Enter = terima, Up/Down & C-n/C-p = pilih
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      menu = { border = "rounded" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      -- Gk ada item terpilih otomatis; item langsung ketulis saat dipilih
      list = { selection = { preselect = false, auto_insert = true } },
      accept = { auto_brackets = { enabled = true } }, -- tutup () otomatis
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    -- Matcher Lua: gk butuh binary prebuilt (aman di Termux)
    fuzzy = { implementation = "lua" },
    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      completion = {
        menu = { auto_show = true }, -- menu muncul sendiri pas ngetik
        list = { selection = { preselect = false, auto_insert = true } },
      },
    },
  },
}
