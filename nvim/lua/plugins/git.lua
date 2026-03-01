return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "esmuellert/codediff.nvim",
      opts = {
        explorer = {
          view_mode = "tree",
          position = "bottom",
          initial_focus = "modified"
        },
        keymaps = {
          view = {
            show_help = "?",
            next_file = "<tab>" ,
            prev_file = "<s-tab>"
          }
        }
      }
    },
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>",          desc = "Show Neogit UI" },
    { "<leader>gt", "<cmd>Neogit kind=tab<cr>", desc = "Show Neogit UI in a new tab" }
  },
  config = function()
    require('neogit').setup {
      disable_hint = true,
      kind = "replace"
    }
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffOpen",
      callback = function()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          vim.wo[win].cursorline = false
        end
      end,
    })
  end,
}
