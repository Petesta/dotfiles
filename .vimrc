""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Pathgoen Installation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev pc@ Pete Cruz iPetesta@gmail.com

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Highlight Colors For git_gutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight GitGutterAdd ctermbg=234
highlight GitGutterChange ctermbg=234
highlight GitGutterDelete ctermbg=234

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Highlight Trailing Whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Vim Configruations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set autoread                   "Autoread
set backspace=indent,eol,start "Fix backspace issue
set hlsearch                   "Highlight matching strings
set showmatch                  "Matching braces
set cursorline                 "Horizontal cursor

" Indentation
set autoindent
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=4
set tabstop=4

set lazyredraw
set ttyfast
set number         "Show line number
set relativenumber "Relative number line
set mouse=a        "Scrolling
set ruler          "Show position in file
set title          "Show title
set visualbell
set laststatus=2   "Vim-Airline
set ttimeoutlen=50 "Vim-Airline
set dictionary=/usr/share/dict/words

" Screen Coloring and Syntax Highlighting
syntax on
let &t_Co=256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Tab mappings.
"map <leader>tt :tabnew<CR>
"map <leader>te :tabedit
"map <leader>tc :tabclose<CR>
"map <leader>to :tabonly<CR>
"map <leader>tn :tabnext<CR>
"map <leader>tp :tabprevious<CR>
"map <leader>tf :tabfirst<CR>
"map <leader>tl :tablast<CR>
"map <leader>tm :tabmove

let mapleader = ","

" Custom
nnoremap - yyddp
nnoremap _ yydd2jp
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
inoremap <c-u> <esc>viwU<esc>i
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap " ""<esc>i

" Jump to a Vim tab positions
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" set paste!
nnoremap <leader>p :set paste!<CR>

" set relativenumber!
nnoremap <leader>n :set relativenumber!<CR>

" insert binding.pry (before[bf] or after[ba]) current line
map <leader>bf :normal $Obinding.pry<CR>
map <leader>ba :normal $obinding.pry<CR>

" Opens up Github page
noremap <silent> cp :let @" = expand("%")<CR>

" Shortcuts for editing files
nnoremap <leader>v :split $MYVIMRC<CR>
nnoremap <leader>b :split ~/.bashrc<CR>

" Automatically source .vimrc upon write
if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Operating System
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    " Molokai
    let g:molokai_original = 1

    " Copy
    vmap <C-c> "+yi
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Vim Plugin Configruations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree Config
autocmd VimEnter * if &filetype !=# 'haskell' && &filetype !=# 'python' && &filetype !=# 'ruby' | NERDTree | endif
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore = ['\.pyc$', '\.class$', '\.o$']
map  <leader>t :NERDTreeToggle<CR>
nmap <leader>w <C-w>w
nmap <leader>e gt
nmap <leader>q gT

" Vim Dispatch
map <leader>rc "ayi"
map <leader>c :copen<CR>
map <leader>R :Dispatch ruby % -n /'<C-R>a'/<CR>
map <leader>r :Dispatch ruby %<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             File Type Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" C, C++, and Objective-C
augroup ft_c
  au!
  au BufNewFile,BufRead *.c   set shiftwidth=4
  au BufNewFile,BufRead *.cpp set shiftwidth=4
  au BufNewFile,BufRead *.m   set shiftwidth=4
  au BufNewFile,BufRead *.h   set shiftwidth=4
augroup END

" Clojure, ClojureScript
augroup ft_clojure
  au!
  au BufNewFile,BufRead *.clj  set shiftwidth=2
  au BufNewFile,BufRead *.cljs set shiftwidth=2
augroup END

" CoffeeScript
augroup ft_coffeescript
  au!
  au BufNewFile,BufRead *.coffee set shiftwidth=2
augroup END

" CSS, LESS, SCSS
augroup ft_css
  au!
  au BufNewFile,BufRead *.css  set shiftwidth=2
  au BufNewFile,BufRead *.less set shiftwidth=2
  au BufNewFile,BufRead *.scss set shiftwidth=2
augroup END

" Haskell
augroup ft_haskell
  au!
  au BufNewFile,BufRead *.hs set shiftwidth=2
augroup END

" Java
augroup ft_java
  au!
  au BufNewFile,BufRead *.java set shiftwidth=4
augroup END

" JavaScript
augroup ft_javascript
  au!
  au BufNewFile,BufRead *.js set shiftwidth=2
augroup END

" Python
augroup ft_python
  au!
  au BufNewFile,BufRead *.py set shiftwidth=4
augroup END

" Ruby
augroup ft_ruby
  au!
  au BufNewFile,BufRead *.rb         set shiftwidth=2
  au BufNewFile,BufRead Berksfile    set shiftwidth=2
  au BufNewFile,BufRead Gemfile      set shiftwidth=2
  au BufNewFile,BufRead Gemfile.lock set shiftwidth=2
augroup END

" Rust
augroup ft_rust
  au!
  au BufNewFile,BufRead *.rs set shiftwidth=2
augroup END

" Scala
augroup ft_scala
  au!
  au BufNewFile,BufRead *.scala set shiftwidth=2
augroup END

" Shell
augroup ft_shell
  au!
  au BufNewFile,BufRead *.sh set shiftwidth=2
augroup END

" Additional File Types
augroup ft_settings
  au!
  au BufNewFile,BufRead *.html colorscheme molokai
  au BufNewFile,BufRead *.json colorscheme molokai
  au BufNewFile,BufRead *.md   colorscheme molokai
  au BufNewFile,BufRead *.toml colorscheme molokai
  au BufNewFile,BufRead *.yaml colorscheme molokai
  au BufNewFile,BufRead *.yml  colorscheme molokai

  au FileType html shiftwidth=2
  au FileType json shiftwidth=2
augroup END
