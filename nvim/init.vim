" vim:fdm=marker

" Plugins {{{
call plug#begin(stdpath('data') . '/plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'gruvbox-community/gruvbox'
call plug#end()
" }}}

" Basics {{{
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set incsearch
set showmatch
set ignorecase
set smartcase
set completeopt=menuone,noinsert,noselect
" }}}

" Escape {{{
inoremap jj <esc>			" jump out of insert mode by typing jj
" }}}

" Splits {{{
set splitbelow
set splitright

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
" }}}

" Clipboard {{{
set clipboard+=unnamedplus
" }}}

" Commands {{{
command! Config execute ":e $MYVIMRC"
command! Reload execute "source $MYVIMRC"
" }}}

" LSP {{{
lua << EOF
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end
require'nvim_lsp'.jdtls.setup{on_attach=on_attach_vim}
EOF

let g:diagnostic_enable_virtual_text = 1

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH    <cmd>lua vim.lsp.buf.signature_help()<CR>
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

" Colorscheme {{{
colorscheme gruvbox
set background=dark
" }}}
