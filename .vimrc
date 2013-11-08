set nocompatible
filetype plugin indent on

" Pathgoen Installation
execute pathogen#infect()

" Vundle Installation
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'derekwyatt/vim-scala'

" Vim-Powerline
let g:Powerline_symbols = 'fancy'

" Vim-Unstack
let g:unstack_layoyt = "portrait"

" Exercises
" :echom "(>^.^<)"

" Abbreviations
iabbrev ssig Pete Cruz Petesta@live.com

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

" Mappings
nnoremap - yyddp
nnoremap _ yydd2jp
inoremap <c-u> <esc>viwU<esc>i
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap " ""<esc>i
let mapleader = ","
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>ev :split $MYVIMRC<CR>
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" NERDTree Config
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let mapleader = ","
map <leader>t :NERDTreeToggle<CR>
nmap <leader>w <C-w>w
nmap <leader>e gt
nmap <leader>q gT

" Scrolling
set mouse=a

" Show Position In File
set ruler

" Show Title
set title

" Syntax Highlighting
syntax on
let &t_Co=256
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" C, C++, and Objective-C
au BufNewFile,BufRead *.c set shiftwidth=4
au BufNewFile,BufRead *.cpp set shiftwidth=4
au BufNewFile,BufRead *.m set shiftwidth=4
au BufNewFile,BufRead *.h set shiftwidth=4

" CoffeeScript
au BufNewFile,BufRead *.coffee set shiftwidth=2
au BufNewFile,BufRead *.js.coffee set shiftwidth=2

" Haskell
au BufNewFile,BufRead *.hs set shiftwidth=4

" Javascript
au BufNewFile,BufRead *.js set shiftwidth=4

" Python
au BufNewFile,BufRead *.py set shiftwidth=4

" Ruby
au BufNewFile,BufRead *.rb set shiftwidth=2

" html.erb
au BufNewFile,BufRead *.erb set shiftwidth=2

" Scala
au BufNewFile,BufRead *.scala set shiftwidth=2
hi scalaNew gui=underline
hi scalaMethodCall gui=italic
hi scalaValName gui=underline
hi scalaVarName gui=underline

" SCSS
au BufNewFile,BufRead *.scss set shiftwidth=2
