"###########################"
"# Personal vimrc settings #"
"###########################"

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
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
"Plug 'kien/ctrlp.vim'
"Plug 'tomtom/tcomment_vim'
"Plug 'tpope/vim-fugitive'
"Plug 'Lokaltog/vim-easymotion'
"Plug 'vim-syntastic/syntastic'
"Plug 'flazz/vim-colorschemes'
"Plug 'sjl/gundo.vim'
"Plug 'vim-airline/vim-airline'
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

"###########################"
" Vim settings

" Set language to english
set langmenu=en_US
let $LANG   ='en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Set color scheme
colors gruvbox

" Set font
set guifont=Consolas:h12

" clipboard and swapfile settings
set clipboard=unnamed                                                " < copy/paste to register * (system's copy/paste buffer)
set swapfile
set dir=~/tmp                                                        " store swapfiles in tmp directory

"###########################"
" Editor settings

" Show line and column numbers
:set number
:set ruler

" Turn on syntax highlighting
syntax on

" set encoding to utf8
set encoding=utf-8

" replace tab with 4 spaces
set tabstop=4 shiftwidth=4 expandtab

"let NERDTreeIgnore=['\~$', '\.o$[[file]]', '\.pyc$[[file]]']
map  <F4>   :NERDTreeToggle C:\Users\gou\Documents\Lokale_Repositories<cr>
" nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

" comment out line in AC2 files
source ~/.vim/additional/vcomments.vim
map <C-q> :call Comment()<CR>
map <A-q> :call Uncomment()<CR>

"###########################"
" Search settings

set hlsearch                                                         " highlight search pattern
set incsearch                                                        " set incremental search
set ignorecase                                                       " activate case-insensitive search
set smartcase
" map numpad * key to search forward
map * <Plug>(incsearch-forward)                                      
" map numpad - key to search backward
map - <Plug>(incsearch-backward)                                     

" Set fortran as language for input file
autocmd BufNewFile,BufRead,BufReadPost *.inp,*.in,*.inp_EXP,*.log set syntax=fortran encoding=utf-8

"###########################"
" Syntax settings

" ############# FORTRAN / AC" ############# 
" au BufWritePre *.f90,*.fpp,*.inp,*.in,*.inp_EXP,*.log :%s/\s\+$//e   " replace spaces with plus until end of line
" au BufRead *.f90,*.fpp,*.inp,*.in,*.inp_EXP,*.log :%s/\t/    /g      " replace tabs with 4 spaces when OPENING fortran/AC2 file
" au BufWritePre *.f90,*.fpp,*.inp,*.in,*.inp_EXP,*.log :%s/\t/    /g  " replace tabs with 4 spaces and SAVE fortran/AC2 file

