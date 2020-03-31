filetype plugin indent on
syntax on
" For Plugins:
    " run pathogen (for package management)
    call pathogen#infect()
    call pathogen#helptags()
    " Use to debug plugins
    " let g:pathogen_disabled = []


" tags
    " Look through parent folders for tags
    set tags=tags;

" some reasonable defaults
    set smartindent
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set shiftround
    set number relativenumber
    set nu
"    set mouse=a
"    set ttymouse=xterm2
    " no gui guiness
    if has('gui_running')
        set guioptions=c
    endif
    let mapleader = "\\"
    let maplocalleader = "\\"

    " no beeps!
    set vb
    set t_vb= 
    autocmd GUIEnter * set vb t_vb= " no GUI beeping
    " Better tab completion
    set wildmode=longest,list,full

    set scrolloff=5

    " matchit html tags
    runtime macros/matchit.vim

    " use system clipboard by default
    set clipboard=unnamedplus


" decent colors
    set background=dark
    if has('gui_running')
        color seoul256
    else
        color torte
    endif
    " grey search highlight
    hi Search term=reverse ctermbg=7
    hi LineNr ctermfg=darkgrey guifg=#8c8ca3
    hi CursorLineNr ctermfg=White guifg=White
    hi javaScriptFuncArg ctermfg=lightred

    set t_Co=256
    if $COLORTERM == 'gnome-terminal'
        set t_Co=256
    endif

    " Not invisible brackets
    hi MatchParen cterm=none ctermbg=blue ctermfg=white

" nicer font

" statusline
    " statusline: filename:%read ... curr character
    " statusline color groups:
    set laststatus=1
    hi User1 ctermbg=white ctermfg=darkblue guifg=darkblue guibg=#e3e3e3
    hi User2 ctermbg=white ctermfg=black guifg=black guibg=#e3e3e3
    hi User3 ctermbg=white ctermfg=darkred guifg=darkred guibg=#e3e3e3
    set statusline=%2*%t:%1*\ %p%%\ %=%1*%k\ \ %1*%c%3*%m
    hi StatusLine ctermfg=8 ctermbg=7
    hi StatusLineNC ctermfg=8 ctermbg=7

" filetype specific
"    au FileType python setl shiftwidth=4 tabstop=4
" MatchTag
    let g:mta_set_default_matchtag_color = 0
    let g:mta_use_matchparen_group = 0
    highlight MatchTag ctermbg=darkgrey
    nnoremap <leader>5 :MtaJumpToOtherTag<cr>

" nerdtree
    let NERDTreeIgnore=['\.pyc$']
    " git branch as nerdtree statusline
    autocmd FileType nerdtree setlocal statusline=\%.35{gitbranch#name()}\
    let g:NERDTreeMapHelp='<F1>'
    " Go to current nerdtree pane
    nnoremap <leader>n :NERDTreeFocus<CR>
    " Open nerdtree pane at current file
    nnoremap <leader>N :NERDTree %<CR>

" filetypes
    " nginx conf is ambigous
    au BufNewFile,BufRead nginx.conf* setfiletype nginx

" vim-notes
    let g:notes_directories = ['~/Notes']
    let g:notes_suffix = '.txt'
    au BufNewFile,BufRead *.txt setfiletype notes

" Mappings
    nnoremap Y y$
    command! Q qa " close all!

    " navigation
    " nnoremap K 6k
    " nnoremap J 6j
    nnoremap <leader>j J

    " hard mode
    " noremap <up> <nop>
    " noremap <down> <nop>
    " noremap <left> <nop>
    " noremap <right> <nop>

    " Quickly edit/reload vim
    nnoremap <leader>ev :split $MYVIMRC<CR>
    nnoremap <leader>sv :source $MYVIMRC<CR>

    " u to uppercase word
    nnoremap <leader>u maviWU`a
    inoremap <C-U> <esc>maviWU`aa

    " surround with quotes
    vnoremap <leader>" <esc>ma`<i"<esc>`>la"<esc>`<v`>ll
    vnoremap <leader>' <esc>ma`<i'<esc>`>la'<esc>`<v`>ll
    " todo
    " nnoremap <leader>" mmbi"<esc>ea"<esc>`m

    " jump to beginning/end of line
    nnoremap H ^
    vnoremap H ^
    nnoremap L $
    vnoremap L $

    " search + highlight
    set incsearch
    set hlsearch
    nnoremap <leader>h :set hls!<CR>:echo<CR>
    " turn off highlighting on mode change
    autocmd InsertEnter * :set nohlsearch
    nohls

    " Smart cases for searching
    set ignorecase
    set smartcase

    " insert mode mappings
    " Just smash j + k to escape
    inoremap jk <esc>l
    inoremap kj <esc>l

    vnoremap ajk <esc>
    " inoremap jf <esc>l
    " vnoremap jf <esc>
    "inoremap <esc> <nop>
    " so I can check this leader shit
    nnoremap <leader><leader> :echo("\<leader\> works! It is set to \"\<leader>\" ")<CR>

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
    nnoremap sw t_
    " nnoremap dsw df_
    " nnoremap csw ct_
    " show search count
    nnoremap <leader>c :%s///gn<cr>

    " using (c)tags
    nnoremap <leader>t :ts<CR>

    " insert new line
    " bar = <S-leader>
    nnoremap <leader><cr> mto<esc>`t
    nnoremap <bar><cr> mtO<esc>`t

    " up/down to same indentation
    nnoremap K :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
    nnoremap J :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
    vnoremap K mt:call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>my`tv`y
    vnoremap J mt:call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>my`tv`y
    let g:SeekKey = '<Space>'
    " nnoremap <space> jk

    " Quick substition/refactor
    nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

    " kim stuff
    noremap <C-c> <Esc>
    nnoremap ; :
    nnoremap : ;

" autocmd InsertLeave * s/\s\+$//e

" Functions

function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 B :call BufSel("<args>")

" Little alert for > 80 chars in column
function! HighlightTooLongLines()
  highlight def link RightMargin Error
endfunction
augroup filetypedetect
  au BufNewFile,BufRead * call HighlightTooLongLines()
augroup END

" cd to current file
nnoremap <leader>cd :cd %:h<cr>

" Syntax mapping
autocmd BufEnter *.tsx :setlocal filetype=typescript
autocmd BufEnter *.ts :setlocal filetype=typescript

" fzf fuzzy finder
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>r :Rg<CR>


" Applied specific
au FileType cc set ts=2 sw=2
au FileType h set ts=2 sw=2
