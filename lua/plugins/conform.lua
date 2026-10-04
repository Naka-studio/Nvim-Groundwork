-- Formatter: conform.nvim (prettierd -> prettier, format on save)
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      desc = "Format file",
    },
  },
  opts = {
    formatters_by_ft = {
      -- Pakai prettierd; kalau gk ada, fallback ke prettier
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Format otomatis tiap save; filetype tanpa formatter pakai LSP
    format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },
  },
}
