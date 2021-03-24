" tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" search
set incsearch
set ignorecase
set smartcase

" clipboard
set clipboard+=unnamedplus

" ui
set number
set relativenumber
set showmatch
set visualbell
set nowrap
set splitbelow
set splitright

" leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" mappings for navigating splits
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" mappings for moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" commands
command! Config execute ":e $MYVIMRC"
command! Reload execute "source $MYVIMRC"

" colorscheme
colorscheme gruvbox
