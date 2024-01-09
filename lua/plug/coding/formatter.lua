-- if i even want switch one
-- https://github.com/stevearc/conform.nvim

local M = {
  'elentok/format-on-save.nvim',
  event = 'VeryLazy',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
}

M.config = function()
  local format_on_save = require('format-on-save')
  local formatters = require('format-on-save.formatters')

  format_on_save.setup({
    exclude_path_patterns = {
      '/node_modules/',
      '.local/share/nvim/lazy',
    },
    formatter_by_ft = {
      rust = formatters.lsp,
      lua = formatters.lsp,
    }
  })
end

return M
