" ============================================================================
" Vim Configuration - Ported from Neovim config
" ============================================================================

" --- Cursor shapes (insert/replace/normal) ---
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[2 q"

" ============================================================================
" OPTIONS (from lua/config/options.lua)
" ============================================================================

set nocompatible
filetype plugin indent on
syntax enable

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Line numbers
set number
set relativenumber

" Clipboard (system clipboard - mirrors unnamedplus)
set clipboard=unnamedplus

" Line wrapping (mirrors wrap + linebreak + breakindent)
set wrap
set linebreak
set breakindent

" Cursorline
set cursorline

" Trailing whitespace display (mirrors listchars trail:·)
set list
set listchars=tab:»\ ,trail:·,extends:›,precedes:‹

" Folding (from origami.lua init - start all folds open)
set foldlevel=99
set foldlevelstart=99

" Miscellaneous
set hidden
set updatetime=300
set signcolumn=yes
set scrolloff=8
set sidescrolloff=8
set mouse=a
set backspace=indent,eol,start
set encoding=utf-8
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set noshowmode
set showcmd
set splitbelow
set splitright
set ttimeoutlen=50
set shortmess+=c
set completeopt=menu,menuone,noselect,noinsert

" True color support
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" ============================================================================
" PLUGIN MANAGER (vim-plug) - replaces lazy.nvim
" ============================================================================

" Auto-install vim-plug if not present
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" --- Colorscheme (gruvbox, medium contrast) ---
Plug 'morhetz/gruvbox'

" --- Status line (replaces lualine) ---
Plug 'itchyny/lightline.vim'

" --- Fuzzy finder (replaces Telescope + Snacks picker) ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- Git (fugitive + gitgutter replaces fugitive + Snacks git) ---
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" --- Surround (replaces nvim-surround) ---
Plug 'tpope/vim-surround'

" --- Repeat (replaces vim-repeat) ---
Plug 'tpope/vim-repeat'

" --- Auto pairs (replaces nvim-autopairs) ---
Plug 'jiangmiao/auto-pairs'

" --- Motion/jump (replaces Flash.nvim) ---
Plug 'justinmk/vim-sneak'

" --- Enhanced text objects (replaces mini.ai) ---
Plug 'wellle/targets.vim'

" --- Comment toggling ---
Plug 'tpope/vim-commentary'

" --- LSP, completion, diagnostics (replaces nvim-lspconfig + nvim-cmp + Mason) ---
" Requires Node.js: https://nodejs.org
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- GitHub Copilot (replaces copilot.lua) ---
" Requires Node.js
Plug 'github/copilot.vim'

" --- File explorer (replaces Snacks explorer) ---
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" --- Indent guides (replaces Snacks indent + mini.indentscope) ---
Plug 'Yggdroot/indentLine'

" --- Color highlighting (replaces nvim-highlight-colors) ---
Plug 'ap/vim-css-color'

" --- Markdown preview (replaces markdown-preview.nvim) ---
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }

call plug#end()

" ============================================================================
" COLORSCHEME (from plugins/colorscheme.lua - gruvbox medium)
" ============================================================================

set background=dark
let g:gruvbox_contrast_dark = 'medium'
silent! colorscheme gruvbox

" ============================================================================
" LEADER KEY (from lua/config/keymaps.lua)
" ============================================================================

let mapleader = " "
let maplocalleader = "\\"

" ============================================================================
" KEYMAPS (from lua/config/keymaps.lua)
" ============================================================================

" --- Scroll + re-center ---
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" --- Append character to end of line ---
" Semicolon
nnoremap <C-;> A;<Esc>
inoremap <C-;> <Esc>A;
" Comma
nnoremap <C-,> A,<Esc>
inoremap <C-,> <Esc>A,

" --- Insert blank lines without entering insert mode ---
nnoremap <M-o> o<Esc>
nnoremap <M-O> O<Esc>

" --- Move lines up/down ---
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" --- H/L for beginning/end of line ---
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

" --- Keep visual mode after indenting ---
vnoremap < <gv
vnoremap > >gv

" --- jk to escape insert mode ---
inoremap jk <Esc>

" --- Quick save ---
nnoremap <leader>w :w<CR>

" --- Clear search highlighting ---
nnoremap <Esc> :nohlsearch<CR>

" ============================================================================
" FZF KEYMAPS (replaces Telescope + Snacks picker)
" ============================================================================

" Top-level pickers
nnoremap <leader><space> :Files<CR>
nnoremap <leader>,       :Buffers<CR>
nnoremap <leader>/       :Rg<CR>
nnoremap <leader>:       :History:<CR>

" Ctrl-T opens files (from keymaps.lua)
nnoremap <C-t> :Files<CR>

" Find group (<leader>f)
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>fh :Helptags<CR>

" Search group (<leader>s)
nnoremap <leader>sg :Rg<CR>
nnoremap <leader>sb :BLines<CR>
nnoremap <leader>sB :Lines<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sk :Maps<CR>
nnoremap <leader>sc :History:<CR>
nnoremap <leader>s/ :History/<CR>
nnoremap <leader>sm :Marks<CR>
nnoremap <leader>sw :Rg <C-R><C-W><CR>
nnoremap <leader>sd :CocList diagnostics<CR>
nnoremap <leader>ss :CocList outline<CR>
nnoremap <leader>sS :CocList symbols<CR>

