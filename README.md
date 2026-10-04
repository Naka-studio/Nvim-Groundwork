# 💤 LazyVim Custom Config & Theme Naka Studio

<div align="center">
	<img src="https://raw.githubusercontent.com/Naka-studio/.resources/main/images/nvim-groundwork/dashboard-preview.webp" width="500" alt="Deskripsi Gambar" />
</div>


![Neovim](https://img.shields.io/badge/Neovim-0.12%2B-57A143?logo=neovim&logoColor=white)




![Platform](https://img.shields.io/badge/Termux-Android-3DDC84?logo=android&logoColor=white)




![Plugin Manager](https://img.shields.io/badge/lazy.nvim-manager-blue)




![Theme](https://img.shields.io/badge/Theme-Ayu%20Dark-orange)



Konfigurasi Neovim modern untuk **web development**, dirancang agar nyaman dipakai langsung dari **Termux di Android**. Ringan, modular, dan tampilannya bersih dengan semua popup berborder rounded.

## Daftar Isi

1. [Pengertian](#1-pengertian)
2. [Penjelasan Environment](#2-penjelasan-environment)
3. [Dependencies](#3-dependencies)
4. [Custom Config](#4-custom-config)
5. [Support](#5-support)
6. [Closing](#6-closing)

---

## 1. Pengertian

Ini adalah konfigurasi Neovim yang ditulis **dari nol** menggunakan [lazy.nvim](https://github.com/folke/lazy.nvim), lengkap dengan LSP, autocomplete, file explorer, dan tema sendiri.

> [!NOTE]
> Meskipun judulnya memuat kata "LazyVim", config ini **bukan** distro LazyVim. Seluruh struktur dan plugin ditulis manual supaya mudah dipahami dan diubah.

### Fitur Utama

- 🎨 **Tema Ayu Dark** dengan style comment block non-italic
- 🧠 **LSP berbasis sistem** (dipasang lewat `pkg`/`npm`), tanpa Mason
- ✨ **Autocomplete** dengan `blink.cmp`, termasuk saran di cmdline lengkap dengan ikon
- 🪟 **Popup rounded**: completion, dokumentasi, notifikasi, cmdline, search
- 📝 Teks notifikasi otomatis **wrap**, editor sendiri **tanpa wrap**
- 🌳 File explorer `neo-tree`, pencarian `telescope`, statusline `lualine`
- 🧩 Plugin pendukung web dev: format on save, auto tag, preview warna, gitsigns, dan lainnya
- 🏠 Dashboard **NAKA STUDIO**

### Struktur Folder

```text
~/.config/nvim/
├── init.lua              # entry point
├── lazy-lock.json        # versi plugin yang dikunci
├── lsp/                  # satu file per language server
│   ├── vtsls.lua
│   ├── eslint.lua
│   ├── html.lua
│   ├── cssls.lua
│   ├── emmet.lua
│   ├── jsonls.lua
│   └── lua_ls.lua
└── lua/
    ├── config/
    │   ├── options.lua   # opsi editor & leader key
    │   ├── lazy.lua      # bootstrap lazy.nvim
    │   └── lsp.lua       # aktivasi LSP, diagnostic, keymap LSP
    └── plugins/          # satu file per plugin/kategori
        ├── colorscheme.lua   ├── treesitter.lua   ├── blink.lua
        ├── lualine.lua       ├── neo-tree.lua     ├── telescope.lua
        ├── notify.lua        ├── noice.lua        ├── dashboard.lua
        ├── conform.lua       ├── autopairs.lua    ├── autotag.lua
        ├── highlight-colors.lua  ├── gitsigns.lua ├── which-key.lua
				└── indent.lua        ├── surround.lua     └── neogit.lua
```

### Daftar Plugin

| Plugin | Fungsi |
|---|---|
| `lazy.nvim` | Plugin manager |
| `neovim-ayu` | Tema Ayu Dark |
| `nvim-treesitter` (branch `main`) | Syntax highlight & indent |
| `blink.cmp` | Autocomplete (insert mode & cmdline) |
| `noice.nvim` + `nvim-notify` | Cmdline/search popup & notifikasi |
| `lualine.nvim` | Statusline |
| `neo-tree.nvim` | File explorer |
| `telescope.nvim` | Fuzzy finder |
| `conform.nvim` | Format on save (Prettier) |
| `nvim-autopairs` | Auto tutup kurung dan kutip |
| `nvim-ts-autotag` | Auto tutup/rename tag HTML & JSX |
| `nvim-highlight-colors` | Preview warna di kode |
| `gitsigns.nvim` | Penanda perubahan git |
| `which-key.nvim` | Bantuan keymap |
| `indent-blankline.nvim` | Garis indentasi |
| `nvim-surround` | Edit pembungkus (kutip, kurung, tag) |
| `snacks.nvim` | Dashboard (hanya modul dashboard yang aktif) |
| `neogit` | UI Git ala Magit (status, commit, push) |

### Keymap Penting

Leader key: **`Space`**

| Keymap | Fungsi |
|---|---|
| `<leader>n` | Buka/tutup file explorer |
| `<leader>ff` / `fg` / `fb` / `fr` / `fh` | Cari file / grep / buffer / file terakhir / help |
| `<leader>cf` | Format file manual |
| `<leader>?` | Lihat keymap di buffer ini |
| `gd` / `K` | Ke definisi / dokumentasi hover |
| `<leader>rn` / `<leader>ca` / `<leader>e` | Rename / code action / detail diagnostic |
| `]h` / `[h` | Hunk git berikutnya / sebelumnya |
| `<leader>hp` / `hs` / `hr` / `hb` | Preview / stage / reset hunk / blame baris |
| `gcc` | Komentar baris (bawaan Neovim) |
| `ysiw"` / `cs"'` / `ds'` | Tambah / ganti / hapus pembungkus |
| `↑` `↓` atau `Ctrl+n` `Ctrl+p` | Pilih saran di completion dan cmdline |
| `<leader>gg` | Buka Neogit (UI Git) |

---

## 2. Penjelasan Environment

Config ini dikembangkan dan diuji pada lingkungan berikut:

| Komponen | Versi / Detail |
|---|---|
| Perangkat | Android (HP) |
| Terminal | Termux |
| Neovim | v0.12.5 |
| Node.js / npm | v26.4.0 / 11.20.0 |
| Git | 2.56.0 |
| Font | Cascadia Code Nerd Font (CaskaydiaCove NF) |

> [!IMPORTANT]
> Config memakai fitur bawaan Neovim yang baru (`vim.lsp.config`, `vim.lsp.enable`, `winborder`, `vim.snippet`). Gunakan **Neovim 0.12 atau lebih baru**.

### Prinsip Desain

- **LSP dari sistem**: semua language server dipasang lewat `pkg`/`npm`, bukan Mason.
- **Modern rounded Layout**: border popup konsisten.
- **Inlay hints dimatikan**: Preferensi pribadi.
- **Modular**: satu file untuk satu tanggung jawab, mudah dicari dan diubah.

### Font

Ikon membutuhkan Nerd Font. Untuk Termux:

1. Unduh **CascadiaCode** dari [Nerd Fonts Releases](https://github.com/ryanoasis/nerd-fonts/releases), lalu ekstrak.
2. Salin file font Regular sebagai font Termux (nama file bisa sedikit berbeda):

```bash
termux-setup-storage
cp ~/storage/downloads/CaskaydiaCoveNerdFont-Regular.ttf ~/.termux/font.ttf
termux-reload-settings
```

---

## 3. Dependencies

### Langkah 1: Paket Termux

```bash
pkg update && pkg upgrade -y
pkg install -y neovim git nodejs clang make tree-sitter ripgrep fd lazygit lua-language-server
```

### Langkah 2: Language Server & Formatter (npm)

```bash
npm install -g \
  @vtsls/language-server \
  vscode-langservers-extracted \
  @olrtg/emmet-language-server \
  @fsouza/prettierd \
  typescript
```

### Langkah 3: Verifikasi

```bash
nvim --version | head -n 1
which vtsls emmet-language-server lua-language-server prettierd
which vscode-html-language-server vscode-css-language-server vscode-json-language-server vscode-eslint-language-server
which rg fd lazygit tree-sitter clang make
```

Semua perintah `which` harus menampilkan path. Jika ada yang kosong, ulangi langkah pemasangan paket tersebut.

| Dependency | Fungsi |
|---|---|
| `clang`, `make`, `tree-sitter` | Compile parser treesitter |
| `ripgrep`, `fd` | Mesin pencarian Telescope |
| `lazygit` | Git UI |
| `vtsls` | LSP TypeScript/JavaScript/React |
| `vscode-langservers-extracted` | LSP HTML, CSS, JSON, ESLint |
| `emmet-language-server` | Emmet |
| `lua-language-server` | LSP Lua |
| `prettierd` | Formatter (dipakai `conform.nvim`) |

> [!NOTE]
> Server ESLint hanya aktif jika project memiliki konfigurasi ESLint atau `package.json`, dan `eslint` terpasang di project tersebut.

---

## 4. Custom Config

### Instalasi

1. **Backup config lama** (lewati jika belum punya):

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. **Clone repo ini:**

```bash
git clone https://github.com/Naka-studio/Nvim-Grounwork.git ~/.config/nvim
```

3. **Buka Neovim**, lalu tunggu proses instalasi plugin dan compile parser treesitter sampai selesai. Di HP ini bisa memakan waktu 1 sampai 2 menit, jangan ditutup.

```bash
nvim
```

4. **Cek kesehatan config:**

```vim
:checkhealth lazy
:checkhealth vim.lsp
:checkhealth vim.treesitter
```

> [!TIP]
> Untuk memulai dari kondisi bersih, hapus data lama dulu: `rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim`

### Update & Restore Plugin

```vim
:Lazy sync       " update semua plugin
:Lazy restore    " kembalikan ke versi di lazy-lock.json
```

### Menyesuaikan Config

| Yang ingin diubah | File | Yang diubah |
|---|---|---|
| Gaya komentar tema | `lua/plugins/colorscheme.lua` | Nilai `italic` di `overrides` |
| Jeda keymap | `lua/config/options.lua` | `o.timeoutlen` (default `1000` ms) |
| Formatter per bahasa | `lua/plugins/conform.lua` | Tabel `formatters_by_ft` |
| Timeout format on save | `lua/plugins/conform.lua` | `timeout_ms` (default `5000`) |
| Margin notifikasi | `lua/plugins/notify.lua` | Variabel `MARGIN` |
| Header & tombol dashboard | `lua/plugins/dashboard.lua` | Tabel `naka`, `studio`, dan `keys` |
| Highlight warna Tailwind | `lua/plugins/highlight-colors.lua` | `enable_tailwind = true` |
| Matcher completion | `lua/plugins/blink.lua` | `fuzzy.implementation` (default `"lua"`) |

### Menambah Language Server Baru

1. **Pasang servernya** lewat `pkg` atau `npm`, lalu cek binary-nya:

```bash
which nama-binary-server
```

2. **Buat file** `~/.config/nvim/lsp/nama_server.lua`:

```lua
return {
  cmd = { "nama-binary-server", "--stdio" },
  filetypes = { "filetype1", "filetype2" },
  root_markers = { "package.json", ".git" },
}
```

3. **Daftarkan** nama file tersebut di `lua/config/lsp.lua`:

```lua
vim.lsp.enable({
  "vtsls", "eslint", "html", "cssls", "emmet", "jsonls", "lua_ls",
  "nama_server", -- tambahkan di sini
})
```

4. **Restart Neovim**, buka file yang sesuai, lalu cek:

```vim
:checkhealth vim.lsp
```

---

## 5. Support

### Dukungan Bahasa

| Bahasa | Language Server | Format on Save |
|---|---|---|
| HTML | `html`, `emmet` | Prettier |
| CSS / SCSS / LESS | `cssls`, `emmet` | Prettier (CSS, SCSS) |
| JavaScript / TypeScript | `vtsls`, `eslint` | Prettier |
| React (JSX / TSX) | `vtsls`, `eslint`, `emmet` | Prettier |
| JSON / JSONC | `jsonls` | Prettier |
| Lua | `lua_ls` | Fallback ke LSP |

**Parser treesitter** yang dipasang: `html`, `css`, `javascript`, `typescript`, `tsx`, `json`, `lua`, `vim`, `vimdoc`, `query`, `markdown`, `markdown_inline`, `bash`, `regex`.

### Troubleshooting

| Masalah | Penyebab & Solusi |
|---|---|
| `<Space>ff` tidak muncul | Mengetik 3 tombol terlalu lambat. Naikkan `o.timeoutlen` di `options.lua`. |
| `<Space>` tidak jalan di file explorer | Di neo-tree, Space dipakai neo-tree. Pindah dulu ke window file. |
| Save terasa menahan 2 detik | `prettierd` perlu menyalakan Node saat memformat, dan HP lebih lambat. Itu normal. |
| Notif "ESLint belum terpasang di project" | Project belum punya ESLint. Pasang di project: `npm i -D eslint`. |
| Pertama kali dibuka lama atau ada error | Plugin dan parser sedang dipasang. Tunggu selesai lalu buka ulang. |
| Ikon berupa kotak kosong | Font belum Nerd Font. Lihat bagian [Font](#font). |

> [!WARNING]
> Config ini baru diuji di **Termux (Android)**. Di Linux atau macOS perintah instalasi paket bisa berbeda (misalnya `apt` atau `brew` pengganti `pkg`).

### Bantuan

Menemukan bug atau punya saran? Buka [Issues](https://github.com/Naka-studio/Nvim-Grounwork/issues) di repo ini.

---

## 6. Closing

Terima kasih sudah mampir dan mencoba config ini. Dibuat sepenuhnya dari HP, dari nol, dan terus disempurnakan sambil belajar. Kalau berguna, silakan **fork**, ubah sesuka hati, dan bagikan lagi.

Terima kasih juga kepada para pembuat plugin open source yang membuat semua ini mungkin.

**Lisensi:** Apache 2.0.

<p align="center">Dibuat dengan ☕ oleh <b>Naka Studio</b></p>