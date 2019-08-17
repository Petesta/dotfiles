""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Pete Cruz's Vim Configuration
"
"                         Some pretty chill stuff here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable compatibility
set nocompatible

" Enable syntax highlighting
syntax on

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
set mouse=a

" Show position in file
set ruler

" Show title
set title

" Enable flashing of error
set visualbell

" Don’t create backups when editing files in certain directories
set backupskip=/private/tmp/*,/tmp/*
