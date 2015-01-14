" Pathgoen Installation
execute pathogen#infect()
filetype plugin indent on

" Abbreviations
iabbrev pc@ Pete Cruz iPetesta@gmail.com

" Vim-Airline
set laststatus=2
set ttimeoutlen=50

" Vim-Unstack
let g:unstack_layoyt = "portrait"

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

" Autoread
set autoread

" Fix backspace issue
set backspace=indent,eol,start

" Braces
set hlsearch
set showmatch

" Horizontal Cursor
set cursorline

" Indentation
set autoindent
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=4
set tabstop=4

" Line Numbers
set number
set relativenumber

" Scrolling
set mouse=a

" Show Position In File
set ruler

" Show Title
set title

" Screen Coloring and Syntax Highlighting
syntax on
set background=dark
let &t_Co=256

" Arrow Keys
nnoremap <up>    :echo "No arrow keys in Vim :)" <esc>
nnoremap <down>  :echo "No arrow keys in Vim :)" <esc>
nnoremap <left>  :echo "No arrow keys in Vim :)" <esc>
nnoremap <right> :echo "No arrow keys in Vim :)" <esc>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Mappings
nnoremap - yyddp
nnoremap _ yydd2jp
inoremap <c-u> <esc>viwU<esc>i
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap " ""<esc>i


" Tab mappings.
"map <leader>tt :tabnew<cr>
"map <leader>te :tabedit
"map <leader>tc :tabclose<cr>
"map <leader>to :tabonly<cr>
"map <leader>tn :tabnext<cr>
"map <leader>tp :tabprevious<cr>
"map <leader>tf :tabfirst<cr>
"map <leader>tl :tablast<cr>
"map <leader>tm :tabmove

let mapleader = ","

" set paste!
nnoremap <leader>p :set paste!<CR>

" set relativenumber!
nnoremap <leader>rn :set relativenumber!<CR>

nnoremap <leader>asdfy orequire 'pry'<esc>obinding.pry<esc>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" Bring up .vimrc
nnoremap <leader>v :split $MYVIMRC<CR>
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Copy
vmap <C-c> "+yi


" NERDTree Config
" autocmd VimEnter * if &filetype !=# 'haskell' && &filetype !=# 'python' | NERDTree | endif
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore = ['\.pyc$'] + ['\.class$'] + ['\.o$']
map  <leader>t :NERDTreeToggle<CR>
nmap <leader>w <C-w>w
nmap <leader>e gt
nmap <leader>q gT

" Additional File Types
augroup filetypesettings
  " C, C++, and Objective-C
  au BufNewFile,BufRead *.c set shiftwidth=4
  au BufNewFile,BufRead *.cpp set shiftwidth=4
  au BufNewFile,BufRead *.m set shiftwidth=4
  au BufNewFile,BufRead *.h set shiftwidth=4

  " Clojure, ClojureScript
  au BufNewFile,BufRead *.clj set shiftwidth=2
  au BufNewFile,BufRead *.cljs set shiftwidth=2

  " CoffeeScript
  au BufNewFile,BufRead *.coffee set shiftwidth=2
  au BufNewFile,BufRead *.js.coffee set shiftwidth=2

  " Haskell
  au BufNewFile,BufRead *.hs set shiftwidth=2

  " Javascript
  au BufNewFile,BufRead *.js set shiftwidth=4

  " Python
  au BufNewFile,BufRead *.py set shiftwidth=4

  " Ruby
  au BufNewFile,BufRead *.rb set shiftwidth=2
  au BufNewFile,BufRead Berksfile set shiftwidth=2

  " Scala
  au BufNewFile,BufRead *.scala set shiftwidth=2

  " SCSS
  au BufNewFile,BufRead *.scss set shiftwidth=2

  au BufNewFile,BufRead *.css colorscheme molokai
  au BufNewFile,BufRead *.html colorscheme molokai
  au BufNewFile,BufRead *.json colorscheme molokai
  au BufNewFile,BufRead *.md colorscheme molokai

  au FileType css shiftwidth=2
  au FileType html shiftwidth=2
  au FileType json shiftwidth=2
augroup END
