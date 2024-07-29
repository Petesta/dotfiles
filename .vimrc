""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ██████╗░░█████╗░
" ██╔══██╗██╔══██╗
" ██████╔╝██║░░╚═╝
" ██╔═══╝░██║░░██╗
" ██║░░░░░╚█████╔╝
" ╚═╝░░░░░░╚════╝░
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Pete Cruz
" Description: Some pretty chill stuff here
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

" Enable matching braces
set showmatch

" Add matchpairs
set matchpairs+=<:>

" Completeopt
set completeopt=menuone,menu,preview,longest

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

" Enable line number
set number

" Enable relative number
set relativenumber

" Show position in file
set ruler

" Show title
set title

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileFormat:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set fileformat
set fileformat=unix

" Set fileformats
set fileformats=unix,dos,mac

" Match
match Error /\%>80c/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev fro for
iabbrev improt import
iabbrev wiht with

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
let mapleader="\<space>"

" Toggle Lex
nnoremap <leader>l :Lex<cr>

" Toggle paste
nnoremap <leader>p :set paste!<cr>

" Switch line with proceeding
nnoremap - yyddp
" Switch line with preceeding
nnoremap _ yydd2jp

" Switch between buffers
nnoremap <leader>e gt
nnoremap <leader>q gT

" Open files
nnoremap <leader>v :split $MYVIMRC<cr>
nnoremap <leader>b :split ~/.bashrc<cr>
nnoremap <leader>z :split ~/.zshrc<cr>

if has('mouse')
  " Enable scrolling
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

" Wildmode
if exists('&wildmode')
  set wildmode=list:longest,full
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IgnoreSearch:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('wildignore')
  set wildignore+=.DS_Store
  set wildignore+=*.bak,*.exe
  set wildignore+=*.bmp,*.docx,*.jpg,*.jpeg,*.gif,*.pdf,*.png
  set wildignore+=*.py[co],*.so,*.sw[op],*.beam,*.class,*.jar,*.zip,*~
endif

" Enable smoothscroll
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

  " Auto-resize splits
  autocmd! VimResized * wincmd =

  " Source .vimrc on save
  autocmd! BufWritePost .vimrc source $MYVIMRC

  augroup highlight_keywords
    autocmd!
    autocmd BufWinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|NOTE\|XXX', -1)
    autocmd BufWinEnter,VimEnter * :silent! call matchadd('Debug', 'Debug\|NOTICE', -1)
    autocmd BufWinEnter,VimEnter * :silent! call matchadd('Error', 'Error\|FATAL', -1)
  augroup END

  if has('&omnifunc')
    augroup ft_omnifunc
      autocmd!
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END
  endif

  augroup append_semi_colon
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.cpp,*.erl,*.go,*.java,*.js,*.rs nnoremap <buffer> <c-;> <esc>;
  augroup END

  augroup spell_check
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=en_us
    autocmd FileType gitcommit,mail setlocal spell spelllang=en_us
  augroup END

  augroup ft_c
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.h setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_cpp
    autocmd!
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_csharp
    autocmd!
    autocmd BufNewFile,BufRead *.cs setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_erlang
    autocmd!
    autocmd BufNewFile,BufRead *.erl setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.erl nnoremap <buffer> <c-.> <end>.
  augroup END

  augroup ft_go
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  augroup END

  augroup ft_haskell
    autocmd!
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=4 shiftwidth=4
    autocmd FileType haskell nnoremap <buffer> <leader>i iimport <esc>
  augroup END

  augroup ft_java
    autocmd!
    autocmd BufNewFile,BufRead *.java setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.java nnoremap <buffer> <leader>i iimport ;<esc>
  augroup END

  augroup ft_json
    autocmd!
    autocmd BufNewFile,BufRead .*-json,.*_json set filetype=json
  augroup END

  augroup ft_kotlin
    autocmd!
    autocmd BufNewFile,BufRead *.kt setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_markdown
    autocmd!
    autocmd FileType markdown setlocal colorscheme newsprint
  augroup END

  augroup ft_ocaml
    autocmd!
    autocmd BufNewFile,BufRead *.ml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_perl
    autocmd!
    autocmd BufNewFile,BufRead *.pl nnoremap <buffer> <leader>p i#!/usr/bin/env perl<esc>
  augroup END

  augroup ft_php
    autocmd!
    autocmd BufWinEnter *.php setlocal matchpairs-=<:>
  augroup END

  augroup ft_python
    autocmd!
    autocmd BufNewFile,BufRead .python-version set filetype=python
    autocmd BufNewFile,BufRead requirements-*.txt,requirements_*.txt set filetype=python
    autocmd FileType python nnoremap <buffer> <leader>p i#!/usr/bin/env python<esc>
    autocmd FileType python nnoremap <buffer> <leader># -*- encoding: utf-8 -*-<esc>
    autocmd FileType python nnoremap <buffer> <leader>i iimport ""<esc>
  augroup END

  augroup ft_ruby
    autocmd!
    autocmd BufNewFile,BufRead .gemrc set filetype=ruby
    autocmd BufNewFile,BufRead .ruby-version set filetype=ruby
    autocmd BufNewFile,BufRead *.slim set filetype=eruby
    autocmd BufNewFile,BufRead Appfile set filetype=ruby
    autocmd BufNewFile,BufRead Fastfile set filetype=ruby
    autocmd BufNewFile,BufRead Podfile set filetype=ruby
    autocmd BufNewFile,BufRead Gemfile.lock set filetype=ruby
    autocmd BufNewFile,BufRead *.ruby nnoremap <buffer> <leader>p i#!/usr/bin/env ruby<esc>
    autocmd BufNewFile,BufRead *.ruby nnoremap <buffer> <leader>r irequire ""<esc>
  augroup END

  augroup ft_rust
    autocmd!
    autocmd BufNewFile,BufRead *.rust,*.toml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_scala
    autocmd!
    autocmd BufNewFile,BufRead *.scala nnoremap <buffer> <leader>i iimport ;<esc>
  augroup END

  augroup ft_sh
    autocmd!
    autocmd BufNewFile,BufRead .* set filetype=sh
    autocmd BufNewFile,BufRead *.sh nnoremap <buffer> <leader>p i#!/usr/bin/env bash<esc>
  augroup END

  augroup ft_xml
    autocmd!
    autocmd BufNewFile,BufRead *.xml setlocal tabstop=4 shiftwidth=4
  augroup END
endif
