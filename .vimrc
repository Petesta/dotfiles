""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Pete Cruz's Vim Configuration
"
"                             Some pretty chill stuff here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
highlight GitGutterAdd    ctermbg=234
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
autocmd BufWritePre * :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Vim Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set autoread                   " Autoread
set backspace=indent,eol,start " Fix backspace issue
set ignorecase                 " Ignore cases in searches
set hlsearch                   " Highlight matching strings
set showmatch                  " Matching braces
set cursorline                 " Horizontal cursor

" Indentation
set autoindent
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=4
set tabstop=4

set lazyredraw
set ttyfast
set number         " Show line number
set relativenumber " Relative number line
set mouse=a        " Scrolling
set ruler          " Show position in file
set title          " Show title
set visualbell
set laststatus=2   " Vim-Airline
set ttimeoutlen=50 " Vim-Airline
set tags=tags
set dictionary=/usr/share/dict/words
set wildignore+=*.pyc,*.so,*.swp,*.class,*/target/*

" Screen Coloring, Syntax Highlighting, and Color Scheme
syntax on
let &t_Co=256
colorscheme molokai

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Arrow Keys
nnoremap <up>    :echo "No arrow keys in Vim 😀" <esc>
nnoremap <down>  :echo "No arrow keys in Vim 😀" <esc>
nnoremap <left>  :echo "No arrow keys in Vim 😀" <esc>
nnoremap <right> :echo "No arrow keys in Vim 😀" <esc>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Custom
nnoremap - yyddp
nnoremap _ yydd2jp
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
inoremap <c-u> <esc>viwU<esc>i
inoremap " ""<esc>i

" Alpha
imap <c-l><c-a> <c-k>a*

" Beta
imap <c-l><c-b> <c-k>b*

" Gamma
imap <c-l><c-g> <c-k>g*

" Delta
imap <c-l><c-d> <c-k>d*

" Epslion
imap <c-l><c-e> <c-k>e*

" Lambda
imap <c-l><c-l> <c-k>l*

" Eta
imap <c-l><c-y> <c-k>y*

" Theta
imap <c-l><c-h> <c-k>h*

" Mu
imap <c-l><c-m> <c-k>m*

" Rho
imap <c-l><c-r> <c-k>r*

" Pi
imap <c-l><c-p> <c-k>p*

" Phi
imap <c-l><c-f> <c-k>f*

let mapleader = "\<space>"

" Jump to a Vim tab position
for i in range(1, 9)
  execute "nnoremap <leader>".i." ".i."gt"
endfor

" Move Vim tab to a different position
for i in range(1, 9)
  let s:num = i - 1
  execute "nnoremap <leader>m".i." :tabm".s:num."<cr>"
endfor

" Toggle paste
nnoremap <leader>p :set paste!<cr>

" Toggle relativenumber
nnoremap <leader>n :set relativenumber!<cr>

" Insert binding.pry (before[bf] or after[ba]) current line
map <leader>bf :normal $Obinding.pry<cr>
map <leader>ba :normal $obinding.pry<cr>

" Shortcuts for editing files
nnoremap <leader>v :split $MYVIMRC<cr>
nnoremap <leader>b :split ~/.bashrc<cr>

" Automatically source .vimrc upon write
if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Operating System
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("unix")
  let s:uname = system("uname -s")

  if has("gui_running")
    set mousehide
  else
    if s:uname == "Darwin\n"
      let g:molokai_original = 1
      let g:airline#extensions#tabline#enabled = 1

      " Copy and paste
      vmap <c-c> "+yi
      vmap <c-x> "+c
      vmap <c-v> c<esc>"+p
      imap <c-v> <esc>"+pa
    endif
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Vim Plugin Configruations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Goyo
au VimEnter * if &filetype ==# "markdown" | Goyo 125 | endif

" NERDTree
autocmd VimEnter * if &filetype !=# "haskell" && &filetype !=# "python" && &filetype !=# "ruby" | NERDTree | endif
autocmd VimEnter * wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore = ["\.pyc$", "\.class$", "\.o$"]
map  <leader>t :NERDTreeToggle<cr>
nmap <leader>w <c-w>w
nmap <leader>e gt
nmap <leader>q gT

" Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle

" Vim Dispatch
map <leader>rc "ayi"
map <leader>c :copen<cr>
map <leader>R :Dispatch ruby % -n /'<C-R>a'/<cr>
map <leader>r :Dispatch ruby %<cr>

" Vim Poi
vnoremap <leader>h  :PoiLines<cr>
nnoremap <leader>h  :PoiLine<cr>
nnoremap <leader>hc :PoiClear<cr>

" indentLine
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Custom Vim Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ex. sbt 'test-only test.ApplicationSpec'
function! SBTTestOnly()
  let b:current_filename = split(split(@%, '/')[1], '\.')[0]
  let b:sbt = ":Dispatch sbt 'test-only test.".b:current_filename."'"
  execute b:sbt
endfunction

command! -nargs=0 SBT :call SBTTestOnly()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             File Type Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup HighlightKeywords
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|NOTE\|XXX', -1)
augroup END

augroup FileTypes
  au!
  au BufNewFile,BufRead .*        set shiftwidth=2 | set filetype=sh
  au BufNewFile,BufRead *.c       set shiftwidth=4
  au BufNewFile,BufRead *.clj     set shiftwidth=2
  au BufNewFile,BufRead *.cljs    set shiftwidth=2
  au BufNewFile,BufRead *.coffee  set shiftwidth=2
  au BufNewFile,BufRead *.cpp     set shiftwidth=4
  au BufNewFile,BufRead *.css     set shiftwidth=2
  au BufNewFile,BufRead *.h       set shiftwidth=4
  au BufNewFile,BufRead *.haml    set shiftwidth=2
  au BufNewFile,BufRead *.hs      set shiftwidth=2
  au BufNewFile,BufRead *.html    set shiftwidth=2
  au BufNewFile,BufRead *.java    set shiftwidth=4
  au BufNewFile,BufRead *.js      set shiftwidth=2
  au BufNewFile,BufRead *.json    set shiftwidth=2
  au BufNewFile,BufRead *.less    set shiftwidth=2
  au BufNewFile,BufRead *.m       set shiftwidth=4
  au BufNewFile,BufRead *.md      set shiftwidth=2
  au BufNewFile,BufRead *.py      set shiftwidth=4
  au BufNewFile,BufRead *.rb      set shiftwidth=2
  au BufNewFile,BufRead *.rc      set shiftwidth=2
  au BufNewFile,BufRead *.rs      set shiftwidth=4
  au BufNewFile,BufRead *.scala   set shiftwidth=2
  au BufNewFile,BufRead *.scss    set shiftwidth=2
  au BufNewFile,BufRead *.sh      set shiftwidth=2
  au BufNewFile,BufRead *.slim    set shiftwidth=2
  au BufNewFile,BufRead *.toml    set shiftwidth=4
  au BufNewFile,BufRead *.xml     set shiftwidth=2
  au BufNewFile,BufRead *.yaml    set shiftwidth=2
  au BufNewFile,BufRead *.yml     set shiftwidth=2
  au BufNewFile,BufRead Berksfile set shiftwidth=2
  au BufNewFile,BufRead Guardfile set shiftwidth=2
  au BufNewFile,BufRead Gemfile*  set shiftwidth=2
  au BufNewFile,BufRead requirements.txt set filetype=py
augroup END
