"whichkey
let g:which_key_map = {}
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>
let g:which_key_map['c'] = { 'name': 'commenter' }

set timeoutlen=500
set signcolumn=yes
set completeopt=menu,menuone,noselect

map <leader>b :NERDTreeToggle<CR>
nmap <C-f> :Rg<CR>

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

"vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
  \ 'syntax': 'markdown', 'ext': '.md'}]
"otherwhise vimwiki considers every .md file as vimwiki
let g:vimwiki_global_ext = 0

nmap <leader>wj <Plug>VimwikiNextLink
nmap <leader>wk <Plug>VimwikiPrevLink
let g:which_key_map['w'] = { 'name': 'vimwiki' }";

"disable all extensions for a minimal setup
let g:airline_extensions = ['tabline']
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
