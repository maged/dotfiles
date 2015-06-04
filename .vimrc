:color desert
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
                  
let mapleader = "\\"
let maplocalleader = "\\"

" change filetypes for ambiguous files
au BufNewFile,BufRead nginx.conf* setfiletype nginx

" Better tab completion
set wildmode=longest,list,full

" Mappings

" hard mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Quickly edit/reload vim
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" move lines up/down
nnoremap <leader>- ddp
nnoremap <leader>_ :m -2<ENTER>

" u to uppercase word
nnoremap <leader>u maviWU`a
inoremap <c-u> <esc>maviWU`aa

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
