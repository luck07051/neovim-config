local M = {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'onsails/lspkind.nvim',

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    'hrsh7th/cmp-nvim-lua',
    'kdheepak/cmp-latex-symbols',

    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
  },
}

M.config = function()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  cmp.setup {
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-y>'] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }, { 'i', 'c' }),
      ['<C-x>'] = cmp.mapping.close(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),

      -- ['<Tab>'] = cmp.mapping.select_next_item(),
      -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },

    sources = {
      -- { name = 'neorg' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lua' },

      { name = 'latex_symbols' },
      { name = 'luasnip' },

      { name = 'treesitter' },
      { name = 'buffer' },
      { name = 'path' },
    },

    preselect = cmp.PreselectMode.None,

    completion = {
      -- autocomplete = false
      -- keyword_length = 2
    },

    window = {
      completion = {
        col_offset = -2,
        side_padding = 1,
      },
      documentation = {
        border = { ' ' },
      },
    },

    formatting = {
      fields = { 'kind', 'abbr' },
      format = function(entry, vim_item)
        if vim.tbl_contains({ 'path' }, entry.source.name) then
          local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
      end
    },

    snippet = {
      expand = function(args)
        -- For luasnip --
        luasnip.lsp_expand(args.body)
      end,
    },
  }


  -- ':' mode
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),

    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' }
    }),

    formatting = {
      fields = { 'abbr' },
    },
  })

  -- '/' mode
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),

    sources = {
      { name = 'buffer' }
    },

    formatting = {
      fields = { 'abbr' },
    }
  })

  -- Close cmp menu when press <C-f> --
  vim.keymap.set('c', '<C-f>', '<C-f>a<Esc>', { desc = 'Close cmp menu' } )
end

return M
