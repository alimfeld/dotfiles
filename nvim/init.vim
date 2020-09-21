" vim:fdm=marker

" Core {{{
set number
set tw=4 sw=4
" }}}

" Mappings {{{
inoremap jj <esc>			" jump out of insert mode by typing jj
" }}}

" Commands {{{
command! Config execute ":e $MYVIMRC"
command! Reload execute "source $MYVIMRC"
" }}}

" Plugins {{{
call plug#begin(stdpath('data') . '/plugged')

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'vim-test/vim-test'

call plug#end()
" }}}

" LSP {{{
lua <<EOF
require'nvim_lsp'.jdtls.setup{}
EOF

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" }}}

" FZF {{{
nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap <leader>p :Files!<CR>
nmap cc :Commands!<CR>
" }}}
