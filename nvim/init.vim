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
inoremap jj <esc>			" jump out of insert mode by typing jj
" -- Splits
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
" -- Leader
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
Plug 'tpope/vim-fugitive'
Plug 'vim-test/vim-test'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'gruvbox-community/gruvbox'
call plug#end()
" }}}

" PlugConf - LSP {{{
lua require('lsp')

let g:diagnostic_enable_virtual_text = 1

func! s:lsp_mappings()
    if luaeval('vim.tbl_isempty(vim.lsp.buf_get_clients())') 
        return
    endif

    nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
endfunc

augroup LSP | au!
    autocmd FileType * call s:lsp_mappings()
augroup END
" }}}

" PlugConf - FZF {{{
nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap <leader>p :Files!<CR>
nmap cc :Commands!<CR>
" }}}

" PlugConf - Gruvbox {{{
colorscheme gruvbox
set background=dark
" }}}
