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
    ["core.defaults"] = {},

    ["core.concealer"] = {},

    ["core.keybinds"] = {
      config = {
        hook = function(keybinds)
          -- Continue Object in Normal mode
          keybinds.map("norg", "n", "<A-o>", "<cmd>Neorg keybind norg core.itero.next-iteration<cr>a")
        end
      },
    },

    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
      },
      default_workspace = "notes",
    },

    ["core.summary"] = {},
  },

}

return M
