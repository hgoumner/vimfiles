"############################################################################################################"
"# Hristo's vimrc settings
"############################################################################################################"

"###########################"
" Plugin settings
"###########################"

" set necessary flags for plugin and tool setup
set nocompatible                                                     " required
filetype off                                                         " required

" import plugins
call plug#begin('~/.vim/vim-plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }              " file explorer
Plug 'AndrewRadev/linediff.vim'                                      " fast line diff
Plug 'haya14busa/incsearch.vim'                                      " incremental search
Plug 'junegunn/vim-easy-align'                                       " align text according to '=' location
Plug 'preservim/tagbar'                                              " tag bar showing tags in file (used mainly for ATHLET input)
Plug 'vim-airline/vim-airline'                                       " enhanced status bar at bottom of buffer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                  " powerful search tool
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'                                            " show most recently used files at startup
Plug 'markonm/traces.vim'                                            " show search/replace matches while typing

call plug#end()

"###########################"
" Vim settings
"###########################"

" auto-reload vimrc-changes
augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC
augroup END

" start vim/gvim maximized
autocmd GUIEnter * simalt ~X

" Set language to english
set langmenu=en_US
let $LANG   ='en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" show NERDTree bookmarks
let NERDTreeShowBookmarks=1

" Set color scheme
colors gruvbox
set bg=dark

" Set font
set guifont=Cousine:h11

" Show line and column numbers, line endings
set number
set relativenumber
set ruler
set cursorline
set list

" command line completion
set wildmenu

" Turn on syntax highlighting
syntax on

" set encoding to utf8
set encoding=utf-8

" replace tab with 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" allow writing anywhere in buffer
set virtualedit=all

" activate backspace key
set backspace=2

" clipboard and swapfile settings
set clipboard=unnamed                          " < copy/paste to register * (system's copy/paste buffer)
set swapfile
set dir=~/tmp                                  " store swapfiles in tmp directory

" clear and limit viminfo entries
set viminfo='10,<10,s10

" tag directory
set tags=$HOME/vimfiles

" set working directory to open file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Open Ggrep results in a quickfix window
autocmd QuickFixCmdPost *grep* cwindow

" set Vim leader key
let mapleader = "\<Space>"

" set shortmess for search count
set shortmess-=S

"###########################"
" F key mappings
"###########################"

" toggle File Explorer
nnoremap <F1> :NERDTreeToggle<CR>
" toggle wrap
nnoremap <silent><expr> <F2> ':set wrap! go'.'-+'[&wrap]."=b\r"
" map split view
" vertical
nnoremap <F3> <C-w><C-v><CR>
" horizontal
nnoremap <F4> <C-w><C-s><CR>
" set synchronous scrolling
nnoremap <F5> :windo set invscrollbind<CR>
" toggle column highlight
nnoremap <F6> :set cursorcolumn!<CR>
" toggle relative line numbers
nnoremap <F7> :set relativenumber!<CR>
" search word under cursor
nnoremap <F8> :vimgrep /<C-r><C-w>/j % <bar> cwindow<cr>

" toggle code folding
" inoremap <F9> <C-O>za
" nnoremap <F9> za
" onoremap <F9> <C-C>za
" vnoremap <F9> zf"

" edit _vimrc file
nnoremap <F12> :e $MYVIMRC<CR>

"#############################################"
"############## Plugin mappings ##############"
"#############################################"

"###########################"
" EasyAlign
"###########################"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga :EasyAlign 

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga :EasyAlign 

" align to import statement or equal sign
xnoremap <leader>ii :EasyAlign /import/<CR>
xnoremap <leader>00 :EasyAlign =<CR>

"###########################"
" FZF
"###########################"

" preview window settings
let s:is_win = 1
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': [ '--info=inline', '--preview', 'bat {}']}, <bang>0)

" Find files with fzf
nnoremap <leader>p :Files $HOME<CR>
nnoremap <leader>l :Files<CR>

" search in file
nnoremap -- :Lines<CR>
nnoremap ?? :Rg<CR>

" show history
nnoremap <leader>h :History<CR>

let g:fzf_commands_expect = 'enter'

" Default fzf layout
" - Popup window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" let $FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
let $FZF_DEFAULT_OPTS = '-e --bind ctrl-a:select-all'

"###########################"
" Tagbar
"###########################"

" show line number of tags
let g:tagbar_show_tag_linenumbers = 1

" jump tags backward and forward
nnoremap <silent> <C-k8> :TagbarToggle<CR>

" create tags for AC2
let g:tagbar_type_ac2 = {
            \ 'ctagstype' : 'ac2',
            \ 'kinds' : [
            \ 'c:Control Words',
            \ 'k:Key Words'
            \ ],
            \ 'sort' : 0
            \ }

let g:tagbar_type_ac2_out = {
            \ 'ctagstype' : 'ac2_out',
            \ 'kinds' : [
            \ 'm:Main Edits'
            \ ],
            \ 'sort' : 1
            \ }  
"        \ 'p:Parameters',
"        \ 'r:ATHLET Run Summary'

"###########################"
" Personal
"###########################"

