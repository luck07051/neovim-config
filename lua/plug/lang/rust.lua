local function cargo_build(cmd)
  local lines = vim.fn.systemlist(cmd)
  local output = table.concat(lines, 'n')
  local filename = output:match('^.*"executable":"(.*)",.*n.*,"success":true}$')

  if filename == nil then
    return error('failed to build cargo project')
  end

  return filename
end

return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'rust-analyzer', 'codelldb' })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        -- Ensure mason installs the server
        rust_analyzer = {
          keys = {
            { 'K',          '<cmd>RustHoverActions<cr>', desc = 'Hover Actions (Rust)' },
            { '<leader>cR', '<cmd>RustCodeAction<cr>',   desc = 'Code Action (Rust)' },
            { '<leader>dr', '<cmd>RustDebuggables<cr>',  desc = 'Run Debuggables (Rust)' },
          },
          settings = {
            ['rust_analyzer'] = {
              settings = {
                ['rust-analyzer'] = {
                  checkOnSave = {
                    command = 'clippy',
                  },
                },
              }
            },
          },
        },
      },
    }
  },

  {
    'mfussenegger/nvim-dap',
    opts = {
      configurations = {
        rust = {
          {
            name = 'Debug Test',
            type = 'codelldb',
            request = 'launch',
            program = function()
              return cargo_build('cargo build --tests -q --message-format=json')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            showDisassembly = 'never'
          },
          {
            name = 'Debug Bin',
            type = 'codelldb',
            request = 'launch',
            program = function()
              return cargo_build('cargo build -q --message-format=json')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            showDisassembly = 'never'
          }
        }
      },
    },
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'rouge8/neotest-rust', -- $ cargo install cargo-nextest
    },
    opts = function(_, opts)
      -- vim.list_extend(opts.adapters, require('neotest-rust'))
      opts.adapters = {
        require('neotest-rust'),
      }
    end
  },
}
