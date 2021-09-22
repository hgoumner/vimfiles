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
Plug 'dense-analysis/ale'
Plug 'https://bitbucket.org/shor-ty/vimextensionopenfoam.git'
Plug 'szw/vim-maximizer'
Plug 'lark-parser/vim-lark-syntax'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'airblade/vim-gitgutter'
Plug 'puremourning/vimspector'
Plug 'perost/modelica-vim'
Plug 'morhetz/gruvbox'

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
let g:gruvbox_contrast_dark='hard'
if has('unix')
    set bg=dark
endif
colorscheme gruvbox

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

" do not fold on file load
set nofoldenable

" set encoding to utf8
set encoding=utf-8

" replace tab with 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" allow writing anywhere in buffer
set virtualedit=block

" activate backspace key
set backspace=2

" clipboard and swapfile settings
set clipboard=unnamed                          " < copy/paste to register * (system's copy/paste buffer)
set noswapfile
set dir=~/tmp                                  " store swapfiles in tmp directory

" clear and limit viminfo entries
set viminfo='10,<10,s10

" tag directory
set tags+=tags;$HOME

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

" " toggle File Explorer
" nnoremap <F1> :NERDTreeToggle<CR>
" " toggle wrap
" nnoremap <silent><expr> <F2> ':windo set wrap! go'.'-+'[&wrap]."=b\r"
" " map split view
" " vertical
" nnoremap <F3> <C-w><C-v><CR>
" " horizontal
" nnoremap <F4> <C-w><C-s><CR>
" " set synchronous scrolling
" nnoremap <F5> :windo set invscrollbind<CR>
" " toggle column highlight
" nnoremap <F6> :set cursorcolumn!<CR>
" " toggle relative line numbers
" nnoremap <F7> :set relativenumber!<CR>
" " window maximizer
" let g:maximizer_default_mapping_key = '<F8>'
" nnoremap <silent><F8> :MaximizerToggle<CR>
" " search word under cursor
" nnoremap <F9> :vimgrep /<C-r><C-w>/j % <bar> cwindow<cr>
" 
" " toggle code folding
" inoremap <F10> <C-O>za
" nnoremap <F10> za
" inoremap <F11> <C-O>zM
" nnoremap <F11> zM
" " onoremap <F10> <C-C>za
" " vnoremap <F10> zf"
" 
" " edit _vimrc file
" nnoremap <F12> :e $MYVIMRC<CR>

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
"if s:is_win
"    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': [ '--info=inline', '--preview', 'bat {}']}, <bang>0)
"endif

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
nnoremap <silent> <leader>8 :TagbarToggle<CR>

