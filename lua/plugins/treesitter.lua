-- Treesitter (branch main): highlight + indent berbasis parser
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,          -- plugin ini gk support lazy-load
  build = ":TSUpdate",
  config = function()
    -- Parser yg di-compile lokal (async, skip kalau udah ada)
    require("nvim-treesitter").install({
      "html", "css", "javascript", "typescript", "tsx",
      "json", "lua", "vim", "vimdoc", "query",
      "markdown", "markdown_inline", "bash", "regex",
    })

    -- Aktifin highlight + indent per filetype
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "html", "css", "javascript", "javascriptreact",
        "typescript", "typescriptreact", "json", "jsonc",
        "lua", "markdown", "sh", "bash",
      },
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or args.match
        -- skip kalau parser belum ke-install (hindari error)
        if not vim.treesitter.language.add(lang) then return end
        vim.treesitter.start(args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
