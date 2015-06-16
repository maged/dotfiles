color desert
hi LineNr ctermfg=Yellow
hi CursorLineNr ctermfg=White
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround
set number relativenumber
set nu

" no beeps!
set vb
set t_vb= 

" statusline: filename:%read ... curr character
set statusline=%t:\ %p%%%=%k\ \ %c

" For Plugins:
" run pathogen (for package management)
call pathogen#infect()
call pathogen#helptags()
" for airline
set laststatus=2 
" for nerdtree
:autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | endif " Open on startup
nnoremap <leader>n :NERDTree %<CR>
nnoremap <leader>f :NERDTreeFind<CR>

let mapleader = "\\"
let maplocalleader = "\\"

" change filetypes for ambiguous files
au BufNewFile,BufRead nginx.conf* setfiletype nginx

" Better tab completion
set wildmode=longest,list,full

" Mappings
nnoremap Y y$

" hard mode
" noremap <up> <nop>
" noremap <down> <nop>
" noremap <left> <nop>
" noremap <right> <nop>

" Quickly edit/reload vim
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" move lines up/down
nnoremap - ddp
nnoremap _ :m -2<ENTER>

" u to uppercase word
nnoremap <leader>u maviWU`a
inoremap <C-U> <esc>maviWU`aa

" surround with quotes
vnoremap <leader>" <esc>ma`<i"<esc>`>la"<esc>`<v`>ll

" jump to beginning/end of line
nnoremap H ^
nnoremap L $

" search + highlight
set incsearch
set hlsearch
nnoremap <leader>h :nohls<CR>
nohls

" Smart cases for searching
set ignorecase
set smartcase

" insert mode mappings
inoremap jk <esc>l
vnoremap jk <esc>
inoremap <esc> <nop>

" so I can check this leader shit
nnoremap <leader><leader> :echo("\<leader\> works! It is set to \<leader> ")<CR>

" fast writes
nnoremap <leader>w :w<cr>
