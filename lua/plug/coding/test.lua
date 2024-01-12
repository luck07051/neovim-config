return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    'rouge8/neotest-rust', -- $ cargo install cargo-nextest
  },

  keys = {
    { '<Leader>tt', function() require("neotest").run.run() end,                   desc = 'Run the nearest test' },
    { '<Leader>tT', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = 'Run current file\'s test' },
    -- { '<Leader>td', function() require("neotest").run.run({ strategy = "dap" }) end, desc = '' },
    { '<Leader>to', function() require("neotest").output.open() end,               desc = 'Open test output window' },
    { '<Leader>ts', function() require("neotest").summary.toggle() end,            desc = 'Toggle test summary' },
  },

  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust"),
      },
    })
  end,
}
