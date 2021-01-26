"automated installation of vimplug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
"PlugInstall, PlugUpdate, PlugClean,
"PlugUpgrade (upgrade vim plug), PlugStatus

"games
Plug 'ThePrimeagen/vim-be-good', { 'on': 'VimBeGood' }

"git
Plug 'tpope/vim-fugitive'

"syntax
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'rhysd/vim-grammarous'
Plug 'mboughaba/i3config.vim'
"displays css colors in vim
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'wellle/context.vim'
"highlights same keywords
Plug 'RRethy/vim-illuminate'
"renders leading whitespace as red
Plug 'ntpeters/vim-better-whitespace'

"fuzzy finder
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }

"autopair
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'AndrewRadev/splitjoin.vim'

"commenting
Plug 'preservim/nerdcommenter'

"autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'liuchengxu/vista.vim'
"expands command bar with suggetions
Plug 'gelguy/wilder.nvim'

"files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-sleuth'

"status bar
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"themes
"Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'joshdick/onedark.vim'
"Plug 'chriskempson/base16-vim'
"Plug 'junegunn/seoul256.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'arcticicestudio/nord-vim'
"Plug 'gruvbox-community/gruvbox'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'hardcoreplayers/oceanic-material'
"Plug 'arzg/vim-colors-xcode'

"organizing
Plug 'wsdjeg/vim-todo', { 'on': 'OpenTodo' }
Plug 'breuerfelix/vim-todo-lists'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

"other
Plug 'mattn/emmet-vim'
"Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/clever-f.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }

"load as last plugin
Plug 'ryanoasis/vim-devicons'

call plug#end()

"
" BASIC CONFIG
"

let g:which_key_map = {}
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

"plugin configurations
"let g:python_host_prog = '/usr/bin/python2'
"let g:python3_host_prog = '/usr/bin/python3'

map <C-f> :Rg<CR>
map <leader>b :NERDTreeToggle<CR>

"edit files
map <leader>ee :e ~/.vimrc<CR>
map <leader>et :e ~/.tmux.conf<CR>
map <leader>er :e ~/.bashrc<CR>
map <leader>es :e ~/.zshrc<CR>
map <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>
map <leader>ei :e ~/.i3/config<CR>
map <leader>ed :e ~/cloud/default.todo<CR>
map <leader>ef :e ~/cloud/temp.md<CR>
let g:which_key_map['e'] = { 'name': 'file shortcuts' }

"
" PLUGIN CONFIG
"

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>
set timeoutlen=500

let g:Illuminate_delay = 500

"needs manual activation with <C-e>
let g:firenvim_config = {
\  'localSettings': {
\    '.*': {
\      'takeover': 'never',
\      'priority': 1,
\    },
\  },
\}

"git
map <leader>hd :Gdiffsplit<CR>
map <leader>hb :Gblame<CR>
let g:which_key_map['h'] = { 'name': 'git' }

let g:spacevim_todo_labels = [
\  'FIXME',
\  'TODO',
\]

nmap m <Plug>(easymotion-prefix)

" fuzzy finder for wilder menu
call wilder#set_option('pipeline', [
\  wilder#branch(
\    wilder#cmdline_pipeline({
\      'fuzzy': 1,
\      'use_python': 1,
\    }),
\    wilder#python_search_pipeline({
\      'regex': 'fuzzy',
\      'engine': 're',
\      'sort': function('wilder#python_sort_difflib'),
\    }),
\  ),
\])

"command completion
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" only / and ? is enabled by default
call wilder#set_option('modes', ['/', '?', ':'])

"improve writing
function! s:goyo_enter()
  set nolist
  Limelight
endfunction

function! s:goyo_leave()
  set list
  Limelight!
endfunction

noremap <silent> <leader>w :Goyo<CR>
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

noremap <C-t> :Vista!!<CR>

"removes flickering in neovim for context plugin
let g:context_nvim_no_redraw = 1

let g:tex_flavor = 'latex'
let g:vimtex_compiler_method = 'tectonic'
nmap <leader>v <Plug>(vimtex-compile)

lua require'colorizer'.setup()

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlighting = 2

"mono only for unity projects
"let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_start_without_solution = 1

let g:OmniSharp_highlight_groups = {
\  'LocalName': 'Text',
\  'FieldName': 'Text',
\  'ParameterName': 'Text',
\}

"linting
map <leader>ln :noh<CR>
map <leader>ls :s/"/'/g<bar>:noh<CR>
map <leader>lf :ALEFix<CR>
map <leader>lg :GrammarousCheck<CR>
map <leader>lr :GrammarousReset<CR>
map <leader>lt :OpenTodo<CR>
let g:which_key_map['l'] = { 'name': 'linting / syntax' }

"linter
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0

let g:ale_fixers = {
\  '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\  'javascript': [ 'eslint' ],
\  'python': [ 'black' ],
\  'rust': [ 'rustfmt' ],
\}

let g:ale_linters = {
\  'cs': [ 'OmniSharp' ],
\}

"use single quotes in emmet
let g:user_emmet_settings = { 'html': { 'quote_char': "'", }, }
let g:user_emmet_leader_key = '<C-d>'

"completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set cmdheight=1
"turn off completion menu messages
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions = [
"\  'coc-git',
\  'coc-json',
\  'coc-tsserver',
\  'coc-jest',
\  'coc-python',
\  'coc-rls',
\  'coc-go',
\  'coc-java',
\  'coc-svelte',
\  'coc-vimtex',
\  'coc-fish',
\]

inoremap <silent><expr> <C-space> coc#refresh()

"GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gt <Plug>(coc-type-definition)zz
nmap <silent> gi <Plug>(coc-implementation)zz
nmap <silent> gr <Plug>(coc-references)zz
let g:which_key_map['g'] = { 'name': 'goto' }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format)

"remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
"apply AutoFix to problem on the current line.
nmap <leader>af <Plug>(coc-fix-current)
nmap <leader>ar <Plug>(coc-rename)
nmap <silent> <leader>ad :call <SID>show_documentation()<CR>

"Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
nmap <leader>ao :Fold<CR>
let g:which_key_map['a'] = { 'name': 'coc actions' }

let g:which_key_map['c'] = { 'name': 'commenter' }

"
" THEMING
"

"disable all extensions for a minimal setup
let g:airline_extensions = ['tabline']
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"let g:onedark_terminal_italics = 1
"let g:palenight_terminal_italics = 1

let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_transparent_background = 0
"colorscheme gruvbox-material
colorscheme nord

"override colorscheme

"enable transparent background
"highlight Normal ctermbg=NONE guibg=NONE

"render whitespace softer than comments
highlight NonText guifg=grey22
highlight Whitespace guifg=grey22
highlight SpecialKey guifg=grey22

"highlight only one character when line too long
highlight ColorColumn ctermbg=grey guibg=grey25
call matchadd('ColorColumn', '\%88v', 100)

"
" OVERRIDING DIFFERENT ENVIRONMENTS
"

if exists('g:started_by_firenvim')
  let g:loaded_airline = 1
  set laststatus=0
  set nolist
  set nonumber
  set norelativenumber
  set signcolumn=no
  colorscheme onedark
  startinsert
endif
