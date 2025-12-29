return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>",          desc = "Show Neogit UI" },
    { "<leader>gt", "<cmd>Neogit kind=tab<cr>", desc = "Show Neogit UI in a new tab" }
  },
  config = function()
    local actions = require("diffview.actions")

    -- Instead of g<C-x> we will just set it to <C-x>, so much easier
    require("diffview").setup {
      keymaps = {
        view = {
          { "n", "<C-x>", actions.cycle_layout, { desc = "Cycle through available layouts." }},
        }
      }
    }

    require('neogit').setup {
      disable_hint = true,
      kind = "replace"
    }
  end,
}
