--[[
Usage: Whenever you need to edit/work with a new language, e.g. a new programming language or text format, do the following:
  - Install the right language for treesitter like this :TSInstall some_language
  - Then you want to install the right lsp for that language on your computer :h lspconfig-all
  - Then define the new lsp like this in this file (init.lua): vim.lsp.enable('some_new_lsp')
  - Optionally define a dedicated language file in after/ftplugin/some_language.lua
    * Example: https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/after/ftplugin/lua.lua
--]]
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "number"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.laststatus = 0
vim.opt.backupcopy = "yes"
vim.opt.wrap = false
vim.opt.ruler = false
vim.opt.relativenumber = true
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.guicursor = ""
vim.opt.fillchars = { eob = " " }
vim.keymap.set({ "n", "i" }, "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-w>q", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-q>", "<cmd>cprev<CR>")
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {}),
  callback = function() vim.highlight.on_yank() end
})
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "monokai-pro" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false }
})
vim.diagnostic.config({ virtual_text = false })
vim.keymap.set('n', '<leader>e', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diagnostics > 0 then
    vim.diagnostic.open_float({ scope = "line" })
  else
    print("No diagnostics found on this line")
  end
end, { desc = "Show LSP diagnostics for current line" })
vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('basedpyright')
vim.lsp.enable('sourcekit')
-- delete the following settings when the neovim version is sufficient
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP Actions",
  callback = function(args)
    local buf = args.buf
    local buffer_opts = { buffer = buf }
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, buffer_opts)
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, buffer_opts)
    vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, buffer_opts)
  end
})
