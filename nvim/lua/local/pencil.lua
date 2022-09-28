vim.api.nvim_exec(
  [[
    augroup pencil
      autocmd!
      autocmd FileType markdown,mkd,text,fountain  call pencil#init()
    augroup END
  ]],
  true
)
