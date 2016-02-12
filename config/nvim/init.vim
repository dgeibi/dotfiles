syntax on
colorscheme Tomorrow

"set background=Tomorrow
set clipboard+=unnamedplus
set nobackup
set fileencodings=utf8,cp936,gb18030,big5
set number
set relativenumber " 显示相对行号
"set cursorline

" 自动缩进
set autoindent
set smartindent
set smarttab
set cindent
" 缩进宽度
set tabstop=4
set shiftwidth=4

set expandtab

let g:vim_markdown_folding_disabled = 1

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

"airline
"let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "light"
