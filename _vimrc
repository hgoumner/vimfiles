"############################################################################################################"
"# Personal vimrc settings #"
"############################################################################################################"

"###########################"
" Plugin settings

" set necessary flags for plugin and tool setup
set nocompatible              " required
filetype off                  " required

" import plugins
call plug#begin('~/.vim/vim-plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }              " file explorer
Plug 'AndrewRadev/linediff.vim'                                      " fast line diff
Plug 'haya14busa/incsearch.vim'                                      " incremental search
Plug 'junegunn/vim-easy-align'                                       " align text according to '=' location
Plug 'preservim/tagbar'
"Plug 'yegappan/taglist'                                              " enhanced status bar
Plug 'vim-airline/vim-airline'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
"Plug 'kien/ctrlp.vim'
"Plug 'tomtom/tcomment_vim'
"Plug 'tpope/vim-fugitive'
"Plug 'Lokaltog/vim-easymotion'
"Plug 'vim-syntastic/syntastic'
"Plug 'flazz/vim-colorschemes'
"Plug 'sjl/gundo.vim'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/view_diff'
"Plug 'shougo/deol.nvim'
"Plug 'yegappan/grep'

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

" Set font
set guifont=Consolas:h12

" Show line and column numbers
set number
set ruler

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
set clipboard=unnamed                                                " < copy/paste to register * (system's copy/paste buffer)
set swapfile
set dir=~/tmp                                                        " store swapfiles in tmp directory

" tag directory
:set tags=$HOME/vimfiles

" set working directory to open file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" set Vim leader key
let mapleader = "\<Space>"

"############################################################################################################"
" Editor settings
"############################################################################################################"

"######################"
"### F key mappings ###"
"######################"

" map myvimrc edit
map <F1> :e $MYVIMRC<CR>
map <F2> :NERDTreeToggle C:\Users\gou\Documents\Lokale_Repositories<CR>
" map split view
map <F3> <C-w><C-v><CR>
map <F4> <C-w><C-s><CR>
" set synchronous scrolling
map <F5> :windo set invscrollbind<CR>
nnoremap <F6> :set hlsearch!<CR>
" search word under cursor
nnoremap <F7> :vimgrep /<C-r><C-w>/j % <bar> cwindow<cr>
" close file without saving
map <F12> :q!<CR>

"#######################"
"### Plugin mappings ###"
"#######################"

"let NERDTreeIgnore=['\~$', '\.o$[[file]]', '\.pyc$[[file]]']
" nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" select all
nnoremap <C-A> ggVG

" comment out lines
source ~/.vim/additional/vcomments.vim
map <C-q> :call Comment()<CR>
map <A-q> :call Uncomment()<CR>

" replace comma with dot or dot with comma
noremap <C-d><C-c> :%s/\./,/g<CR>
noremap <C-c><C-d> :%s/\,/./g<CR>
 
"### Open new buffer ###
nmap <leader>b<left>   :leftabove  vnew<CR>
nmap <leader>b<right>  :rightbelow vnew<CR>
nmap <leader>b<up>     :leftabove  new<CR>
nmap <leader>b<down>   :rightbelow new<CR>

nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

"##########################"
"########## FZF ###########"
"##########################"

" Find files with fzf
nmap <leader>p :Files<CR>

" Default fzf layout
" - Popup window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

"##########################"
"######### CtrlSF #########"
"##########################"
 
nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>

let g:ctrlsf_backend = "C:/Users/gou/vimfiles/additional/ripgrep-12.1.1-x86_64-pc-windows-gnu/rg.exe"

let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }

"##########################"
"
" new line without insert mode
nnoremap o o<Esc>
nnoremap O O<Esc>

" save file
nmap <c-s> :w<CR>
"vmap <C-s> <Esc><C-s>gv
imap <c-s> <Esc>:w<CR>a
" save file as
nnoremap <C-S> :sav<CR>
" close file after saving
map <C-s><C-x> :wq!<CR>
" Toggle tag bar
nmap <F8> :TagbarToggle<CR>
"nmap <F8> :TlistToggle<CR>

"############################################################################################################"
" Search settings
"############################################################################################################"

set hlsearch                                                         " highlight search pattern
set incsearch                                                        " set incremental search
set ignorecase                                                       " activate case-insensitive search
set smartcase
" map numpad * key to search forward
"map * <Plug>(incsearch-forward)                                      
" map numpad - key to search backward
"map - <Plug>(incsearch-backward)                                     

" Open Ggrep results in a quickfix window
 autocmd QuickFixCmdPost *grep* cwindow


" Substitute the word under the cursor.
nmap <leader>ss :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Set fortran as language for input file
autocmd BufNewFile,BufRead,BufReadPost *.iix,*.inp,*.in,*.inp_EXP,*.log set syntax=ac2 encoding=utf-8

"############################################################################################################"
" Syntax settings
"############################################################################################################"

" ############# FORTRAN / AC2" ############# 
" au BufWritePre *.f90,*.fpp,*.inp,*.in,*.inp_EXP,*.log :%s/\s\+$//e   " replace spaces with plus until end of line
" au BufRead *.f90,*.fpp,*.inp,*.in,*.inp_EXP,*.log :%s/\t/    /g      " replace tabs with 4 spaces when OPENING fortran/AC2 file
" au BufWritePre *.f90,*.fpp,*.inp,*.in,*.inp_EXP,*.log :%s/\t/    /g  " replace tabs with 4 spaces and SAVE fortran/AC2 file

" Tags for most languages
let g:tagbar_ctags_bin = 'C:\Users\gou\vimfiles\additional\ctags58\ctags.exe'
let g:Tlist_Ctags_Cmd = 'C:\Users\gou\vimfiles\additional\ctags58\ctags.exe'

" create tags for AC2
let g:tagbar_ac2ctags_bin='.ctags'
let g:tagbar_type_ac2 = {
    \ 'ctagstype' : 'ac2',
    \ 'ctagsbin'  : tagbar_ac2ctags_bin,
    \ 'kinds' : [
        \ 'c:controlwords',
        \ ],
        \ 'sort' : 0
    \ }

