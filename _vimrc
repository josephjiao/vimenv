" install pathogen
call pathogen#infect()

nnoremap <F2> :g//laddexpr expand("%") . ":" . line(".") . ":" . getline(".")<CR>:lopen<CR>
nnoremap <F3>  :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR><CR>

" when `paste' is set, filetype indent and autoindent don't work
nnoremap <F4> :set paste<CR>"*p:set nopaste<CR>
nnoremap <F5> :set paste<CR>"+p:set nopaste<CR>
inoremap <F4> <ESC>:set paste<CR>"*p:set nopaste<CR>i
inoremap <F5> <ESC>:set paste<CR>"+p:set nopaste<CR>i
nmap <F12> "_diwP
"
" " copy to CLIPBOARD selection
 vnoremap <F6> "+y
"
" " Let F7 to show buf explorer(bufexplorer plugin)
map <F7> <ESC>\be
imap <F7> <ESC>\be

let g:qb_hotkey="<S-F7>"

" mru.vim
nnoremap <silent> <F8> :MRU<CR>
"
" " Taglist plugin
 nnoremap <silent> <F9> :TlistToggle<CR>
"
" " autopreview.vim
 nnoremap <S-F9> :AutoPreviewToggle<CR>
 inoremap <S-F9> <ESC>:AutoPreviewToggle<CR>i
"
 "nnoremap <TAB>      gt
 nnoremap <S-TAB>    gT
 nnoremap <C-N>      <C-W>w
 nnoremap <C-P>      <C-W>W

 if version >= 700
	 " open file in new tabpage
	 nnoremap gf <C-W>gf:tabmove<CR>
 endif
"
" incompatibility between vim 6.x and 7.0
" " :help incompatible-7
" " :help ft-tex-plugin
 let g:tex_flavor = "latex"        " plaintex, context, latex
"
"
" " for taglist plugin
 let Tlist_Show_Menu = 1
" "let Tlist_Ctags_Cmd = $VIMRUNTIME . '/ctags'
 let Tlist_File_Fold_Auto_Close = 1

" for mru.vim
 let MRU_Max_Entries = 50
"
" " for autopreview.vim, below is default setting
 "let g:AutoPreview_enabled = 0
" "let g:AutoPreview_allowed_filetypes = ["c", "cpp", "java"]
"
" for showmarks.vim
 let  g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"
" " for GetLatestVimScripts
 let g:GetLatestVimScripts_allowautoinstall=1

"--------------------------------------misc
"settings-----------------------------
"" recursively search tag file upwards, see :help file-searching
set tags=./tags,tags;

