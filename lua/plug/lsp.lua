local M = {
  'neovim/nvim-lspconfig',
  name = 'lsp',
  event = 'BufReadPre',
  dependencies = {
    { 'folke/neodev.nvim', opts = {} },
  },
}

M.config = function()
  local lspconfig = require 'lspconfig'


  local server_settings = {
    lua_ls = { --{{{
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {
            -- Get the language server to recognize the `vim` global
            'vim',
            -- Luasnip env
            'ls', 's', 'sn', 'isn', 't', 'i', 'f', 'c', 'd', 'r',
            'events', 'ai', 'extras', 'l', 'rep', 'p', 'm', 'n', 'dl',
            'fmt', 'fmta', 'conds', 'postfix', 'types', 'parse', 'ms', 'k',
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
          -- Stop asking about working environment on every startup
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }, --}}}
    pylsp = {
      pylsp = {
        plugins = {
          flake8 = { enabled = true, },
          pycodestyle = { enabled = false, },
          pyflakes = { enabled = false, },
        },
      }
    },
    bashls = { },
  }


  -- Icon define
  local function set_sign(name, text)
    vim.fn.sign_define('DiagnosticSign'..name, { texthl = 'DiagnosticSign'..name, text = text, numhl = '' })
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


  local on_attach = function(client, bufnr)
    -- vim.keymap.set('n', '<space>gd', vim.diagnostic.setloclist, { desc = '' } )
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition,           { desc = '' } )
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,          { desc = '' } )
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,       { desc = '' } )
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references,           { desc = '' } )

    -- Show help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,                  { desc = 'Displays hover information' } )
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.signature_help, { desc = 'Displays signature information' } )

    -- Root dir
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder,    { desc = 'Add the folder at path to the workspace folders' } )
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove the folder at path from the workspace folders' } )
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = 'Print out workspace folders' } )
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { desc = 'Renames all references to the symbol under the cursor' } )

    -- Formatting
    vim.keymap.set('n', '<Leader>=', vim.lsp.buf.format, { desc = 'Formats a buffer using the language server clients' } )


    -- Statusline plugin that shows current code context
    local has_navic, navic = pcall(require, 'nvim-navic')
    if has_navic then
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

  end

  -- Capabilities
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  local capabilities
  if has_cmp then
    capabilities = cmp_lsp.default_capabilities()
  else
    capabilities = vim.lsp.protocol.make_client_capabilities()
  end

  -- local language_servers = require('lspconfig').util.available_servers()
  for server, settings in pairs(server_settings) do
    lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings,
    }
  end

end

return M
