" vim:fdm=marker

" Settings {{{
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
set nowrap
set splitbelow
set splitright
set clipboard+=unnamedplus
" }}}

" Mappings {{{
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

nnoremap <SPACE> <Nop>
let mapleader=" "
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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
call plug#end()
" }}}

" Plug - FZF {{{
nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap <leader>p :Files!<CR>
nmap cc :Commands!<CR>
" }}}

" Plug - Gruvbox {{{
colorscheme gruvbox
set background=dark
" }}}

" Plug - Airline {{{
let g:airline_powerline_fonts=1
" }}}
