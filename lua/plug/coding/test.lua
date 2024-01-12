return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    'rouge8/neotest-rust', -- $ cargo install cargo-nextest
  },

  keys = {
    { '<Leader>tt', function() require("neotest").run.run() end,                   desc = '' },
    { '<Leader>tT', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = '' },
    -- { '<Leader>td', function() require("neotest").run.run({ strategy = "dap" }) end, desc = '' },
    { '<Leader>to', function() require("neotest").output.open() end,               desc = '' },
    { '<Leader>ts', function() require("neotest").summary.toggle() end,            desc = '' },
  },

  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust"),
      },
    })
  end,
}
