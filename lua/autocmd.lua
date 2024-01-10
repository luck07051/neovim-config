local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

-- Disable auto comment new line
au('FileType', {
  pattern = { '*' },
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

-- Delete trailing spaces and extra line when save file
au('BufWrite', {
  desc = 'Delete trailing spaces and extra line',
  callback = function()
    local pos = vim.fn.getpos('.')
    vim.cmd [[ %s/\s\+$//e ]]
    vim.cmd [[ %s/\n\+\%$//e ]]
    vim.fn.setpos('.', pos)
  end
})

-- Restore the cursor position after yank
local yank_restore_cursor = ag('yank_restore_cursor', {})
au({ 'VimEnter', 'CursorMoved' }, {
  group = yank_restore_cursor,
  desc = 'Tracking the cursor position',
  callback = function()
    Cursor_pos = vim.fn.getpos('.')
  end,
})

au('TextYankPost', {
  group = yank_restore_cursor,
  desc = 'Restore the cursor position after yank',
  callback = function()
    if vim.v.event.operator == 'y' then
      vim.fn.setpos('.', Cursor_pos)
    end
  end,
})

-- Yank highlighting
au('TextYankPost', {
  desc = 'Yank highlighting',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Yank',
      timeout = 300,
      priority = 250,
    })
  end,
})

-- Settings for terminal mode
au('TermOpen', {
  callback = function(opts)
    -- when start dap, it active the insert mode, i dont want that
    if opts.file:match('dap%-terminal') then
      return
    end
    vim.cmd('startinsert')
    vim.cmd('setlocal nonu')
    vim.cmd('setlocal signcolumn=no')
  end,
})

-- Only focused window has cursorline
au('WinEnter', { command = 'setlocal cursorline' })
au('WinLeave', { command = 'setlocal nocursorline' })


-- Use marker folding in nvim config
au('BufEnter', {
  pattern = { '*/.config/nvim/*' },
  callback = function()
    vim.opt.foldmethod = 'marker'
    vim.opt.foldlevel = 0
  end
})

-- Correcting the filetype
local function corrft(pattern, ft)
  au('BufEnter', {
    pattern = { pattern },
    command = 'setf ' .. ft
  })
end

corrft('*qmk*/*.keymap', 'c') -- C for qmk file
corrft('*qmk*/*.def', 'c')

corrft('*manuscript/*.txt', 'markdown') -- Use md to open the book 'pure bash bible'
