vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.laststatus = 3    -- global statusline
vim.opt.cmdheight = 0

-- Some shortmess work with cmdheight=0
vim.opt.shortmess:append('c')
vim.opt.shortmess:append('C')
vim.opt.shortmess:append('s')
vim.opt.shortmess:append('S')
vim.opt.shortmess:remove('t')

local hi = function(group)
  return '%#'..group..'#'
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == '' then
    return ''
  end
  local added = git_info.added == 0 and '' or (' +' .. git_info.added)
  local changed = git_info.changed == 0 and '' or (' ~' .. git_info.changed)
  local removed = git_info.removed == 0 and '' or (' -' .. git_info.removed)
  return table.concat {
    -- hi('GitSignsAdd'),
    '  '..git_info.head,
    -- hi('GitSignsAdd'),
    added,
    -- hi('GitSignsChange'),
    changed,
    -- hi('GitSignsDelete'),
    removed,
    -- hi('StatusLine'),
  }
end

local diagnostic = function(format, severity)
  local count = #(vim.diagnostic.get(0, { severity = severity }))
  return count == 0 and '' or string.format(format, count)
end

local diagnostics = function()
  return table.concat {
    -- hi('DiagnosticError'),
    diagnostic(' %s', 'Error'),
    -- hi('DiagnosticWarn'),
    diagnostic(' %s', 'Warn'),
    -- hi('DiagnosticInfo'),
    diagnostic(' %s', 'Info'),
    -- hi('DiagnosticHint'),
    diagnostic(' %s', 'Hint'),
    -- hi('StatusLine'),
  }
end

local macro_recoding = function()
  if vim.fn.reg_recording() == '' then
    return ''
  end
  return '  @' .. vim.fn.reg_recording()
end

local search_count = function()
  if vim.v.hlsearch ~= 1 then
    return ''
  end

  local ok, searchcount = pcall(vim.fn.searchcount)
  if not ok and searchcount['total'] == 0 then
    return ''
  end

  return '  ' .. searchcount['current'] .. '∕' .. searchcount['total']
end


function statusline()
  return table.concat({
    '  %t %h%m%r%w',  -- Flie info
    vcs(),
    diagnostics(),

    '%=',  -- Separation

    hi('MatchParen'),
    macro_recoding(),
    search_count(),
    hi('StatusLine'),
    '  %{&filetype}',  -- Flietype
    '  %{&expandtab?"󱁐 ":"󰌒 "}%{&tabstop}',  -- Indent info
    '  %L',  -- Line info
    '  ',
  })
end

vim.opt.statusline = '%!v:lua.statusline()'
