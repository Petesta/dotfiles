" ╔════════════════════════════════════════════════════════════════════════════╗
" ██████╗░░█████╗░                                                             ║
" ██╔══██╗██╔══██╗                                                             ║
" ██████╔╝██║░░╚═╝                                                             ║
" ██╔═══╝░██║░░██╗                                                             ║
" ██║░░░░░╚█████╔╝                                                             ║
" ╠═╝░░░░░░╚════╝░                                                             ║
" ╚════════════════════════════════════════════════════════════════════════════╝
" ╔════════════════════════════════════════════════════════════════════════════╗
" Author: Pete Cruz                                                            ║
" Description: Some pretty chill stuff here                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" Enable compatibility
if &compatible
  set nocompatible
endif

filetype plugin indent on

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

" ╔════════════════════════════════════════════════════════════════════════════╗
" Indentation:                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝
set autoindent
" Spaces no tabs
set expandtab
" Whitespace length for one indentation level
set shiftwidth=2
set smarttab
" Make tabs as wide as two spaces
set tabstop=2
set softtabstop=2

" Round misaligned indents
set shiftround

set listchars=tab:▸»,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣

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

" Show key presses
set showcmd

" Enable flashing of error
set visualbell

set history=1000

" Prepend default location of swap files
set directory^=~/.vim/directory//

if has('persistent_undo')
  " Enable undofiles
  set undofile

  " Prepend default location of undo files
  set undodir^=~/.vim/undodir//
endif

