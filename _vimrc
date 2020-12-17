"############################################################################################################"
"# Personal vimrc settings #"
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
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
"Plug 'terryma/vim-multiple-cursors'

call plug#end()

" auto-reload vimrc-changes ...
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC
augroup END

"############################################################################################################"
" Vim settings
"############################################################################################################"

" Set language to english
set langmenu=en_US
let $LANG   ='en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" open NERDTree on startup
" autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1

" Set color scheme
colors gruvbox
set bg=dark

" Set font
set guifont=Cousine:h11

" Show line and column numbers, line endings
set number
set ruler
set cursorline
set list

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

"############################################################################################################"
" Editor settings
"############################################################################################################"

"######################"
"### F key mappings ###"
"######################"

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
" search word under cursor
nnoremap <F7> :vimgrep /<C-r><C-w>/j % <bar> cwindow<cr>
" toggle code folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf"
" edit _vimrc file
nnoremap <F12> :e $MYVIMRC<CR>

"#######################"
"### Plugin mappings ###"
"#######################"

" Start interactive EasyAlign in visual mode (e.g. vipga)
"xnoremap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
"nnoremap ga <Plug>(EasyAlign)

"let NERDTreeIgnore=['\~$', '\.o$[[file]]', '\.pyc$[[file]]']
" nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

"##########################"
"########## FZF ###########"
"##########################"

""let $FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
let $FZF_DEFAULT_OPTS = '-e --bind ctrl-a:select-all'
""command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

if has('win32')
  " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = ''
else
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif

" Find files with fzf
nnoremap <leader>p :Files $HOME<CR>
nnoremap <leader>l :Files<CR>

" search in file
nnoremap -- :Lines!<CR>
nnoremap ?? :Rg!<CR>

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

"##########################"
"######### CtrlSF #########"
"##########################"

" search result settings
nnoremap <leader>a :CtrlSF -R -I ""<Left>
nnoremap <leader>c <Plug>CtrlSFCwordPath -W<CR>
"nnoremap <leader>c :CtrlSFFocus<CR>
"nnoremap <leader>C :CtrlSFToggle<CR>

" plugin settings
let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }

"##########################"
"######### Tagbar #########"
"##########################"

" show line number of tags
let g:tagbar_show_tag_linenumbers = 1

" jump tags backward and forward
nnoremap <silent> <C-k7> :TagbarOpen fj<CR><C-p>
nnoremap <silent> <C-k9> :TagbarOpen fj<CR><C-n>
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

"##########################"
"####### Personal #########"
"##########################"

" select all
nnoremap <C-a> ggVG

" select with alt + mouse in column mode
noremap <M-LeftMouse> <LeftMouse><Esc><C-V>

" remove trailing whitespaces
nnoremap <leader>, :%s/\s*$//<CR>

" remove empty lines
nnoremap <leader>. :g:^\h*$:d<CR>

" toggle search highlighting
nnoremap <C-k0> :set hlsearch!<CR>

" copy selection
vnoremap <C-c> "+y

" paste selection (from clipboard)
inoremap <C-v> <C-r>+

" fix indentation of complete file
nnoremap <C-i> gg=G<CR>

" word completion with tab
inoremap <Tab> <C-n>

" auto-close
inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap % %%<left>
inoremap [ []<left>
inoremap { {}<left>

" comment out lines
source $HOME/vimfiles/additional/vcomments.vim
xnoremap <C-q> :call Comment()<CR>
xnoremap <A-q> :call Uncomment()<CR>

" replace comma with dot or dot with comma
noremap <leader>dc :%s/\./,/g<CR>
noremap <leader>cd :%s/\,/./g<CR>

" open new buffer
nnoremap <leader>b<left>   :leftabove  vnew<CR>
nnoremap <leader>b<right>  :rightbelow vnew<CR>
nnoremap <leader>b<up>     :leftabove  new<CR>
nnoremap <leader>b<down>   :rightbelow new<CR>

" navigate through windows
nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>

" set equal buffer size
nnoremap <leader>0         <C-w>=<CR>

" toggle through buffers
nnoremap <C-k1> :bp<CR>
nnoremap <C-k2> :buffers<CR>:buffer<Space>
nnoremap <C-k3> :bn<CR>

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

" new line without insert mode
nnoremap o o<Esc>
nnoremap O O<Esc>

" Toggle Quickfix window
"nnoremap <leader>f :QFix<CR>
"############################################################################################################"
" Search settings
"############################################################################################################"

"set hlsearch                                                         " highlight search pattern
set incsearch                                                        " set incremental search
set ignorecase                                                       " activate case-insensitive search
set smartcase

" highlight word under cursor with double click
set mouse=a     "Enables mouse click
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" Substitute the word under the cursor.
nnoremap <leader>r :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Set ac2 as language for input file
autocmd BufNewFile,BufRead,BufReadPost *.iix,*.inp,*.in,*.inp_EXP,*.log,*.dat set syntax=ac2 encoding=utf-8 filetype=ac2

" Set ac2_out as language for *.out file
"autocmd BufNewFile,BufRead,BufReadPost *.out set syntax=ac2 encoding=utf-8 filetype=ac2_out

" Set Python as language for Veusz file
autocmd BufNewFile,BufRead,BufReadPost *.vsz,*.vst set syntax=python encoding=utf-8

"############################################################################################################"
" Syntax settings
"############################################################################################################"

" ############# FORTRAN / AC2" #############
" au BufWritePre *.f90,*.fpp :%s/\s\+$//e   " replace spaces with plus until end of line
" au BufRead *.f90,*.fpp :%s/\t/    /g      " replace tabs with 4 spaces when OPENING fortran/AC2 file
" au BufWritePre *.f90,*.fpp :%s/\t/    /g  " replace tabs with 4 spaces and SAVE fortran/AC2 file

