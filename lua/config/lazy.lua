-- Bootstrap lazy.nvim (auto-clone kalau belum ada)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Gagal clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } }, -- load semua file di lua/plugins/
  install = { colorscheme = { "habamax" } }, -- fallback theme saat install pertama
  checker = { enabled = false }, -- gk auto-cek update
  change_detection = { notify = false }, -- gk spam notif tiap edit config
  ui = { border = "rounded" }, -- window lazy rounded
  rocks = { enabled = false }, -- gk butuh luarocks
})