" Git pickers (fzf)
nnoremap <leader>gs :GFiles?<CR>
nnoremap <leader>gl :Commits<CR>
nnoremap <leader>gL :BCommits<CR>

" ============================================================================
" FILE EXPLORER (replaces Snacks explorer)
" ============================================================================

nnoremap <leader>e :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
autocmd FileType nerdtree setlocal relativenumber

" ============================================================================
" GIT KEYMAPS (replaces Snacks git + fugitive keymaps)
" ============================================================================

nnoremap <leader>gg :tab Git<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gB :GBrowse<CR>

" GitGutter navigation (replaces git hunk navigation)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)

" ============================================================================
" BUFFER MANAGEMENT (replaces Snacks bufdelete)
" ============================================================================

nnoremap <leader>bd :bdelete<CR>
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

" ============================================================================
" COC.NVIM (replaces nvim-lspconfig + nvim-cmp + Mason)
" ============================================================================

" Auto-install extensions (replaces Mason ensure_installed + nvim-cmp sources)
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-pyright',
      \ 'coc-lua',
      \ 'coc-rust-analyzer',
      \ 'coc-clangd',
      \ 'coc-snippets',
      \ ]

" --- Completion keymaps (replaces nvim-cmp mappings) ---

" Tab/S-Tab to navigate completion menu (mirrors nvim-cmp Tab behavior)
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" C-K to confirm completion (matches nvim-cmp <C-K> confirm)
inoremap <silent><expr> <C-k>
      \ coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" C-Space to trigger completion (matches nvim-cmp <C-Space>)
inoremap <silent><expr> <C-Space> coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" --- LSP navigation (replaces Snacks LSP picker keymaps) ---
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)

" --- Code actions (replaces fastaction + native LSP code_action) ---
nmap <leader>a  <Plug>(coc-codeaction-cursor)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction)

" --- Rename (replaces Snacks rename) ---
nmap <leader>cR <Plug>(coc-rename)

" --- Show documentation (replaces LSP hover) ---
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" --- Diagnostics navigation ---
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" --- Format ---
nmap <leader>cf <Plug>(coc-format)
xmap <leader>cf <Plug>(coc-format-selected)

" Highlight symbol under cursor on CursorHold (replaces Snacks words)
autocmd CursorHold * silent call CocActionAsync('highlight')

" ============================================================================
" COPILOT (from plugins/copilot.lua)
" ============================================================================

" Accept suggestion with Ctrl-J (matches copilot.lua keymap)
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Next/prev/dismiss suggestion (matches copilot.lua keymaps)
imap <M-]> <Plug>(copilot-next)
imap <M-[> <Plug>(copilot-previous)
imap <C-]> <Plug>(copilot-dismiss)

" ============================================================================
" LIGHTLINE (replaces lualine)
" ============================================================================

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" ============================================================================
" VIM-SNEAK (replaces Flash.nvim)
" ============================================================================

let g:sneak#label = 1
let g:sneak#s_next = 1
" Use sneak for f/F/t/T as well (enhanced motions)
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" ============================================================================
" INDENT LINE (replaces Snacks indent + mini.indentscope)
" ============================================================================

let g:indentLine_char = '│'
let g:indentLine_enabled = 1

" ============================================================================
" GITGUTTER
" ============================================================================

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '~'

" ============================================================================
" AUTOCOMMANDS (from lua/config/autocmds.lua)
" ============================================================================

augroup vimrc_autocmds
  autocmd!

  " Toggle relative numbers in insert mode
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber | call TrimTrailingWhitespace()

  " Disable auto-extension of comments on newline
  autocmd BufWinEnter * set formatoptions-=cro

  " Highlight yanked text (Vim 8.1.1140+)
  if exists('##TextYankPost')
    autocmd TextYankPost * call s:HighlightYank()
  endif

augroup END

" Trim trailing whitespace (from autocmds.lua)
function! TrimTrailingWhitespace()
  if !&binary && &filetype !=# 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfunction

" Yank highlight approximation (matches options.lua TextYankPost highlight)
function! s:HighlightYank()
  let l:hi_id = matchadd('IncSearch', ".\\%>'\\[.*\\%<']..")
  call timer_start(200, {tid -> s:ClearHighlight(l:hi_id)})
endfunction

function! s:ClearHighlight(id)
  silent! call matchdelete(a:id)
endfunction

" ============================================================================
" TODO HIGHLIGHTING (replaces todo-comments.nvim)
" ============================================================================

augroup todo_highlights
  autocmd!
  autocmd Syntax * call matchadd('Todo', '\v\W\zs(TODO|FIXME|FIX|HACK|XXX|NOTE|WARNING|BUG)')
augroup END

" Navigate TODO comments (replaces ]t / [t from todo-comments.nvim)
nnoremap ]t /\v(TODO\|FIXME\|FIX\|HACK\|XXX\|NOTE)<CR>
nnoremap [t ?\v(TODO\|FIXME\|FIX\|HACK\|XXX\|NOTE)<CR>

" ============================================================================
" TERMINAL (replaces Snacks terminal <C-/>)
" ============================================================================

if has('terminal')
  nnoremap <C-/> :terminal<CR>
  tnoremap <C-/> <C-\><C-n>:bdelete!<CR>
  tnoremap <Esc> <C-\><C-n>
endif

" ============================================================================
" NETRW FALLBACK (if NERDTree is not available)
" ============================================================================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
