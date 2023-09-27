return {
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Line comment' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Block comment' },
    },
    config = true,
  },

  {
    "kylechui/nvim-surround",
    keys = {
      { 'cs', desc = 'Change the surround' },
      { 'ds', desc = 'Delete the surround' },
      { 'ys', desc = 'Add the surround' },
    },
    config = true
  }
}
