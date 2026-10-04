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
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

-- Keymap LSP (cuma aktif di buffer yg punya LSP)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>e", vim.diagnostic.open_float, "Show diagnostic")
    -- Inlay hints sengaja GK diaktifin (ganggu)
  end,
})
