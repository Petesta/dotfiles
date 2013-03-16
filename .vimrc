set nocompatible

" Vundle Installation
filetype off

execute pathogen#infect()

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required
Bundle 'gmarik/vundle'
Bundle 'derekwyatt/vim-scala'

" Required 
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

" NERDTree Config
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Shows Position In File
set ruler

" C and C++
au BufNewFile,BufRead *.c set shiftwidth=4
au BufNewFile,BufRead *.cpp set shiftwidth=4
au BufNewFile,BufRead *.h set shiftwidth=4

" Coffee
au BufNewFile,BufRead *.coffee set shiftwidth=2

" Haskell
au BufNewFile,BufRead *.hs set shiftwidth=4

" Python
au BufNewFile,BufRead *.py set shiftwidth=2

" Ruby
au BufNewFile,BufRead *.rb set shiftwidth=2

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
let &t_Co=256
set background=dark
"highlight LineNr ctermfg=grey ctermbg=black
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "high
"let g:solarized_contrast = "high
let g:solarized_termtrans = 1
colorscheme solarized
