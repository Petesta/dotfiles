" Pathgoen Installation
execute pathogen#infect()
filetype plugin indent on
 
" Abbreviations
iabbrev pc@ Pete Cruz iPetesta@gmail.com
 
" Highlight colors for git_gutter
highlight GitGutterAdd ctermbg=234
highlight GitGutterChange ctermbg=234
highlight GitGutterDelete ctermbg=234
 
" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
 
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
 
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
 
" Molokai
let g:molokai_original = 1
 
" Screen Coloring and Syntax Highlighting
syntax on
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

for i in [1,2,3,4,5,6,7,8,9]
  nnoremap <leader>i igt
endfor
 
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
 
" Shortcuts for editing files
nnoremap <leader>v :split $MYVIMRC<CR>
nnoremap <leader>b :split ~/.bashrc<CR>
 
if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
endif
 
" Copy
vmap <C-c> "+yi
 
" NERDTree Config
" autocmd VimEnter * if &filetype !=# 'haskell' && &filetype !=# 'python' | NERDTree | endif
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
 
let NERDTreeIgnore = ['\.pyc$', '\.class$', '\.o$']
map  <leader>t :NERDTreeToggle<CR>
nmap <leader>w <C-w>w
nmap <leader>e gt
nmap <leader>q gT
 
" C, C++, and Objective-C
augroup ft_c
  au!
  au BufNewFile,BufRead *.c set shiftwidth=4
  au BufNewFile,BufRead *.cpp set shiftwidth=4
  au BufNewFile,BufRead *.m set shiftwidth=4
  au BufNewFile,BufRead *.h set shiftwidth=4
augroup END
 
" Clojure, ClojureScript
augroup ft_clojure
  au!
  au BufNewFile,BufRead *.clj set shiftwidth=2
  au BufNewFile,BufRead *.cljs set shiftwidth=2
augroup END
 
" CoffeeScript
augroup ft_coffeescript
  au!
  au BufNewFile,BufRead *.coffee set shiftwidth=2
augroup END
 
" Haskell
augroup ft_haskell
  au!
  au BufNewFile,BufRead *.hs set shiftwidth=2
augroup END
 
augroup ft_java
  au!
  au BufNewFile,BufRead *.java set shiftwidth=4
augroup END
 
" Javascript
augroup ft_javascript
  au!
  au BufNewFile,BufRead *.js set shiftwidth=4
augroup END
 
" Python
augroup ft_python
  au!
  au BufNewFile,BufRead *.py set shiftwidth=4
augroup END
 
" Ruby
augroup ft_ruby
  au!
  au BufNewFile,BufRead *.rb set shiftwidth=2
  au BufNewFile,BufRead Berksfile set shiftwidth=2
  au BufNewFile,BufRead Gemfile set shiftwidth=2
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
 
" SCSS
augroup ft_scss
  au!
  au BufNewFile,BufRead *.scss set shiftwidth=2
augroup END
 
" Shell
augroup ft_shell
  au!
  au BufNewFile,BufRead *.sh set shiftwidth=2
augroup END
 
" Additional File Types
augroup ft_settings
  au!
  au BufNewFile,BufRead *.css colorscheme molokai
  au BufNewFile,BufRead *.html colorscheme molokai
  au BufNewFile,BufRead *.json colorscheme molokai
  au BufNewFile,BufRead *.md colorscheme molokai
 
  au FileType css shiftwidth=2
  au FileType html shiftwidth=2
  au FileType json shiftwidth=2
augroup END
