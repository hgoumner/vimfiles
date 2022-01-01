"###########################################################################################################"
"# Hristo's neovim settings
"############################################################################################################"

call plug#begin()

" basic coloring and statusbar
Plug 'mhinz/vim-startify'       " show most recently used files at startup
Plug 'vim-airline/vim-airline'  " enhanced status bar at bottom of buffer
Plug 'morhetz/gruvbox'

" simple productivity plugins
Plug 'markonm/traces.vim'       " show search/replace matches while typing
Plug 'AndrewRadev/linediff.vim' " fast line diff
Plug 'haya14busa/incsearch.vim' " incremental search
Plug 'preservim/tagbar'         " tag bar showing tags in file (used mainly for ATHLET input)
Plug 'tpope/vim-commentary'

" neovim specific plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'

" ide plugins
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

call plug#end()

" Initial settings
" auto-reload vimrc-changes
augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC
augroup END

set number
set relativenumber
set autoindent
set tabstop=4
set smarttab
set expandtab
set shiftwidth=4
set ruler
set cursorline
set list
set nowrap

" command line completion
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=**/.git/*

set mouse=a

" Set colorscheme
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_transparent_bg=1
set background=dark

" Workaround for creating transparent bg
autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
                \ |  highlight LineNr     ctermbg=NONE guibg=NONE
                \ |  highlight SignColumn ctermbg=NONE guibg=NONE

" Set font
set guifont=MesloLGS_NF:h10

" set encoding to utf8
set encoding=utf-8

" allow writing anywhere in buffer
set virtualedit=block

" activate backspace key
set backspace=2

" clipboard and swapfile settings
set clipboard=unnamed

" copy, search, and join mappings
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" stupid Ex mode
nnoremap <silent> Q <nop>

" ############# leader mappings #############

" set Vim leader key
let mapleader = "\<Space>"

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
"nnoremap <leader>of :source $HOME/vimfiles/scripts/openfoam_case.vim<CR>

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

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
