return {
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>',  mode = 'n', desc = 'Enhanced <C-a>' },
      { '<C-x>',  mode = 'n', desc = 'Enhanced <C-x>' },
      { '<C-a>',  mode = 'v', desc = 'Enhanced <C-a>' },
      { '<C-x>',  mode = 'v', desc = 'Enhanced <C-x>' },
      { 'g<C-a>', mode = 'v', desc = 'Enhanced g<C-a>' },
      { 'g<C-x>', mode = 'v', desc = 'Enhanced g<C-x>' },
    },

    config = function()
      local augend = require("dial.augend")
      require('dial.config').augends:register_group{
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
        },
      }

      vim.keymap.set('n', '<C-a>', require('dial.map').inc_normal() )
      vim.keymap.set('n', '<C-x>', require('dial.map').dec_normal() )
      vim.keymap.set('v', '<C-a>', require('dial.map').inc_visual() )
      vim.keymap.set('v', '<C-x>', require('dial.map').dec_visual() )
      vim.keymap.set('v', 'g<C-a>', require('dial.map').inc_gvisual() )
      vim.keymap.set('v', 'g<C-x>', require('dial.map').dec_gvisual() )
    end,
  },

  {
    'stsewd/gx-extended.vim',
    keys = {
      { 'gx', desc = 'Enhanced gx' },
    },
  },

  {
    'karb94/neoscroll.nvim',
    opts = {
      mappings = {},
    },
    keys = {
      { '<C-u>', function() require('neoscroll').scroll(-vim.wo.scroll, true, 150) end, desc = 'Neoscroll <C-u>' },
      { '<C-d>', function() require('neoscroll').scroll( vim.wo.scroll, true, 150) end, desc = 'Neoscroll <C-d>' },
      { '<C-b>', function() require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 250) end, desc = 'Neoscroll <C-b>' },
      { '<C-f>', function() require('neoscroll').scroll( vim.api.nvim_win_get_height(0), true, 250) end, desc = 'Neoscroll <C-f>' },
      { '<C-y>', function() require('neoscroll').scroll(-0.10, false, 50) end, desc = 'Neoscroll <C-y>' },
      { '<C-e>', function() require('neoscroll').scroll( 0.10, false, 50) end, desc = 'Neoscroll <C-e>' },
      { 'zt',    function() require('neoscroll').zt(100) end, desc = 'Neoscroll zt' },
      { 'zz',    function() require('neoscroll').zz(100) end, desc = 'Neoscroll zz' },
      { 'zb',    function() require('neoscroll').zb(100) end, desc = 'Neoscroll zb' },

      { '<PageUp>',   function() require('neoscroll').scroll(-vim.wo.scroll, true, 150) end, desc = 'Neoscroll <C-u>' },
      { '<PageDown>', function() require('neoscroll').scroll( vim.wo.scroll, true, 150) end, desc = 'Neoscroll <C-d>' },
    }
  },

  { -- Enhanced matchparen
    "utilyre/sentiment.nvim",
    event = "VeryLazy",
    opts = { },
  }
}
