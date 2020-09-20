" --- Plugins

call plug#begin(stdpath('data') . '/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'

call plug#end()

" --- Language Server

lua <<EOF
require'nvim_lsp'.jdtls.setup{}
EOF

" --- Boilerplate

set number

" Jump out of insert mode by typing jj
inoremap jj <esc>

" --- VIM Config

command! Config execute ":e $MYVIMRC"
command! Reload execute "source $MYVIMRC"

" --- FZF

" Bind "//" to a fzf-powered buffer search
nmap // :BLines!<CR>
" Bind "??" to a fzf-powered project search
nmap ?? :Rg!<CR>
" Bind "<leader>p" to a fzf-powered filename search
nmap <leader>p :Files!<CR>
" Bind "cc" to a fzf-powered command search
nmap cc :Commands!<CR>
