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
Plugin 'maximbaz/lightline-ale'

let g:lightline#ale#indicator_checking = '...'
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':  [ [ 'mode', 'paste' ],
  \                [ 'gitbranch', 'gitpath',
  \                  'readonly', 'modified' ] ],
  \     'right': [ [ 'ale_expand', 'ale_errors', 'ale_warnings', 'ale_infos', 'ale_ok' ],
  \              [ 'lineinfo', 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype'] ]
  \   },
  \   'component': {
  \     'readonly': '%{&readonly?"x":""}',
  \   },
  \   'component_expand': {
  \     'gitbranch':    'FugitiveHead',
  \     'gitpath':      'LightlineRepoPath',
  \     'ale_expand':   'lightline#ale#checking',
  \     'ale_infos':    'lightline#ale#infos',
  \     'ale_warnings': 'lightline#ale#warnings',
  \     'ale_errors':   'lightline#ale#errors',
  \     'ale_ok':       'lightline#ale#ok',
  \   },
  \   'component_type': {
  \     'ale_checking': 'right',
  \     'ale_infos':    'right',
  \     'ale_warnings': 'warning',
  \     'ale_errors':   'error',
  \     'ale_ok':       'green',
  \   },
  \ }

function! LightlineRepoPath()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

"let g:ctrlp_max_files = 0
"let g:ctrlp_clear_cache_on_exit = 0
"Plugin 'ctrlpvim/ctrlp.vim'
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/](_site|\.(git|hg|svn|bin|build|_build)|build|cmake-build-debug)$',
"  \ 'file': '\v\.(exe|so|dll|class|o)$',
"  \ }

Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" <F3>
Plugin 'mbbill/undotree'
let g:undotree_HighlightChangedText = 0

" <F12>
Plugin 'scrooloose/nerdtree'

"------------
" Display
"------------
Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/indentLine'

"------------
" git
"------------
Plugin 'airblade/vim-gitgutter'
autocmd BufWritePost * GitGutter
autocmd BufEnter * GitGutter
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb' " GBrowse handler for GH

"------------
" Utilities
"------------
runtime! Plugin 'tpope/vim-sensible' " load early so I can override settings

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'            " try to automatically set tab length
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-speeddating'       " fix increment for dates

Plugin 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)

" select block and C-A or C-X
Plugin 'triglav/vim-visual-increment'

"------------
" Syntax
"------------
Plugin 'ervandew/supertab'

Plugin 'neovim/nvim-lspconfig'

"Plugin 'dense-analysis/ale'
"let g:ale_linters = {
"    \ 'rust': ['analyzer']
"  \ }
"let g:ale_fixers = { 'rust': ['rustfmt'] }
"let g:ale_completion_enabled = 1
"let g:ale_set_balloons = 1 " doesn't work in neovim unfortunately
""let g:ale_cursor_detail = 1
"
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 1
"let g:ale_fix_on_save = 1
"
"let g:ale_proto_protoc_gen_lint_options = '-I ~/src/schema.protobuf/proto/ -I ~/src/schema.protobuf/deps/'
"
"let g:ale_ruby_rubocop_executable = 'bundle'

"-------------------
" Language-Specific
"-------------------

" Use :A to switch .c <-> .h
Plugin 'vim-scripts/a.vim'

Plugin 'pangloss/vim-javascript'
"Plugin 'wookiehangover/jshint.vim'
"let JSHintUpdateWriteOnly=1

Plugin 'rust-lang/rust.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
let g:conceallevel = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
Plugin 'cespare/vim-toml'

"Plugin 'saltstack/salt-vim'
"Plugin 'chr4/nginx.vim'

"Plugin 'lervag/vimtex'
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'beyondmarc/glsl.vim'

"Plugin 'def-lkb/vimbufsync'
"Plugin 'the-lambda-church/coquille'

"Plugin 'derekwyatt/vim-scala'
"Plugin 'eagletmt/ghc-mod'
"Plugin 'digitaltoad/vim-jade'

" Ocaml-Merlin
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'uarun/vim-protobuf'
Plugin 'cstrahan/vim-capnp'

Plugin 'leafgarland/typescript-vim'
Plugin 'google/vim-jsonnet'
Plugin 'pearofducks/ansible-vim'

Plugin 'fatih/vim-go'
let g:go_fmt_fail_silently = 1
let g:go_def_mapping_enabled = 0

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

call vundle#end()
filetype plugin indent on

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-a>"] = false,
      },
    },
  }
}

require('lspconfig').rust_analyzer.setup({})
-- require('lspconfig').pyright.setup({})

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

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

""""""""""""""""""""""""""""""""" Colorscheme """"""""""""""""""""""""""""""""""

syntax enable
set background=light
colorscheme solarized

highlight SignColumn      ctermbg=none
highlight GitGutterAdd    ctermbg=none
highlight GitGutterChange ctermbg=none
highlight GitGutterDelete ctermbg=none

""""""""""""""""""""""""""""" Filetype Settings """"""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""" Function keys """""""""""""""""""""""""""""""

map <F2> :Git blame<CR>
map <F3> :UndotreeToggle<CR>
set pastetoggle=<F4>
map <F5> :!reset<CR><CR>

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

map <F12> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""" Commands """"""""""""""""""""""""""""""""""
command W w

" stop search highlighting
nnoremap <space><space> :noh<CR>
" enter newline
nnoremap <CR> o<ESC>k

" map <C-]> <Plug>(ale_go_to_definition)
" map <Leader>q :ALEHover<CR>

" tex: put selection in math mode
xmap m S$
