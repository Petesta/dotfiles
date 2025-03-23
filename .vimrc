"===============================================================================
" ██████╗░░█████╗░
" ██╔══██╗██╔══██╗
" ██████╔╝██║░░╚═╝
" ██╔═══╝░██║░░██╗
" ██║░░░░░╚█████╔╝
" ╚═╝░░░░░░╚════╝░
"===============================================================================
" Author: Pete Cruz
" Description: Some pretty chill stuff here
"===============================================================================

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

set smartcase

" Enable matching braces
set showmatch

" Add matchpairs
set matchpairs+=<:>

" Completeopt
set completeopt=menuone,menu,preview,longest

"===============================================================================
" Indentation:
"===============================================================================
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

"===============================================================================
" FileFormat:
"===============================================================================
" Set fileformat
set fileformat=unix

" Set fileformats
set fileformats=unix,dos,mac

" Match
match Error /\%>80c/

"===============================================================================
" Abbreviations:
"===============================================================================
iabbrev fro for
iabbrev improt import
iabbrev wiht with

"===============================================================================
" Mappings:
"===============================================================================
" Disable arrow keys
nnoremap <Up>    :echo "no arrow keys in vim :)" <Esc>
nnoremap <Down>  :echo "no arrow keys in vim :)" <Esc>
nnoremap <Left>  :echo "no arrow keys in vim :)" <Esc>
nnoremap <Right> :echo "no arrow keys in vim :)" <Esc>
inoremap <Up>    :echo "no arrow keys in vim :)" <Esc>
inoremap <Down>  :echo "no arrow keys in vim :)" <Esc>
inoremap <Left>  :echo "no arrow keys in vim :)" <Esc>
inoremap <Right> :echo "no arrow keys in vim :)" <Esc>

" Navigate around splits
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Leader key
let mapleader="\<Space>"

" Toggle Lex
nnoremap <Leader>l :Lex<CR>

" Toggle paste
nnoremap <Leader>p :set paste!<CR>

" Switch line with proceeding
nnoremap - yyddp
" Switch line with preceeding
nnoremap _ yydd2jp

" Switch between buffers
nnoremap <Leader>e gt
nnoremap <Leader>q gT

" Jump to buffer position
for i in range(1, 9)
  execute "nnoremap <Leader>" . i . " " . i . "gt"
endfor

" Open files
nnoremap <Leader>v :split $MYVIMRC<Cr>
nnoremap <Leader>b :split ~/.bashrc<Cr>
nnoremap <Leader>z :split ~/.zshrc<Cr>

" Default grep search to ack
if has('mac')
  if executable('ack')
    set grepprg='ack -k'
  endif
elseif has('unix')
  if executable('ack-grep')
    set grepprg='ack-grep -k'
  endif
endif

if has('mouse')
  " Enable scrolling
  set mouse=a
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

"===============================================================================
" IgnoreSearch:
"===============================================================================
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

