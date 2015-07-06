" For Plugins:
    " run pathogen (for package management)
    call pathogen#infect()
    call pathogen#helptags()

" tags file

" some reasonable defaults
    set smartindent
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set shiftround
    set number relativenumber
    set nu
    let mapleader = "\\"
    let maplocalleader = "\\"

    " no beeps!
    set vb
    set t_vb= 
    " Better tab completion
    set wildmode=longest,list,full

" decent colors
    set background=dark
    color torte
    " grey search highlight
    hi Search term=reverse ctermbg=7
    hi LineNr ctermfg=darkgrey
    hi CursorLineNr ctermfg=White
    hi javaScriptFuncArg ctermfg=lightred

    set t_Co=256
    if $COLORTERM == 'gnome-terminal'
        set t_Co=256
    endif

    " Not invisible brackets
    hi MatchParen cterm=none ctermbg=blue ctermfg=white

" statusline
    " statusline: filename:%read ... curr character
    " statusline color groups:
    set laststatus=1
    hi User1 ctermbg=white ctermfg=darkblue
    hi User2 ctermbg=white ctermfg=black
    hi User3 ctermbg=white ctermfg=lightred
    set statusline=%2*%t:%1*\ %p%%\ %=%1*%k\ \ %1*%c%3*%m
    hi StatusLine ctermfg=8 ctermbg=7 cterm=bold
    hi StatusLineNC ctermfg=8 ctermbg=7 cterm=none

" MatchTag
    let g:mta_set_default_matchtag_color = 0
    let g:mta_use_matchparen_group = 0
    highlight MatchTag ctermbg=darkgrey
    nnoremap <leader>5 :MtaJumpToOtherTag<cr>

" nerdtree
    autocmd VimEnter * if @% == "" | NERDTree | endif " Open on startup
    " open curfile nerdtree, and make panes equal
    nnoremap <leader>n :NERDTree %<CR><C-w>=
    nnoremap <leader>f :NERDTreeFind<CR>
    " git branch as nerdtree statusline
    autocmd FileType nerdtree setlocal statusline=\%.35{gitbranch#name()}\

" filetypes
    " nginx conf is ambigous
    au BufNewFile,BufRead nginx.conf* setfiletype nginx

" Mappings
    nnoremap Y y$
    command! Q qa " close all!
    " I keep pressing K accidentally
    nnoremap K <nop>

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
    vnoremap <leader>' <esc>ma`<i'<esc>`>la'<esc>`<v`>ll

    " jump to beginning/end of line
    nnoremap H ^
    nnoremap L $

    " search + highlight
    set incsearch
    set hlsearch
    nnoremap <leader>h :nohls<CR>:echo<CR>
    nohls

    " Smart cases for searching
    set ignorecase
    set smartcase

    " insert mode mappings
    inoremap jk <esc>l
    vnoremap ajk <esc>
    " inoremap jf <esc>l
    " vnoremap jf <esc>
    "inoremap <esc> <nop>
    " so I can check this leader shit
    nnoremap <leader><leader> :echo("\<leader\> works! It is set to \<leader> ")<CR>

    " fast writes
    nnoremap <leader>w :w<cr>
    " switch bufs
    nnoremap <leader>b :bnext<cr>
    nnoremap <leader>bb :b#<cr>
    nnoremap <leader>bn :bnext<cr>

    " Close buffer but not split window
    nnoremap <leader>q :b#<CR>bd#<CR> 

    " Move around splits
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    nnoremap <Tab> <C-w>W

    " Auto-closing bracket on \n
    inoremap {<CR> {<cr>}<esc>O
    " Un-indenting (todo) 
    " daa: delete an (html) attr
    " todo: use a function, do it right
    " - first attribute, uses ' case
    nnoremap daa lF d2f"
    " dtw: delete trailing whitespace
    nnoremap dtw :%s/\s\+$//e<CR>
    " ftw: find trailing whitespace
        nnoremap ftw /\s\+$<cr>
    " dsw: delete small word (deletethis_from_this)
    nnoremap dsw df_
    nnoremap csw ct_
    " show search count
    nnoremap <leader>c :%s///gn<cr>

" autocmd InsertLeave * s/\s\+$//e

" Functions

