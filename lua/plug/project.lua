return {
  'ahmedkhalf/project.nvim',
  -- enabled = false,
  event = 'BufReadPre',
  config = function()
    require('project_nvim').setup()
  end,
}
