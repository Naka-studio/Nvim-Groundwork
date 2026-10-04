-- Preview warna di buffer (CSS, JS, dll)
return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy",
  opts = {
    render = "virtual",     -- kotak warna kecil di samping kode warna
    virtual_symbol = "■",
    enable_tailwind = false, -- nyalain kalau nanti pakai Tailwind
  },
}
