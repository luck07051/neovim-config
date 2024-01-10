-- [LazyVim/lua/lazyvim/plugins/extras/dap/core.lua at main · LazyVim/LazyVim](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua)

return {
  {
    'mfussenegger/nvim-dap',

    dependencies = {
      { 'theHamsta/nvim-dap-virtual-text', opts = {}, },
      'rcarriga/nvim-dap-ui',
      'jay-babu/mason-nvim-dap.nvim',
    },

    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dc', function() require('dap').continue() end,          desc = 'Continue' },
      { '<A-o>',      function() require('dap').step_over() end,         desc = 'Step Over' },
      { '<A-i>',      function() require('dap').step_into() end,         desc = 'Step Into' },
      { '<A-u>',      function() require('dap').step_out() end,          desc = 'Step Out' },
      { '<leader>ds', function() require('dap').session() end,           desc = 'Session' },
      { '<leader>dt', function() require('dap').terminate() end,         desc = 'Terminate' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end,  desc = 'Widgets' },
    },

    config = function()
      local dap = require('dap')

      -- Rust
      local function cargo_build(cmd)
        local lines = vim.fn.systemlist(cmd)
        local output = table.concat(lines, 'n')
        local filename = output:match('^.*"executable":"(.*)",.*n.*,"success":true}$')

        if filename == nil then
          return error('failed to build cargo project')
        end

        return filename
      end

      dap.configurations.rust = {
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
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    keys = {
      { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI' },
      { '<leader>de', function() require('dapui').eval() end,     desc = 'Eval',  mode = { 'n', 'v' } },
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      require('dap.ext.vscode').load_launchjs()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup(opts)

      -- automatically open / close window
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'codelldb', -- c / c++ / rust
      },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
  },
}