"===============================================================================
" Autocommands:
"===============================================================================
if has('autocmd')
  if has('syntax')
    " Toggled horizontal and vertical cursors
    augroup cursors_toggled
      autocmd!
      autocmd WinEnter * set cursorline cursorcolumn
      autocmd WinLeave * set nocursorline nocursorcolumn
    augroup END

    highlight CursorLine cterm=bold
  endif

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
    augroup enable_omnifunc
      autocmd!
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END
  endif

  if has('persistent_undo')
    augroup no_undofile
      autocmd!
      autocmd BufWritePre /tmp/* setlocal noundofile
      autocmd BufWritePre COMMIT_EDITMSG setlocal noundofile
      autocmd BufWritePre MERGE_MSG setlocal noundofile
      autocmd BufWritePre *.log setlocal noundofile
      autocmd BufWritePre *.tmp setlocal noundofile
    augroup END
  endif

  augroup append_semi_colon
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.cpp,*.erl,*.go,*.java,*.js,*.rs nnoremap <buffer> <c-;> <end>;
  augroup END

  augroup spell_check
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=en_us
    autocmd FileType gitcommit,mail setlocal spell spelllang=en_us
  augroup END

  augroup ft_makefile
    autocmd!
    autocmd BufNewFile,BufRead Makefile setlocal noexpandtab tabstop=8 shiftwidth=8
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
    autocmd BufNewFile,BufRead *.erl nnoremap <buffer> <C-.> <End>.
  augroup END

  augroup ft_gleam
    autocmd!
    autocmd BufNewFile,BufRead *.gleam set filetype=gleam
  augroup END

  augroup ft_go
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  augroup END

  augroup ft_haskell
    autocmd!
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_java
    autocmd!
    autocmd BufNewFile,BufRead *.java setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_json
    autocmd!
    autocmd BufNewFile,BufRead .*-json,.*_json set filetype=json
    " <F9> Format json
    autocmd FileType json nnoremap <buffer> <F9> :%!python -m json.tool<CR>
  augroup END

  augroup ft_kotlin
    autocmd!
    autocmd BufNewFile,BufRead *.kt setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_makefile
    autocmd!
    autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8
  augroup END

  augroup ft_markdown
    autocmd!
    autocmd FileType markdown setlocal silent! colorscheme newsprint
    autocmd FileType markdown nnoremap <buffer> <Leader>c i```<CR>```<Esc>
    autocmd FileType markdown nnoremap <buffer> <Leader>h i[]()<Esc>
  augroup END

  augroup ft_ocaml
    autocmd!
    autocmd BufNewFile,BufRead .ocamlformat set filetype=ocaml
    autocmd BufNewFile,BufRead *.ml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_org
    autocmd!
    autocmd FileType org nnoremap <buffer> <Leader>c i#+BEGIN_SRC<CR>#+END_SRC<Esc>
    autocmd FileType org nnoremap <buffer> <Leader>h i[[][]]<Esc>
  augroup END

  augroup ft_perl
    autocmd!
    autocmd BufNewFile,BufRead *.pl nnoremap <buffer> <Leader>s i#!/usr/bin/env perl<Esc>
  augroup END

  augroup ft_php
    autocmd!
    autocmd BufWinEnter *.php setlocal matchpairs-=<:>
  augroup END

  augroup ft_python
    autocmd!
    autocmd BufNewFile,BufRead .python-version set filetype=python
    autocmd BufNewFile,BufRead requirements-*.txt,requirements_*.txt set filetype=python
    autocmd FileType python nnoremap <buffer> <Leader>c i# -*- coding: utf-8 -*-<Esc>
    autocmd FileType python nnoremap <buffer> <Leader>s i#!/usr/bin/env python<Esc>
  augroup END

  augroup ft_ruby
    autocmd!
    autocmd BufNewFile,BufRead .gemrc set filetype=ruby
    autocmd BufNewFile,BufRead .irbrc set filetype=ruby
    autocmd BufNewFile,BufRead .ruby-version set filetype=ruby
    autocmd BufNewFile,BufRead *.slim set filetype=eruby
    autocmd BufNewFile,BufRead Appfile set filetype=ruby
    autocmd BufNewFile,BufRead Brewfile set filetype=ruby
    autocmd BufNewFile,BufRead Fastfile set filetype=ruby
    autocmd BufNewFile,BufRead Podfile set filetype=ruby
    autocmd BufNewFile,BufRead Gemfile.lock set filetype=ruby
    autocmd BufNewFile,BufRead *.ruby nnoremap <buffer> <Leader>s i#!/usr/bin/env ruby<Esc>
  augroup END

  augroup ft_rust
    autocmd!
    autocmd BufNewFile,BufRead *.rust,*.toml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_sh
    autocmd!
    autocmd BufNewFile,BufRead .* set filetype=sh
    autocmd BufNewFile,BufRead .ripgreprc set filetype=sh
  augroup END

  augroup ft_sql
    autocmd!
    autocmd BufNewFile,BufRead .psqlrc set filetype=sql
  augroup END

  augroup ft_unison
    autocmd!
    autocmd BufNewFile,BufRead *.u set filetype=unison
  augroup END

  augroup ft_xml
    autocmd!
    autocmd BufNewFile,BufRead *.xml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_zig
    autocmd!
    autocmd BufNewFile,BufRead *.zig set filetype=zig
    autocmd BufNewFile,BufRead *.zig setlocal tabstop=4 shiftwidth=4
  augroup END
endif

"===============================================================================
" Plugins:
"===============================================================================

"-------------------------------------------------------------------------------
" Airline:
"-------------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:battery#update_tabline = 1
let g:battery#update_statusline = 1
let g:airline#extensions#battery#enabled = 1

"-------------------------------------------------------------------------------
" NERDTree:
"-------------------------------------------------------------------------------

augroup plugin_nerdtree
  autocmd!

  " Start NERDTree and put the cursor back in the other window
  autocmd VimEnter * NERDTree | wincmd p

  " Exit Vim if NERDTree is the only window remaining in the only tab
  if v:version >= 900
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
  else
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  fi
augroup END

let g:NERDTreeFileLines = 1

"-------------------------------------------------------------------------------
" CSV:
"-------------------------------------------------------------------------------
let g:csv_highlight_column = 'y'

"-------------------------------------------------------------------------------
" LSP:
"-------------------------------------------------------------------------------
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
