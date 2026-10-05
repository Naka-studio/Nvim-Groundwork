-- Keymap global
local map = vim.keymap.set

-- Buffer
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Tutup buffer" })
map("n", "L", "<cmd>bnext<cr>", { desc = "Buffer berikutnya" })
map("n", "H", "<cmd>bprevious<cr>", { desc = "Buffer sebelumnya" })
