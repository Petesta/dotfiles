set nocompatible

" Vundle Installation
filetype off

execute pathogen#infect()

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required
Bundle 'gmarik/vundle'
Bundle 'derekwyatt/vim-scala'

"Required 
filetype plugin indent on

" Vim Configuration File

" Arrow Keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Braces
set showmatch
set hlsearch

" Indentation
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set tabstop=4

" Line Numbers
set number

" Shows position in file
set ruler

" Scala
au BufNewFile,BufRead *.scala set shiftwidth=2
hi scalaNew gui=underline
hi scalaMethodCall gui=italic
hi scalaValName gui=underline
hi scalaVarName gui=underline

" Scrolling
set mouse=a

" Show Title
set title

" Syntax Highlighting
syntax on
set t_Co=16
set background=dark
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
colorscheme solarized
