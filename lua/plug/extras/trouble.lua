return {
  'folke/trouble.nvim',
  cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    use_diagnostic_signs = true,
  },

  keys = {
    { "<leader>xx", function() require("trouble").toggle() end,                        desc = 'Toggle the trouble list' },
    { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = 'trouble list for workspace diagnostics' },
    { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = 'trouble list for document diagnostics' },
    { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = 'trouble list for quickfix' },
    { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = 'trouble list for loclist' },
    { "gR",         function() require("trouble").toggle("lsp_references") end,        desc = 'trouble list for lsp references' },
  },
}
