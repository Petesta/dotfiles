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

" Jump to a Vim tab position
for i in range(1,9)
  execute "nnoremap <leader>".i." ".i."gt"
endfor

" Move Vim tab to a different position
for i in range(1,9)
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

" Opens up Github page
noremap <silent> cp :let @" = expand("%")<cr>

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

" NERDTree Config
autocmd VimEnter * if &filetype !=# "haskell" && &filetype !=# "python" && &filetype !=# "ruby" | NERDTree | endif
autocmd VimEnter * wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore = ["\.pyc$", "\.class$", "\.o$"]
map  <leader>t :NERDTreeToggle<cr>
nmap <leader>w <c-w>w
nmap <leader>e gt
nmap <leader>q gT

" Vim Dispatch
map <leader>rc "ayi"
map <leader>c :copen<cr>
map <leader>R :Dispatch ruby % -n /'<C-R>a'/<cr>
map <leader>r :Dispatch ruby %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Custom Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:match_base = ':match poi '
let g:lines = []

function! MakeMatch()
  highlight poi ctermbg=darkred guibg='#004f27' guifg='#ffcc00'

  let g:build_string = g:match_base
  let c = 0
  for i in g:lines
    let c += 1
    if c == 1
      let g:build_string = g:build_string.'/\%'.string(i).'l'
    else
      let g:build_string = g:build_string.'\%'.string(i).'l'
    endif
    if c == len(g:lines)
      let g:build_string = g:build_string.'/'
    else
      let g:build_string = g:build_string.'\|'
    endif
  endfor
  execute g:build_string
endfunction

function! AddLine(...)
  " Weird bug with highlight not getting called in MakeMatch
  highlight poi ctermbg=darkred guibg='#004f27' guifg='#ffcc00'

  if a:1 == 0
    let g:line_num = line('.')
  else
    let g:line_num = a:1
  endif
  let add = 1
  let dup_ind = 99
  let c = 0
  for i in g:lines
    if g:line_num == i
      let add = 0
      let dup_ind = c
    endif
    let c += 1
  endfor

  if add == 1
    let g:lines += [g:line_num]
  else
    if dup_ind != 99
      call remove(g:lines, dup_ind)
    endif
  endif
  call MakeMatch()
endfunction

function! AddRange() range
  let start = a:firstline
  let end = a:lastline

  while start <= end
    call AddLine(eval(start))
    let start += 1
  endwhile
endfunction

" Bug with some colorschemes reloading highlights
vnoremap <leader>h :call AddRange()<cr>
nnoremap <leader>h :call AddLine(line('.'))<cr>

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
