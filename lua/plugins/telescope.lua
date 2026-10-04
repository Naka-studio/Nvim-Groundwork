-- Telescope (config punya Kaka)
return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Cari file" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Grep isi project" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffer terbuka" },
      { "<leader>fr", function() require("telescope.builtin").oldfiles() end,   desc = "File terakhir" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Cari help" },
    },
    config = function()
      local telescope = require("telescope")
      local actions_layout = require("telescope.actions.layout")

      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            flex = { flip_columns = 120 },
            horizontal = {
              width = 0.95,
              height = 0.95,
              prompt_position = "top",
              preview_width = 0.55,
              preview_cutoff = 1,
            },
            vertical = {
              width = 0.95,
              height = 0.95,
              prompt_position = "top",
              mirror = true,
              preview_height = 0.5,
              preview_cutoff = 1,
            },
          },
          file_ignore_patterns = { "^%.git/", "node_modules/" },
          mappings = {
            i = { ["<C-p>"] = actions_layout.toggle_preview },
            n = { ["<C-p>"] = actions_layout.toggle_preview },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      })

      telescope.load_extension("ui-select")
    end,
  },
}
