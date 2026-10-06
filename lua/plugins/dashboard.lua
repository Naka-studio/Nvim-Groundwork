-- Dashboard: snacks.nvim (cuma modul dashboard yg aktif)
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false, -- dashboard harus siap saat nvim kebuka
  opts = function()
    local function ic(code) return vim.fn.nr2char(code) .. " " end

    -- Header: NAKA + STUDIO
    local pad = "" -- snacks sudah center tiap baris
    local naka = {
      "███╗   ██╗ █████╗ ██╗  ██╗ █████╗ ",
      "████╗  ██║██╔══██╗██║ ██╔╝██╔══██╗",
      "██╔██╗ ██║███████║█████╔╝ ███████║",
      "██║╚██╗██║██╔══██║██╔═██╗ ██╔══██║",
      "██║ ╚████║██║  ██║██║  ██╗██║  ██║",
      "╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝",
    }
    local studio = {
      "███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗ ",
      "██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║██╔═══██╗",
      "███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║",
      "╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║",
      "███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝",
      "╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝ ",
    }
    local lines = {}
    for _, l in ipairs(naka) do lines[#lines + 1] = pad .. l end
    lines[#lines + 1] = ""
    vim.list_extend(lines, studio)

    return {
      indent = { enabled = true }, -- garis indent + scope (snacks)
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat(lines, "\n"),
          keys = {
            { icon = ic(0xf002), key = "f", desc = "Find file",    action = ":Telescope find_files" },
            { icon = ic(0xf0f6), key = "n", desc = "New file",     action = ":ene | startinsert" },
            { icon = ic(0xf0e7), key = "g", desc = "Grep text",    action = ":Telescope live_grep" },
            { icon = ic(0xf1da), key = "r", desc = "Recent files", action = ":Telescope oldfiles" },
            {
              icon = ic(0xf013),
              key = "c",
              desc = "Config",
              action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })",
            },
            { icon = ic(0xf0ae), key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = ic(0xf011), key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" }, -- waktu startup (lazy.nvim)
        },
      },
    }
  end,
}
