set nocompatible
filetype off

""""""""""""""""""""""""""""""""""" Plugins """"""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
set shell=/bin/bash
call vundle#begin()
Plugin 'gmarik/vundle'

" Navigation/Display
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-bufferline'
Plugin 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'jellybeans' }
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|bin)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

Plugin 'mbbill/undotree'
let g:undotree_HighlightChangedText = 0

" DVCS
Plugin 'mhinz/vim-signify'

" Vimprj
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'

" Misc. utilities
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'junegunn/vim-easy-align'

" Plugin 'Valloric/YouCompleteMe'

" Syntax-ish things
Plugin 'scrooloose/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'

let g:syntastic_cpp_include_dirs = ["/usr/include/qt4/QtGui"]
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:ycm_confirm_extra_conf = 0

Plugin 'digitaltoad/vim-jade'
Plugin 'pangloss/vim-javascript'
Plugin 'eagletmt/ghc-mod'
Plugin 'wting/rust.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'tpope/vim-markdown'
" Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

set lazyredraw
set laststatus=2

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
  set ttymouse=xterm2
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

" Italics
hi Comment cterm=italic ctermfg=blue
set t_ZH=[3m
set t_ZR=\[23m


"""""""""""""""""""""""""""""" Filetype Settings """""""""""""""""""""""""""""""

syntax enable

autocmd Filetype html       setlocal ts=4 sw=4 sts=4
autocmd Filetype javascript setlocal ts=4 sw=4 sts=4
autocmd Filetype jade       setlocal ts=2 sw=2 sts=2

" compile .tex on save, clean directory on exit
autocmd BufWritePost *.tex !pdflatex "<afile>"
autocmd VimLeave *.tex !rm *.log *.aux

""""""""""""""""""""""""""""""""" Custom remaps """"""""""""""""""""""""""""""""
nnoremap <space> :noh<cr>
nnoremap <CR> o<ESC>k

map <F1> :W<CR>
map <F2> :set paste!<CR>
map <F3> :UndotreeToggle<CR>
map <F4> :NERDTreeToggle<CR>
vmap <Enter> <Plug>(EasyAlign)

" clear terminal screen
map <F5> :!reset<CR><CR>

" put selection in math mode for latex
xmap m S$

" Y to yank to end of line
nnoremap Y y$

" map j gj
" map k gk

""""""""""""""""""""""""""""""""""" Commands """""""""""""""""""""""""""""""""""
command W w|copen|make
