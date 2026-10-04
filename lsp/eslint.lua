-- ESLint server (system: vscode-langservers-extracted)
local flat_configs = {
  "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
  "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
}
local root_files = vim.list_extend(
  vim.deepcopy(flat_configs),
  { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "package.json" }
)

return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
  -- Cuma start kalo root ketemu (gk ada root = server gk dijalanin)
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, root_files)
    if root then on_dir(root) end
  end,
  settings = {
    validate = "on",
    run = "onType",
    packageManager = "npm",
    workingDirectory = { mode = "auto" },
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
  },
  -- Server butuh workspaceFolder (konsep VSCode) + deteksi flat config
  before_init = function(_, config)
    local root = config.root_dir
    if not root then return end
    config.settings = config.settings or {}
    config.settings.workspaceFolder = {
      uri = root,
      name = vim.fn.fnamemodify(root, ":t"),
    }
    for _, f in ipairs(flat_configs) do
      if vim.fn.filereadable(root .. "/" .. f) == 1 then
        config.settings.experimental = { useFlatConfig = true }
        break
      end
    end
  end,
  -- Balasan wajib buat request custom dari server
  handlers = {
    ["eslint/confirmESLintExecution"] = function() return 4 end, -- 4 = allow
    ["eslint/noLibrary"] = function()
      vim.notify("ESLint belum terpasang di project", vim.log.levels.WARN)
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("ESLint gagal dijalankan", vim.log.levels.WARN)
    end,
  },
}
