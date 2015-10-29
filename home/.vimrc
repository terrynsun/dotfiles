set nocompatible
filetype off

""""""""""""""""""""""""""""""""""" Plugins """"""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
set shell=/bin/bash
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

""""""" Navigation
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/a.vim'

Plugin 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'component': {
    \   'readonly': '%{&readonly?"⭤":""}',
    \     }
    \ }

Plugin 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|bin|build|_build)$',
  \ 'file': '\v\.(exe|so|dll|class|o)$',
  \ }

Plugin 'mbbill/undotree'
let g:undotree_HighlightChangedText = 0

Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'

""""""" Display
Plugin 'altercation/vim-colors-solarized'

""""""" DVCS
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

""""""" Misc. utilities
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-sleuth'
runtime! Plugin 'tpope/vim-sensible' " load early so I can override settings
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'junegunn/vim-easy-align'

"""""" Syntax and Syntax-ish things
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/syntastic'
" Plugin 'octol/vim-cpp-enhanced-highlight'

let g:syntastic_cpp_compiler = 'clang'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_mode_map = {
\   "mode": "active",
\   "passive_filetypes": [ "scala" ]
\   }
let g:syntastic_always_populate_loc_list = 1

" Plugin 'Valloric/YouCompleteMe'

"""""" Language Specific
Plugin 'pangloss/vim-javascript'
Plugin 'wookiehangover/jshint.vim'
let JSHintUpdateWriteOnly=1
Plugin 'wting/rust.vim'
Plugin 'tpope/vim-markdown'
Plugin 'beyondmarc/glsl.vim'

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

set lazyredraw
set laststatus=2
set noshowmode

""""""""""""""""""""""""""""" General Vim Settings """""""""""""""""""""""""""""

set ruler
set showcmd

" Tab stuff
set autoindent smartindent         " copy indent to nl; autoindent on nl
set expandtab smarttab             " tabs set to spaces; backspace by tabstop
set ts=4 sw=4 sts=4                " tab lengths - default 4
set shiftround                     " round to nearest tabstop of spaces

" Numbering
set number                         " line numbering
set tw=80 cc=81 wrap               " line wrap (input/display), color column
set scrolloff=4                    " 4 line buffer above/below

" Search options
set incsearch hlsearch showmatch   " improve search display
set ignorecase smartcase           " search case options

set noerrorbells

if has('mouse')
  set mouse=a
  set mousemodel=extend
  if !has('nvim')
    set ttymouse=xterm2
  endif
endif

" Save undo tree
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undolevels=10000

" List training whitespace
set list listchars=tab:»\ ,trail:·

" Splitting on the proper side
set splitbelow splitright

" Fast escape (neovim)
if has('nvim')
    set ttimeout
    set ttimeoutlen=-1
endif

"""""""""""""""""""""""""""""" Filetype Settings """""""""""""""""""""""""""""""

syntax enable
colorscheme solarized

" compile .tex on save, clean directory on exit
"autocmd BufWritePost *.tex !pdflatex "<afile>"
autocmd BufWritePost *.tex !pdflatex -interaction=nonstopmode -halt-on-error "<afile>"

autocmd VimEnter *.tex set conceallevel=0
autocmd VimEnter *.md set conceallevel=0

autocmd VimLeave *.tex !rm *.log *.aux

""""""""""""""""""""""""""""""""" Custom remaps """"""""""""""""""""""""""""""""
nnoremap <space> :noh<cr>
nnoremap <CR> o<ESC>k

map <F2> :set paste!<CR>
map <F3> :UndotreeToggle<CR>
map <F4> :SyntasticCheck<CR>

" clear terminal screen
map <F5> :!reset<CR><CR>

map <F11> :Sex<CR>
map <F12> :NERDTree<CR>

vmap <Enter> <Plug>(EasyAlign)

" put selection in math mode for latex
xmap m S$

" Y to yank to end of line
nnoremap Y y$

" use global clipboard
set clipboard=unnamed,unnamedplus

if has('nvim')
    nnoremap <Leader>m :rightbelow vertical split <bar> :term make<cr>
endif

""""""""""""""""""""""""""""""""""" Commands """""""""""""""""""""""""""""""""""
command W wall|Make

function! WriteSmall()
    let mtime = system("date -d @`stat -c %Y ".shellescape(expand('%:p')) . "`")
    write
    call system("touch --date='".mtime."' ".shellescape(expand('%:p')))
endfunction
map <F6> :call WriteSmall()<CR>
