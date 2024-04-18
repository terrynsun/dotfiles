set nocompatible
filetype off

""""""""""""""""""""""""""""""""""" Plugins """"""""""""""""""""""""""""""""""""
set shell=/bin/bash

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
"---------------------
" Navigation & Display
"---------------------
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
" Plug 'overcache/NeoSolarized'
Plug 'Yggdroot/indentLine'
Plug 'christoomey/vim-tmux-navigator'

Plug 'itchyny/lightline.vim'

let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':  [ [ 'mode', 'paste' ],
  \                [ 'gitbranch', 'gitpath',
  \                  'readonly', 'modified' ] ],
  \     'right': [ [ 'lineinfo', 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype'] ]
  \   },
  \   'component': {
  \     'readonly': '%{&readonly?"x":""}',
  \   },
  \   'component_expand': {
  \     'gitbranch':    'FugitiveHead',
  \     'gitpath':      'LightlineRepoPath',
  \   }
  \ }

function! LightlineRepoPath()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim' " todo what is this for?
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'sharkdp/fd'

  nnoremap <C-p> <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
else
  Plug 'ctrlpvim/ctrlp.vim'

  let g:ctrlp_max_files = 0
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](_site|\.(git|hg|svn|bin|build|_build)|build|cmake-build-debug)$',
    \ 'file': '\v\.(exe|so|dll|class|o)$',
    \ }
endif

" <F3>
Plug 'mbbill/undotree'
let g:undotree_HighlightChangedText = 0

" <F12>
Plug 'scrooloose/nerdtree'

"------------
" git
"------------
Plug 'airblade/vim-gitgutter'
autocmd BufWritePost * GitGutter
autocmd BufEnter * GitGutter
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " GBrowse handler for GH
let g:netrw_browsex_viewer = "xdg-open"

"------------
" Utilities
"------------
runtime! Plug 'tpope/vim-sensible' " load early so I can override settings

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'            " try to automatically set tab length
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'       " fix increment for dates

Plug 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)

" select block and C-A or C-X
Plug 'triglav/vim-visual-increment'

"------------
" Syntax
"------------
Plug 'ervandew/supertab'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'kosayoda/nvim-lightbulb'

  "Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/trouble.nvim'
end

"-------------------
" Language-Specific
"-------------------

" Use :A to switch .c <-> .h
Plug 'vim-scripts/a.vim'

Plug 'pangloss/vim-javascript'
"Plug 'wookiehangover/jshint.vim'
"let JSHintUpdateWriteOnly=1

Plug 'rust-lang/rust.vim'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:conceallevel = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
Plug 'cespare/vim-toml'

"Plug 'saltstack/salt-vim'
"Plug 'chr4/nginx.vim'

"Plug 'lervag/vimtex'
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'beyondmarc/glsl.vim'

"Plug 'def-lkb/vimbufsync'
"Plug 'the-lambda-church/coquille'

"Plug 'derekwyatt/vim-scala'
"Plug 'eagletmt/ghc-mod'
"Plug 'digitaltoad/vim-jade'

" Ocaml-Merlin
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'uarun/vim-protobuf'
Plug 'cstrahan/vim-capnp'

Plug 'leafgarland/typescript-vim'
Plug 'google/vim-jsonnet'
Plug 'pearofducks/ansible-vim'
Plug 'hashivim/vim-terraform'

Plug 'fatih/vim-go'
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

call plug#end()
filetype plugin indent on

" Lua config must run after plug#end has loaded plugins:
if has('nvim')
lua << EOF
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- delay update diagnostics
      update_in_insert = false,
    }
  )
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

  local lspconfig = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<leader>T', '<cmd>TroubleToggle<CR>', opts)
  end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'rust_analyzer', 'gopls', 'solargraph' }
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  lspconfig.tsserver.setup {
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
  }

  require("trouble").setup {
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    auto_preview = false,
    auto_jump = { }
  }
EOF
end

if has('nvim')
  " todo check if lightbulb installed
  autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
  set updatetime=500
end

"""""""""""""""""""""""""""" General Vim Settings """"""""""""""""""""""""""""

set lazyredraw
set laststatus=2
set noshowmode

set ruler
set showcmd

" Tabs
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
set termguicolors " truecolor suport
colorscheme solarized8

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
command Wq wq

" stop search highlighting
nnoremap <space> :noh<CR>
" enter newline
nnoremap <CR> o<ESC>k

" tex: put selection in math mode
xmap m S$
