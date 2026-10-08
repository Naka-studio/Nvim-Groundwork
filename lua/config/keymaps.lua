-- Keymap global
local map = vim.keymap.set


-- LSP (cuma aktif di buffer yg punya LSP)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local function lsp(mode, keys, fn, desc)
      vim.keymap.set(mode, keys, fn, { buffer = ev.buf, desc = desc, nowait = true })
    end
    lsp("n", "gd", vim.lsp.buf.definition, "Go to definition")
    lsp("n", "gr", vim.lsp.buf.references, "References")
    lsp("n", "K", vim.lsp.buf.hover, "Hover docs")
    lsp("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    lsp({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    lsp("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
    -- Inlay hints sengaja gk diaktifin (ganggu)
  end,
})

-- Root project: root LSP, lalu .git/lua, terakhir cwd (versi sederhana LazyVim)
local function root()
  local buf = vim.api.nvim_get_current_buf()
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    if c.root_dir then return c.root_dir end
  end
  return vim.fs.root(buf, { ".git", "lua" }) or vim.uv.cwd()
end
local function cwd() return vim.uv.cwd() end

-- Explorer (neo-tree)
local function explorer(dir_fn)
  return function()
    require("neo-tree.command").execute({ toggle = true, dir = dir_fn() })
  end
end
map("n", "<leader>e", explorer(root), { desc = "Explorer (root dir)" })
map("n", "<leader>fe", explorer(root), { desc = "Explorer (root dir)" })
map("n", "<leader>E", explorer(cwd), { desc = "Explorer (cwd)" })
map("n", "<leader>fE", explorer(cwd), { desc = "Explorer (cwd)" })

-- Find & search (telescope)
local function tb(name, dir_fn, opts)
  return function()
    local o = vim.tbl_extend("force", opts or {}, dir_fn and { cwd = dir_fn() } or {})
    require("telescope.builtin")[name](o)
  end
end
map("n", "<leader><space>", tb("find_files", root), { desc = "Find files (root dir)" })
map("n", "<leader>ff", tb("find_files", root), { desc = "Find files (root dir)" })
map("n", "<leader>fF", tb("find_files", cwd), { desc = "Find files (cwd)" })
map("n", "<leader>fg", tb("git_files"), { desc = "Find files (git-files)" })
map("n", "<leader>fr", tb("oldfiles"), { desc = "Recent" })
map("n", "<leader>fb", tb("buffers"), { desc = "Buffers" })
map("n", "<leader>,", tb("buffers"), { desc = "Buffers" })
map("n", "<leader>fc", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find config file" })
map("n", "<leader>fh", tb("help_tags"), { desc = "Help tags" })
map("n", "<leader>/", tb("live_grep", root), { desc = "Grep (root dir)" })
map("n", "<leader>sg", tb("live_grep", root), { desc = "Grep (root dir)" })
map("n", "<leader>sG", tb("live_grep", cwd), { desc = "Grep (cwd)" })
map("n", "<leader>sk", tb("keymaps"), { desc = "Keymaps" })
map("n", "<leader>sd", tb("diagnostics"), { desc = "Diagnostics" })
map("n", "<leader>sD", tb("diagnostics", nil, { bufnr = 0 }), { desc = "Buffer diagnostics" })
map("n", "<leader>:", tb("command_history"), { desc = "Command history" })

-- Format (conform)
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
map({ "n", "x" }, "<leader>cF", function()
  require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })

-- which-key
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Keymaps (which-key)" })