" Don’t create backups when editing files in certain directories
set backupskip=/logs/*,/node_modules/*,/tmp/*,/vendor/*

set t_Co=256

if &term =~ 'xterm'
  if $TERM_PROGRAM == 'Apple_Terminal'
    let &t_SI = '\e[5 q'
    let &t_SR = '\e[4 q'
    let &t_EI = '\e[1 q'
  elseif $TERM_PROGRAM == 'iTerm.app'
    let &t_SI = '\<Esc>]1337;CursorShape=1\x7'
    let &t_SR = '\<Esc>]1337;CursorShape=2\x7'
    let &t_EI = '\<Esc>]1337;CursorShape=0\x7'
  endif
endif

" Scroll when five lines away from margin
set scrolloff=5

" Set encoding
set encoding=utf-8

" Fix Shell syntax highlighting
let g:is_posix = 1

" Enable Postgres dialect
let g:sql_type_default = 'pgsql'

" Enable code block highlighting
let g:markdown_fenced_languages = [
  \ 'bash',
  \ 'erb=eruby',
  \ 'html',
  \ 'javascript',
  \ 'json=javascript',
  \ 'python',
  \ 'ruby',
  \ 'rust',
  \ 'xml',
  \ 'vim'
\ ]

" Enable highlighting special atoms
let g:erlang_highlight_special_atoms = 1

" ╔════════════════════════════════════════════════════════════════════════════╗
" FileFormat:                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝
" Set fileformat
set fileformat=unix

" Set fileformats
set fileformats=unix,dos,mac

" Match
match Error /\%>80c/

" ╔════════════════════════════════════════════════════════════════════════════╗
" Abbreviations:                                                               ║
" ╚════════════════════════════════════════════════════════════════════════════╝
if exists('*strftime')
  iabbrev <expr> today strftime('%Y-%m-%d')
endif

" ╔════════════════════════════════════════════════════════════════════════════╗
" Mappings:                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝
" Disable arrow keys
nnoremap <Up>    :echo "no arrow keys in vim :)" <Esc>
nnoremap <Down>  :echo "no arrow keys in vim :)" <Esc>
nnoremap <Left>  :echo "no arrow keys in vim :)" <Esc>
nnoremap <Right> :echo "no arrow keys in vim :)" <Esc>
inoremap <Up>    :echo "no arrow keys in vim :)" <Esc>
inoremap <Down>  :echo "no arrow keys in vim :)" <Esc>
inoremap <Left>  :echo "no arrow keys in vim :)" <Esc>
inoremap <Right> :echo "no arrow keys in vim :)" <Esc>

" Toggle lowercase|uppercase
nnoremap <C-t> mzg~iw`z

" Navigate splits/windows
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Resize window
nnoremap <C-S-Left> <C-w><
nnoremap <C-S-Right> <C-w>>
nnoremap <C-S-Down> <C-w>-
nnoremap <C-S-Up> <C-w>+

" Ctrl-[Rr]: Rotate window up/left and down/right
nnoremap <Leader>R <C-w>R
nnoremap <Leader>r <C-w>r

" Center screen from search pattern
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Visually reselect pasted text
nnoremap gp `[v`]

" Visually selects last modified text
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" Ctrl-[jk]: Move cursor down/up
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk

" Ctrl-[hl]: Move left/right by word
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>

" Ctrl-[ae]: Move head/tail of input
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Switch line with proceeding
nnoremap - yyddp
" Switch line with preceeding
nnoremap _ yydd2jp

" Leader key
let mapleader = '\<Space>'

" Local leader key
let maplocalleader = ','

" Visually selects block
nnoremap <Leader>v V`}

" Navigate buffer list
nnoremap <Leader>[b :bprevious<CR>
nnoremap <Leader>]b :bnext<CR>

" Navigate tabs
nnoremap <Leader>[t :tabprevious<CR>
nnoremap <Leader>]t :tabnext<CR>

" Toggle paste
nnoremap <Leader>p :set paste!<CR>

" Navigate buffers
nnoremap <Leader>e gt
nnoremap <Leader>q gT

for i in range(1, 9)
  " Jump to tab position
  execute 'nnoremap <Leader>' . i . ' ' . i . 'gt'

  " Move tab to different position
  execute 'nnoremap <Leader>m' . i . ' :tabmove ' . (i - 1) . '<CR>'
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

" ╔════════════════════════════════════════════════════════════════════════════╗
" IgnoreSearch:                                                                ║
" ╚════════════════════════════════════════════════════════════════════════════╝
if has('wildignore')
  set wildignore+=.git,.hg,.svn
  set wildignore+=.tmp
  set wildignore+=node_modules
  set wildignore+=.DS_Store
  set wildignore+=*.bmp,*.docx,*.jpg,*.jpeg,*.gif,*.pdf,*.png
  set wildignore+=*~,*.beam,*.class,*.jar,*.o,*.py[co],*.so,*.sw[op],*.zip
  set wildignore+=*.bak,*.dll,*.exe,*.so
endif

" Enable smoothscroll
if exists('&smoothscroll')
  set smoothscroll
endif

" Remove trailing whitespace
command! FixWhiteSpace :%s/\s\+$//e

" ╔════════════════════════════════════════════════════════════════════════════╗
" Autocommands:                                                                ║
" ╚════════════════════════════════════════════════════════════════════════════╝
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

  " Check if file changed and update
  augroup check_time
    autocmd!
    autocmd FocusGained * if mode() != 'c' | checktime | endif
  augroup END

  " Auto-resize splits
  augroup auto_resize_splits
    autocmd!
    autocmd! VimResized * wincmd =
  augroup END

  " Source .vimrc on save
  augroup source_vimrc
    autocmd! BufWritePost .vimrc source $MYVIMRC
  augroup END

  augroup highlight_keywords
    autocmd!
    autocmd BufWinEnter,VimEnter * :silent!
      \ call matchadd('Todo', 'TODO\|FIXME\|NOTE\|XXX', -1)
    autocmd BufWinEnter,VimEnter * :silent!
      \ call matchadd('Debug', 'DEBUG\|NOTICE', -1)
    autocmd BufWinEnter,VimEnter * :silent!
      \ call matchadd('Error', 'ERR\|ERROR\|FATAL', -1)
  augroup END

  if has('&omnifunc')
    augroup enable_omnifunc
      autocmd!
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType javascript
        \ setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END
  endif

  if has('persistent_undo')
    augroup no_undofile
      autocmd!
      autocmd BufRead,BufWritePre /logs/* setlocal noundofile
      autocmd BufRead,BufWritePre /node_modules/* setlocal noundofile
      autocmd BufRead,BufWritePre /tmp/* setlocal noundofile
      autocmd BufRead,BufWritePre COMMIT_EDITMSG setlocal noundofile
      autocmd BufRead,BufWritePre MERGE_MSG setlocal noundofile
      autocmd BufRead,BufWritePre *.log setlocal noundofile
      autocmd BufRead,BufWritePre *.tmp setlocal noundofile
    augroup END
  endif

  augroup private_mode
    autocmd!
    autocmd BufRead *
      \ if &cryptmethod != ""
        \ | setlocal nobackup nomodeline noswapfile noundofile nowritebackup secure viminfo=""
      \ | endif
  augroup END

  augroup append_semi_colon
    autocmd!
    autocmd BufNewFile,BufRead *.c,
      \*.cpp,
      \*.erl,
      \*.go,
      \*.java,
      \*.js,
      \*.rs
      \ nnoremap <buffer> <C-;> <End>;
  augroup END

  augroup remember_cursor_position
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") > 1
          \ && line("'\"") <= line("$")
          \ && &filetype !~# 'commit'
          \ && index(['gitrebase', 'tutor', 'xxd'], &filetype) == -1
        \ | execute "normal! g`\""
      \ | endif
  augroup END

  augroup spell_check
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=en_us
    autocmd FileType gitcommit,mail setlocal spell spelllang=en_us
  augroup END

  augroup ft_applescript
    autocmd!
    autocmd BufNewFile,BufRead *.scpt setlocal tabstop=4 shiftwidth=4
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

  augroup ft_helm
    autocmd!
    autocmd BufNewFile,BufRead *.{yaml,yml}
      \ if getline(1) =~ '^apiVersion:'
          \ || getline(2) =~ '^apiVersion:'
        \ | setlocal filetype=helm
      \ | endif
  augroup END

  augroup ft_java
    autocmd!
    autocmd BufNewFile,BufRead *.java setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_javascript
    autocmd!
    autocmd FileType javascript
      \ nnoremap <buffer> <LocalLeader>s i#!/usr/bin/env node<Esc>
  augroup END

  augroup ft_json
    autocmd!
    autocmd BufNewFile,BufRead .*{-json,_json} set filetype=json
    " <F9> Format json
    autocmd FileType json nnoremap <buffer> <F9> :%!python -m json.tool<CR>
  augroup END

  augroup ft_kotlin
    autocmd!
    autocmd BufNewFile,BufRead *.kt setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_makefile
    autocmd!
    autocmd BufNewFile,BufRead Makefile
      \ setlocal noexpandtab tabstop=8 shiftwidth=8
  augroup END

  augroup ft_markdown
    autocmd!
    if v:version < 740
      autocmd BufNewFile,BufRead *.md set filetype=markdown
    endif
    autocmd FileType markdown setlocal silent! colorscheme newsprint
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>c i```<CR>```<Esc>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>h i[]()<Esc>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>- m`yypVr-``
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>= m`yypVr=``
  augroup END

  augroup ft_ocaml
    autocmd!
    autocmd BufNewFile,BufRead .ocamlformat set filetype=ocaml
    autocmd BufNewFile,BufRead *.ml setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_org
    autocmd!
    autocmd FileType org
      \ nnoremap <buffer> <LocalLeader>c i#+BEGIN_SRC<CR>#+END_SRC<Esc>
    autocmd FileType org nnoremap <buffer> <LocalLeader>h i[[][]]<Esc>
  augroup END

  augroup ft_perl
    autocmd!
    autocmd BufNewFile,BufRead *.pl
      \ nnoremap <buffer> <LocalLeader>s i#!/usr/bin/env perl<Esc>
  augroup END

  augroup ft_php
    autocmd!
    autocmd BufWinEnter *.php setlocal matchpairs-=<:>
  augroup END

  augroup ft_python
    autocmd!
    autocmd BufNewFile,BufRead .python-version,
      \requirements-*.txt,
      \requirements_*.txt
      \ set filetype=python
    autocmd FileType python
      \ nnoremap <buffer> <LocalLeader>c i# -*- coding: utf-8 -*-<Esc>
    autocmd FileType python
      \ nnoremap <buffer> <LocalLeader>s i#!/usr/bin/env python<Esc>
  augroup END

  augroup ft_ruby
    autocmd!
    autocmd BufNewFile,BufRead .gemrc,
      \.irbrc,
      \.ruby-version,
      \*.slim,
      \Appfile,
      \Brewfile,
      \*.Brewfile,
      \Fastfile,
      \Podfile,
      \Gemfile.lock
      \ set filetype=ruby
    autocmd BufNewFile,BufRead *.rb
      \ nnoremap <buffer> <LocalLeader>s i#!/usr/bin/env ruby<Esc>
  augroup END

  augroup ft_rust
    autocmd!
    autocmd BufNewFile,BufRead *.{rust,toml} setlocal tabstop=4 shiftwidth=4
  augroup END

  augroup ft_sh
    autocmd!
    autocmd BufNewFile,BufRead .*,
      \.ripgreprc
      \ set filetype=sh
  augroup END

  augroup ft_swift
    autocmd!
    autocmd FileType swift
      \ nnoremap <buffer> <LocalLeader>s i#!/usr/bin/env swift<Esc>
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

" ╔════════════════════════════════════════════════════════════════════════════╗
" Plugins:                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝
if v:version >= 800
  packadd! matchit
endif

" ╭────────────────────────────────────────────────────────────────────────────╮
" Airline:                                                                     │
" ╰────────────────────────────────────────────────────────────────────────────╯
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:battery#update_tabline = 1
let g:battery#update_statusline = 1
let g:airline#extensions#battery#enabled = 1

" ╭────────────────────────────────────────────────────────────────────────────╮
" NERDTree:                                                                    │
" ╰────────────────────────────────────────────────────────────────────────────╯
augroup plugin_nerdtree
  autocmd!

  " Start NERDTree and put the cursor back in the other window
  autocmd VimEnter * NERDTree | wincmd p

  " Exit Vim if NERDTree is the only window remaining in the only tab
  if v:version >= 900
    autocmd BufEnter *
      \ if tabpagenr('$') == 1
          \ && winnr('$') == 1
          \ && exists('b:NERDTree')
          \ && b:NERDTree.isTabTree()
        \ | call feedkeys(":quit\<CR>:\<BS>")
      \ | endif
  else
    autocmd BufEnter *
      \ if tabpagenr('$') == 1
          \ && winnr('$') == 1
          \ && exists('b:NERDTree')
          \ && b:NERDTree.isTabTree()
        \ | quit
      \ | endif
  endif
augroup END

let g:NERDTreeFileLines = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = [
  \ '\~$',
  \ '\.DS_Store$',
  \ '\.bak$',
  \ '\.beam$',
  \ '\.class$',
  \ '\.dll$',
  \ '\.exe$',
  \ '\.git$',
  \ '\.jar$',
  \ '\.o$',
  \ '\.py[co]$',
  \ '\.so$',
  \ '\.sw[op]$'
\ ]

" ╭────────────────────────────────────────────────────────────────────────────╮
" CSV:                                                                         │
" ╰────────────────────────────────────────────────────────────────────────────╯
let g:csv_highlight_column = 'y'

" ╭────────────────────────────────────────────────────────────────────────────╮
" LSP:                                                                         │
" ╰────────────────────────────────────────────────────────────────────────────╯
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

  nnoremap <buffer> gd <plug>(lsp-definition)
  nnoremap <buffer> gs <plug>(lsp-document-symbol-search)
  nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nnoremap <buffer> gr <plug>(lsp-references)
  nnoremap <buffer> gi <plug>(lsp-implementation)
  nnoremap <buffer> gt <plug>(lsp-type-definition)
  nnoremap <buffer> <leader>rn <plug>(lsp-rename)
  nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
  nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
  nnoremap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

  let g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  autocmd!
  " NOTE: Call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Enable LSP hover
augroup enable_lsp_hover
  autocmd!
  autocmd FileType python autocmd CursorHold,CursorHoldI <buffer> LspHover
augroup END

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

if filereadable(expand('~/.vim/custom.vim'))
  source ~/.vim/custom.vim
endif
