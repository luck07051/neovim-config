return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  keys = {
    { '<leader>nf', function() require('neogen').generate() end, desc = 'Create annotations' },
  },
  opts = {},
}
