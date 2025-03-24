return {
  'stevearc/oil.nvim',
  config = function()
    require("oil").setup {
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        -- Don't show parent directory nor the .git directory
        return name == ".." or name == ".git"
      end
    },
    }
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
