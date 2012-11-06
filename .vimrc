set nocompatible
" Vundle Installation
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required
Bundle 'gmarik/vundle'

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

" Indentation
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Line Numbers
set number

" Show Title
set title

" Syntax Highlighting
syntax on
set background=dark
colorscheme molokai