-- Git: Lazygit (snacks)
map("n", "<leader>gg", function() Snacks.lazygit({ cwd = root() }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
map("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = root() }) end, { desc = "Lazygit Log" })
map("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })

-- Git: hunks (gitsigns)
local function gs() return require("gitsigns") end
map("n", "]h", function()
  if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs().nav_hunk("next") end
end, { desc = "Next Hunk" })
map("n", "[h", function()
  if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs().nav_hunk("prev") end
end, { desc = "Prev Hunk" })
map("n", "]H", function() gs().nav_hunk("last") end, { desc = "Last Hunk" })
map("n", "[H", function() gs().nav_hunk("first") end, { desc = "First Hunk" })
map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
map("n", "<leader>ghS", function() gs().stage_buffer() end, { desc = "Stage Buffer" })
map("n", "<leader>ghu", function() gs().undo_stage_hunk() end, { desc = "Undo Stage Hunk" })
map("n", "<leader>ghR", function() gs().reset_buffer() end, { desc = "Reset Buffer" })
map("n", "<leader>ghp", function() gs().preview_hunk_inline() end, { desc = "Preview Hunk Inline" })
map("n", "<leader>ghb", function() gs().blame_line({ full = true }) end, { desc = "Blame Line" })
map("n", "<leader>ghB", function() gs().blame() end, { desc = "Blame Buffer" })
map("n", "<leader>ghd", function() gs().diffthis() end, { desc = "Diff This" })
map("n", "<leader>ghD", function() gs().diffthis("~") end, { desc = "Diff This ~" })
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Pindah antar window
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Buffer (bufferline)
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
map("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Delete Buffers to the Left" })

-- Esc: clear highlight search + stop snippet
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  if vim.snippet.active() then vim.snippet.stop() end
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
map("n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>",
  { desc = "Redraw / Clear hlsearch / Diff Update" })

-- Search result: n selalu maju, N selalu mundur
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Simpan file, indent tanpa kehilangan seleksi, undo breakpoint
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("v", "<", "<gv")
map("v", ">", ">gv")
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Komentar di bawah/atas baris
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Window & tab
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Toggle UI (snacks)
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", {
  off = 0,
  on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
  name = "Conceal Level",
}):map("<leader>uc")
Snacks.toggle.option("showtabline", {
  off = 0,
  on = vim.o.showtabline > 0 and vim.o.showtabline or 2,
  name = "Tabline",
}):map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle({
  name = "Git Signs",
  get = function() return require("gitsigns.config").config.signcolumn end,
  set = function(state) require("gitsigns").toggle_signs(state) end,
}):map("<leader>uG")
-- Modul yg belum lu aktifin: dibungkus pcall biar gk bikin error saat startup
for key, name in pairs({
  ["<leader>ua"] = "animate",
  ["<leader>uS"] = "scroll",
  ["<leader>uz"] = "zen",
  ["<leader>uZ"] = "zoom",
  ["<leader>wm"] = "zoom",
}) do
  pcall(function() Snacks.toggle[name]():map(key) end)
end

-- UI lainnya
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })
map("n", "<leader>un", function()
  require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss All Notifications" })
map("n", "<leader>uC", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Colorscheme with Preview" })

-- Diagnostic: lompat antar error/warning
local function diagnostic_goto(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Quickfix & location list
map("n", "<leader>xl", function()
  local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Location List" })
map("n", "<leader>xq", function()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Misc
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = root() }) end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })

-- Search (telescope)
map("n", '<leader>s"', tb("registers"), { desc = "Registers" })
map("n", "<leader>s/", tb("search_history"), { desc = "Search History" })
map("n", "<leader>sa", tb("autocommands"), { desc = "Auto Commands" })
map("n", "<leader>sb", tb("current_buffer_fuzzy_find"), { desc = "Buffer Lines" })
map("n", "<leader>sB", tb("live_grep", nil, { grep_open_files = true }), { desc = "Grep Open Buffers" })
map("n", "<leader>sc", tb("command_history"), { desc = "Command History" })
map("n", "<leader>sC", tb("commands"), { desc = "Commands" })
map("n", "<leader>sh", tb("help_tags"), { desc = "Help Pages" })
map("n", "<leader>sH", tb("highlights"), { desc = "Highlights" })
map("n", "<leader>sj", tb("jumplist"), { desc = "Jumps" })
map("n", "<leader>sl", tb("loclist"), { desc = "Location List" })
map("n", "<leader>sm", tb("marks"), { desc = "Marks" })
map("n", "<leader>sM", tb("man_pages"), { desc = "Man Pages" })
map("n", "<leader>so", tb("vim_options"), { desc = "Options" })
map("n", "<leader>sq", tb("quickfix"), { desc = "Quickfix List" })
map("n", "<leader>sR", tb("resume"), { desc = "Resume" })
map("n", "<leader>ss", tb("lsp_document_symbols"), { desc = "LSP Symbols" })
map("n", "<leader>sS", tb("lsp_dynamic_workspace_symbols"), { desc = "LSP Workspace Symbols" })
map("n", "<leader>sw", tb("grep_string", root), { desc = "Word (root dir)" })
map("n", "<leader>sW", tb("grep_string", cwd), { desc = "Word (cwd)" })

-- Git (picker & snacks)
map("n", "<leader>gs", tb("git_status"), { desc = "Git Status" })
map("n", "<leader>gS", tb("git_stash"), { desc = "Git Stash" })
map("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })
