-- Lua server (system: lua-language-server)
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", "stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },          -- nvim pakai LuaJIT
      diagnostics = { globals = { "vim" } },     -- "vim" bukan undefined global
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME .. "/lua" }, -- autocomplete vim.api dkk
      },
      hint = { enable = false },                 -- inlay hints off
      telemetry = { enable = false },
    },
  },
}
