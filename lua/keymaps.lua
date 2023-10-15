-------------------------------
--          KEYMAPS          --
-------------------------------

-- Make space as leader key
vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','


-- Insert mode mapping
vim.keymap.set('i', '<C-h>', '<C-w>')  -- map <C-BS> to <C-w>


-- Terminal mapping
vim.keymap.set('', '<Leader>sh', ':terminal<cr>')
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>')


-- Buffer movement
vim.keymap.set('n', '<BS>', '<C-^>')
vim.keymap.set('n', '<Tab>', ':bn<cr>')
vim.keymap.set('n', '<S-Tab>', ':bp<cr>')

-- Copy paste with clipboard
vim.keymap.set('', '<Leader>y', '"+y')
vim.keymap.set('', '<Leader>Y', '"+y$')
vim.keymap.set('', '<Leader>p', '"+p')
vim.keymap.set('', '<Leader>P', '"+P')
vim.keymap.set('', '<Leader><Leader>y', 'gg"+yG\'\'')

-- Select the paste
vim.keymap.set('', 'gp', function()
  local v = vim.fn.getregtype():sub(1, 1)
  if v == '' then
    return ''
  end
  -- `:h getregtype`: <C-V> is one character with value 0x16
  v = v:byte() == 0x16 and '<C-V>' or v
  return '`[' .. v .. '`]'
end, { expr = true, desc = 'Select the paste' } )

-- Diagnostic
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics in a floating window' } )
vim.keymap.set('n', '[d',        vim.diagnostic.goto_prev,  { desc = 'Move to the prev diagnostic' } )
vim.keymap.set('n', ']d',        vim.diagnostic.goto_next,  { desc = 'Move to the next diagnostic' } )

-- Center the search
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('c', '<CR>', function()
  return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>'
end, { expr = true })

-- Redo and search next
vim.keymap.set('n', '<C-n>', '.nzzzv')

-- Spell check
vim.keymap.set('n', '<Leader>sp', ':setlocal spell! spelllang=en_us<CR>')

-- Switch conceal
vim.keymap.set("n", "<Leader>zc", function()
  vim.o.conceallevel = vim.o.conceallevel > 0 and 0 or 3
end, { silent = true, desc = 'Toggle conceal' } )

-- Remapping navigation keys
vim.keymap.set('', '<PageUp>', '<C-u>')
vim.keymap.set('', '<PageDown>', '<C-d>')
vim.keymap.set('', '<Home>', '^')

-- Navigate windows
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


-- Abbr for command mode
local function cabbrev(lhs, rhs)
  -- only working on ':' mode
  local command = "cnoreabbrev <expr> %s ((getcmdtype() is# ':' && getcmdline() is# '%s')?('%s'):('%s'))"
  vim.cmd(command:format(lhs, lhs, rhs, lhs))
end

cabbrev('f', 'find')
cabbrev('s', 'sp')
cabbrev('v', 'vs')
-- Write file as root
cabbrev('sudow', 'w !sudo tee %')
cabbrev('doasw', 'w !doas tee %')
