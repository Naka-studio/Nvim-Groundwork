-- Leader harus di-set sebelum lazy.nvim load
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local o = vim.opt

-- Tampilan
o.number = true            -- nomor baris
o.relativenumber = true    -- nomor relatif (enak buat motion)
o.cursorline = true        -- highlight baris aktif
o.signcolumn = "yes"       -- kolom diagnostic gk geser layout
o.termguicolors = true     -- true color
o.showmode = false         -- mode udah ada di lualine
o.scrolloff = 8            -- jarak kursor ke tepi layar
o.fillchars = { eob = " " } -- hilangin "~" di baris kosong
vim.o.winborder = "rounded" -- semua floating window rounded

-- Wrap: editor TANPA wrap
o.wrap = false
o.sidescrolloff = 8

-- Indentasi (standar web dev: 2 spasi)
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true         -- sensitif huruf besar kalau diketik kapital

-- Perilaku
o.mouse = "a"              -- support sentuh/mouse
o.splitright = true
o.splitbelow = true
o.undofile = true          -- undo tetap ada setelah file ditutup
o.confirm = true          -- :q/:qa tanya simpan dulu kalau ada perubahan
o.updatetime = 250
o.timeoutlen = 1000
