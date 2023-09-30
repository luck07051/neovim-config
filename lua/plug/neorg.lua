local M = {
  "nvim-neorg/neorg",
  cmd = { 'Neorg' },
  event = "BufReadPre,BufNew *.norg",
  build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
}

M.opts = {
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
      },
      default_workspace = "notes",
    },
  },

}

return M
