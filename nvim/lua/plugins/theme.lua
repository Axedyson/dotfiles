-- the colorscheme should be available when starting Neovim
return {
  "loctvl842/monokai-pro.nvim",
  version = "v2.1.1",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    require("monokai-pro").setup({
      filter = "classic",
      transparent_background = true
    })
    vim.cmd.colorscheme "monokai-pro"
  end,
}
