-- TS/JS/React server (system: vtsls)
-- Inlay hints dimatiin semua (ganggu)
local no_hints = {
  inlayHints = {
    parameterNames = { enabled = "none" },
    parameterTypes = { enabled = false },
    variableTypes = { enabled = false },
    propertyDeclarationTypes = { enabled = false },
    functionLikeReturnTypes = { enabled = false },
    enumMemberValues = { enabled = false },
  },
}

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  settings = {
    typescript = no_hints,
    javascript = no_hints,
  },
}
