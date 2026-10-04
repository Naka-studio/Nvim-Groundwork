-- Notifikasi: nvim-notify (rounded + teks ngewrap + margin kanan)
local MARGIN = 2 -- jarak box ke tepi kanan jendela (kolom)

-- Bungkus stage bawaan: geser `col` ke kiri sebesar MARGIN
local function with_margin(stages)
  local out = {}
  for i, stage in ipairs(stages) do
    out[i] = function(...)
      local r = stage(...)
      if r and r.col then
        if type(r.col) == "table" then
          r.col[1] = r.col[1] - MARGIN
        else
          r.col = r.col - MARGIN
        end
      end
      return r
    end
  end
  return out
end

-- Potong teks per karakter, tiap potongan maksimal `width` karakter
local function split_chars(line, width)
  local parts, i, len = {}, 0, vim.fn.strchars(line)
  while i < len do
    parts[#parts + 1] = vim.fn.strcharpart(line, i, width)
    i = i + width
  end
  return parts
end

-- Renderer: salinan wrapped-default, tapi baris jadi PAS max_width
-- (potong di max_width - 2, karena tiap baris ditambah 1 spasi kiri + kanan)
local function render(bufnr, notif, hl, config)
  local ns = require("notify.render.base").namespace()
  local icon = notif.icon .. " "
  local title = notif.title[1] or "Notify"

  local w = config.max_width and config.max_width() or math.floor(vim.o.columns * 0.3)
  w = math.max(10, math.min(w, vim.o.columns - 1))

  local message = {}
  for _, line in ipairs(notif.message) do
    for _, part in ipairs(split_chars(line, w - 2)) do
      message[#message + 1] = " " .. vim.trim(part) .. " "
    end
  end

  local prefix = string.format(" %s %s", icon, title)
  table.insert(message, 1, prefix)
  table.insert(message, 2, string.rep("━", w))
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, message)

  vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, {
    virt_text = { { " " }, { icon, hl.icon }, { title, hl.title }, { " " } },
    virt_text_win_col = 0,
    priority = 10,
  })
  vim.api.nvim_buf_set_extmark(bufnr, ns, 1, 0, {
    virt_text = { { string.rep("━", w), hl.border } },
    virt_text_win_col = 0,
    priority = 10,
  })
  vim.api.nvim_buf_set_extmark(bufnr, ns, 2, 0, {
    hl_group = hl.body,
    end_line = #message,
    end_col = 0,
    priority = 50,
  })
end

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    render = render,
    max_width = function() return math.floor(vim.o.columns * 0.5) end,
    timeout = 3000,
    background_colour = "#0b0e14", -- ayu dark
  },
  config = function(_, opts)
    local direction = require("notify.stages.util").DIRECTION.TOP_DOWN
    opts.stages = with_margin(require("notify.stages.fade_in_slide_out")(direction))
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify -- semua vim.notify() lewat sini
  end,
}
