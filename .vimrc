""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Pete Cruz's Vim Configuration
"
"                         Some pretty chill stuff here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable compatibility
set nocompatible

" Enable syntax highlighting
syntax on

" Enable colorscheme
colorscheme koehler

" Enable autoread of files changed externally
set autoread

" Fix backspace issue in insert mode
set backspace=indent,eol,start

" Disable case sensitivity for searches
set ignorecase

" Enable highlighting of matching strings
set hlsearch

" Show matching braces
set showmatch

" Enable horizontal cursor
set cursorline

" Enable vertical cursor
set cursorcolumn

" Indentation
set autoindent
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2

" Make tabs as wide as two spaces
set tabstop=2

set lazyredraw

" Optimize for fast terminal connections
set ttyfast

" Show line number
set number

" Enable scrolling
if has('mouse')
  set mouse=a
endif

" Show position in file
set ruler

" Show title
set title

" Highlight matching strings
set hlsearch

" Show matching braces
set showmatch

" Enable flashing of error
set visualbell

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/

set t_Co=256

augroup FileTypes
  au!
  au BufNewFile,BufRead *.c       set shiftwidth=4
  au BufNewFile,BufRead *.clj     set shiftwidth=2
  au BufNewFile,BufRead *.cpp     set shiftwidth=4
  au BufNewFile,BufRead *.cs      set shiftwidth=4
  au BufNewFile,BufRead *.css     set shiftwidth=2
  au BufNewFile,BufRead *.h       set shiftwidth=4
  au BufNewFile,BufRead *.haml    set shiftwidth=2
  au BufNewFile,BufRead *.hs      set shiftwidth=2
  au BufNewFile,BufRead *.html    set shiftwidth=2
  au BufNewFile,BufRead *.java    set shiftwidth=4
  au BufNewFile,BufRead *.js      set shiftwidth=4
  au BufNewFile,BufRead *.json    set shiftwidth=2
  au BufNewFile,BufRead *.less    set shiftwidth=2
  au BufNewFile,BufRead *.md      set shiftwidth=2
  au BufNewFile,BufRead *.py      set shiftwidth=4
  au BufNewFile,BufRead *.rb      set shiftwidth=2
  au BufNewFile,BufRead *.rs      set shiftwidth=4
  au BufNewFile,BufRead *.scala   set shiftwidth=2
  au BufNewFile,BufRead *.scss    set shiftwidth=2
  au BufNewFile,BufRead *.sh      set shiftwidth=2
  au BufNewFile,BufRead *.slim    set shiftwidth=2
  au BufNewFile,BufRead *.swift   set shiftwidth=4
  au BufNewFile,BufRead *.toml    set shiftwidth=4
  au BufNewFile,BufRead *.ts      set shiftwidth=2
  au BufNewFile,BufRead *.xml     set shiftwidth=4
  au BufNewFile,BufRead *.yaml    set shiftwidth=2
  au BufNewFile,BufRead *.yml     set shiftwidth=2
  au BufNewFile,BufRead Berksfile set shiftwidth=2
  au BufNewFile,BufRead Guardfile set shiftwidth=2
  au BufNewFile,BufRead Gemfile*  set shiftwidth=2
augroup END
