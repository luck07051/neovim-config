return {
  'lukas-reineke/headlines.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = {
    'markdown',
  },
  opts = {
    markdown = {
      headline_highlights = { 'Headline' },
      codeblock_highlight = 'CodeBlock',
      dash_highlight = 'Dash',
      dash_string = '━',
      quote_highlight = 'Quote',
      quote_string = '┃',
      fat_headlines = false,
    }
  },
}
