return {
  'L3MON4D3/LuaSnip',
  event = { 'InsertEnter', 'CmdlineEnter' },
  keys = {
    { '<PageDown>', mode = { 'i', 's' }, function()
        require('luasnip').expand_or_jump()
    end },
    { '<PageUp>', mode = { 'i', 's' }, function()
        require('luasnip').jump(-1)
    end },
    { '<End>', mode = { 'i', 's' }, function()
      if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
      end
    end },
  },

  config = function()
    local ls = require('luasnip')
    local types = require('luasnip.util.types')
    local ft_fn = require('luasnip.extras.filetype_functions')

    ls.setup({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      delete_check_events = 'TextChanged',
      enable_autosnippets = true,
      store_selection_keys = '<Tab>',
      ft_func = ft_fn.from_pos_or_filetype,

      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'MatchParen' } },
          },
        },
      },
    })

    require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets/' })
  end
}
