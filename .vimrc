""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Pete Cruz's Vim Configuration
"
"                         Some pretty chill stuff here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable compatibility
if &compatible
  set nocompatible
endif

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

" Show matching braces
set showmatch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set expandtab
set shiftwidth=2
set smarttab
" Make tabs as wide as two spaces
set tabstop=2
set softtabstop=2

" Don't redraw while executing macros
set lazyredraw

" Optimize for fast terminal connections
set ttyfast

" Show line number
set number

" Show relative number
set relativenumber

" Show position in file
set ruler

" Show title
set title

" Show matching braces
set showmatch

" Enable flashing of error
set visualbell

" Don’t create backups when editing files in certain directories
set backupskip=/logs/*,/tmp/*,/vendor/*

set t_Co=256

if &term =~ 'xterm'
  if $TERM_PROGRAM == 'Apple_Terminal'
    let &t_SI = '\e[5 q'
    let &t_SR = '\e[4 q'
    let &t_EI = '\e[1 q'
  elseif $TERM_PROGRAM == 'iTerm.app'
    let &t_SI = '\<Esc>]50;CursorShape=1\x7'
    let &t_SR = '\<Esc>]50;CursorShape=2\x7'
    let &t_EI = '\<Esc>]50;CursorShape=0\x7'
  endif
endif

" Scroll when five lines away from margin
set scrolloff=5

" Set encoding
set encoding=utf-8

" Set fileformat
set fileformat=unix

" Set fileformats
set fileformats=unix,dos,mac

" Match
match Error /\%>80c/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
iabbrev fro for
iabbrev improt import
iabbrev wiht with

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
let mapleader='\<space>'

" Toggle Lex
nnoremap <leader>l :Lex<cr>

" Toggle paste
nnoremap <leader>p :set paste!<cr>

nnoremap - yyddp
nnoremap _ yydd2jp
inoremap " ""<esc>i

" Switch between buffers
nnoremap <leader>e gt
nnoremap <leader>q gT

" Open files
nnoremap <leader>v :split $MYVIMRC<cr>
nnoremap <leader>b :split ~/.bashrc<cr>
nnoremap <leader>z :split ~/.zshrc<cr>

" Enable scrolling
if has('mouse')
  set mouse=a
endif

if has('syntax')
  " Enable horizontal cursor
  set cursorline

  " Enable vertical cursor
  set cursorcolumn
endif

" Extra search
if has('extra_search')
  " Enable highlighting of matching strings
  set hlsearch
  set incsearch
endif

" Wildmenu
if has('wildmenu')
  set wildmenu
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IgnoreSearch:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('wildignore')
  set wildignore+=*.docx,*.jpg,*.gif,*.pdf,*.png
  set wildignore+=*.py[co],*.so,*.sw[op],*.class,*.jar,*.zip,*~
endif

if exists('&smoothscroll')
  set smoothscroll
endif

" Remove trailing whitespace
command! FixWhiteSpace :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('autocmd')
  " Highlight trailing whitespace
  highlight TrailingWhitespace ctermbg=red guibg=red
  match TrailingWhitespace /\s\+$/
  augroup TrailingWhitespaceGroup
    autocmd!
    autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
    autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match TrailingWhitespace /\s\+$/
  augroup END

  autocmd! BufWritePost .vimrc source $MYVIMRC

  augroup HighlightKeywords
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|NOTE\|XXX', -1)
  augroup END

  augroup SpellCheck
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=en_us
  augroup END

  augroup FT_C
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.h setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup FT_CPP
    autocmd!
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup FT_GO
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  augroup END

  augroup FT_HASKELL
    autocmd!
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup FT_JAVA
    autocmd!
    autocmd FileType java nnoremap <buffer> <leader>i iimport <esc>
    autocmd BufNewFile,BufRead *.java setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup FT_PYTHON
    autocmd!
    autocmd FileType python nnoremap <buffer> <leader>i iimport ""<esc>
    autocmd FileType python nnoremap <buffer> <leader>p i#!/usr/bin/env python<esc>
  augroup END

  augroup FT_RUBY
    autocmd!
    autocmd FileType ruby nnoremap <buffer> <leader>r irequire ""<esc>
    autocmd FileType ruby nnoremap <buffer> <leader>p i#!/usr/bin/env ruby<esc>
  augroup END

  augroup FT_RUST
    autocmd!
    autocmd BufNewFile,BufRead *.rust,*.toml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup FT_SH
    autocmd!
    autocmd BufNewFile,BufRead .* set filetype=sh
    autocmd FileType shell nnoremap <buffer> <leader>p i#!/usr/bin/env bash<esc>
  augroup END
endif
