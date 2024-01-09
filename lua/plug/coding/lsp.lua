local M = {
  'neovim/nvim-lspconfig',
  name = 'lsp',
  event = 'BufReadPre',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
}

M.config = function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer" },
    automatic_installation = true,
  })

  -- Capabilities
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  local capabilities = has_cmp and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,

    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                'vim',
                -- Luasnip env
                'ls', 's', 'sn', 'isn', 't', 'i', 'f', 'c', 'd', 'r',
                'events', 'ai', 'extras', 'l', 'rep', 'p', 'm', 'n', 'dl',
                'fmt', 'fmta', 'conds', 'postfix', 'types', 'parse', 'ms', 'k',
              },
            },
          },
        }
      })
    end,

    ["rust_analyzer"] = function()
      require("lspconfig").rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        }
      })
    end,

    ["pylsp"] = function()
      require("lspconfig").pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              flake8 = { enabled = true, },
              pycodestyle = { enabled = false, },
              pyflakes = { enabled = false, },
            },
          }
        }
      })
    end,
  }

  -- Icon define
  local function set_sign(name, text)
    vim.fn.sign_define('DiagnosticSign' .. name, { texthl = 'DiagnosticSign' .. name, text = text, numhl = '' })
  end
  set_sign('Error', '')
  set_sign('Warn', '')
  set_sign('Hint', '')
  set_sign('Info', '')

  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  })

  vim.lsp.handlers['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded', })
end

return M
