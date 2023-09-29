-------------------------------
--          KEYMAPS          --
-------------------------------

-- Make space as leader key --
vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Copy paste with clipboard --
vim.keymap.set('', '<Leader>y', '"+y')
vim.keymap.set('', '<Leader>Y', '"+y$')
vim.keymap.set('', '<Leader>p', '"+p=`]')
vim.keymap.set('', '<Leader>P', '"+P=`]')
vim.keymap.set('', '<Leader><Leader>y', 'gg"+yG\'\'')

-- Delete with black hole --
vim.keymap.set('', '_d', '"_d')
vim.keymap.set('', '_D', '"_D')

-- Diagnostic
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics in a floating window' } )
vim.keymap.set('n', '[d',        vim.diagnostic.goto_prev,  { desc = 'Move to the prev diagnostic' } )
vim.keymap.set('n', ']d',        vim.diagnostic.goto_next,  { desc = 'Move to the next diagnostic' } )

-- Paste fit indent --
vim.keymap.set('', 'p', 'p=`]')
vim.keymap.set('', 'P', 'P=`]')

-- Center the search --
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('c', '<CR>', function()
  return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>'
end, { expr = true })

-- [ ] --
vim.keymap.set('n', ']<Space>', 'm`o<Esc>``')
vim.keymap.set('n', '[<Space>', 'm`O<Esc>``')

-- Wizard --
-- vim.keymap.set('n', '<Leader>r', '!!$SHELL<CR>')
-- vim.keymap.set('v', '<Leader>r', '!$SHELL<CR>')

-- Substitute and search -- TODO:
vim.keymap.set("n", "<C-n>", "*Ncgn", { desc = "Substitute word under cursor" })

-- Spell check --
vim.keymap.set('n', '<Leader>sp', ':setlocal spell! spelllang=en_us<CR>')

-- Buffer movement --
vim.keymap.set('n', '<BS>', '<C-^>')
vim.keymap.set('n', '<Tab>', ':bn<cr>')
vim.keymap.set('n', '<S-Tab>', ':bp<cr>')

-- Terminal --
vim.keymap.set('', '<Leader>sh', ':terminal<cr>')
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>')
-- vim.keymap.set('t', '<CR>', '<CR><C-\\><C-n>')


-- Navigate windows --
local function win_focus_resize(arr, dir, cmd)
  vim.keymap.set('n', '<A-'..arr..'>', '<C-w>'..dir)
  vim.keymap.set('i', '<A-'..arr..'>', '<C-\\><C-N><C-w>'..dir)
  vim.keymap.set('t', '<A-'..arr..'>', '<C-\\><C-N><C-w>'..dir)
  vim.keymap.set('n', '<A-S-'..arr..'>', '3<C-w>'..cmd)
  vim.keymap.set('i', '<A-S-'..arr..'>', '<C-\\><C-N>3<C-w>'..cmd..'gi')
  vim.keymap.set('t', '<A-S-'..arr..'>', '<C-\\><C-N>3<C-w>'..cmd..'i')
end
win_focus_resize('h', 'h', '<')
win_focus_resize('j', 'j', '+')
win_focus_resize('k', 'k', '-')
win_focus_resize('l', 'l', '>')
win_focus_resize('Left', 'h', '<')
win_focus_resize('Down', 'j', '+')
win_focus_resize('Up',   'k', '-')
win_focus_resize('Right','l', '>')

vim.keymap.set('n', '<A-w>', '<C-w><C-w>')
vim.keymap.set('i', '<A-w>', '<C-\\><C-N><C-w><C-w>')
vim.keymap.set('t', '<A-w>', '<C-\\><C-N><C-w><C-w>')


-- Remapping navigation keys --
vim.keymap.set('', '<PageUp>', '<C-u>')
vim.keymap.set('', '<PageDown>', '<C-d>')
vim.keymap.set('', '<Home>', '^')

-- Make things consistent --
vim.keymap.set('i', '<C-h>', '<C-w>')  -- map <C-BS> to <C-w>


-- Switch conceal --
vim.keymap.set("n", "<Leader>zc", function()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end, { silent = true, desc = 'Toggle conceal' } )


-- Check hi group
vim.keymap.set('n', '<Leader>hi', function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(result))
end)


-- Abbr for command mode --
local function cabbrev(lhs, rhs)
  -- only working on ':' mode
  local command = "cnoreabbrev <expr> %s ((getcmdtype() is# ':' && getcmdline() is# '%s')?('%s'):('%s'))"
  vim.cmd(command:format(lhs, lhs, rhs, lhs))
end

cabbrev('sudow', 'w !sudo tee %')
cabbrev('doasw', 'w !doas tee %')
cabbrev('f', 'find')
