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
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

" lsp settings
lua require('lspconfig').pyright.setup{}
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" -----------------------------------------------------------------------
" -----------------------------------------------------------------------

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF

" -----------------------------------------------------------------------
" -----------------------------------------------------------------------

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
