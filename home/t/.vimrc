set nocompatible
filetype off

""""""""""""""""""""""""""""""""""" Plugins """"""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
set shell=/bin/bash
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"------------
" Navigation
"------------
Plugin 'christoomey/vim-tmux-navigator'

Plugin 'itchyny/lightline.vim'
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \   },
  \   'component': {
  \     'readonly': '%{&readonly?"x":""}',
  \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
  \   }
  \ }

let g:ctrlp_max_files = 0
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](_site|\.(git|hg|svn|bin|build|_build)|build|cmake-build-debug)$',
  \ 'file': '\v\.(exe|so|dll|class|o)$',
  \ }

" <F3>
Plugin 'mbbill/undotree'
let g:undotree_HighlightChangedText = 0

" <F12>
Plugin 'scrooloose/nerdtree'

"------------
" Display
"------------
"Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/indentLine'

"------------
" git
"------------
Plugin 'airblade/vim-gitgutter'
autocmd BufWritePost * GitGutter
Plugin 'tpope/vim-fugitive'

"------------
" Utilities
"------------
runtime! Plugin 'tpope/vim-sensible' " load early so I can override settings

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'            " try to automatically set tab length
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-speeddating'       " fix increment for dates

" <Enter>
Plugin 'junegunn/vim-easy-align'

" select block and C-A or C-X
Plugin 'triglav/vim-visual-increment'

"------------
" Syntax
"------------

"Plugin 'ervandew/supertab'

"-------------------
" Language-Specific
"-------------------

" Use :A to switch .c <-> .h
Plugin 'vim-scripts/a.vim'

Plugin 'pangloss/vim-javascript'
"Plugin 'wookiehangover/jshint.vim'
"let JSHintUpdateWriteOnly=1

Plugin 'rust-lang/rust.vim'

Plugin 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['rust']

"Plugin 'saltstack/salt-vim'
"Plugin 'chr4/nginx.vim'

"Plugin 'lervag/vimtex'
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'beyondmarc/glsl.vim'

"Plugin 'def-lkb/vimbufsync'
"Plugin 'the-lambda-church/coquille'

"Plugin 'vim-ruby/vim-ruby'
"Plugin 'derekwyatt/vim-scala'
"Plugin 'eagletmt/ghc-mod'
"Plugin 'digitaltoad/vim-jade'

" Ocaml-Merlin
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"
" let g:syntastic_ocaml_checkers = ['merlin']

call vundle#end()
filetype plugin indent on

"-------------------
" Lightline Config
"-------------------

set lazyredraw
set laststatus=2
set noshowmode

"""""""""""""""""""""""""""" General Vim Settings """"""""""""""""""""""""""""

set ruler
set showcmd

" Tab stuff
set autoindent smartindent         " copy indent to nl; autoindent on nl
set expandtab smarttab             " tabs set to spaces; backspace by tabstop
set ts=4 sw=4 sts=4                " tab lengths - default 4 [usually overriden]
set shiftround                     " round to nearest tabstop of spaces

" Numbering
set number                         " line numbering
set tw=80 cc=81 wrap linebreak     " line wrap (input/display), color column
set scrolloff=4                    " 4 line buffer above/below

" Search options
set incsearch hlsearch showmatch   " improve search display
set ignorecase smartcase           " search case options

set foldmethod=syntax
set foldlevel=100

set noerrorbells

set nofixendofline                 " stop adding trailing newlines
set list listchars=tab:»\ ,trail:· " display trailing whitespace
set splitbelow splitright          " open new splits to the bottom and right
set nojoinspaces                   " don't append lines (J) with spaces

set clipboard=unnamed,unnamedplus  " use global clipboard

" Save undo tree to undodir
set undofile
set undodir=~/.vim/undo
set undolevels=10000

" Terminal settings
if has('mouse')
  set mouse=a
  set mousemodel=extend
  if !has('nvim')
    set ttymouse=xterm2
  endif
endif

" Fast escape (neovim)
if has('nvim')
    set ttimeout
    set ttimeoutlen=-1
endif

""""""""""""""""""""""""""""" Filetype Settings """"""""""""""""""""""""""""""

syntax enable
set background=light
"colorscheme solarized

" Misc
autocmd BufNewFile,BufRead *.sage set filetype=python

autocmd BufEnter,BufNewFile *.rs set cc=101

" Conceallevel fix for some filetypes
autocmd BufEnter *.tex set conceallevel=0
autocmd BufEnter *.md set conceallevel=0
autocmd BufEnter *.json set conceallevel=0

" LaTeX
" compile on save
"autocmd BufWritePost *.tex !pdflatex "<afile>"
"autocmd BufWritePost *.tex !pdflatex -interaction=nonstopmode -halt-on-error "<afile>"
"autocmd VimLeave *.tex !rm *.log *.aux

au FileType tex nnoremap j gj
au FileType tex nnoremap k gk
autocmd BufEnter *.tex set tw=100 cc=100

"""""""""""""""""""""""""""""""" Custom remaps """""""""""""""""""""""""""""""
" stop search highlighting
nnoremap <space> :noh<cr>
" enter newline
nnoremap <CR> o<ESC>k

map <F2> :Gblame<CR>
map <F3> :UndotreeToggle<CR>
map <F4> :SyntasticCheck<CR>

" clear terminal screen
map <F5> :!reset<CR><CR>

map <F12> :NERDTreeToggle<CR>

vmap <Enter> <Plug>(EasyAlign)

" tex: put selection in math mode
xmap m S$

"""""""""""""""""""""""""""""""""" Commands """"""""""""""""""""""""""""""""""
command W w
