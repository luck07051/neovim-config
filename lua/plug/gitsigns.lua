local M = {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
}

M.opts = {
  signs = {
    add          = { text = '▎' },
    change       = { text = '▎' },
    delete       = { text = '契' },
    topdelete    = { text = '契' },
    changedelete = { text = '▎' },
  },
}

return M
