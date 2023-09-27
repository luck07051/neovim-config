-- Clear nonessential files when leave Tex file
vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*.tex',
  command = [[ !latexmk -c % ]]
})