" select all
nnoremap <C-a> ggVG

" select with alt + mouse in column mode
noremap <M-LeftMouse> <LeftMouse><Esc><C-V>

" enter search and replace
noremap ,, :%s:::g<Left><Left><Left>
noremap ,. :%s:\<<C-r><C-w>\>:<C-r><C-w>:gI<Left><Left><Left>

" toggle search highlighting
nnoremap <C-k0> :set hlsearch!<CR>

" copy selection
vnoremap <C-c> "+y

" paste selection (from clipboard)
inoremap <C-v> <C-r>+

" delete and send to void register
vnoremap <Del> "_d

" fix indentation of complete file
nnoremap <C-i> gg=G<CR>

" word completion with tab
inoremap <Tab> <C-n>

" auto-close
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" move lines
nnoremap <silent> <A-k2>        :m .+1<CR>==
nnoremap <silent> <A-k8>        :m .-2<CR>==
inoremap <silent> <A-k2>   <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k8>   <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-k2>        :m '>+1<CR>gv=gv
vnoremap <silent> <A-k8>        :m '<-2<CR>gv=gv

" comment out lines
source $HOME/vimfiles/additional/vcomments.vim
nnoremap <A-q> :call ToggleComment()<CR>
nnoremap <A-,> :call Comment()<CR>
nnoremap <A-.> :call UnComment()<CR>

" toggle through buffers
nnoremap <C-k1> :bp<CR>
nnoremap <C-k2> :buffers<CR>:buffer<Space>
nnoremap <C-k3> :bn<CR>

" navigate through windows
nnoremap <silent> <A-Up>    :wincmd k<CR>
nnoremap <silent> <A-Down>  :wincmd j<CR>
nnoremap <silent> <A-Left>  :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>

" ############# leader mappings #############

" remove trailing whitespaces
nnoremap <leader>tw :%s/\s*$//<CR>

" remove empty lines
nnoremap <leader>. :g:^\h*$:d<CR>

" replace comma with dot or dot with comma
nnoremap <leader>dc :%s:\.:,:g<CR>
nnoremap <leader>cd :%s:\,:.:g<CR>

" replace tabs with spaces
nnoremap <leader>ts :%s:\t:    :g<CR>

" open new buffer
nnoremap <leader>b<left>   :leftabove  vnew<CR>
nnoremap <leader>b<right>  :rightbelow vnew<CR>
nnoremap <leader>b<up>     :leftabove  new<CR>
nnoremap <leader>b<down>   :rightbelow new<CR>

" set equal buffer size
nnoremap <leader>0 <C-w>=<CR>

" show all open buffers in vertical split
nnoremap <leader>bv :vert sball<CR>

" save and close file with leader
nnoremap <leader>w :w!<CR>
nnoremap <leader>e :browse confirm saveas<CR>
nnoremap <leader>q :q!<CR>

" open new file with leader
nnoremap <leader>o :browse confirm e<CR>

" create new file with leader
nnoremap <leader>n :enew<CR>

" diff of currently opened buffers
nnoremap <leader>d :windo diffthis<CR>
nnoremap <leader>f :windo diffoff<CR>

" diff between current buffer state and state of file on drive (as loaded)
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
nnoremap <leader>dt :DiffOrig<CR>

"###########################"
" Search settings
"###########################"

"set hlsearch
set incsearch                                                        " highlight search pattern while typing
set ignorecase                                                       " set incremental search
set smartcase                                                        " activate case-insensitive search

" highlight word under cursor with double click
set mouse=a                                                          " Enables mouse click
inoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

"###########################"
" Syntax settings
"###########################"

" ############# FORTRAN / AC2 #############

" Set ac2 as language for input file
autocmd BufNewFile,BufRead,BufReadPost *.iix,*.inp,*.in,*.inp_EXP,*.log,*.dat set
            \ syntax=ac2
            \ encoding=utf-8
            \ filetype=ac2

autocmd BufWritePre *.iix,*.inp,*.in,*.inp_EXP,*.log,*.dat :%s/\t/    /e              " replace tabs with 4 spaces when SAVING file
autocmd BufWritePre *.iix,*.inp,*.in,*.inp_EXP,*.log,*.dat :%s/\s\+$//e               " remove trailing white space(s)

" Set ac2_out as language for *.out file
autocmd BufNewFile,BufRead,BufReadPost *.out set
            \ syntax=ac2
            \ encoding=utf-8
            \ filetype=ac2_out 


" ############# Python #############

autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst set
            \ syntax=python
            \ encoding=utf-8
            \ filetype=python

autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst inoremap<buffer> ' ''<left>
autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst inoremap<buffer> " ""<left>

autocmd BufWritePre *.py :%s/\t/    /e              " replace tabs with 4 spaces when SAVING file
autocmd BufWritePre *.py :%s/\s\+$//e               " remove trailing white space(s)

" ############# DOS Batch #############
autocmd FileType dosbatch inoremap<buffer> % %%<left>

" ############# HTML #############
" autocmd BufWritePre *.html :%s/\t/    /g            " replace tabs with 4 spaces when OPENING file

