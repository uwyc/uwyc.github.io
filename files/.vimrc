" A minimalist Vim plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" A code-completion engine for vim
"Plug 'valloric/youcompleteme'

" one colorscheme pack to rule them all!
Plug 'flazz/vim-colorschemes'

" Lean & mean status/tabline for vim that's light as air.
Plug 'bling/vim-airline'

Plug 'townk/vim-autoclose'

" Functions and mappings to close open HTML/XML tags
Plug 'docunext/closetag.vim'

" extended % matching for HTML,LaTeX, and many other languages
Plug 'matchit.zip'

call plug#end()
" End run :PlugInstall

syntax on
set t_Co=256
colorscheme molokai
filetype on
filetype plugin on
filetype indent on
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
set nocompatible
set confirm
set number
set cursorline
set autoindent
set cindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set showmatch
set matchtime=5
set novisualbell
set laststatus=2
set formatoptions=tcrqn