" recursively search file downwards for gf command
" "set path+=/home/dieken/src/vim7/**
"
 set nu
"
 set ignorecase smartcase
"
 set sidescrolloff=10
 "set scrolloff=5
 " to keep the cursor centered in the window
 " set scrolloff=999
 " set sidescrolloff=999

set showmatch
" set time to 0.5 second
"set matchtime=5

set writebackup
set nobackup
" useful for some VCSes that use hardlink in working copy
set backupcopy+=breakhardlink

set wildmode=list:full
set wildmenu

" text auto formation mode.
" r -> <ENTER> then add comment leader
" o -> o/O then add comment leader
set formatoptions+=tcrqvmMB

set textwidth=72
set expandtab
set tabstop=4
set shiftwidth=4
"set cinoptions=t0,:0,(0,g0,j1
set cinoptions=t0,:0,g0,j1

"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10,Monospace\ 10,Courier\ New\ 11
set guifont=Bitstream\ Vera\ Sans\ Mono:h10  

" always show status line
set laststatus=2
set statusline=%F%*\ %y[%{&ff}][%{&fenc}]\ %2*%r%m%*\ %l,%c\ %=%l/%L\ (%p%%)%*\ %{strftime('%Y-%m-%d-%H:%M')}

set virtualedit=block

set fileformats+=dos
set fencs=ucs-bom,utf-8,prc
set ambiwidth=double

set nowrap
set nowrapscan

set more

" no beep or flash
"set vb t_vb=

set display=lastline

set listchars+=extends:>,precedes:<,tab:>-

set updatetime=2000

" for linux kernel source
if getcwd() =~ 'linux-2.6'
    set noet tabstop=8 shiftwidth=8
endif
if has("cscope")
    if executable('mlcscope')
        set cscopeprg=mlcscope\ -d\ -k\ -q
    else
        set cscopeprg=cscope\ -d\ -k\ -q
    endif
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set cst
    set csto=1
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

"--------------------------------------for autocmd and filetype------------------
syntax on
filetype plugin on
"filetype indent on

" press v in quickfix window to preview
au FileType qf :nnoremap <buffer> v <Enter>zz:wincmd p<Enter>

" for gf command to open java source file at import clause
au FileType java :set suffixesadd+=.java

" Keep indentation consistent with erlang-mode in Emacs
au FileType erlang :set noet tabstop=8 softtabstop=4 shiftwidth=4

" backup last search pattern for each window
au WinEnter * :if exists("w:blsp") && w:blsp != '' | let @/=w:blsp | endif
au WinLeave * :let w:blsp=@/

" make tab characters and trailing whitespace obvious
"au FileType * :if &ft != 'help' | 2match Error /\t\|\s\+$/ | endif

" au BufNewFile,BufRead *.c,*.cpp
"     \   :setlocal equalprg=d:\program\astyle\bin\AStyle.exe\ --style=kr\ -l

" au VimEnter * :Vexplore | :vertical resize 20 | :wincmd l

" Cltr+F4 CloseBuffer
nnoremap <C-F4> :confirm bd<CR>
vnoremap <C-F4> <ESC>:confirm bd<Enter>
onoremap <C-F4> <ESC>:confirm bd<Enter>
map! <C-F4> <ESC>:confirm bd<Enter>

" Alt+Num switch Tabs
nmap <C-Tab> <C-PageDown>
imap <C-Tab> <C-PageDown>
nmap <C-S-Tab> <C-PageUp>
imap <C-S-Tab> <C-PageUp>

nmap <A-1> :tabn 1<CR>
nmap <A-2> :tabn 2<CR>
nmap <A-3> :tabn 3<CR>
nmap <A-4> :tabn 4<CR>
nmap <A-5> :tabn 5<CR>
nmap <A-6> :tabn 6<CR>

imap <A-1> <C-o>:tabn 1<CR>
imap <A-2> <C-o>:tabn 2<CR>
imap <A-3> <C-o>:tabn 3<CR>
imap <A-4> <C-o>:tabn 4<CR>
imap <A-5> <C-o>:tabn 5<CR>
imap <A-6> <C-o>:tabn 6<CR>

" press v in quickfix window to preview
au FileType qf :nnoremap <buffer> v <Enter>zz:wincmd p<Enter>

"edit and split a file under the same path of the current one
noremap ,e :e <C-R>=expand("%:p:h") . "/" <CR><C-D>
noremap ,s :split <C-R>=expand("%:p:h") . "/" <CR><C-D>

"cd to the path of the current file
noremap ,d :cd <C-R>=expand("%:p:h")<CR><CR>

"Custimized hotkey
"switch windows
"nmap <silent> <TAB>     <C-W>w:set cursorline<CR>:200sl m<CR>:set nocursorline<CR>
nmap <silent> <S-TAB>   <C-W>p:set cursorline<CR>:200sl m<CR>:set nocursorline<CR>
"change window's size
nmap <silent> <LEFT> <C-W><:let t:flwwinlayout = winrestcmd()<CR>
nmap <silent> <RIGHT> <C-W>>:let t:flwwinlayout = winrestcmd()<CR>
nmap <silent> <UP> <C-W>+:let t:flwwinlayout = winrestcmd()<CR>
nmap <silent> <DOWN> <C-W>-:let t:flwwinlayout = winrestcmd()<CR>

"open in new window
nmap gF <C-W>f

"txt browser plugin
let tlist_txt_settings='txt;c:content;f:figures;t:tables'
au BUfRead,BufNewFile *.txt setlocal ft=txt

colorscheme wombat256mod
set cursorline

set t_Co=256
let python_highlight_all = 1

if has('mouse')
    set mouse=a
endif