" create tags for AC2
let g:tagbar_type_ac2 = {
            \ 'ctagstype' : 'ac2',
            \ 'kinds' : [
            \ 'c:Control section',
            \ 'k:Key Words:1:0',
            \ 'p:Pseudo Key Words:1:0',
            \ 's:GCSM Signals:1:0',
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

" create tags for openFOAM
let g:tagbar_type_foam256_general = {
            \ 'ctagstype' : 'foam256_general',
            \ 'kinds' : [
            \ 'm:Mesh',
            \ ],
            \ 'sort' : 0
            \ }

" RELAP5 tags
let g:tagbar_type_relap5 = {
            \ 'ctagstype' : 'relap5',
            \ 'kinds' : [
            \ 'c:Control words',
            \ 'k:Key words',
            \ ],
            \ 'sort' : 0
            \ }

"###########################"
" Ale
"###########################"
"
let g:ale_linters = {'python': ['flake8']}

" show warnings or errors in gutter
let g:flake8_show_in_gutter=1

" ignore unimportant warnings
"let g:flake8_ignore="E201,E221,E265,E271,E272,E303,E501,E701,W391"
"
"###########################"
" OpenFOAM syntax
"###########################"

let g:foam256_use_own_colors=1

"###########################"
" Vimspector
"###########################"

if has('win32')
    set pythonthreedll=C:\\Users\\gou\\Miniconda3\\envs\\py36_32bit\\python36.dll
    set pythonthreehome=C:\\Users\\gou\\Miniconda3\\envs\\py36_32bit
endif

let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector

"###########################"
" Personal
"###########################"

" select all
nnoremap <C-a> ggVG

" select with alt + mouse in column mode
noremap <M-LeftMouse> <LeftMouse><Esc><C-V>

" enter search and replace
noremap ,, :%s///g<Left><Left><Left>
noremap ,. :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

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

" keep search matches and line joining in screen center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap <kMultiply> *zz
nnoremap <kDivide> #zz
nnoremap # #zz
nnoremap J mzJ`z

" yank to end of line
nnoremap Y y$

" word completion with tab
" inoremap <Tab> <C-n>

" auto-close
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>

" move lines
nnoremap <silent> <A-j>        :m .+1<CR>==
nnoremap <silent> <A-k>        :m .-2<CR>==
inoremap <silent> <A-j>   <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k>   <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j>        :m '>+1<CR>gv=gv
vnoremap <silent> <A-k>        :m '<-2<CR>gv=gv

" navigate in insert and command mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-l> <Right>
cnoremap <C-k> <Up>

" comment out lines
source $HOME/vimfiles/additional/vcomments.vim
noremap <A-q> :call ToggleComment()<CR>
noremap <leader>k :call ToggleComment()<CR>
noremap <A-,> :call Comment()<CR>
noremap <A-.> :call UnComment()<CR>

" toggle through buffers
nnoremap <C-k1> :bp<CR>
nnoremap <C-k2> :buffers<CR>:buffer<Space>
nnoremap <C-k3> :bn<CR>

" ############# leader mappings #############

" open new buffer
nnoremap <leader>bh :leftabove  vnew<CR>
nnoremap <leader>bl :rightbelow vnew<CR>
nnoremap <leader>bk :leftabove  new<CR>
nnoremap <leader>bj :rightbelow new<CR>

" show all open buffers in vertical split
nnoremap <leader>bv :vert sball<CR>

" compile and run C code
nnoremap <leader>c :!gcc % -Wall -o %< && ./%< <CR>

" replace comma with dot or dot with comma
nnoremap <leader>cd :%s/\,/./g<CR>
nnoremap <leader>dc :%s/\./,/g<CR>

" diff of currently opened buffers
nnoremap <leader>d :windo diffthis<CR>
nnoremap <leader>f :windo diffoff<CR>

" diff between current buffer state and state of file on drive (as loaded)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
nnoremap <leader>dt :DiffOrig<CR>

" remove leading whitespaces
nnoremap <leader>lw :%s/^\s\+//e<CR>

" create new file with leader
nnoremap <leader>n :enew<CR>

" open new file with leader
nnoremap <leader>o :browse confirm e<CR>

" openfoam script
nnoremap <leader>of :source $HOME/vimfiles/scripts/openfoam_case.vim<CR>

" retab
nnoremap <leader>t :retab<CR>

" remove trailing whitespaces
nnoremap <leader>tw :%s/\s\+$//e<CR>


" remove empty lines
nnoremap <leader>. :g/^\h*$/d<CR>

" replace tabs with spaces
nnoremap <leader>ts :%s/\t/    /g<CR>

" set equal buffer size
nnoremap <leader>0 <C-w>=<CR>

" save and close file with leader
nnoremap <leader>e :browse confirm saveas<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>x :x<CR>

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
            \ filetype=ac2

" Set ac2_out as language for *.out file
autocmd BufNewFile,BufRead,BufReadPost *.out set
            \ syntax=ac2
            \ filetype=ac2_out

" ############# Python #############

autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst set
            \ syntax=python
            \ filetype=python

autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst inoremap<buffer> ' ''<left>
autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst inoremap<buffer> " ""<left>

" ############# DOS Batch #############
autocmd FileType dosbatch inoremap<buffer> % %%<left>

" ############# GMSH #############
autocmd BufNewFile,BufRead,BufReadPost *.geo set
            \ syntax=gmsh
            \ filetype=gmsh

" ############# HTML #############

" ############# C++ #############
"autocmd BufNewFile,BufRead,BufReadPost *.cpp set
"            \ syntax=cpp
"            \ filetype=cpp
"
" ############# OpenFOAM #############

" ############# RELAP5 #############
autocmd BufNewFile,BufRead,BufReadPost *.rl5 set
            \ syntax=relap5
            \ filetype=relap5

" ############# Modelica #############
autocmd BufNewFile,BufRead,BufReadPost *.mo set 
            \ syntax=modelica
            \ filetype=modelica

" ############# All files #############
"autocmd BufReadPre * set nowrap
autocmd BufReadPre * silent! :retab
autocmd BufReadPre * silent! exec "normal gg=G"
autocmd BufRead * silent! set encoding=utf-8

