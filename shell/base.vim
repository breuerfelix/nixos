"
" NATIVE CONFIG
"

"mappings
let mapleader = ' '
inoremap jk <Esc>
vnoremap u <Esc>

"trailing
noremap <C-c> <S-j>

"faster scrolling
noremap <S-j> 4jzz
noremap <S-k> 4kzz
"nnoremap <S-j> <C-d>zz
"nnoremap <S-k> <C-u>zz

"buffer
map <C-n> :bnext<CR>
map <C-p> :bprevious<CR>
"map <C-t> :tabnew<CR>

"finder
map ; :Files<CR>

"inserts blank line below
noremap <C-[> :set paste<CR>o<Esc>:set nopaste<CR>
noremap gl $
noremap gh 0

"save
noremap <silent> <C-i> :w<CR>
"sudo tee hack, write as root
cmap w!! w !sudo tee > /dev/null %

"quit
noremap <C-u> :q<CR>
inoremap <C-u> <Esc>:q<CR>

"splits
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

noremap <silent> <C-h> :call WinMove('h')<CR>
noremap <silent> <C-j> :call WinMove('j')<CR>
noremap <silent> <C-k> :call WinMove('k')<CR>
noremap <silent> <C-l> :call WinMove('l')<CR>

"terminal
tnoremap jk <C-\><C-n>
tnoremap <C-u> <C-\><C-n>:q<CR>

"run current buffer
autocmd filetype python noremap <CR> :below split <bar> :terminal python %<CR>
autocmd filetype javascript,typescript noremap <CR> :below split <bar> :terminal node %<CR>

"true colors
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"vim update delay in ms
set updatetime=300

"disable mouse
set mouse=

"syntax
syntax enable
set number
set relativenumber
set autoread
set encoding=UTF-8
"set foldmethod=syntax

set clipboard=unnamedplus

"disable pre rendering of some things like ```
set conceallevel=0

"toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:~,extends:❯,precedes:❮,space:␣
set showbreak=↪

"default for vim sleuth
set expandtab
set tabstop=2
set shiftwidth=2

"split
set splitbelow
set splitright

"in house fuzzy finder
set path+=**
set wildmenu

"searching
set ignorecase
set smartcase

set cursorline
set laststatus=2
set scrolloff=8

augroup save_when_leave
    au BufLeave * silent! wall
augroup END

set hidden
set nobackup
set nowritebackup
set noswapfile
set noshowmode
"automatically source .vimrc from project folder
set exrc

"jump back to and forth
noremap <leader>o <C-o>zz
noremap <leader>i <C-i>zz

set background=dark
