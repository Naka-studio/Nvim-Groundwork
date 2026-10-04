-- Emmet server (system: emmet-language-server)
return {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "html", "css", "scss", "less",
    "javascriptreact", "typescriptreact",
  },
  root_markers = { "package.json", ".git" },
}
