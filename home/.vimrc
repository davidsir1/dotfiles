" Plugins
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'

call plug#end()

" Settings
colorscheme gruvbox
filetype on
filetype plugin on
syntax on
set mouse=a
set termguicolors
set backspace=eol,start,indent
set encoding=utf8
set nu
set cmdheight=2
set showcmd
set showmode
set tabstop=4
set shiftwidth=4
set incsearch
set ignorecase
set hls
set cursorline
"set columns=80
set scrolloff=6
set wildmenu

" Mappings
nnoremap <C-s> :w!<CR>
nnoremap <C-q> :q!<CR>
nn <Esc> <Cmd>noh<CR>

" Gruvbox Settings
let g:gruvbox_italics=1
set bg=dark
