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
autocmd vimenter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let mapleader = ","
map <leader>t :NERDTreeToggle<CR>
nmap <leader>w <C-w>w
nmap <leader>e gt
nmap <leader>q gT


" Shows Position In File
set ruler

" C, C++, and Objective-C
au BufNewFile,BufRead *.c set shiftwidth=4
au BufNewFile,BufRead *.cpp set shiftwidth=4
au BufNewFile,BufRead *.h set shiftwidth=4

" CoffeeScript
au BufNewFile,BufRead *.coffee set shiftwidth=2

" Haskell
au BufNewFile,BufRead *.hs set shiftwidth=4

" Python
au BufNewFile,BufRead *.py set shiftwidth=4

" Ruby
au BufNewFile,BufRead *.rb set shiftwidth=2

" Scala
au BufNewFile,BufRead *.scala set shiftwidth=2
hi scalaNew gui=underline
hi scalaMethodCall gui=italic
hi scalaValName gui=underline
hi scalaVarName gui=underline

" SCSS
au BufNewFile,BufRead *.scss set shiftwidth=2

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
