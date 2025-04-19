return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    {"folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        }
      }
    }
  },
  -- Define servers here
  opts = {
    servers = {
      lua_ls = {},
      ts_ls = {}
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
    -- delete the following settings when the neovim version is sufficient
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        local buffer_opts = { buffer = buf }
        vim.keymap.set('n', 'grr', vim.lsp.buf.references, buffer_opts)
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename, buffer_opts)
        vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, buffer_opts)
      end
    })
  end
}
