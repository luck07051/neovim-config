local M = {
  'nvim-treesitter/nvim-treesitter',
  event = "BufReadPost",
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/playground',
  },
}

M.keys = {
  { '<Leader>tp', '<cmd>TSPlaygroundToggle<cr>',   desc = 'View treesitter information' },
  -- { '<Leader>ts', '<cmd>TSCaptureUnderCursor<cr>', desc = 'View treesitter under the cursor' },
  { '<Leader>hi', function() vim.print(vim.treesitter.get_captures_at_cursor(0)) end, desc = 'Print treesitter structure' },


}

M.config = function()
  local treesitter = require "nvim-treesitter.configs"

  treesitter.setup {
    ensure_installed = 'all',
    ignore_install = { '' },

    highlight = {
      enable = true,
      disable = { "help" },
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
      -- lint_events = { "BufWrite", "CursorHold" },
    },
  }
end

return M
