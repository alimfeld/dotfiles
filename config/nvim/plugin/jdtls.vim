if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls-setup').setup()
  augroup end
endif
