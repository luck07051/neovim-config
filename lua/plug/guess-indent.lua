return {
  'nmac427/guess-indent.nvim',
  event = 'BufReadPost',
  keys = {
    { '<Leader>ind', function() require("guess-indent").set_from_buffer(true) end, desc = 'Reset indent' },
  },
  config = true
}
