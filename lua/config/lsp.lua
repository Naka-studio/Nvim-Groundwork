-- Kasih tau semua server: client support completion + snippet (blink.cmp)
local ok, cmp_lsp = pcall(require, "blink.cmp")
if ok then
  vim.lsp.config("*", { capabilities = cmp_lsp.get_lsp_capabilities() })
end

-- Aktifin semua server (nama = nama file di lsp/)
vim.lsp.enable({
  "vtsls", "eslint", "html", "cssls", "emmet", "jsonls", "lua_ls",
})

-- Tampilan diagnostic
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,           -- gk berisik pas ngetik
  virtual_text = { prefix = "●", spacing = 2 },
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = vim.fn.nr2char(0xf057),
      [vim.diagnostic.severity.WARN] = vim.fn.nr2char(0xf071),
      [vim.diagnostic.severity.INFO] = vim.fn.nr2char(0xf05a),
      [vim.diagnostic.severity.HINT] = vim.fn.nr2char(0xf0eb),
    },
  },
})

