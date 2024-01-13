return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPost',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/playground',
  },

  keys = {
    { '<Leader>hi', function() vim.print(vim.treesitter.get_captures_at_cursor(0)) end, desc = 'Print treesitter structure' },
  },

  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = 'all',
    ignore_install = { '' },

    highlight = {
      enable = true,
      disable = { 'help' },
    },

    indent = {
      enable = true,
      disable = { 'yaml' }
    },

    playground = {
      enable = true,
    },

    query_linter = {
      enable = true,
      -- use_virtual_text = true,
      -- lint_events = { 'BufWrite', 'CursorHold' },
    },
  },
}
